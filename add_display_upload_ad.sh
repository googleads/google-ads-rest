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

# Creates a media bundle asset.
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
#   MEDIA_BUNDLE_DATA: A base64-encoded string for Media bundle (ZIP file)
#     asset data.
curl -f --request POST \
"https://googleads.googleapis.com/v${API_VERSION}/customers/${CUSTOMER_ID}/assets:mutate" \
--header "Content-Type: application/json" \
--header "developer-token: ${DEVELOPER_TOKEN}" \
--header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
--data @- <<EOF
{
  "operations": [
    {
      "create": {
        "mediaBundleAsset": {
          "data": "${MEDIA_BUNDLE_DATA}"
        },
        "name": "Ad Media Bundle"
      }
    }
  ]
}
EOF

# Adds a display upload ad to a given ad group.
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
#   FINAL_URL: The final URL of the ad.
#   AD_ASSET_RESOURCE_NAME: The resource name of the media bundle asset created
#     in the previous request.
#   AD_GROUP_RESOURCE_NAME: The resource name of the ad group to add the ad to.
curl -f --request POST \
"https://googleads.googleapis.com/v${API_VERSION}/customers/${CUSTOMER_ID}/adGroupAds:mutate" \
--header "Content-Type: application/json" \
--header "developer-token: ${DEVELOPER_TOKEN}" \
--header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
--data @- <<EOF
{
  "operations": [
    {
      "create": {
        "status": "PAUSED",
        "ad": {
          "name": "Ad for HTML5",
          "finalUrls": [
            "${FINAL_URL}"
          ],
          "displayUploadAd": {
            "mediaBundle": {
              "asset": "${AD_ASSET_RESOURCE_NAME}"
            },
            "displayUploadProductType": "HTML5_UPLOAD_AD"
          }
        },
        "adGroup": "${AD_GROUP_RESOURCE_NAME}"
      }
    }
  ]
}
EOF