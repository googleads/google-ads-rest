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

# Looks up geo target constants by display name.
#
# For details, see
# https://developers.google.com/google-ads/api/docs/query/cookbook#by-display-name.
#
# Variables:
#   API_VERSION
#   CUSTOMER_ID
#   MANAGER_CUSTOMER_ID
#   OAUTH2_ACCESS_TOKEN

# [START curl_command]
curl --compressed --fail-with-body --request POST \
  "https://googleads.googleapis.com/v${API_VERSION}/customers/${CUSTOMER_ID}/googleAds:searchStream" \
  --header "Content-Type: application/json" \
  --header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
  --header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
  --data @- <<'EOF'
{
  "query": "
    SELECT geo_target_constant.canonical_name,
      geo_target_constant.country_code,
      geo_target_constant.id,
      geo_target_constant.name,
      geo_target_constant.status,
      geo_target_constant.target_type
    FROM geo_target_constant
    WHERE geo_target_constant.country_code = 'US'
      AND geo_target_constant.target_type = 'City'
      AND geo_target_constant.name = 'Mountain View'
      AND geo_target_constant.status = 'ENABLED'
  "
}
EOF
# [END curl_command]
