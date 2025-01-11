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