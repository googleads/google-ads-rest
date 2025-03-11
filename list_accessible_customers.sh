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

# [START list_accessible_customers]
# Returns the resource names of customers directly accessible by the user
# authenticating the call.
#
# Variables:
#   API_VERSION,
#   DEVELOPER_TOKEN,
#   OAUTH2_ACCESS_TOKEN:
#     See https://developers.google.com/google-ads/api/rest/auth#request_headers
#     for details.
#
curl -f --request GET \
"https://googleads.googleapis.com/v${API_VERSION}/customers:listAccessibleCustomers" \
--header "Content-Type: application/json" \
--header "developer-token: ${DEVELOPER_TOKEN}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
# [END list_accessible_customers]
