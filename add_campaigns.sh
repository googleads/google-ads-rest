#!/bin/bash
# Copyright 2025 Google LLC

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     https://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Creates a campaign budget.
#
# Variables:
#   API_VERSION,
#   CUSTOMER_ID,
#   DEVELOPER_TOKEN,
#   MANAGER_CUSTOMER_ID,
#   OAUTH2_ACCESS_TOKEN:
#     See https://developers.google.com/google-ads/api/rest/auth#request_headers
#     for details.
curl -f --request POST \
  "https://googleads.googleapis.com/v${API_VERSION}/customers/${CUSTOMER_ID}/campaignBudgets:mutate" \
  --header "Content-Type: application/json" \
  --header "Developer-Token: ${DEVELOPER_TOKEN}" \
  --header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
  --header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
  --data @- <<EOF
{
  "operations": [
    {
      "create": {
        "name":"Interplanetary Cruise Budget #${RANDOM}",
        "deliveryMethod":"STANDARD",
        "amountMicros":500000
      }
    }
  ]
}
EOF

# Creates a campaign.
#
# Variables:
#   API_VERSION,
#   CUSTOMER_ID,
#   DEVELOPER_TOKEN,
#   MANAGER_CUSTOMER_ID,
#   OAUTH2_ACCESS_TOKEN:
#     See https://developers.google.com/google-ads/api/rest/auth#request_headers
#     for details.
#   CAMPAIGN_BUDGET_RESOURCE_NAME:
#     The resource of the campaign budget as returned by the previous step.

curl -f --request POST \
  "https://googleads.googleapis.com/v${API_VERSION}/customers/${CUSTOMER_ID}/campaigns:mutate" \
  --header "Content-Type: application/json" \
  --header "Developer-Token: ${DEVELOPER_TOKEN}" \
  --header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
  --header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
  --data @- <<EOF
{
  "operations": [
    {
      "create": {
        "campaignBudget": "${CAMPAIGN_BUDGET_RESOURCE_NAME}",
        "name": "Interplanetary Cruise Campaign #${RANDOM}",
        "advertisingChannelType": "SEARCH",
        "status": "PAUSED",
        "manualCpc": {},
        "networkSettings": {
          "targetGoogleSearch":true,
          "targetSearchNetwork":true,
          "targetContentNetwork":true,
          "targetPartnerSearchNetwork":false
        }
      }
    }
  ]
}
EOF
