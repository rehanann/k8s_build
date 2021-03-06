# Demo: Kubernetes 1.17 installation

## Archicture
* Master 1
* worker 1

## deployment method:
* Use Google CLoud platform, and for Infra autoation Jenkins 2, Terraform 0.12.x, and application deployment with Ansible 2.9.
* Put GCP credentials in Jenkins secrets, also for security reasons and donot expose GCP project id copy terraform provider.tf and variables.tf in jenkins secrets.
*  Find nodes deployments in Terraform main.tf file and kubernetes installation ansible playbooks in the ansible directory.
* additional steps: create overlay2 filesystem for docker storage.
## steps for manual installation
* git clone https://github.com/rehanann/k8s_build.git
* terraform init
* terraform plan -out myplan
* terraform plan -out myplan
* ansible-playbook -i host.ini ansible/config.yml
* ansible-playbook -i host.ini ansible/docker-storage-setup-ofs.yml
* ansible-playbook -i host.ini ansible/masters.yml
* ansible-playbook -i host.ini ansible/worker.yml
* ansible-playbook -i host.ini ansible/jenkins.yml
  

<p> 
create provide.tf
</p>
</>
<p>
    provider "google" {  <br>
        project = "project-id" <br>
        region  = "us-central1" <br>
        credentials = "${file("${var.path}/credes.json")}" <br>
    }
</p>

<p>
create variable.tf
</p>
        <p> 
        variable "path" {default = "/var/lib/jenkins/  secerts"} <br>
            variable "project_id" {default = "project_id"} <br>
            variable "image" {default = "project_id/centos-7-custom"} <br>
            variable "machine_type" {default = "n1-standard-2"} <br>
            variable "username" {default = "your_user"} <br>
            variable "region" {default = "us-central1"} <br>
        </p>
