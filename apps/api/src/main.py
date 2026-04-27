from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from typing import List, Optional

app = FastAPI(title="AI-LZ Provisioning API", version="1.0.0")

class WorkspaceRequest(BaseModel):
    team_name: str
    workspace_type: str # sandbox, production, rag_platform
    region: str
    budget_code: str

@app.post("/api/v1/provision")
async def provision_workspace(request: WorkspaceRequest):
    """
    Triggers the Terraform Cloud workflow for an isolated AI Spoke VNet.
    """
    # Validation logic: Check budget and tier
    if request.workspace_type not in ["sandbox", "production"]:
        raise HTTPException(status_code=400, detail="Invalid workspace type.")
    
    # In a real environment, this triggers 'terraform apply'
    return {
        "status": "Accepted",
        "tracking_id": "LZ-99-ALPHA",
        "message": f"Provisioning {request.workspace_type} for {request.team_name} in {request.region}."
    }

@app.get("/api/v1/govern/policies")
async def get_active_policies():
    """Returns the list of active guardrails enforced on the Landing Zone."""
    return [
        {"id": "ALZ-01", "name": "Private Link Mandatory", "status": "Active"},
        {"id": "ALZ-02", "name": "GPU Quota Limit", "status": "Active"},
        {"id": "ALZ-03", "name": "Regional Pinning: UK South", "status": "Active"}
    ]
