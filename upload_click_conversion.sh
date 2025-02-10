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

# This code example uploads a click conversion.
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
#   CONVERSION_ACTION_RESOURCE_NAME: Resource name of the conversion action
#     associated with this conversion.
#   GCLID: The Google click ID (gclid) associated with this conversion.
#   CONVERSION_VALUE: The value of the conversion for the advertiser.
#   CONVERSION_DATE_TIME: The date time at which the conversion occurred. The
#     format is "yyyy-mm-dd hh:mm:ss+|-hh:mm", for example,
#     "2019-01-01 12:32:45-08:00".
#   CURRENCY_CODE: The currency code of the conversion value. This is the
#     ISO 4217 3-character currency code. For example: USD, EUR.
#   CONVERSION_CUSTOM_VARIABLE: The name of the conversion custom variable.
#   CONVERSION_CUSTOM_VARIABLE_VALUE: The value of the conversion custom
#     variable.
#   ORDER_ID: The order ID of the conversion.
curl -f --request POST \
"https://googleads.googleapis.com/v${API_VERSION}/customers/${CUSTOMER_ID}:uploadClickConversions" \
--header "Content-Type: application/json" \
--header "developer-token: ${DEVELOPER_TOKEN}" \
--header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
--data @- <<EOF
{
  "conversions": [
    {
      "conversionAction": "${CONVERSION_ACTION_RESOURCE_NAME}",
      "gclid": "${GCLID}",
      "conversionValue": ${CONVERSION_VALUE},
      "conversionDateTime": "${CONVERSION_DATE_TIME}",
      "currencyCode": "${CURRENCY_CODE}",
      "customVariables": [
        {
          "conversionCustomVariable": "${CONVERSION_CUSTOM_VARIABLE}",
          "value": "${CONVERSION_CUSTOM_VARIABLE_VALUE}"
        }
      ],
      "orderId": "${ORDER_ID}",
      "consent": {
        "adUserData": "GRANTED"
      }
    }
  ],
  "partialFailure": true
}
EOF
