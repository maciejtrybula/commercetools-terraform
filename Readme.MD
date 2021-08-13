# commercetools project configuration

## Step-by-step guide

1. Create project in commercetools
2. Create new API client with full access
3. Copy and export from popup values exported as environment variables

#### export those variables before `terraform init` and `terraform plan`
```export CTP_CLIENT_ID=
   export CTP_CLIENT_SECRET=
   export CT_PROJECT_KEY=
   export CTP_SCOPES=
   export CTP_API_URL=
   export CTP_AUTH_URL=
   export CTP_CLIENT_ID=
   
```
4. run `terraform init`
5. run `terraform apply`
