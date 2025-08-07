"""Main API file
"""
import os
from enum import IntEnum

from fastapi import FastAPI, Depends, HTTPException, Header, status
from sqlalchemy import select, create_engine
from sqlalchemy.orm import Session
from geopy.distance import distance

from schema.schemas import OrganizationSchema, GeoSearchSchema
from model.models import Buildings, Organizations, EconomicActivities


class GeoSearchType(IntEnum):
    """Type of geo serching
    """
    CIRCLE = 0
    SQUARE = 1

engine = create_engine(os.environ.get('DB_URL'))
app = FastAPI(title='Secunda test task API', description='Task from Secunda company')

API_KEYS = {os.environ.get('API_KEY')}

def verify_api_key(x_api_key: str = Header(...)):
    if x_api_key not in API_KEYS:
        raise HTTPException(
            status_code=status.HTTP_401_UNAUTHORIZED,
            detail="Invalid or missing API Key"
        )


@app.get("/organizations/search_by_building", dependencies=[Depends(verify_api_key)])
async def get_organizations_in_building(building_id: int) -> list[OrganizationSchema]:
    """Get all organizations in building_id

    Args:
        building_id (int): id of building

    Returns:
        list[OrganizationSchema]: list of organizations in building
    """
    result = []
    stmt = select(Organizations).where(Organizations.building_id == building_id)
    with Session(engine) as session:
        for i in session.scalars(stmt):
            result.append(OrganizationSchema.model_validate(i))
    return result

@app.get('/organizations/search_by_activity', dependencies=[Depends(verify_api_key)])
async def get_organizations_of_activities(activity_id: int) -> list[OrganizationSchema]:
    """Get all organization by activity

    Args:
        activity_id (int): id of activity

    Returns:
        list[OrganizationSchema]: list of organizations
    """
    result = []
    stmt = select(Organizations).where(Organizations.activities.any(EconomicActivities.id == activity_id))
    with Session(engine) as session:
        for i in session.scalars(stmt):
            result.append(OrganizationSchema.model_validate(i))
    return result

@app.get('/geosearch', dependencies=[Depends(verify_api_key)])
async def get_geoserch(latitude: float, longitude: float, radius: float, search_type: GeoSearchType) -> GeoSearchSchema:
    """Search organizations and building by geoserching

    Args:
        latitude (float): point latitude
        longitude (float): point longitude
        radius (float): search raduis in km
        search_type (GeoSearchType): circle or square type. CIRCLE = 0, SQUARE = 1

    Returns:
        GeoSearchSchema: Lists of organizations and building in geoserching
    """
    orgs = []
    buildings = []
    buildings_ids = []
    point = (latitude, longitude)

    with Session(engine) as session:
        for i in session.scalars(select(Buildings)):
            build_point = (i.latitude, i.longitude)
            if search_type == GeoSearchType.CIRCLE:
                if distance(point, build_point).km <= radius:
                    buildings.append(i)
                    buildings_ids.append(i.id)
            else:
                north = distance(km=radius).destination(point, bearing=0)
                east = distance(km=radius).destination(point, bearing=90)
                south = distance(km=radius).destination(point, bearing=180)
                west = distance(km=radius).destination(point, bearing=270)
                if south.latitude <= i.latitude <= north.latitude and west.longitude <= i.longitude <= east.longitude:
                    buildings.append(i)
                    buildings_ids.append(i.id)

        org_stmt = select(Organizations).where(Organizations.building_id.in_(buildings_ids))
        for i in session.scalars(org_stmt):
            orgs.append(OrganizationSchema.model_validate(i))

    return GeoSearchSchema(organizations=orgs, buildings=buildings)

def recursive_acty_search(acty_id: int, depth: int = 0) -> list[int]:
    """recusively searching activites id

    Args:
        acty_id (int): currect activity id
        depth (int, optional): current depth. If 3, quit. Defaults to 0.

    Returns:
        list[int]: list of activity ids
    """
    result = []
    if depth >= 3:
        return []
    stmt = select(EconomicActivities).where(EconomicActivities.id == acty_id)
    with Session(engine) as session:
        for i in session.scalars(stmt).unique():
            result.append(i.id)
            for j in i.children:
                result.extend(recursive_acty_search(j.id, depth + 1))
    return result

@app.get('/organizations/search_by_activity_recursive', dependencies=[Depends(verify_api_key)])
async def get_orgs_by_acty_recursive(activity_id: int) -> list[OrganizationSchema]:
    """Get organizations list by recursive activities

    Args:
        activity_id (int): root of activity recursice search

    Returns:
        list[OrganizationSchema]: list of organizations
    """
    result = []
    acty_idx = recursive_acty_search(activity_id)
    stmt = select(Organizations).where(Organizations.activities.any(EconomicActivities.id.in_(acty_idx)))

    with Session(engine) as session:
        for i in session.scalars(stmt):
            result.append(OrganizationSchema.model_validate(i))

    return result

@app.get('/organizations/get_by_name', dependencies=[Depends(verify_api_key)])
async def get_organization_by_name(organization_name: str) -> list[OrganizationSchema]:
    """_summary_

    Args:
        organization_name (str): _description_

    Returns:
        list[OrganizationSchema]: _description_
    """
    result = []
    stmt = select(Organizations).where(Organizations.tittle.like(f'%{organization_name}%'))
    with Session(engine) as session:
        for i in session.scalars(stmt):
            result.append(OrganizationSchema.model_validate(i))
    return result

@app.get('/organizations/{organization_id}', dependencies=[Depends(verify_api_key)])
async def get_organization(organization_id: int) -> OrganizationSchema | None:
    """Get organization by id

    Args:
        organization_id (int): id of organization

    Returns:
        OrganizationSchema | None: organization or null of not exist
    """
    result = None
    stmt = select(Organizations).where(Organizations.id == organization_id)
    with Session(engine) as session:
        for i in session.scalars(stmt):
            result = OrganizationSchema.model_validate(i)
    return result
