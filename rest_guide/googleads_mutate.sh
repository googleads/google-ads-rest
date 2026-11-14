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

# Creates a campaign budget, campaign, ad group, and ad in a single
# GoogleAdsService.Mutate request.
#
# For details, see
# https://developers.google.com/google-ads/api/rest/examples#grouped-operations.
#
# Variables:
#   API_VERSION
#   CUSTOMER_ID
#   MANAGER_CUSTOMER_ID
#   OAUTH2_ACCESS_TOKEN

# [START curl_command]
curl -f --request POST "https://googleads.googleapis.com/v${API_VERSION}/customers/${CUSTOMER_ID}/googleAds:mutate" \
--header "Content-Type: application/json" \
--header "login-customer-id: ${MANAGER_CUSTOMER_ID}" \
--header "Authorization: Bearer ${OAUTH2_ACCESS_TOKEN}" \
--data "{
'validateOnly': true,
'mutateOperations': [
  {
    'campaignBudgetOperation': {
      'create': {
        'resourceName': 'customers/${CUSTOMER_ID}/campaignBudgets/-1',
        'name': 'My Campaign Budget #${RANDOM}',
        'deliveryMethod': 'STANDARD',
        'amountMicros': 500000,
        'explicitlyShared': false
      }
    }
  },
  {
    'campaignOperation': {
      'create': {
        'resourceName': 'customers/${CUSTOMER_ID}/campaigns/-2',
        'status': 'PAUSED',
        'advertisingChannelType': 'SEARCH',
        'geoTargetTypeSetting': {
          'positiveGeoTargetType': 'PRESENCE_OR_INTEREST',
          'negativeGeoTargetType': 'PRESENCE_OR_INTEREST'
        },
        'name': 'My Search campaign #${RANDOM}',
        'campaignBudget': 'customers/${CUSTOMER_ID}/campaignBudgets/-1',
        'targetSpend': {}
      }
    }
  },
  {
    'adGroupOperation': {
      'create': {
        'resourceName': 'customers/${CUSTOMER_ID}/adGroups/-3',
        'campaign': 'customers/${CUSTOMER_ID}/campaigns/-2',
        'name': 'My ad group #${RANDOM}',
        'status': 'PAUSED',
        'type': 'SEARCH_STANDARD'
      }
    }
  },
  {
    'adGroupAdOperation': {
      'create': {
        'adGroup': 'customers/${CUSTOMER_ID}/adGroups/-3',
        'status': 'PAUSED',
        'ad': {
          'responsiveSearchAd': {
            'headlines': [
              {
                'pinned_field': 'HEADLINE_1',
                'text': 'An example headline'
              },
              {
                'text': 'Another example headline'
              },
              {
                'text': 'Yet another headline'
              }
            ],
            'descriptions': [
              {
                'text': 'An example description'
              },
              {
                'text': 'Another example description'
              }
            ],
            'path1': 'all-inclusive',
            'path2': 'deals'
          },
          'finalUrls': ['https://www.example.com']
        }
      }
    }
  }
]
}"
# [END curl_command]
