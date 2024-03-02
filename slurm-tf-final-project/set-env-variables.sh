#!/bin/bash

export YC_TOKEN=$(yc config get token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)
export TF_VAR_folder_id=${YC_FOLDER_ID}
export PKR_VAR_subnet_id=$(yc vpc subnet list | awk '/default-ru-central1-a/ {print $2}')
