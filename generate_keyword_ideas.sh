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

# This code example generates keyword ideas.
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
#   LANGUAGE: The resource name of the language to target. This is in the format
#     of "languageConstants/{criterion_id}". See
#     https://developers.google.com/google-ads/api/data/codes-formats#languages
#     for the available criterion_id values.
#   GEO_TARGET_CONSTANT: The resource name of the geo target constant to
#     generate keyword ideas for. This is in the format of
#     "geoTargetConstants/{criterion_id}". See
#     https://developers.google.com/google-ads/api/data/geotargets for the
#     available criterion_id values.
#   KEYWORD: The keyword to generate keyword ideas for.
#   URL: The URL of the website to generate keyword ideas for.
curl -f --request POST \
"https://googleads.googleapis.com/v${API_VERSION}/customers/${CUSTOMER_ID}:generateKeywordIdeas" \
--header "Content-Type: application/json" \
--header "developer-token: ${DEVELOPER_TOKEN}" \
--header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
--data @- <<EOF
{
  "language": "${LANGUAGE}",
  "geoTargetConstants": [
    "${GEO_TARGET_CONSTANT}"
  ],
  "includeAdultKeywords": false,
  "keywordPlanNetwork": "GOOGLE_SEARCH",
  "keywordAndUrlSeed": {
    "keywords": [
      "${KEYWORD}"
    ],
    "url": "${URL}"
  }
}
EOF
