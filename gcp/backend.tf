terraform {
  backend "gcs" {
    bucket = "furonverse-tfstate"
    prefix = "gcp"
  }
}
