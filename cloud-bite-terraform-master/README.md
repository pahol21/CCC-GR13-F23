## OBJECTIVES:

- Create group GCP project.
- Create a Google Cloud Source Repository git repo and use it for the project together.
- Fork this project to your own repositories and work in those together for the rest of the steps.
- Invite team members to the project with relevant IAM roles assigned.
- Create Terraform landing zone (initialize Terraform, connect with GCP backend) use Terraform for the next steps where it makes sense.
- Create build pipeline for frontend and backend applications.
- Change frontend app so that the backend address comes from configuration.
- Deploy frontend application to Storage Bucket with web settings and publish it with CDN.
- Deploy backend application to Cloud Run.
- Use Secret Manager to store database sensitive information.
- Create Cloud SQL MySQL instance.
- Create secure connection between Cloud Run backend and the deployed MySQL instance.
- Implement generative AI, that generates food images, stores them in a bucket and shows as the menu items (e.g. by acquiring images with a Cloud Function).
- Implement centralised logging and alerting on key metrics for the whole stack.

## STEPS OF IMPLEMENTATION:
 - Initiated a Google Cloud project and invited team members, assigning them specific IAM roles and permissions.
 - The provided repository ressources was cloned into a personal git repository - this was later moved to pahol21 for ease of use
 - Launched a local version of our project using docker-compose.
 - Set up a publicly accessible bucket for the frontend, enabling open read access.
 - Deployed the frontend to the bucket using a basic command-line approach, conducting tests with a locally hosted backend.
 - Deployed the backend as a Docker image using command-line methods. Updated the frontend to fetch backend URL from an .env file.
 - Established a connection with a newly created database.
 - main.tf was written to establish the base ressources / architecture, it was split into multiple files later.
 - Established early, primitive command-line-based deployment procedure.
 - A gcloud Source Repository was set to synchronize with the GitHub repository
 - Added a cloudbuild trigger to the terraform configuration to establish CICD pipeline, re-writing the manual procedure into a top-level cloudbuild.yaml
 - Extended pipeline to include the backend
 - Moved DB credentials to projects' Secret Manager - added secrets to the terraform configuration
 - Separated frontend, backend and terraform into different repositories and synchronized these as described above.
 - Separated top-level cloudbuild into project specific files for each repository
 - Exported backend IP as TF output, as to have the frontend load it into its environment variables during a build step.
 - Added a separate bucket with images for the frontend
 - Enabled CDN for the frontend using a http load-balancer and url map.
 - Added project-level log sink exporting logs for the frontend, backend and DB to a bigquery dataset.
 - Enabled cache invalidation for frontend CDN to improve iteration speed.
