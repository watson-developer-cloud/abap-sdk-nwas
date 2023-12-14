# Upgrading to ABAP SDK version 2.0.0

Note: If migrating from a version less than v1.0.0, also see the
[v1.0.0 migration guide
wiki](https://github.com/watson-developer-cloud/abap-sdk-nwas/blob/1.0.0/MIGRATION-V1.0.0.md).

<details>
  <summary>Table of Contents</summary>

- [Breaking changes](#breaking-changes)
  - [Breaking changes by service](#breaking-changes-by-service)
    - [Watson Assistant V1](#watson-assistant-v1)
    - [Watson Assistant V2](#watson-assistant-v2)
    - [Language Translator V3](#language-translator-v3)
    - [Speech to Text V1](#speech-to-text-v1)
  - [New features by service](#new-features-by-service)
    - [Watson Assistant V1](#watson-assistant-v1-1)
    - [Watson Assistant V2](#watson-assistant-v2-1)
    - [Discovery V2](#discovery-v2)
    - [Natural Language Understanding V1](#natural-language-understanding-v1)
    - [Text to Speech V1](#text-to-speech-v1)
    - [Speech to Text V1](#speech-to-text-v1-1)
  - [Discontinued services](#discontinued-services)
    - [Discontinued services still included in the ABAP SDK in version 2.0.0](#discontinued-services-still-included-in-the-abap-sdk-in-version-200)
      - [Language Translator V3](#language-translator-v3-1)
    - [Discontinued services removed from the ABAP SDK in version 2.0.0](#discontinued-services-removed-from-the-abap-sdk-in-version-200)
      - [Compare and Comply V1](#compare-and-comply-v1)
      - [Discovery V1](#discovery-v1)
      - [Natural Language Classifier V1](#natural-language-classifier-v1)
      - [Personality Insights V3](#personality-insights-v3)
      - [Tone Analyzer V3](#tone-analyzer-v3)
      - [Visual Recognition V3 and V4](#visual-recognition-v3-and-v4)

</details>

## Breaking changes

### Breaking changes by service

#### Watson Assistant V1

Component `Text` was removed from structure `t_Output_Data` for method `message`. The returned data is now available in component `Generic`, a standard table of `t_Runtime_Response_Generic`, which results in data of type `JSONOBJECT`. To convert data in a variable of type `JSONOBJECT` to data type string, you can use method `move_data_reference_to_abap`, which is provided in the service class `zcl_ibmc_service`.

#### Watson Assistant V2

Data type `t_Dialog_Nodes_Visited` was renamed to `t_Dialog_Node_Visited`.

#### Language Translator V3

The following input parameters for method `Create_Model` were renamed:

| Old name               | New name                         |
|:-----------------------|:---------------------------------|
| `i_Forced_Glossary_ct` | `i_Forced_Glossary_Content_Type` |
| `i_Parallel_Corpus_ct` | `i_Parallel_Corpus_Content_Type` |

Default values for these parameters are no longer provided.

#### Speech to Text V1

- Methods `Recognize` and `Create_Job`:

  - Parameter `i_Customization_Id` was removed - use
    parameter `i_Language_Customization_Id` instead.

- Method `Add_Grammar`

  - Type of parameter `i_Grammar_File` was changed from
    `String` to `File`.

### New features by service

#### Watson Assistant V1

- Support for asynchronous workspace operations - new methods:

  - `Create_Workspace_Async`, `Export_Workspace_Async`, `Update_Workspace_Async`

#### Watson Assistant V2

- Support to create and modify assistants, releases, skills and environments - new methods:

  - `Create_Assistant`, `Delete_Assistant`, `List_Assistants`
  - `Create_Release`, `Delete_Release`, `Deploy_Release`, `Get_Release`, `List_Releases`
  - `Export_Skills`, `Get_Skill`, `Import_Skills`, `Import_Skills_Status`, `Update_Skill`
  - `Get_Environment`, `List_Environments`, `Update_Environment`

#### Discovery V2

The ABAP SDK includes now interfaces to all Discovery V2
methods. See details on IBM's documentation site
[here](https://cloud.ibm.com/apidocs/discovery-data).

#### Natural Language Understanding V1

- Support to create and modify custom models - new methods:

  - `create_categories_model`, `list_categories_models`, `get_categories_model`, `update_categories_model`, `delete_categories_model`
  - `create_classifications_model`, `list_classifications_models`, `get_classifications_model`, `update_classifications_model`, `delete_classifications_model`

#### Text to Speech V1

- Support for custom prompts and speaker models - new methods:

  - `List_Custom_Prompts`, `Get_Custom_Prompt`, `Add_Custom_Prompt`, `Delete_Custom_Prompt`
  - `List_Speaker_Models`, `Get_Speaker_Model`, `Create_Speaker_Model`, `Delete_Speaker_Model`

- Method `Synthesize`:

  - New optional parameters `i_Spell_Out_Mode`,
    `i_Rate_Percentage` and`i_Pitch_Percentage`.

See details of these new methods and parameters on IBM's
documentation site [here](https://cloud.ibm.com/apidocs/text-to-speech).

#### Speech to Text V1

- Methods `Recognize` and `Create_Job`:

  - New optional parameters `i_Low_Latency` and  `i_Character_Insertion_Bias`.

- Methods `Train_Language_Model` and `Train_Acoustic_Model`:

  - New optional parameter `i_strict`.

See details of these new parameters on IBM's documentation
site [here](https://cloud.ibm.com/apidocs/speech-to-text).


### Discontinued services

#### Discontinued services still included in the ABAP SDK in version 2.0.0

The following service is discontinued. New service instances cannot be created anymore. The ABAP SDK still includes interfaces to this service, which cannot be used anymore when IBM support of the corresponding service ends.

##### Language Translator V3

Existing instances are supported until 10 June 2024 and will be deleted afterwards.

#### Discontinued services removed from the ABAP SDK in version 2.0.0

The following services are discontinued. New service instances cannot be created anymore. Interfaces to these services have been removed from the ABAP SDK.

##### Compare and Comply V1

Discontinued since 30 November 2021.

##### Discovery V1

Discontinued since 11 July 2023. Migrate to Discovery V2.

##### Natural Language Classifier V1

Discontinued since 9 August 2021. Migrate to Natural Language Understanding V1.

##### Personality Insights V3

Discontinued since 1 December 2021.

##### Tone Analyzer V3

Discontinued since 24 February 2023. Migrate to Natural Language Understanding V1.

##### Visual Recognition V3 and V4

Discontinued since 1 December 2021.
