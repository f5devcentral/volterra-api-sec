# volterra-api-sec
This Repo will give you the detailed information on how to automate the testing of F5 Distributed Cloud WAAP Distributed Cloud API Security (https://community.f5.com/t5/technical-articles/f5-distributed-cloud-waap-introducing-the-distributed-cloud-api/ta-p/292993)

# How To Run:
* Pre-requisites:
  * You need to download the certificate and Private key files from your volterra tenant and copy the files with the below names
    certificate file --> certificate-latest.cert
    privatekey file --> private_key-latest.key
    You can refer the below link to know how to download certificate and private key file with your tenant.
    (https://docs.cloud.f5.com/docs/how-to/user-mgmt/credentials)
  * Add the below variables under github-->secrets
    DOMAIN_NAME
    LB_NAME
    POLICYPATH1
    POLICYPATH2
    RESOURCE_LB_NAME
    
