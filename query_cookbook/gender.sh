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

# Retrieves data from the default Gender demographics overview screen in the
# Google Ads UI.
#
# For details, see
# https://developers.google.com/google-ads/api/docs/query/cookbook#gender.
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
    SELECT ad_group_criterion.gender.type,
      campaign.name,
      ad_group.name,
      ad_group_criterion.system_serving_status,
      ad_group_criterion.bid_modifier,
      metrics.clicks,
      metrics.impressions,
      metrics.ctr,
      metrics.average_cpc,
      metrics.cost_micros,
      campaign.advertising_channel_type
    FROM gender_view
    WHERE segments.date DURING LAST_7_DAYS
  "
}
EOF
# [END curl_command]
