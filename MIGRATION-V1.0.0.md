# Upgrading to ABAP SDK version 1.0.0

Note: If migrating from a version less than v0.3.0, also see the
[v0.3.0 migration guide
wiki](https://github.com/watson-developer-cloud/abap-sdk-nwas/blob/0.3.0/MIGRATION-V0.3.0.md).

<details>
  <summary>Table of Contents</summary>

- [Breaking changes](#breaking-changes)
  - [Breaking changes by service](#breaking-changes-by-service)
    - [Watson Assistant V1](#watson-assistant-v1)
    - [Watson Assistant V2](#watson-assistant-v2)
    - [Compare and Comply V1](#compare-and-comply-v1)
    - [Discovery V2](#discovery-v2)
    - [Text to Speech V1](#text-to-speech-v1)
  - [Discontinued services](#discontinued-services)
    - [Compare and Comply V1](#compare-and-comply-v1-1)
    - [Personality Insights V3](#personality-insights-v3)
    - [Visual Recognition V3 and V4](#visual-recognition-v3-and-v4)

</details>

## Breaking changes

### Breaking changes by service

#### Watson Assistant V1 

Data types `t_Dialog_Node_Output_Generic` and `t_Runtime_Response_Generic` were changed from structures with several components (`RESPONSE_TYPE`, `TEXT`, `VALUES`, ...) to data type `JSONOBJECT`. Depending on the expected data type, data type `JSONOBJECT` must be mapped to the corresponding data structure, for example `t_Dia_Nd_Otpt_Gnrc_Dia_Nd_Otp1` (dialog node output generic) or `t_Rt_Resp_Gnrc_Rt_Resp_Typ_Txt` (runtime response generic).

When you fill in one of these structures and want to assign this structure to a variable of type `JSONOBJECT`, you can use the reference operator `REF` or the deprecated form `GET REFERENCE OF` to perform the mapping. When you receive data in a variable of type `JSONOBJECT` and need to map it to one of these structures, you can use method `move_data_reference_to_abap`, which is provided in the service class `zcl_ibmc_service`.

#### Watson Assistant V2 

Data type `t_Runtime_Response_Generic` was changed from a structure with several components (`RESPONSE_TYPE`, `TEXT`, ...) to data type `JSONOBJECT`. Depending on the expected data type, data type `JSONOBJECT` must be mapped to the corresponding data structure, for example `t_Rt_Resp_Gnrc_Rt_Resp_Typ_Txt`.

When you fill in one of these structures and want to assign this structure to a variable of type `JSONOBJECT`, you can use the reference operator `REF` or the deprecated form `GET REFERENCE OF` to perform the mapping. When you receive data in a variable of type `JSONOBJECT` and need to map it to one of these structures, you can use method `move_data_reference_to_abap`, which is provided in the service class `zcl_ibmc_service`.

#### Compare and Comply V1 

Parameters `I_BEFORE` and `I_AFTER` have been removed from method `LIST_FEEDBACK`.

#### Discovery V2

The Discovery V2 interface is available for Premium Discovery instances only and not supported by the ABAP SDK.

#### Text to Speech V1 

The following types were renamed:

| Old name               | New name                |
|:-----------------------|:------------------------|
| `t_Voice_Model`        | `t_Custom_Model`        |
| `t_Voice_Models`       | `t_Custom_Models`       |
| `t_Create_Voice_Model` | `t_Create_Custom_Model` |
| `t_Update_Voice_Model` | `t_Update_Custom_Model` |

The following methods were renamed:

| Old name             | New name              |
|:---------------------|:----------------------|
| `create_Voice_Model` | `create_Custom_Model` |
| `get_Voice_Model`    | `get_Custom_Model`    |
| `update_Voice_Model` | `update_Custom_Model` |
| `delete_Voice_Model` | `delete_Custom_Model` |
| `list_Voice_Models`  | `list_Custom_Models`  |


### Discontinued services

The following services are discontinued. New service instances cannot be created anymore. The ABAP SDK still includes interfaces to these services, which cannot be used anymore when IBM support of the corresponding service ends.

#### Compare and Comply V1

Existing instances are supported until 30 November 2021 and will be deleted afterwards.

#### Personality Insights V3 

Existing instances are supported until 1 December 2021 and will be deleted afterwards.

#### Visual Recognition V3 and V4

Existing instances are supported until 1 December 2021 and will be deleted afterwards.

