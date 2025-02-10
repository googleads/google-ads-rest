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

# Gets keyword recommendations.
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
"https://googleads.googleapis.com/v${API_VERSION}/customers/${CUSTOMER_ID}/googleAds:search" \
--header "Content-Type: application/json" \
--header "developer-token: ${DEVELOPER_TOKEN}" \
--header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
--data @- <<EOF
{
"query": "
  SELECT
    recommendation.campaign,
    recommendation.keyword_recommendation
  FROM recommendation
  WHERE
    recommendation.type = KEYWORD
"
}
EOF

# Applies a recommendation.
#
# Variables:
#   API_VERSION,
#   CUSTOMER_ID,
#   DEVELOPER_TOKEN,
#   MANAGER_CUSTOMER_ID,
#   OAUTH2_ACCESS_TOKEN:
#     See https://developers.google.com/google-ads/api/rest/auth#request_headers
#     for details.
#
#   RECOMMENDATION_RESOURCE_NAME: The resource name of the recommendation to
#     apply, from the previous request.
curl -f --request POST \
"https://googleads.googleapis.com/v${API_VERSION}/customers/${CUSTOMER_ID}/recommendations:apply" \
--header "Content-Type: application/json" \
--header "developer-token: ${DEVELOPER_TOKEN}" \
--header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
--data @- <<EOF
{
  "operations": [
    {
      "resourceName": "${RECOMMENDATION_RESOURCE_NAME}"
    }
  ]
}
EOF