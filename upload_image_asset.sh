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

# Creates an image asset.
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
#   IMAGE_CONTENT: A base64-encoded string of the raw bytes data of an image.

#   IMAGE_MIME_TYPE: The MIME type of the image, for example, IMAGE_JPEG.
#   IMAGE_FILE_SIZE: The file size of the image in bytes, for example, 1000000.
#   IMAGE_HEIGHT: The height of the image, for example, 100.
#   IMAGE_WIDTH: The width of the image, for example, 200.
#   IMAGE_URL: The URL of the image.
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
        "imageAsset": {
          "data": "${IMAGE_CONTENT}",
          "fileSize": "${IMAGE_FILE_SIZE}",
          "mimeType": "${IMAGE_MIME_TYPE}",
          "fullSize": {
            "heightPixels": "${IMAGE_HEIGHT}",
            "widthPixels": "${IMAGE_WIDTH}",
            "url": "${IMAGE_URL}"
          }
        },
        "name": "Marketing Image"
      }
    }
  ]
}
EOF
