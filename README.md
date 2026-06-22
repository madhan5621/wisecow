# Wisecow - DevOps Trainee Assessment
Accuknox DevOps Trainee Practical Assessment Submission

## Problem Statement 1: Containerization and Kubernetes Deployment

### Overview
Containerized the Wisecow application and deployed it to a Kubernetes 
cluster with an automated CI/CD pipeline and TLS support.

### How to Run Locally (Docker)
1. Build the image:
   docker build -t wisecow:v1 .

2. Run the container:
   docker run -p 4499:4499 wisecow:v1

3. Test it:
   curl http://localhost:4499

### Kubernetes Deployment
1. Apply manifests:
   kubectl apply -f k8s/deployment.yaml
   kubectl apply -f k8s/service.yaml

2. Access the app:
   kubectl port-forward service/wisecow-service 8080:4499
   curl http://localhost:8080

### TLS Setup
Configured TLS using NGINX Ingress Controller and cert-manager 
with a self-signed certificate (appropriate for local clusters 
without a public domain).

To apply:
   kubectl apply -f k8s/selfsigned-issuer.yaml
   kubectl apply -f k8s/ingress.yaml
   kubectl get certificate

Certificate confirmed issued — kubectl get certificate shows READY: True.

### CI/CD Pipeline
GitHub Actions workflow (.github/workflows/ci-cd.yaml) does the following
automatically on every push to main:

- Job 1 (build-and-push):
  Builds the Docker image and pushes it to GitHub Container Registry (ghcr.io)

- Job 2 (deploy):
  Spins up a temporary Kind Kubernetes cluster, applies the manifests,
  updates the deployment with the new image, and verifies the pod is running.

Both jobs confirmed passing (green checkmark in the Actions tab).

---

## Problem Statement 2: Automation Scripts

### Script 1: Application Health Checker
Location: scripts/app_health_checker.sh

Checks whether a web application is up or down by sending an HTTP request
and checking the response status code.
- UP = HTTP 2xx or 3xx response
- DOWN = HTTP 4xx, 5xx, or no response

Usage:
   sh scripts/app_health_checker.sh <URL>

Example:
   sh scripts/app_health_checker.sh https://google.com

Example output:
   ---- Application Health Check ----
   UP - https://google.com (HTTP 200)
   ---- Check Complete ----

### Script 2: Automated Backup Solution
Location: scripts/automated_backup.sh

Backs up a sp