from sqlalchemy import Column, Integer, String, Date, Numeric, DateTime, ForeignKey, Text
from sqlalchemy.orm import relationship, declarative_base, Mapped # <-- Mapped is critical here
from typing import List, Optional
from .database import Base

# ===============================
# BASE TABLES
# ===============================
class Personnel(Base):
    __tablename__ = 'personnel'
    personnel_id: int = Column(Integer, primary_key=True)
    name: str = Column(String(50))
    email: str = Column(String(50))
    phone: str = Column(String(50))
    personnel_type: str = Column(String(50))
    contract_hire_date: Date = Column(Date)
    contract_expiration_date: Date = Column(Date)

    performer: Mapped[Optional['Performer']] = relationship(
        'Performer',
        back_populates='personnel',
        uselist=False,
        cascade='all, delete-orphan'
    )
    partner_personnel_contracts: Mapped[List['PartnerPersonnel']] = relationship(
        'PartnerPersonnel',
        back_populates='personnel',
        foreign_keys='PartnerPersonnel.personnel_id'
    )
    assignments: Mapped[List['PersonnelAssignment']] = relationship(
        'PersonnelAssignment',
        back_populates='personnel'
    )
    schedules: Mapped[List['ProductionSchedule']] = relationship(
        'ProductionSchedule',
        back_populates='personnel'
    )

class Performer(Base):
    __tablename__ = 'performer'
    personnel_id: int = Column(Integer, ForeignKey('personnel.personnel_id'), primary_key=True)
    performance_type: str = Column(String(50))
    agency: str = Column(String(50))

    personnel: Mapped['Personnel'] = relationship('Personnel', back_populates='performer')

class PartnerPersonnel(Base):
    __tablename__ = 'partner_personnel'
    partner_id: int = Column(Integer, primary_key=True)
    name: str = Column(String(50))
    service_type: str = Column(String(50))
    personnel_id: int = Column(Integer, ForeignKey('personnel.personnel_id'))
    contact_hire_date: Date = Column(Date)
    contact_expiration_date: Date = Column(Date)
    contract_amount: float = Column(Numeric)
    contact_info: str = Column(Text)

    personnel: Mapped['Personnel'] = relationship('Personnel', back_populates='partner_personnel_contracts', foreign_keys=[personnel_id])
    productions: Mapped[List['Production']] = relationship('Production', back_populates='partner')

# ===============================
# PRODUCTION TABLES
# ===============================

class Production(Base):
    __tablename__ = 'production'
    production_id: int = Column(Integer, primary_key=True)
    title: str = Column(String(50))
    production_type: str = Column(String(50))
    contract_hire_date: Date = Column(Date)
    contract_expiration_date: Date = Column(Date)
    partner_id: int = Column(Integer, ForeignKey('partner_personnel.partner_id'))

    partner: Mapped['PartnerPersonnel'] = relationship('PartnerPersonnel', back_populates='productions')
    general_details: Mapped[Optional['GeneralProduction']] = relationship('GeneralProduction', back_populates='production', uselist=False, cascade='all, delete-orphan')
    event_details: Mapped[Optional['EventProduction']] = relationship('EventProduction', back_populates='production', uselist=False, cascade='all, delete-orphan')
    expenses: Mapped[List['ProductionExpense']] = relationship('ProductionExpense', back_populates='production')
    assignments: Mapped[List['PersonnelAssignment']] = relationship('PersonnelAssignment', back_populates='production')
    schedules: Mapped[List['ProductionSchedule']] = relationship('ProductionSchedule', back_populates='production')
    rental_usages: Mapped[List['RentalUsage']] = relationship('RentalUsage', back_populates='production')

class GeneralProduction(Base):
    __tablename__ = 'generalproduction'
    production_id: int = Column(Integer, ForeignKey('production.production_id'), primary_key=True)
    genre: str = Column(String(50))
    plan_release_quarter: int = Column(Integer)
    plan_release_year: int = Column(Integer)

    production: Mapped['Production'] = relationship('Production', back_populates='general_details')

class EventProduction(Base):
    __tablename__ = 'eventproduction'
    production_id: int = Column(Integer, ForeignKey('production.production_id'), primary_key=True)
    event_type: str = Column(String(50))
    location: str = Column(String(50))
    audience_capacity: int = Column(Integer)

    production: Mapped['Production'] = relationship('Production', back_populates='event_details')

class ProductionExpense(Base):
    __tablename__ = 'productionexpense'
    expense_id: int = Column(Integer, primary_key=True)
    production_id: int = Column(Integer, ForeignKey('production.production_id'))
    expense_type: str = Column(String(50))
    amount: float = Column(Numeric)
    expense_date: Date = Column(Date)
    description: str = Column(Text)

    production: Mapped['Production'] = relationship('Production', back_populates='expenses')

class PersonnelAssignment(Base):
    __tablename__ = 'personnelassignment'
    personnel_id: int = Column(Integer, ForeignKey('personnel.personnel_id'), primary_key=True)
    production_id: int = Column(Integer, ForeignKey('production.production_id'), primary_key=True)
    role_title: str = Column(String(50))

    personnel: Mapped['Personnel'] = relationship('Personnel', back_populates='assignments')
    production: Mapped['Production'] = relationship('Production', back_populates='assignments')

class ProductionSchedule(Base):
    __tablename__ = 'productionschedule'
    prod_schedule_id: int = Column(Integer, primary_key=True)
    production_id: int = Column(Integer, ForeignKey('production.production_id'))
    personnel_id: int = Column(Integer, ForeignKey('personnel.personnel_id'))
    start_dt: DateTime = Column(DateTime)
    end_dt: DateTime = Column(DateTime)
    taskname: str = Column(String(50))
    location: str = Column(String(50))

    production: Mapped['Production'] = relationship('Production', back_populates='schedules')
    personnel: Mapped['Personnel'] = relationship('Personnel', back_populates='schedules')

# ===============================
# RENTAL TABLES
# ===============================

class RentalPlace(Base):
    __tablename__ = 'rentalplace'
    place_id: int = Column(Integer, primary_key=True)
    name: str = Column(String(50))
    address: str = Column(Text)
    type: str = Column(String(50))
    capacity: int = Column(Integer)
    contact_info: str = Column(Text)

    usages: Mapped[List['RentalUsage']] = relationship('RentalUsage', back_populates='place')

class RentalUsage(Base):
    __tablename__ = 'rentalusage'
    usage_id: int = Column(Integer, primary_key=True)
    production_id: int = Column(Integer, ForeignKey('production.production_id'))
    place_id: int = Column(Integer, ForeignKey('rentalplace.place_id'))
    start_time: DateTime = Column(DateTime)
    end_time: DateTime = Column(DateTime)

    production: Mapped['Production'] = relationship('Production', back_populates='rental_usages')
    place: Mapped['RentalPlace'] = relationship('RentalPlace', back_populates='usages')
    payments: Mapped[List['RentalPayment']] = relationship('RentalPayment', back_populates='usage')

class RentalPayment(Base):
    __tablename__ = 'rentalpayment'
    payment_id: int = Column(Integer, primary_key=True)
    usage_id: int = Column(Integer, ForeignKey('rentalusage.usage_id'))
    daily_rate: float = Column(Numeric)
    total_cost: float = Column(Numeric)
    payment_date: Date = Column(Date)

    usage: Mapped['RentalUsage'] = relationship('RentalUsage', back_populates='payments')