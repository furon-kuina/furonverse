resource "google_secret_manager_secret" "k8s" {
  secret_id = "k8s"
  replication {
    auto {

    }
  }
}

resource "google_service_account" "eso" {
  account_id = "external-secrets-operator"
}

resource "google_project_iam_member" "eso_viewer" {
  project = "furonverse"
  role    = "roles/secretmanager.viewer"
  member  = "serviceAccount:${google_service_account.eso.email}"
}

resource "google_project_iam_member" "eso_accessor" {
  project = "furonverse"
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${google_service_account.eso.email}"
}

resource "google_artifact_registry_repository" "furonverse" {
  location      = "asia-northeast1"
  repository_id = "furonverse"
  description   = "Repository for furonverse"
  format        = "DOCKER"
}


resource "google_service_account" "ar-github" {
  account_id = "artifact-registry-github"
}

resource "google_project_iam_member" "ar-writer" {
  project = "furonverse"
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.ar-github.email}"
}

# used for pulling image by the cluster
resource "google_service_account" "cluster" {
  account_id = "cluster"
}

resource "google_project_iam_member" "cluster_image_pull" {
  project = "furonverse"
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.cluster.email}"
}