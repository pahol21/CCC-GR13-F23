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
 - The provided repository ressources was cloned into a personal git repository  - this was later moved to pahol21 for ease of use
 - main.tf was written to establish the baseline architecture
 - Established early, primitive command-line-based deployment procedure
 - A gcloud Source Repository was set to synchronize with the GitHub repository
 - Added a trigger to main.tf to establish CICD pipeline, re-writing the manual procedure into cloudbuild.yaml
 - 