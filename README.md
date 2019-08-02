# ElasticSearch-OCI-ExistingSubnet

## Initialize the deployment
Clone the module and change to the directory.

Update the terraform variables mentioned in `env-vars.sh` and source it.

Check and update the variable definition in `variables.tf` and update the values in `terraform.tfvars` file. 

Make sure the subnet you specified is a Public Subnet with Route Table configured with Internet Gateway for outbound traffic. Also make sure the Security List associated with the subnet has Ingress rules allowed for `9200/TCP` & `5601/TCP` ports.

We now need to initialize the directory with the module in it.  This makes the module aware of the OCI provider.  You can do this by running:

    terraform init

## Deploy the module
Now for the main attraction.  Let's make sure the plan looks good:

    terraform plan


If that's good, we can go ahead and apply the deploy:

    terraform apply

You'll need to enter `yes` when prompted.  


When the apply is complete, the infrastructure will be deployed, but cloud-init scripts will still be running.  Those will wrap up asynchronously.  So, it'll be a few more minutes before your cluster is accessible.  Now is a good time to get a coffee.


## Connect to Elasticsearch
When the module is deployed, findout the ElasticSearch node's public IP.

Create an SSH tunnel for ports `9200` and `5601` with the following command:

`ssh -L 9200:localhost:9200 -L 5601:localhost:5601 opc@<ES VM public IP`

Now you can browse to (http://localhost:9200) for Elasticsearch, and (http://localhost:5601) for Kibana.

## Destroy the Deployment
When you no longer need the deployment, you can run this command to destroy it:

    terraform destroy

You'll need to enter `yes` when prompted.
