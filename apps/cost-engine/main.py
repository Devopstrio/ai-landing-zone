import json
from datetime import datetime, timedelta

class CostIntelligenceEngine:
    """Enterprise FinOps Engine for AI Landing Zone."""
    
    def __init__(self):
        # Sample Unit Costs (Simulated for Enterprise)
        self.gpu_hourly_cost = 3.06 # NC6s_v3
        self.token_cost_per_1k = 0.03 # gpt-4o

    def calculate_bu_chargeback(self, usage_data: list) -> dict:
        """
        Calculates departmental chargeback for ingested usage metrics.
        """
        report = {}
        for entry in usage_data:
            bu = entry['business_unit']
            if bu not in report:
                report[bu] = {"total_usd": 0.0, "gpu_hours": 0, "token_volume": 0}
            
            report[bu]["gpu_hours"] += entry.get('gpu_hours', 0)
            report[bu]["token_volume"] += entry.get('tokens', 0)
            
            # Weighted calculation
            cost = (entry.get('gpu_hours', 0) * self.gpu_hourly_cost) + \
                   (entry.get('tokens', 0) / 1000 * self.token_cost_per_1k)
            
            report[bu]["total_usd"] += round(cost, 2)
            
        return {
            "fiscal_period": "Q4-2026",
            "currency": "USD",
            "departmental_breakdown": report,
            "forecast": self._generate_forecast(report)
        }

    def _generate_forecast(self, report: dict) -> str:
        total = sum(d['total_usd'] for d in report.values())
        return f"Projected 30-day spend: ${round(total * 1.15, 2)} based on current velocity."

if __name__ == "__main__":
    engine = CostIntelligenceEngine()
    sample_usage = [
        {"business_unit": "Retail-AI", "gpu_hours": 120, "tokens": 500000},
        {"business_unit": "Finance-GenAI", "gpu_hours": 45, "tokens": 2000000}
    ]
    print(json.dumps(engine.calculate_bu_chargeback(sample_usage), indent=4))
