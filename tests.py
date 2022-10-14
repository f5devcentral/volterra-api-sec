import os, sys
import requests,re

#Variable Declaration
domainName= os.environ['LBDomainName']
Url_path1 = os.environ['PATH1']
Url_path2 = os.environ['PATH2']

def check_petstore(lbd_name, secure=False):
    """Check if application is running successfully."""
    if secure:
        req = requests.get('https://' + str(lbd_name), verify=False)
    else:
        req = requests.get('http://' + str(lbd_name))
    return req
#Make lb domain name and lb name as secret variables later
print("Verify the usecase with Service policy ALLOW")
url1= domainName + "/" + Url_path1
url2= domainName + "/" + Url_path2
lb_stat_allow = check_petstore(url1)

if lb_stat_allow.status_code == 200 or lb_stat_allow.status_code == 404:
      print("Service policy applied sucessfully!!!\n",lb_stat_allow.text)
else:
    print("Error: Unable to access the LB Domain")
    
print("Verify the usecase with Service policy Deny")
lb_stat_deny= check_petstore(url2)
if "support ID" in lb_stat_deny.text:
    print("Service policy applied sucessfully!!! \n",lb_stat_deny.text)
