const bool isProduction = bool.fromEnvironment('dart.vm.product');

const testConfig = {
  "BASE_URL": "http://10.36.36.81:9180/pcs/api/v1",
  "SERVICE_PREFIX": "/pcs/api/v1",
  "SERVICE_NAME": "pcs",
  "SERVICE_REGION": "bidv",
  "SERVICE_CLIENT_ID": "MSP",
  "SERVICE_AUTH_TYPE": "ows1_request",
  "SERVICE_AUTH_ALGORITHM": "OWS1-HMAC-SHA256",
  "SERVICE_CLIENT_KEY": "3CQFGHLN7_kwxe_z787wN3T85gA7BvxFc1VqrHPn7_Q",
  "SERVICE_REQUEST_TIMEOUT": "60000"
};

const productionConfig = {
  "BASE_URL": "http://10.36.36.81:9180/pcs/api/v1",
  "SERVICE_PREFIX": "/pcs/api/v1",
  "SERVICE_NAME": "pcs",
  "SERVICE_REGION": "bidv",
  "SERVICE_CLIENT_ID": "MSP",
  "SERVICE_AUTH_TYPE": "ows1_request",
  "SERVICE_AUTH_ALGORITHM": "OWS1-HMAC-SHA256",
  "SERVICE_CLIENT_KEY": "3CQFGHLN7_kwxe_z787wN3T85gA7BvxFc1VqrHPn7_Q",
  "SERVICE_REQUEST_TIMEOUT": "60000"
};

final environment = isProduction ? productionConfig : testConfig;


