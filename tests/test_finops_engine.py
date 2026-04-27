import pytest
from apps.cost_engine.main import EnterpriseFinOpsEngine

@pytest.fixture
def finops_engine():
    return EnterpriseFinOpsEngine(tenant_id="TEST-ORG-01")

def test_cost_estimation_logic(finops_engine):
    """Verifies that the GPU cost estimation is mathematically correct."""
    sku = "Standard_NC6s_v3"
    price = finops_engine.get_real_time_estimate(sku)
    assert price == 3.06
    assert isinstance(price, float)

def test_idle_resource_detection(finops_engine):
    """Verifies that idle resources trigger de-provisioning recommendations."""
    idle_metrics = {
        "resource_id": "aks-test",
        "sku": "Standard_NC6s_v3",
        "avg_gpu_utilization": 5.0
    }
    report = finops_engine.analyze_efficiency(idle_metrics)
    assert report["efficiency_status"] == "POOR"
    assert len(report["recommendations"]) == 1
    assert report["recommendations"][0]["action"] == "DE-PROVISION"

def test_optimal_resource_status(finops_engine):
    """Verifies that high-utilization resources are marked as optimal."""
    busy_metrics = {
        "resource_id": "aks-prod",
        "avg_gpu_utilization": 85.0
    }
    report = finops_engine.analyze_efficiency(busy_metrics)
    assert report["efficiency_status"] == "OPTIMAL"
    assert len(report["recommendations"]) == 0
