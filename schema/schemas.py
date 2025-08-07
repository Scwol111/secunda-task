"""Schemas of project
"""
from typing import Annotated, Optional, List

from pydantic import BaseModel, Field, ConfigDict, model_validator

class BaseSchema(BaseModel):
    """Base schema
    """
    model_config = ConfigDict(from_attributes=True)

class BuildingShortSchema(BaseSchema):
    """Schema of one building
    """
    id: Annotated[int, Field()]
    address: Annotated[str, Field()]
    latitude: Annotated[float, Field()]
    longitude: Annotated[float, Field()]


class PhoneSchema(BaseSchema):
    """Schema for organization's phones
    """
    id: Annotated[int, Field()]
    phone: Annotated[str, Field()]


class EconomicActivitiesSchema(BaseSchema):
    """Schema for Economic Activities for organizations
    """
    id: Annotated[int, Field()]
    name: Annotated[str, Field()]


class OrganizationSchema(BaseSchema):
    """Schema for organization
    """
    id: Annotated[int, Field()]
    tittle: Annotated[str, Field()]
    building: Annotated[BuildingShortSchema, Field()]
    phones: Annotated[List[PhoneSchema], Field()]
    activities: Annotated[List[EconomicActivitiesSchema], Field()]


class GeoSearchSchema(BaseModel):
    """Schema for geoserching
    """
    organizations: Annotated[List[OrganizationSchema], Field()]
    buildings: Annotated[List[BuildingShortSchema], Field()]
