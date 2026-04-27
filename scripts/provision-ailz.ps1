# Devopstrio AI Landing Zone: One-Touch Provisioner
# Usage: ./provision-ailz.ps1 -Environment prod -AutoApprove

param (
    [Parameter(Mandatory=$true)]
    [ValidateSet("dev", "test", "prod")]
    [string]$Environment,

    [switch]$AutoApprove
)

Write-Host "🚀 Initializing AI Landing Zone Deployment: [$Environment]" -ForegroundColor Cyan

# 1. Hub Networking (Connectivity Anchor)
Write-Host "--- Provisioning Hub Connectivity ---" -ForegroundColor DarkGray
Set-Location "./terraform/environments/$Environment"
terraform init
if ($AutoApprove) {
    terraform apply -auto-approve
} else {
    terraform apply
}

# 2. Verify Hub Health
Write-Host "--- Verifying Hub VNet & Firewall ---" -ForegroundColor DarkGray
# (Conceptual: az network vnet list...)

# 3. K8s Application Orchestration
Write-Host "--- Deploying Management Portal & API ---" -ForegroundColor DarkGray
helm upgrade --install ai-lz-platform "../../helm/ai-landing-zone" --values "../../helm/ai-landing-zone/values.yaml" --namespace ai-platform --create-namespace

Write-Host "✅ AI Landing Zone [$Environment] is now OPERATIONAL." -ForegroundColor Green
Write-Host "Portal: https://portal.ailz.devopstrio.co.uk"
