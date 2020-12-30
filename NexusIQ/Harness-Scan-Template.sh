mkdir -p ~/nexus-scans
cd ~/nexus-scans
sudo docker pull webgoat/webgoat-8.0
sudo docker save webgoat/webgoat-8.0:latest > webgoat-8.0.tar
java -jar ~/nexus-cli/nexus-iq-cli.jar -i ${workflow.variables.nexusiqappid} -s http://<iq_public_ip>:8070 -a ${secrets.getValue("nexusiq_user")}:${secrets.getValue("nexusiq_password")} -t build webgoat-8.0.tar
