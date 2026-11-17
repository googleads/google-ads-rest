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

# [START upload_image_asset]
# Creates an image asset.
#
# Variables:
#   API_VERSION,
#   CUSTOMER_ID,
#   MANAGER_CUSTOMER_ID,
#   OAUTH2_ACCESS_TOKEN:
#     See https://developers.google.com/google-ads/api/rest/auth#request_headers
#     for details.
#
#   IMAGE_CONTENT: A base64-encoded string of the raw bytes data of an image.
curl -f --request POST \
"https://googleads.googleapis.com/v${API_VERSION}/customers/${CUSTOMER_ID}/assets:mutate" \
--header "Content-Type: application/json" \
--header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
--data @- <<EOF
{
  "operations": [
    {
      "create": {
        "imageAsset": {
          "data": "${IMAGE_CONTENT}"
        },
        "name": "Marketing Image"
      }
    }
  ]
}
EOF
# [END upload_image_asset]
