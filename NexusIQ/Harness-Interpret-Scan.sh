#Interpret Scan Results - Template
echo "Interpreting Scan Results"

#Get AppID
export AppID=$(curl -u ${secrets.getValue("nexusiq_user")}:${secrets.getValue("nexusiq_password")} -X GET 'http://<iq_public_ip>:8070/api/v2/applications?publicId=webgoat-application' | jq '.applications[0] .id' | tr -d '"')
echo "AppID: " $AppID

#Get Report IDs
export ReportID=$(curl -u ${secrets.getValue("nexusiq_user")}:${secrets.getValue("nexusiq_password")} -X GET 'http://<iq_public_ip>:8070/api/v2/reports/applications/'$AppID'' | jq '.[0] .reportDataUrl' | cut -d'/' -f 6)
echo "ReportID: " $ReportID

#Get Violation Count
export TotalViolations=$(curl -u ${secrets.getValue("nexusiq_user")}:${secrets.getValue("nexusiq_password")} -X GET "http://<iq_public_ip>:8070/api/v2/applications/webgoat-application/reports/"$ReportID"/policy" | jq '.components[] .violations[] .policyThreatLevel' | grep  -c '[${workflow.variables.minfailpoilcyviolation}-9]')
echo "Total Sev Violations: " $TotalViolations

#Exit if Violations Match
if [[ $TotalViolations -gt 0 ]] ; then
  echo "Violations Preventing Deployment"
  exit 1
else
  echo "Moving Forward with Deployment"
  exit 0
fi
