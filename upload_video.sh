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
#
# This code example uploads a video to YouTube.
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
#   VIDEO_TITLE: The title of the video to upload.
#   VIDEO_DESCRIPTION: The description of the video to upload.
#   VIDEO_FILE_NAME: The file name of the video to upload.

# [START upload_video_1]
# 
# Use the --i curl parameter to capture response headers in the $RESPONSE
# variable.
FILE_SIZE=$(wc -c < "${VIDEO_FILE_NAME}" | tr -d '\r')
RESPONSE=$(curl -i -f -v -s --request POST \
"https://googleads.googleapis.com/resumable/upload/v${API_VERSION}/customers/${CUSTOMER_ID}/youTubeVideoUploads:create" \
--header "Content-Type: application/json" \
--header "developer-token: ${DEVELOPER_TOKEN}" \
--header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
--header "X-Goog-Upload-Protocol: resumable" \
--header "X-Goog-Upload-Command: start" \
--header "X-Goog-Upload-Header-Content-Length: ${FILE_SIZE}" \
--data @- <<EOF
{
  "customer_id": "${CUSTOMER_ID}",
  "you_tube_video_upload": {
    "video_title": "${VIDEO_TITLE}",
    "video_description": "${VIDEO_DESCRIPTION}",
    "video_privacy": "UNLISTED"
  }
}
EOF
)

# Extract the value of the "x-goog-upload-url" header from the HTTP response.
UPLOAD_URL=$(echo "${RESPONSE}" \
  | grep -i '^x-goog-upload-url' \
  | awk '{print $2}' \
  | tr -d '\r')
CHUNK_SIZE=$(echo "${RESPONSE}" \
  | grep -i '^x-goog-upload-chunk-granularity' \
  | awk '{print $2}' \
  | tr -d '\r')
# [END upload_video_1]

# [START upload_video_2]
# Take the first ${CHUNK_SIZE} bytes of the video file and upload them.
head -c ${CHUNK_SIZE} ${VIDEO_FILE_NAME} | curl -i -v -X PUT "${UPLOAD_URL}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
--header "X-Goog-Upload-Offset: 0" \
--header "X-Goog-Upload-Command: upload" \
--header "Content-Length: ${CHUNK_SIZE}" \
--data-binary @-

# Query the status of the upload.
QUERY_RESPONSE=$(curl -i -s -X POST "${UPLOAD_URL}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
--header "X-Goog-Upload-Command: query")

# Extract the value of the "x-goog-upload-size-received" header from the HTTP
# response.
UPLOADED_BYTES=$(echo "${QUERY_RESPONSE}" \
  | grep -i '^x-goog-upload-size-received' \
  | awk '{print $2}' \
  | tr -d '\r')

echo "Uploaded ${UPLOADED_BYTES} bytes."

REMAINING_BYTES=$((FILE_SIZE - UPLOADED_BYTES))
echo "${REMAINING_BYTES} bytes remaining to upload."

FINALIZE_RESPONSE=$(tail -c ${REMAINING_BYTES} ${VIDEO_FILE_NAME} | curl -v -X PUT "${UPLOAD_URL}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
--header "X-Goog-Upload-Offset: ${UPLOADED_BYTES}" \
--header "X-Goog-Upload-Command: upload, finalize" \
--data-binary @-)
UPLOADED_VIDEO_RESOURCE_NAME=$(echo $FINALIZE_RESPONSE | jq -r '.resourceName')
# [END upload_video_2]

# [START upload_video_3]
curl -i -v -X POST \
"https://qa-prod-googleads.sandbox.googleapis.com/v${API_VERSION}/customers/${CUSTOMER_ID}/googleAds:search" \
--header "Content-Type: application/json" \
  --header "Developer-Token: ${DEVELOPER_TOKEN}" \
  --header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
  --header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
  --data @- <<EOF
{
  "query": "SELECT you_tube_video_upload.resource_name, you_tube_video_upload.video_id, you_tube_video_upload.state FROM you_tube_video_upload WHERE you_tube_video_upload.resource_name = '$UPLOADED_VIDEO_RESOURCE_NAME'"
}
EOF
# [END upload_video_3]
