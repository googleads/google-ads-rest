#!/bin/bash
# Copyright 2026 Google LLC

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     https://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Sends a campaign mutate request that fails because one operation is invalid.
#
# For details, see
# https://developers.google.com/google-ads/api/rest/examples#partial-failures.
#
# Variables:
#   API_VERSION
#   CAMPAIGN_ID
#   CUSTOMER_ID
#   MANAGER_CUSTOMER_ID
#   OAUTH2_ACCESS_TOKEN

# Don't use -f here, as it's expected to return an HTTP error.
# [START curl_command]
curl --request POST "https://googleads.googleapis.com/v${API_VERSION}/customers/${CUSTOMER_ID}/campaigns:mutate" \
--header "Content-Type: application/json" \
--header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
--data "{
'validateOnly': true,
'partialFailure': false,
'operations': [
  {
    'update': {
      'resourceName': 'customers/${CUSTOMER_ID}/campaigns/${CAMPAIGN_ID}',
      'manualCpc': {
        'enhancedCpcEnabled': false
      }
    },
    'updateMask': 'manual_cpc.enhanced_cpc_enabled'
  },
  {
    'remove': 'customers/${CUSTOMER_ID}/campaigns/INVALID_CAMPAIGN_ID'
  }
]
}"
# [END curl_command]
