___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "WiderPlanet Tag Script",
  "brand": {
    "id": "brand_dummy",
    "displayName": ""
  },
  "description": "wp_items : EventType(Item, Cart, PurchaseComplete) - Required value\nex)\nvar wp_items \u003d wp_items || [];\nwp_items.push({i:\"p_id\", t:\"p_name\", p:\"10000\", q:\"2\"});",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "ClientID",
    "displayName": "ClientID  (Required value)",
    "simpleValueType": true,
    "valueValidators": [
      {
        "type": "NUMBER"
      }
    ]
  },
  {
    "type": "SELECT",
    "name": "EventType",
    "displayName": "EventType (Required value)",
    "selectItems": [
      {
        "value": "Home",
        "displayValue": "Home"
      },
      {
        "value": "Login",
        "displayValue": "Login"
      },
      {
        "value": "Join",
        "displayValue": "Join"
      },
      {
        "value": "Item",
        "displayValue": "Item (Additional Required value : wp_items)"
      },
      {
        "value": "Cart",
        "displayValue": "Cart (Additional Required value : wp_items)"
      },
      {
        "value": "PurchaseComplete",
        "displayValue": "PurchaseComplete (Additional Required value : wp_items)"
      }
    ],
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const copyFromWindow = require('copyFromWindow');
const injectScript = require('injectScript');
const log = require('logToConsole');

scriptCall(data.EventType);

function scriptCall(EventType) {
  injectScript('https://cdn-aitg.widerplanet.com/js/wp_astg_6.0.js', function() {
    const wp_items = copyFromWindow('wp_items');
    const wpts = copyFromWindow('wpts');
    
    wpts.init(data.ClientID);
    
    if (EventType == 'Home') {
      wpts.tag();
    } else if (EventType == 'Login' || EventType == 'Join') {
      wpts.tag({
        ty: EventType,
        items: [ {i:EventType, t:EventType, p:1, q:1} ]
      });
    } else if (EventType == 'Item' || EventType == 'Cart' || EventType == 'PurchaseComplete') {
      wpts.tag({
        ty: EventType,
        items: wp_items
      });
    }
    
  }, function(err) {
    log('inject error:' + err);
  });
}

data.gtmOnSuccess();


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "all"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "wpts"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "wptg_tagscript_vars"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "wp_items"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": true
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "inject_script",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urls",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "https://*.widerplanet.com/"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios:
- name: Quick Test
  code: runCode();
setup: ''


___NOTES___

Created on 2021. 5. 24. 오전 11:58:46


