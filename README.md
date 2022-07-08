Run terraform from services -> sites-vpc folder with "terraform init", then "terraform apply -var-file=conf/config.tfvars" commands.
Route53 record will be created, but not available from internet, because it is require to register domain (not for free), that's why it is impossible to validate certificate and apply it for 443 port of lb. 443 port (listener) commented in alb.tf file.
