from sqlalchemy import Column, Integer, String, Float, ForeignKey, DateTime, JSON, Boolean
from sqlalchemy.orm import relationship, declarative_base
import datetime

Base = declarative_base()

class Tenant(Base):
    __tablename__ = "tenants"
    id = Column(String, primary_key=True)
    name = Column(String, nullable=False)
    subscription_id = Column(String)  # Target Azure Subscription for this tenant
    created_at = Column(DateTime, default=datetime.datetime.utcnow)

class AIWorkspaceRequest(Base):
    __tablename__ = "workspace_requests"
    id = Column(String, primary_key=True)
    tenant_id = Column(String, ForeignKey("tenants.id"))
    workspace_type = Column(String) # sandbox, production, rag_platform
    region = Column(String)
    requester_email = Column(String)
    status = Column(String, default="pending_governance") # pending_governance, approved, provisioning, failed, ready
    approval_comment = Column(String)
    created_at = Column(DateTime, default=datetime.datetime.utcnow)

class ProvisionedResource(Base):
    __tablename__ = "provisioned_resources"
    id = Column(Integer, primary_key=True)
    request_id = Column(String, ForeignKey("workspace_requests.id"))
    resource_type = Column(String) # vnet, aks, openai, keyvault
    resource_id = Column(String)   # Azure ARM ID
    provisioning_state = Column(String)
    last_updated = Column(DateTime, onupdate=datetime.datetime.utcnow)

class CostAllocation(Base):
    __tablename__ = "cost_allocations"
    id = Column(Integer, primary_key=True)
    tenant_id = Column(String, ForeignKey("tenants.id"))
    resource_id = Column(String)
    daily_cost = Column(Float)
    currency = Column(String, default="USD")
    usage_date = Column(DateTime)
    tag_bu = Column(String) # Business Unit Tag for chargeback

class SecurityFinding(Base):
    __tablename__ = "security_findings"
    id = Column(Integer, primary_key=True)
    resource_id = Column(String)
    severity = Column(String) # critical, high, medium, low
    finding_description = Column(String)
    is_remediated = Column(Boolean, default=False)
    detected_at = Column(DateTime, default=datetime.datetime.utcnow)
