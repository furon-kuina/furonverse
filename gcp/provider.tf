terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.14.1"
    }
  }
}

provider "google" {
  project = "furonverse"
  region  = "asia-northeast1"
}