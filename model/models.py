""" Module that contain project models
"""
from typing import List

from sqlalchemy import ForeignKey, String, Integer, Float, Column, JSON, Table
from sqlalchemy.orm import DeclarativeBase, mapped_column, Mapped, relationship

class Base(DeclarativeBase):
    """Base class for ORM
    """

OrganizationsActivities = Table(
    'organization_activities',
    Base.metadata,
    Column('organization_id', Integer, ForeignKey("organizations.id", ondelete='CASCADE'), primary_key=True),
    Column('activity_id', Integer, ForeignKey("economic_activities.id", ondelete='CASCADE'), primary_key=True)
)

class Buildings(Base):
    """Buildings table
    """
    __tablename__ = 'buildings'
    id: Mapped[int] = mapped_column(Integer, autoincrement=True, primary_key=True)
    address: Mapped[str] = mapped_column(String(255))
    latitude: Mapped[float] = mapped_column(Float)
    longitude: Mapped[float] = mapped_column(Float)
    organizations: Mapped[List["Organizations"]] = relationship(
        back_populates="building", cascade="all, delete-orphan"
    )


class Organizations(Base):
    """Table of organizations
    """
    __tablename__ = 'organizations'
    id: Mapped[int] = mapped_column(Integer, autoincrement=True, primary_key=True)
    tittle: Mapped[str] = mapped_column(String(255), nullable=False)
    building_id: Mapped[int] = mapped_column(ForeignKey("buildings.id"), nullable=False)
    building: Mapped['Buildings'] = relationship(back_populates='organizations', foreign_keys=building_id)
    phones: Mapped[List["OrganizationPhones"]] = relationship(
         back_populates="organization", cascade="all, delete-orphan"
    )
    activities: Mapped[List['EconomicActivities']] = relationship(
        secondary=OrganizationsActivities,
        back_populates='organizations',
    )


class OrganizationPhones(Base):
    """Organization's phone numbers
    """
    __tablename__ = 'organization_phones'
    id: Mapped[int] = mapped_column(Integer, autoincrement=True, primary_key=True)
    phone: Mapped[str] = mapped_column(String(20), nullable=False)
    organization_id: Mapped[int] = mapped_column(ForeignKey("organizations.id"), nullable=False)
    organization: Mapped["Organizations"] = relationship(back_populates='phones')


class EconomicActivities(Base):
    """Classifier of economic activities
    """
    __tablename__ = 'economic_activities'
    id: Mapped[int] = mapped_column(Integer, autoincrement=True, primary_key=True)
    name: Mapped[str] = mapped_column(String(100), nullable=False)
    parent_id: Mapped[int] = mapped_column(ForeignKey('economic_activities.id'), nullable=True, default=None)
    children: Mapped[List['EconomicActivities']] = relationship(
        "EconomicActivities",
        lazy="joined", join_depth=3,
    )
    organizations: Mapped[List['Organizations']] = relationship(
        secondary=OrganizationsActivities,
        back_populates='activities',
    )
