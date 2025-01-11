resource "google_secret_manager_secret" "test" {
  secret_id = "test"
  replication {
    auto {

    }
  }
}

resource "google_secret_manager_secret_version" "test" {
  secret      = google_secret_manager_secret.test.id
  secret_data = file("${path.module}/secret.json") # string形式なのでこれ

  deletion_policy = "DELETE" # 新規バージョン作成時、過去のバージョンを全て破棄
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