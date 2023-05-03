# Secure Web Gateway example

This project contains examples how to provision all necessary resources to use Secure Web Gateway in Google Cloud Platform through terraform. It covers the [quickstart tutorial](https://cloud.google.com/secure-web-proxy/docs/quickstart#create-secure-web-proxy-policy) but using the terraform instead.

## Requirements

### Terraform plugins

- [Terraform](https://www.terraform.io/downloads.html) ~> 1.1.x
- [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) plugin ~> v4.XY.x <!-- TODO(felipegc) update the version once the last resource is launched -->

### GCP project

A project where all resources will be created. The project must contain the following service apis enabled:

- compute.googleapis.com
- certificatemanager.googleapis.com
- networksecurity.googleapis.com
- networkservices.googleapis.com

### GCP user account

A user account that contains the following roles at project level:

- Compute Network Admin
- Compute Security Admin
- Certificate Manager Owner

### SSL certificate

A valid SSL certificate to be uploaded to the certificate manager. 

__Note:__ You may want to generate a self signed certificate for test purpose:

```bash
export KEY_PATH="<the path to save the key, such as `./selfsignedkeys/key.pem`>"
export CERTIFICATE_PATH="<the path to save the certificate, such as `./selfsignedkeys/cert.pem`>"
export SWP_HOST_NAME="<the hostname for your Secure Web Proxy instance, such as `myswp.example.com`>"
```

```bash
openssl req -x509 -newkey rsa:2048 \
  -keyout ${KEY_PATH} \
  -out ${CERTIFICATE_PATH} -days 365 \
  -subj '/CN=${SWP_HOST_NAME}' -nodes -addext \
  "subjectAltName=DNS:{SWP_HOST_NAME}"
```

## Usage

You will find different examples under the `examples` folder in this directory.
Inside of each folder there is a file called `terraform.example.tfvars.json`. These files contain all necessary parameters to run the examples easily.

### From one of the examples

1. Enable the [application default credentials](https://cloud.google.com/docs/authentication/provide-credentials-adc):

    ```bash
    gcloud auth application-default login
    ```

1. Choose one example and go to its folder. For example:

    ```bash
    cd examples/basic_swg
    ```

1. Copy `terraform.example.tfvars.json` to `terraform.tfvars.json` and update `terraform.tfvars.json` with values from your environment.

    ```bash
    cp terraform.example.tfvars.json terraform.tfvars.json
    ```

1. Run `terraform plan` and review the plan

    ```bash
    terraform plan
    ```

1. Run `terraform apply`

    ```bash
    terraform apply
    ```

1. Run `terraform detroy` in order to deleted all secure web gateway related resources

    ```bash
    terraform destroy
    ```

### Tests

You may want to test all resource are successfully working as expected by performing a request through the created `secure web gateway` you just created.

1. Create a vm instance under the same subnetwork where the gateway resources were created. You may create by using `gcloud` CLI tool:
   
    ```bash
    export SUBNETWORK_NAME="<the chosen subnetwork where the resources were created `default`>"
    export ZONE="<a zone for the region where the swg esources were created such as `us-central1-a`>"
    export VM_INSTANCE_NAME="<vm instance name whetever you like such as `swg-test-vm`>"
    export PROJECT_ID="<project_id where the resources were created>"
    ```

    ```bash
    gcloud compute instances create ${VM_INSTANCE_NAME} \
    --subnet=${SUBNETWORK_NAME} \
    --zone=${ZONE} \
    --project=${PROJECT_ID} \ 
    --image-project=debian-cloud \
    --image-family=debian-11

    ```

1. SSH into the vm instance. You may access the vm instance by using `gcloud` CLI tool:
   
   ```bash
    gcloud compute ssh ${VM_INSTANCE_NAME} \
    --zone=${ZONE}
   ```

    __Note:__ You may have to create a ssh firewall rule in order to ssh into the machine:

    ```bash
    export NETWORK_NAME="<the chosen network where the resources were created such as `default`>"
    export DEST_RANGES="<the chosen `subnet_ip_cidr_range` usend in `terraform.tfvars.json` such as `10.128.0.0/20`"
    ```

    ```bash
    gcloud compute firewall-rules create allow-ssh --network ${NETWORK_NAME} --direction ingress --action=ALLOW --rules=tcp:22 --rules all --destination-ranges ${DEST_RANGES} --project=${PROJECT_ID}
    ```

1. Perform a https request through the secure web gateway to hit the allowed `session_matcher_rule` you defined in `terraform.tfvars.json`
    
    ```bash
    export GATEWAY_ADDRESS="<the chosen `gateway_address` in `terraform.tfvars.json`>"
    export TARGET="<the chosen address you defined in `session_matcher_rule` in `terraform.tfvars.json` such as `example.com`>"
    ```

    ```bash
    curl -x https://${GATEWAY_ADDRESS}:443 https://${TARGET_HOST}
    ```