# Sonatype and Harness Integration

Sonatype Nexus IQ is a vulnerability scanning and management platform that supports a multitude of formats. Harness is CI/CD platform focusing on making software delivery simple for everyone. 

This repository shows a few examples on what is needed to call Nexus IQ from Harness. OWASP's WebGoat is used
as an example Docker Image aiming to be deployed into a Kubernetes Cluster. The scripts assume that you have Nexus IQ running
on a Linux/CentOS instance that has a public IP address. 

## Pre-Reqs
A few pre-reqs are needed. The CentOS-Prep.sh will install the needed CentOS pre-reqs. 

* Harness Account [Free/Paid]
* Nexus IQ Account [Trial/Paid]
* CentOS
  * Docker Engine
  * OpenJDK
  * JQ
  * WGET
  
## Harness Specific Attributes
You are able to leverage Harness Workflow Variables [prompts] and the Harness Secrets Manager
to mask sensntive information such as your Nexus IQ credentials. 

### Example
```
#Download and Scan Template
mkdir -p ~/nexus-scans
cd ~/nexus-scans
sudo docker pull webgoat/webgoat-8.0
sudo docker save webgoat/webgoat-8.0:latest > webgoat-8.0.tar
java -jar ~/nexus-cli/nexus-iq-cli.jar -i ${workflow.variables.nexusiqappid} -s http://mynexus:8070 -a ${secrets.getValue("nexusiq_user")}:${secrets.getValue("nexusiq_password")} -t build webgoat-8.0.tar
```
The `${workflow.variables.nexusiqappid}` accesses a Workflow Variable e.g prompting for a Nexus App ID. 
The `${secrets.getValue("nexusiq_user")}` acccesses a value in the Harness Secrets Manager e.g your Nexus User ID. 

## Use

* CentOS-Prep.sh: Installs pre-reqs into a CentOS instance. 
* Install-IQ.sh: Installs Nexus IQ into a CentOS instance. 
* Install-IQ-CLI.sh: Installs Nexus IQ CLI into a CentOS instance. 
* Harness-Scan-Template: Shell file to be called from Harness using a Workflow Variable and Secrets Manager. 
* harness-Interpret-Scan.sh: Shell file to be called from Harness parsing scan report and looking for violations which can be set as a Workflow Variable. 

## Further Material
* Harness Blog Part One: https://harness.io/blog/devops/vulnerability-scanning-ci-cd-pipeline/
* Harness Blog Part Two (Interpreting): https://harness.io/blog/devops/automated-vulnerability-scanning-ci-cd-pipeline/
* Harness Video Part One: https://www.youtube.com/watch?v=WFjDN7dpeXk&feature=youtu.be
* Harness Video Part Two (Interpreting): https://www.youtube.com/watch?v=t5avv7ZNJJc&feature=youtu.be
