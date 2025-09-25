#!/usr/bin/env bash
set -euo pipefail

LOG="execution_logs.txt"
echo "=== Running Terraform + Docker demo (local) ===" > "$LOG"
echo "" >> "$LOG"

echo ">>> terraform init" | tee -a "$LOG"
terraform init 2>&1 | tee -a "$LOG"

echo "" | tee -a "$LOG"
echo ">>> terraform plan -out=tfplan" | tee -a "$LOG"
terraform plan -out=tfplan 2>&1 | tee -a "$LOG"

echo "" | tee -a "$LOG"
echo ">>> terraform apply tfplan" | tee -a "$LOG"
terraform apply "tfplan" 2>&1 | tee -a "$LOG"

echo "" | tee -a "$LOG"
echo ">>> docker ps" | tee -a "$LOG"
docker ps --format 'table {{.ID}}\t{{.Image}}\t{{.Names}}\t{{.Ports}}' 2>&1 | tee -a "$LOG"

echo "" | tee -a "$LOG"
echo ">>> terraform state list" | tee -a "$LOG"
terraform state list 2>&1 | tee -a "$LOG"

echo "" | tee -a "$LOG"
echo ">>> terraform destroy -auto-approve" | tee -a "$LOG"
terraform destroy -auto-approve 2>&1 | tee -a "$LOG"

echo "" | tee -a "$LOG"
echo "=== Demo completed ===" | tee -a "$LOG"