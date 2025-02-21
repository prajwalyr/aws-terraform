Terraform Infra to deploy Jenkins Server on AWS.

1. The instance is assigned to an elastic IP and have scheduled ebs snapshots once per day.
2. Jenkins is deployed using docker compose, and have ensured data persistence for jenkins.
3. Maintaining the docker compose in github repo and cloning the docker compose in the instance to launch Jenkins Server


Terraform code for creating a Managed Kubernetes Cluster(EKS) and deploying Authentik Application.

1. Data Persistence & backups are taken care. 
2. Database and Application are running in separate pods.
3. Reference: https://docs.goauthentik.io/docs/install-config/
