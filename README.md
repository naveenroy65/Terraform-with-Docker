# Terraform + Docker: Local Nginx Container

## Objective
Provision a local Docker container using Terraform (Docker provider).

## What's included
- `main.tf` — Terraform configuration to pull the `nginx:latest` image and run a container mapping host port `8080` to container port `80`.
- `run.sh` — Convenience script that runs the common Terraform/Docker commands and captures output into `execution_logs.txt` (does not run in this environment; run locally).
- `execution_logs.txt` — **Simulated** example outputs from running the commands (for guidance).
- `README.md` — (this file)

## Prerequisites (on your local machine)
1. Docker installed and the Docker daemon running.
   - macOS / Windows: Docker Desktop.
   - Linux: install Docker Engine and ensure your user can access the socket (or run with sudo).
2. Terraform installed (tested with Terraform 1.0+).
3. A shell (bash) to run the provided `run.sh`, or run commands manually.

## Step-by-step instructions

1. Open a terminal and `cd` into this folder.

2. Initialize Terraform (downloads provider plugins):
```bash
terraform init
```

3. (Optional) Create a plan:
```bash
terraform plan -out=tfplan
```

4. Apply the plan (choose one):
- From the saved plan:
```bash
terraform apply "tfplan"
```
- Or apply directly (non-interactive):
```bash
terraform apply -auto-approve
```

5. Verify the container is running:
```bash
docker ps
curl http://localhost:8080
```

6. Inspect Terraform state and resources:
```bash
terraform state list
terraform show
```

7. Cleanup / destroy:
```bash
terraform destroy -auto-approve
```

## Notes & troubleshooting
- The Docker provider interacts with your local Docker daemon via the `host` you set in `provider "docker"`.
- The `docker_image` resource resolves the image and exposes an `image_id` which the `docker_container` uses to ensure the container is created from that exact image. This avoids ambiguity around the `latest` tag changing between runs.
- If Terraform cannot connect to the Docker daemon, ensure Docker is running and that the socket path `unix:///var/run/docker.sock` is correct for your system, or update the provider `host` accordingly.

## Security
- This example runs a simple public `nginx` image and maps a host port. Do not use `latest` in production without controlled pinning; consider using digest-pinned images.


<img width="1701" height="713" alt="Screenshot 2025-09-25 213244" src="https://github.com/user-attachments/assets/adfc465d-fb5a-46c8-a770-ae50807199a8" />
<br>
<br>
<br>
<img width="1789" height="951" alt="Screenshot 2025-09-25 213258" src="https://github.com/user-attachments/assets/6936857a-d100-4c85-9a52-142248226fd9" />
<br>
<br>
<br>
<img width="1914" height="926" alt="Screenshot 2025-09-25 213345" src="https://github.com/user-attachments/assets/1085ac28-d8fe-4d03-a5f8-9e839294e3dd" />
<br>
<br>
<br>
<img width="1859" height="966" alt="Screenshot 2025-09-25 213149" src="https://github.com/user-attachments/assets/e7d3c012-eee5-41c0-afe4-bf533e856be1" />


