# variables.tf
    
    variable "resource_group_name" {
      type        = string
      description = "tf-cloud-tp1"
    }
    
    variable "location" {
      type        = string
      default     = "WestEU"
      description = "Azure region"
    }
    
    variable "admin_username" {
      type        = string
      description = "dorian"
    }
    
    variable "public_key_path" {
      type        = string
      description = "~/.ssh/cloud_tp1"
    }
    
    variable "subscription_id" {
      type        = string
      description = "2c1a3857-ab2c-454b-92f8-053d0a5b9f15"
    }

    variable "super_account" {
      description = "cloud-storage"
      type        = string
    }

    variable "super_container" {
      description = "blob-storage"
      type        = string
    }
