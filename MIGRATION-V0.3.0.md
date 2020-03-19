# Upgrading to ABAP SDK version 0.3.0

## Breaking changes

### Breaking changes by service
#### Factory Method
- Parameter `I_PROXY_SERVICE` of method `ZCL_IBMC_SERVICE_EXT=>GET_INSTANCE` is renamed to `I_PROXY_PORT`.

#### Visual Recognition V4
- Parameter `I_UPDATEOBJECTMETADATA` of method `UPDATE_OBJECT_METADATA` is required (previously this was optional).

##
## Special instructions when directly upgrading from versions earlier than 0.2.0

### Table conversion necessary after pull

The ABAP SDK for IBM Watson is now enabled to separate configuration data by storing data into client-specific tables. To achieve this tables `ZIBMC_TOKEN` and `ZIBMC_CONFIG` were made client-specific by adding a column holding the SAP client number.

This change may result in an error when trying to activate the tables. To fix the error please execute the following steps:
1. Call transaction SE14 (Data Dictionary Database Utility).
2. Enter `ZIBMC_TOKEN` for "Object name" and click "Edit".
3. Click "Activate and adjust database" (ensure that radio button "Persist data" is selected).
4. Confirm "adjust" request.
5. Repeat the steps above for table `ZIBMC_CONFIG`.

After this fix, the table content is available only in the SAP client where these steps have been performed. If you want to use configuration data in table `ZIBMC_CONFIG` in another SAP client, you have to copy the records to that SAP client.
