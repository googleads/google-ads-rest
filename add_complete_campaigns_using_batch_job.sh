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

# [START add_complete_campaigns_using_batch_job]
# Creates a batch job.
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
"https://googleads.googleapis.com/v${API_VERSION}/customers/${CUSTOMER_ID}/batchJobs:mutate" \
--header "Content-Type: application/json" \
--header "developer-token: ${DEVELOPER_TOKEN}" \
--header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
--data @- <<EOF
{
  "operation": {
    "create": {}
  }
}
EOF
# [END add_complete_campaigns_using_batch_job]

# [START add_complete_campaigns_using_batch_job_1]
# Adds operations to a batch job.
#
# Variables:
#   API_VERSION,
#   CUSTOMER_ID,
#   DEVELOPER_TOKEN,
#   MANAGER_CUSTOMER_ID,
#   OAUTH2_ACCESS_TOKEN:
#     See https://developers.google.com/google-ads/api/rest/auth#request_headers
#     for details.
#   BATCH_JOB_RESOURCE_NAME:
#     The resource name of the batch job to which the operations should be added
#     as returned by the previous step.

curl -f --request POST \
"https://googleads.googleapis.com/v${API_VERSION}/${BATCH_JOB_RESOURCE_NAME}:addOperations" \
--header "Content-Type: application/json" \
--header "developer-token: ${DEVELOPER_TOKEN}" \
--header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
--data @- <<EOF
{
  "mutateOperations": [
    {
      "campaignBudgetOperation": {
        "create": {
          "resourceName": "customers/${CUSTOMER_ID}/campaignBudgets/-1",
          "name": "batch job budget #${RANDOM}",
          "deliveryMethod": "STANDARD",
          "amountMicros": 5000000
        }
      }
    },
    {
      "campaignOperation": {
        "create": {
          "advertisingChannelType": "SEARCH",
          "status": "PAUSED",
          "name": "batch job campaign #${RANDOM}",
          "campaignBudget": "customers/${CUSTOMER_ID}/campaignBudgets/-1",
          "resourceName": "customers/${CUSTOMER_ID}/campaigns/-2",
          "manualCpc": {
          }
        }
      },
    }
  ]
}
EOF
# [END add_complete_campaigns_using_batch_job_1]

# [START add_complete_campaigns_using_batch_job_2]
# Runs a batch job.
#
# Variables:
#   API_VERSION,
#   CUSTOMER_ID,
#   DEVELOPER_TOKEN,
#   MANAGER_CUSTOMER_ID,
#   OAUTH2_ACCESS_TOKEN:
#     See https://developers.google.com/google-ads/api/rest/auth#request_headers
#     for details.
#   BATCH_JOB_RESOURCE_NAME:
#     The resource name of the batch job to run as returned by the previous step.

curl -f --request POST \
"https://googleads.googleapis.com/v19/${BATCH_JOB_RESOURCE_NAME}:run" \
--header "Content-Type: application/json" \
--header "developer-token: ${DEVELOPER_TOKEN}" \
--header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
--data @- <<EOF
{}
EOF

# [END add_complete_campaigns_using_batch_job_2]

# [START add_complete_campaigns_using_batch_job_3]
# Gets the status of a batch job.
#
# Variables:
#   API_VERSION,
#   CUSTOMER_ID,
#   DEVELOPER_TOKEN,
#   MANAGER_CUSTOMER_ID,
#   OAUTH2_ACCESS_TOKEN:
#     See https://developers.google.com/google-ads/api/rest/auth#request_headers
#     for details.
#   BATCH_JOB_OPERATION_NAME:
#     The operation name of the running batch job as returned by the previous
#     step.

curl -f --request GET \
"https://googleads.googleapis.com/v${API_VERSION}/${BATCH_JOB_OPERATION_NAME}" \
--header "Content-Type: application/json" \
--header "developer-token: ${DEVELOPER_TOKEN}" \
--header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \

# [END add_complete_campaigns_using_batch_job_3]

# [START add_complete_campaigns_using_batch_job_4]
# Gets the results of a batch job.
#
# Variables:
#   API_VERSION,
#   CUSTOMER_ID,
#   DEVELOPER_TOKEN,
#   MANAGER_CUSTOMER_ID,
#   OAUTH2_ACCESS_TOKEN:
#     See https://developers.google.com/google-ads/api/rest/auth#request_headers
#     for details.
#   BATCH_JOB_RESOURCE_NAME:
#     The operation name of the running batch job as returned by the previous
#     step.
curl -f --request GET \
"https://googleads.googleapis.com/v${API_VERSION}/${BATCH_JOB_RESOURCE_NAME}:listResults?pageSize=1000" \
--header "Content-Type: application/json" \
--header "developer-token: ${DEVELOPER_TOKEN}" \
--header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}"

# [END add_complete_campaigns_using_batch_job_4]
