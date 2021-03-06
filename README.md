# Example of a secured API Management instance fronting Azure Functions

Basic demo of a minimally secured API with a single Azure Function behind it. The stack is Serverless Framework, Typescript, Babel and Webpack.

At this stage the demo helps you:

- Deploy an API with a basic function (written in Typescript)
- [Set authorization mode](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-http-webhook-trigger?tabs=javascript#configuration) to `function` (no anonymous function access; must go through API)
- Require an API key ("subscription") in the `Ocp-Apim-Subscription-Key` header
- Rate limit the API
- Set CORS
- Strip headers
- Change response URL

Note that rate limiting does not work on Consumption plans.

**It is highly recommended that you configure and run the "postfix" security improvement script!** While it's technically possible to run ARM templates together with Serverless Framework, I personally find the templates too wordy and unintuitive. Instead, just run the simple script `postfix-security.sh` to tighten security on the deployment bucket and the function app. Doing so, you will remove public bucket access, force HTTP2 and HTTPS transfers, disable FTP and force the use of TLS 1.2 as the minimum version. There's also an additional adjustment that turns on 64-bit workers.

## Installation

Just `yarn install` or `npm install`.

## Creating and setting the API key ("subscription")

This has to be a manual step.

Follow the guide at [https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-create-subscriptions](https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-create-subscriptions).

## Configuration

### CORS

Change settings to whatever you need, now it's just open. Available under `cors` in `serverless.yml`.

### API Policy

You can add the example policy (`policy-example.xml`) to the API Management instance if you'd like. AFAIK you'll need to do this manually. It does not seem to get overwritten by Serverless Framework on re-deployment (good, I guess). The policy is based on the below reference link ("Secure an HTTP endpoint in production") and combined with what's generated from this repo's `serverless.yml`.

#### Headers and response URL

This example can strip headers and change response URL: both are copy-pasted examples that won't do much in this particular demo repo. Change the values to whatever your needs are instead!

#### Rate limiting

Note that the `<rate-limit-by-key ... />` block will not work with a Consumption plan.

## Deployment

Given you have environment access to Azure, you only need to run `sls deploy`.

## References

- [serverless-azure-functions: API Management](https://github.com/serverless/serverless-azure-functions/blob/master/docs/examples/apim.md)
- [Create subscriptions in Azure API Management](https://docs.microsoft.com/en-us/azure/api-management/api-management-howto-create-subscriptions)
- [Secure an HTTP endpoint in production](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-http-webhook-trigger?tabs=javascript#secure-an-http-endpoint-in-production)
- [Azure Functions HTTP trigger](https://docs.microsoft.com/en-us/azure/azure-functions/functions-bindings-http-webhook-trigger?tabs=javascript#configuration)
- [API Management transformation policies](https://docs.microsoft.com/en-us/azure/api-management/api-management-transformation-policies)
