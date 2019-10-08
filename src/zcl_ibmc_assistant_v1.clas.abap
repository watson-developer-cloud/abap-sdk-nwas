* Copyright 2019 IBM Corp. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
"! <h1>Watson Assistant v1</h1>
"! The IBM Watson&trade; Assistant service combines machine learning, natural
"!  language understanding, and an integrated dialog editor to create conversation
"!  flows between your apps and your users.
"!
"! The Assistant v1 API provides authoring methods your application can use to
"!  create or update a workspace. <br/>
class ZCL_IBMC_ASSISTANT_V1 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "!
    begin of T_DIA_ND_OTPT_TEXT_VALUES_ELEM,
      TEXT type STRING,
    end of T_DIA_ND_OTPT_TEXT_VALUES_ELEM.
  types:
    "!   A mention of a contextual entity.
    begin of T_MENTION,
      ENTITY type STRING,
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
    end of T_MENTION.
  types:
    "!
    begin of T_EXAMPLE,
      TEXT type STRING,
      MENTIONS type STANDARD TABLE OF T_MENTION WITH NON-UNIQUE DEFAULT KEY,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_EXAMPLE.
  types:
    "!
    begin of T_INTENT,
      INTENT type STRING,
      DESCRIPTION type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
      EXAMPLES type STANDARD TABLE OF T_EXAMPLE WITH NON-UNIQUE DEFAULT KEY,
    end of T_INTENT.
  types:
    "!
    begin of T_DIALOG_NODE_ACTION,
      NAME type STRING,
      TYPE type STRING,
      PARAMETERS type MAP,
      RESULT_VARIABLE type STRING,
      CREDENTIALS type STRING,
    end of T_DIALOG_NODE_ACTION.
  types:
    "!   Workspace settings related to the disambiguation feature.
    "!
    "!   **Note:** This feature is available only to Premium users.
    begin of T_WS_SYSTM_STTNGS_DSMBGTN,
      PROMPT type STRING,
      NONE_OF_THE_ABOVE_PROMPT type STRING,
      ENABLED type BOOLEAN,
      SENSITIVITY type STRING,
    end of T_WS_SYSTM_STTNGS_DSMBGTN.
  types:
    "!   Options that modify how specified output is handled.
    begin of T_DIALOG_NODE_OUTPUT_MODIFIERS,
      OVERWRITE type BOOLEAN,
    end of T_DIALOG_NODE_OUTPUT_MODIFIERS.
  types:
    "!   The next step to execute following this dialog node.
    begin of T_DIALOG_NODE_NEXT_STEP,
      BEHAVIOR type STRING,
      DIALOG_NODE type STRING,
      SELECTOR type STRING,
    end of T_DIALOG_NODE_NEXT_STEP.
  types:
    "!   An input object that includes the input text.
    begin of T_MESSAGE_INPUT,
      TEXT type STRING,
    end of T_MESSAGE_INPUT.
  types:
    "!   A recognized capture group for a pattern-based entity.
    begin of T_CAPTURE_GROUP,
      GROUP type STRING,
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
    end of T_CAPTURE_GROUP.
  types:
    "!   A term from the request that was identified as an entity.
    begin of T_RUNTIME_ENTITY,
      ENTITY type STRING,
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
      VALUE type STRING,
      CONFIDENCE type NUMBER,
      METADATA type MAP,
      GROUPS type STANDARD TABLE OF T_CAPTURE_GROUP WITH NON-UNIQUE DEFAULT KEY,
    end of T_RUNTIME_ENTITY.
  types:
    "!   An intent identified in the user input.
    begin of T_RUNTIME_INTENT,
      INTENT type STRING,
      CONFIDENCE type DOUBLE,
    end of T_RUNTIME_INTENT.
  types:
    "!   An object defining the message input to be sent to the Watson Assistant service
    "!    if the user selects the corresponding option.
    begin of T_DIA_ND_OUTPUT_OPT_ELEM_VALUE,
      INPUT type T_MESSAGE_INPUT,
      INTENTS type STANDARD TABLE OF T_RUNTIME_INTENT WITH NON-UNIQUE DEFAULT KEY,
      ENTITIES type STANDARD TABLE OF T_RUNTIME_ENTITY WITH NON-UNIQUE DEFAULT KEY,
    end of T_DIA_ND_OUTPUT_OPT_ELEM_VALUE.
  types:
    "!
    begin of T_DIA_NODE_OUTPUT_OPT_ELEMENT,
      LABEL type STRING,
      VALUE type T_DIA_ND_OUTPUT_OPT_ELEM_VALUE,
    end of T_DIA_NODE_OUTPUT_OPT_ELEMENT.
  types:
    "!
    begin of T_DIALOG_NODE_OUTPUT_GENERIC,
      RESPONSE_TYPE type STRING,
      VALUES type STANDARD TABLE OF T_DIA_ND_OTPT_TEXT_VALUES_ELEM WITH NON-UNIQUE DEFAULT KEY,
      SELECTION_POLICY type STRING,
      DELIMITER type STRING,
      TIME type INTEGER,
      TYPING type BOOLEAN,
      SOURCE type STRING,
      TITLE type STRING,
      DESCRIPTION type STRING,
      PREFERENCE type STRING,
      OPTIONS type STANDARD TABLE OF T_DIA_NODE_OUTPUT_OPT_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
      MESSAGE_TO_HUMAN_AGENT type STRING,
      QUERY type STRING,
      QUERY_TYPE type STRING,
      FILTER type STRING,
      DISCOVERY_VERSION type STRING,
    end of T_DIALOG_NODE_OUTPUT_GENERIC.
  types:
    "!   The output of the dialog node. For more information about how to specify dialog
    "!    node output, see the
    "!    [documentation](https://cloud.ibm.com/docs/services/assistant?topic=assistant-d
    "!   ialog-overview#dialog-overview-responses).
    begin of T_DIALOG_NODE_OUTPUT,
      GENERIC type STANDARD TABLE OF T_DIALOG_NODE_OUTPUT_GENERIC WITH NON-UNIQUE DEFAULT KEY,
      MODIFIERS type T_DIALOG_NODE_OUTPUT_MODIFIERS,
    end of T_DIALOG_NODE_OUTPUT.
  types:
    "!   Workspace settings related to the Watson Assistant user interface.
    begin of T_WS_SYSTEM_SETTINGS_TOOLING,
      STORE_GENERIC_RESPONSES type BOOLEAN,
    end of T_WS_SYSTEM_SETTINGS_TOOLING.
  types:
    "!   Global settings for the workspace.
    begin of T_WORKSPACE_SYSTEM_SETTINGS,
      TOOLING type T_WS_SYSTEM_SETTINGS_TOOLING,
      DISAMBIGUATION type T_WS_SYSTM_STTNGS_DSMBGTN,
      HUMAN_AGENT_ASSIST type MAP,
    end of T_WORKSPACE_SYSTEM_SETTINGS.
  types:
    "!
    begin of T_DIALOG_NODE,
      DIALOG_NODE type STRING,
      DESCRIPTION type STRING,
      CONDITIONS type STRING,
      PARENT type STRING,
      PREVIOUS_SIBLING type STRING,
      OUTPUT type T_DIALOG_NODE_OUTPUT,
      CONTEXT type MAP,
      METADATA type MAP,
      NEXT_STEP type T_DIALOG_NODE_NEXT_STEP,
      TITLE type STRING,
      TYPE type STRING,
      EVENT_NAME type STRING,
      VARIABLE type STRING,
      ACTIONS type STANDARD TABLE OF T_DIALOG_NODE_ACTION WITH NON-UNIQUE DEFAULT KEY,
      DIGRESS_IN type STRING,
      DIGRESS_OUT type STRING,
      DIGRESS_OUT_SLOTS type STRING,
      USER_LABEL type STRING,
      DISABLED type BOOLEAN,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_DIALOG_NODE.
  types:
    "!
    begin of T_VALUE,
      VALUE type STRING,
      METADATA type MAP,
      TYPE type STRING,
      SYNONYMS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      PATTERNS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_VALUE.
  types:
    "!
    begin of T_COUNTEREXAMPLE,
      TEXT type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_COUNTEREXAMPLE.
  types:
    "!
    begin of T_ENTITY,
      ENTITY type STRING,
      DESCRIPTION type STRING,
      METADATA type MAP,
      FUZZY_MATCH type BOOLEAN,
      CREATED type DATETIME,
      UPDATED type DATETIME,
      VALUES type STANDARD TABLE OF T_VALUE WITH NON-UNIQUE DEFAULT KEY,
    end of T_ENTITY.
  types:
    "!
    begin of T_WORKSPACE,
      NAME type STRING,
      DESCRIPTION type STRING,
      LANGUAGE type STRING,
      METADATA type MAP,
      LEARNING_OPT_OUT type BOOLEAN,
      SYSTEM_SETTINGS type T_WORKSPACE_SYSTEM_SETTINGS,
      WORKSPACE_ID type STRING,
      STATUS type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
      INTENTS type STANDARD TABLE OF T_INTENT WITH NON-UNIQUE DEFAULT KEY,
      ENTITIES type STANDARD TABLE OF T_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      DIALOG_NODES type STANDARD TABLE OF T_DIALOG_NODE WITH NON-UNIQUE DEFAULT KEY,
      COUNTEREXAMPLES type STANDARD TABLE OF T_COUNTEREXAMPLE WITH NON-UNIQUE DEFAULT KEY,
    end of T_WORKSPACE.
  types:
    "!
    begin of T_RT_ENTTY_INTRPRTTN_SYS_NUM,
      NUMERIC_VALUE type NUMBER,
      RANGE_LINK type STRING,
      SUBTYPE type STRING,
    end of T_RT_ENTTY_INTRPRTTN_SYS_NUM.
  types:
    "!
    begin of T_UPDATE_COUNTEREXAMPLE,
      TEXT type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_UPDATE_COUNTEREXAMPLE.
  types:
    "!
    begin of T_SYNONYM,
      SYNONYM type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_SYNONYM.
  types:
    "!   The pagination data for the returned objects.
    begin of T_PAGINATION,
      REFRESH_URL type STRING,
      NEXT_URL type STRING,
      TOTAL type INTEGER,
      MATCHED type INTEGER,
      REFRESH_CURSOR type STRING,
      NEXT_CURSOR type STRING,
    end of T_PAGINATION.
  types:
    "!
    begin of T_SYNONYM_COLLECTION,
      SYNONYMS type STANDARD TABLE OF T_SYNONYM WITH NON-UNIQUE DEFAULT KEY,
      PAGINATION type T_PAGINATION,
    end of T_SYNONYM_COLLECTION.
  types:
    "!
    begin of T_RUNTIME_RESPONSE_TYPE_OPTION,
      TITLE type STRING,
      DESCRIPTION type STRING,
      PREFERENCE type STRING,
      OPTIONS type STANDARD TABLE OF T_DIA_NODE_OUTPUT_OPT_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
    end of T_RUNTIME_RESPONSE_TYPE_OPTION.
  types:
    "!   Log message details.
    begin of T_LOG_MESSAGE,
      LEVEL type STRING,
      MSG type STRING,
    end of T_LOG_MESSAGE.
  types:
    "!   An array of objects describing the entities for the workspace.
    begin of T_ENTITY_COLLECTION,
      ENTITIES type STANDARD TABLE OF T_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      PAGINATION type T_PAGINATION,
    end of T_ENTITY_COLLECTION.
  types:
    "!
    begin of T_DIA_ND_OUTPUT_RESP_TYPE_TEXT,
      VALUES type STANDARD TABLE OF T_DIA_ND_OTPT_TEXT_VALUES_ELEM WITH NON-UNIQUE DEFAULT KEY,
      SELECTION_POLICY type STRING,
      DELIMITER type STRING,
    end of T_DIA_ND_OUTPUT_RESP_TYPE_TEXT.
  types:
    "!
    begin of T_INTENT_COLLECTION,
      INTENTS type STANDARD TABLE OF T_INTENT WITH NON-UNIQUE DEFAULT KEY,
      PAGINATION type T_PAGINATION,
    end of T_INTENT_COLLECTION.
  types:
    "!
    begin of T_DIA_ND_OTPT_RESP_TYPE_PAUSE,
      TIME type INTEGER,
      TYPING type BOOLEAN,
    end of T_DIA_ND_OTPT_RESP_TYPE_PAUSE.
  types:
    "!
    begin of T_BASE_WORKSPACE,
      NAME type STRING,
      DESCRIPTION type STRING,
      LANGUAGE type STRING,
      METADATA type MAP,
      LEARNING_OPT_OUT type BOOLEAN,
      SYSTEM_SETTINGS type T_WORKSPACE_SYSTEM_SETTINGS,
      WORKSPACE_ID type STRING,
      STATUS type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_BASE_WORKSPACE.
  types:
    "!
    begin of T_DIA_SUGGESTION_RESP_GENERIC,
      RESPONSE_TYPE type STRING,
      TEXT type STRING,
      TIME type INTEGER,
      TYPING type BOOLEAN,
      SOURCE type STRING,
      TITLE type STRING,
      DESCRIPTION type STRING,
      PREFERENCE type STRING,
      OPTIONS type STANDARD TABLE OF T_DIA_NODE_OUTPUT_OPT_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
      MESSAGE_TO_HUMAN_AGENT type STRING,
      TOPIC type STRING,
      DIALOG_NODE type STRING,
    end of T_DIA_SUGGESTION_RESP_GENERIC.
  types:
    "!
    begin of T_DIA_ND_OUTPUT_RESP_TYPE_IMG,
      SOURCE type STRING,
      TITLE type STRING,
      DESCRIPTION type STRING,
    end of T_DIA_ND_OUTPUT_RESP_TYPE_IMG.
  types:
    "!
    begin of T_ERROR_DETAIL,
      MESSAGE type STRING,
      PATH type STRING,
    end of T_ERROR_DETAIL.
  types:
    "!
    begin of T_ERROR_RESPONSE,
      ERROR type STRING,
      ERRORS type STANDARD TABLE OF T_ERROR_DETAIL WITH NON-UNIQUE DEFAULT KEY,
      CODE type INTEGER,
    end of T_ERROR_RESPONSE.
  types:
    "!   Workspace settings related to the behavior of system entities.
    begin of T_WS_SYSTM_STTNGS_SYSTM_ENTTS,
      ENABLED type BOOLEAN,
    end of T_WS_SYSTM_STTNGS_SYSTM_ENTTS.
  types:
    "!
    begin of T_RT_ENTITY_INTERPRETATION,
      CALENDAR_TYPE type STRING,
      DATETIME_LINK type STRING,
      FESTIVAL type STRING,
      GRANULARITY type STRING,
      RANGE_LINK type STRING,
      RANGE_MODIFIER type STRING,
      RELATIVE_DAY type NUMBER,
      RELATIVE_MONTH type NUMBER,
      RELATIVE_WEEK type NUMBER,
      RELATIVE_WEEKEND type NUMBER,
      RELATIVE_YEAR type NUMBER,
      SPECIFIC_DAY type NUMBER,
      SPECIFIC_DAY_OF_WEEK type STRING,
      SPECIFIC_MONTH type NUMBER,
      SPECIFIC_QUARTER type NUMBER,
      SPECIFIC_YEAR type NUMBER,
      NUMERIC_VALUE type NUMBER,
      SUBTYPE type STRING,
      PART_OF_DAY type STRING,
      RELATIVE_HOUR type NUMBER,
      RELATIVE_MINUTE type NUMBER,
      RELATIVE_SECOND type NUMBER,
      SPECIFIC_HOUR type NUMBER,
      SPECIFIC_MINUTE type NUMBER,
      SPECIFIC_SECOND type NUMBER,
      TIMEZONE type STRING,
    end of T_RT_ENTITY_INTERPRETATION.
  types:
    "!   An object defining the message input, intents, and entities to be sent to the
    "!    Watson Assistant service if the user selects the corresponding disambiguation
    "!    option.
    begin of T_DIALOG_SUGGESTION_VALUE,
      INPUT type T_MESSAGE_INPUT,
      INTENTS type STANDARD TABLE OF T_RUNTIME_INTENT WITH NON-UNIQUE DEFAULT KEY,
      ENTITIES type STANDARD TABLE OF T_RUNTIME_ENTITY WITH NON-UNIQUE DEFAULT KEY,
    end of T_DIALOG_SUGGESTION_VALUE.
  types:
    "!
    begin of T_DIALOG_NODE_VISITED_DETAILS,
      DIALOG_NODE type STRING,
      TITLE type STRING,
      CONDITIONS type STRING,
    end of T_DIALOG_NODE_VISITED_DETAILS.
  types:
    "!   The dialog output that will be returned from the Watson Assistant service if the
    "!    user selects the corresponding option.
    begin of T_DIALOG_SUGGESTION_OUTPUT,
      NODES_VISITED type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      NODES_VISITED_DETAILS type STANDARD TABLE OF T_DIALOG_NODE_VISITED_DETAILS WITH NON-UNIQUE DEFAULT KEY,
      TEXT type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      GENERIC type STANDARD TABLE OF T_DIA_SUGGESTION_RESP_GENERIC WITH NON-UNIQUE DEFAULT KEY,
    end of T_DIALOG_SUGGESTION_OUTPUT.
  types:
    "!
    begin of T_BASE_ENTITY,
      ENTITY type STRING,
      DESCRIPTION type STRING,
      METADATA type MAP,
      FUZZY_MATCH type BOOLEAN,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_BASE_ENTITY.
  types:
    "!
    begin of T_RUNTIME_RESPONSE_TYPE_TEXT,
      TEXT type STRING,
    end of T_RUNTIME_RESPONSE_TYPE_TEXT.
  types:
    "!   For internal use only.
      T_SYSTEM_RESPONSE type MAP.
  types:
    "!   Metadata related to the message.
    begin of T_MESSAGE_CONTEXT_METADATA,
      DEPLOYMENT type STRING,
      USER_ID type STRING,
    end of T_MESSAGE_CONTEXT_METADATA.
  types:
    "!   State information for the conversation. To maintain state, include the context
    "!    from the previous response.
    begin of T_CONTEXT,
      CONVERSATION_ID type STRING,
      SYSTEM type T_SYSTEM_RESPONSE,
      METADATA type T_MESSAGE_CONTEXT_METADATA,
    end of T_CONTEXT.
  types:
    "!
    begin of T_RT_ENTTY_INTRPRTTN_SYS_TIME,
      DATETIME_LINK type STRING,
      GRANULARITY type STRING,
      PART_OF_DAY type STRING,
      RANGE_LINK type STRING,
      RELATIVE_HOUR type NUMBER,
      RELATIVE_MINUTE type NUMBER,
      RELATIVE_SECOND type NUMBER,
      SPECIFIC_HOUR type NUMBER,
      SPECIFIC_MINUTE type NUMBER,
      SPECIFIC_SECOND type NUMBER,
      TIMEZONE type STRING,
    end of T_RT_ENTTY_INTRPRTTN_SYS_TIME.
  types:
    "!
    begin of T_UPDATE_EXAMPLE,
      TEXT type STRING,
      MENTIONS type STANDARD TABLE OF T_MENTION WITH NON-UNIQUE DEFAULT KEY,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_UPDATE_EXAMPLE.
  types:
    "!
    begin of T_DIALOG_SUGGESTION,
      LABEL type STRING,
      VALUE type T_DIALOG_SUGGESTION_VALUE,
      OUTPUT type T_DIALOG_SUGGESTION_OUTPUT,
      DIALOG_NODE type STRING,
    end of T_DIALOG_SUGGESTION.
  types:
    "!
    begin of T_RUNTIME_RESPONSE_GENERIC,
      RESPONSE_TYPE type STRING,
      TEXT type STRING,
      TIME type INTEGER,
      TYPING type BOOLEAN,
      SOURCE type STRING,
      TITLE type STRING,
      DESCRIPTION type STRING,
      PREFERENCE type STRING,
      OPTIONS type STANDARD TABLE OF T_DIA_NODE_OUTPUT_OPT_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
      MESSAGE_TO_HUMAN_AGENT type STRING,
      TOPIC type STRING,
      DIALOG_NODE type STRING,
      SUGGESTIONS type STANDARD TABLE OF T_DIALOG_SUGGESTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_RUNTIME_RESPONSE_GENERIC.
  types:
    "!   An output object that includes the response to the user, the dialog nodes that
    "!    were triggered, and messages from the log.
    begin of T_OUTPUT_DATA,
      NODES_VISITED type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      NODES_VISITED_DETAILS type STANDARD TABLE OF T_DIALOG_NODE_VISITED_DETAILS WITH NON-UNIQUE DEFAULT KEY,
      LOG_MESSAGES type STANDARD TABLE OF T_LOG_MESSAGE WITH NON-UNIQUE DEFAULT KEY,
      TEXT type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      GENERIC type STANDARD TABLE OF T_RUNTIME_RESPONSE_GENERIC WITH NON-UNIQUE DEFAULT KEY,
    end of T_OUTPUT_DATA.
  types:
    "!
    begin of T_BASE_MESSAGE,
      INPUT type T_MESSAGE_INPUT,
      INTENTS type STANDARD TABLE OF T_RUNTIME_INTENT WITH NON-UNIQUE DEFAULT KEY,
      ENTITIES type STANDARD TABLE OF T_RUNTIME_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      ALTERNATE_INTENTS type BOOLEAN,
      CONTEXT type T_CONTEXT,
      OUTPUT type T_OUTPUT_DATA,
      ACTIONS type STANDARD TABLE OF T_DIALOG_NODE_ACTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_BASE_MESSAGE.
  types:
    "!   An object describing a contextual entity mention.
    begin of T_ENTITY_MENTION,
      TEXT type STRING,
      INTENT type STRING,
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
    end of T_ENTITY_MENTION.
  types:
    "!
    begin of T_RT_RESPONSE_TYPE_SUGGESTION,
      TITLE type STRING,
      SUGGESTIONS type STANDARD TABLE OF T_DIALOG_SUGGESTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_RT_RESPONSE_TYPE_SUGGESTION.
  types:
    "!
    begin of T_ENTITY_MENTION_COLLECTION,
      EXAMPLES type STANDARD TABLE OF T_ENTITY_MENTION WITH NON-UNIQUE DEFAULT KEY,
      PAGINATION type T_PAGINATION,
    end of T_ENTITY_MENTION_COLLECTION.
  types:
    "!
    begin of T_UPDATE_SYNONYM,
      SYNONYM type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_UPDATE_SYNONYM.
  types:
    "!
    begin of T_DIA_ND_OTPT_RESP_TYP_SRCH_S1,
      QUERY type STRING,
      QUERY_TYPE type STRING,
      FILTER type STRING,
      DISCOVERY_VERSION type STRING,
    end of T_DIA_ND_OTPT_RESP_TYP_SRCH_S1.
  types:
    "!
    begin of T_EXAMPLE_COLLECTION,
      EXAMPLES type STANDARD TABLE OF T_EXAMPLE WITH NON-UNIQUE DEFAULT KEY,
      PAGINATION type T_PAGINATION,
    end of T_EXAMPLE_COLLECTION.
  types:
    "!   The pagination data for the returned objects.
    begin of T_LOG_PAGINATION,
      NEXT_URL type STRING,
      MATCHED type INTEGER,
      NEXT_CURSOR type STRING,
    end of T_LOG_PAGINATION.
  types:
    "!
    begin of T_RT_RESP_TYP_CONNECT_TO_AGENT,
      MESSAGE_TO_HUMAN_AGENT type STRING,
      TOPIC type STRING,
      DIALOG_NODE type STRING,
    end of T_RT_RESP_TYP_CONNECT_TO_AGENT.
  types:
    "!
    begin of T_CREATE_VALUE,
      VALUE type STRING,
      METADATA type MAP,
      TYPE type STRING,
      SYNONYMS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      PATTERNS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_CREATE_VALUE.
  types:
    "!
    begin of T_BASE_INTENT,
      INTENT type STRING,
      DESCRIPTION type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_BASE_INTENT.
  types:
    "!
      T_EMPTY_RESPONSE type JSONOBJECT.
  types:
    "!
    begin of T_UPDATE_VALUE,
      VALUE type STRING,
      METADATA type MAP,
      TYPE type STRING,
      SYNONYMS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      PATTERNS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_UPDATE_VALUE.
  types:
    "!   An alternative value for the recognized entity.
    begin of T_RUNTIME_ENTITY_ALTERNATIVE,
      VALUE type STRING,
      CONFIDENCE type NUMBER,
    end of T_RUNTIME_ENTITY_ALTERNATIVE.
  types:
    "!
    begin of T_RT_ENTTY_INTRPRTTN_SYS_DATE,
      CALENDAR_TYPE type STRING,
      DATETIME_LINK type STRING,
      FESTIVAL type STRING,
      GRANULARITY type STRING,
      RANGE_LINK type STRING,
      RANGE_MODIFIER type STRING,
      RELATIVE_DAY type NUMBER,
      RELATIVE_MONTH type NUMBER,
      RELATIVE_WEEK type NUMBER,
      RELATIVE_WEEKEND type NUMBER,
      RELATIVE_YEAR type NUMBER,
      SPECIFIC_DAY type NUMBER,
      SPECIFIC_DAY_OF_WEEK type STRING,
      SPECIFIC_MONTH type NUMBER,
      SPECIFIC_QUARTER type NUMBER,
      SPECIFIC_YEAR type NUMBER,
    end of T_RT_ENTTY_INTRPRTTN_SYS_DATE.
  types:
    "!
    begin of T_UPDATE_INTENT,
      INTENT type STRING,
      DESCRIPTION type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
      EXAMPLES type STANDARD TABLE OF T_EXAMPLE WITH NON-UNIQUE DEFAULT KEY,
    end of T_UPDATE_INTENT.
  types:
    "!
    begin of T_VALUE_COLLECTION,
      VALUES type STANDARD TABLE OF T_VALUE WITH NON-UNIQUE DEFAULT KEY,
      PAGINATION type T_PAGINATION,
    end of T_VALUE_COLLECTION.
  types:
    "!   An object describing the role played by a system entity that is specifies the
    "!    beginning or end of a range recognized in the user input.
    "!
    "!   This property is part of the new system entities, which are a beta feature.
    begin of T_RUNTIME_ENTITY_ROLE,
      TYPE type STRING,
    end of T_RUNTIME_ENTITY_ROLE.
  types:
    "!
    begin of T_DIA_ND_OUTPUT_RESP_TYPE_OPT,
      TITLE type STRING,
      DESCRIPTION type STRING,
      PREFERENCE type STRING,
      OPTIONS type STANDARD TABLE OF T_DIA_NODE_OUTPUT_OPT_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
    end of T_DIA_ND_OUTPUT_RESP_TYPE_OPT.
  types:
    "!
    begin of T_BASE_COUNTEREXAMPLE,
      TEXT type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_BASE_COUNTEREXAMPLE.
  types:
    "!
    begin of T_RUNTIME_RESPONSE_TYPE_IMAGE,
      SOURCE type STRING,
      TITLE type STRING,
      DESCRIPTION type STRING,
    end of T_RUNTIME_RESPONSE_TYPE_IMAGE.
  types:
    "!
    begin of T_CREATE_INTENT,
      INTENT type STRING,
      DESCRIPTION type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
      EXAMPLES type STANDARD TABLE OF T_EXAMPLE WITH NON-UNIQUE DEFAULT KEY,
    end of T_CREATE_INTENT.
  types:
    "!
    begin of T_CREATE_ENTITY,
      ENTITY type STRING,
      DESCRIPTION type STRING,
      METADATA type MAP,
      FUZZY_MATCH type BOOLEAN,
      CREATED type DATETIME,
      UPDATED type DATETIME,
      VALUES type STANDARD TABLE OF T_CREATE_VALUE WITH NON-UNIQUE DEFAULT KEY,
    end of T_CREATE_ENTITY.
  types:
    "!
    begin of T_UPDATE_WORKSPACE,
      NAME type STRING,
      DESCRIPTION type STRING,
      LANGUAGE type STRING,
      METADATA type MAP,
      LEARNING_OPT_OUT type BOOLEAN,
      SYSTEM_SETTINGS type T_WORKSPACE_SYSTEM_SETTINGS,
      WORKSPACE_ID type STRING,
      STATUS type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
      INTENTS type STANDARD TABLE OF T_CREATE_INTENT WITH NON-UNIQUE DEFAULT KEY,
      ENTITIES type STANDARD TABLE OF T_CREATE_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      DIALOG_NODES type STANDARD TABLE OF T_DIALOG_NODE WITH NON-UNIQUE DEFAULT KEY,
      COUNTEREXAMPLES type STANDARD TABLE OF T_COUNTEREXAMPLE WITH NON-UNIQUE DEFAULT KEY,
    end of T_UPDATE_WORKSPACE.
  types:
    "!   An array of dialog nodes.
    begin of T_DIALOG_NODE_COLLECTION,
      DIALOG_NODES type STANDARD TABLE OF T_DIALOG_NODE WITH NON-UNIQUE DEFAULT KEY,
      PAGINATION type T_PAGINATION,
    end of T_DIALOG_NODE_COLLECTION.
  types:
    "!
    begin of T_BASE_DIALOG_NODE,
      DIALOG_NODE type STRING,
      DESCRIPTION type STRING,
      CONDITIONS type STRING,
      PARENT type STRING,
      PREVIOUS_SIBLING type STRING,
      OUTPUT type T_DIALOG_NODE_OUTPUT,
      CONTEXT type MAP,
      METADATA type MAP,
      NEXT_STEP type T_DIALOG_NODE_NEXT_STEP,
      TITLE type STRING,
      TYPE type STRING,
      EVENT_NAME type STRING,
      VARIABLE type STRING,
      ACTIONS type STANDARD TABLE OF T_DIALOG_NODE_ACTION WITH NON-UNIQUE DEFAULT KEY,
      DIGRESS_IN type STRING,
      DIGRESS_OUT type STRING,
      DIGRESS_OUT_SLOTS type STRING,
      USER_LABEL type STRING,
      DISABLED type BOOLEAN,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_BASE_DIALOG_NODE.
  types:
    "!   The response sent by the workspace, including the output text, detected intents
    "!    and entities, and context.
    begin of T_MESSAGE_RESPONSE,
      INPUT type T_MESSAGE_INPUT,
      INTENTS type STANDARD TABLE OF T_RUNTIME_INTENT WITH NON-UNIQUE DEFAULT KEY,
      ENTITIES type STANDARD TABLE OF T_RUNTIME_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      ALTERNATE_INTENTS type BOOLEAN,
      CONTEXT type T_CONTEXT,
      OUTPUT type T_OUTPUT_DATA,
      ACTIONS type STANDARD TABLE OF T_DIALOG_NODE_ACTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_MESSAGE_RESPONSE.
  types:
    "!
    begin of T_BASE_VALUE,
      VALUE type STRING,
      METADATA type MAP,
      TYPE type STRING,
      SYNONYMS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      PATTERNS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_BASE_VALUE.
  types:
    "!   A request sent to the workspace, including the user input and context.
    begin of T_MESSAGE_REQUEST,
      INPUT type T_MESSAGE_INPUT,
      INTENTS type STANDARD TABLE OF T_RUNTIME_INTENT WITH NON-UNIQUE DEFAULT KEY,
      ENTITIES type STANDARD TABLE OF T_RUNTIME_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      ALTERNATE_INTENTS type BOOLEAN,
      CONTEXT type T_CONTEXT,
      OUTPUT type T_OUTPUT_DATA,
      ACTIONS type STANDARD TABLE OF T_DIALOG_NODE_ACTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_MESSAGE_REQUEST.
  types:
    "!
    begin of T_LOG,
      REQUEST type T_MESSAGE_REQUEST,
      RESPONSE type T_MESSAGE_RESPONSE,
      LOG_ID type STRING,
      REQUEST_TIMESTAMP type STRING,
      RESPONSE_TIMESTAMP type STRING,
      WORKSPACE_ID type STRING,
      LANGUAGE type STRING,
    end of T_LOG.
  types:
    "!
    begin of T_UPDATE_ENTITY,
      ENTITY type STRING,
      DESCRIPTION type STRING,
      METADATA type MAP,
      FUZZY_MATCH type BOOLEAN,
      CREATED type DATETIME,
      UPDATED type DATETIME,
      VALUES type STANDARD TABLE OF T_CREATE_VALUE WITH NON-UNIQUE DEFAULT KEY,
    end of T_UPDATE_ENTITY.
  types:
    "!   An output object that includes the response to the user, the dialog nodes that
    "!    were triggered, and messages from the log.
    begin of T_BASE_OUTPUT,
      NODES_VISITED type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      NODES_VISITED_DETAILS type STANDARD TABLE OF T_DIALOG_NODE_VISITED_DETAILS WITH NON-UNIQUE DEFAULT KEY,
    end of T_BASE_OUTPUT.
  types:
    "!
    begin of T_UPDATE_DIALOG_NODE,
      DIALOG_NODE type STRING,
      DESCRIPTION type STRING,
      CONDITIONS type STRING,
      PARENT type STRING,
      PREVIOUS_SIBLING type STRING,
      OUTPUT type T_DIALOG_NODE_OUTPUT,
      CONTEXT type MAP,
      METADATA type MAP,
      NEXT_STEP type T_DIALOG_NODE_NEXT_STEP,
      TITLE type STRING,
      TYPE type STRING,
      EVENT_NAME type STRING,
      VARIABLE type STRING,
      ACTIONS type STANDARD TABLE OF T_DIALOG_NODE_ACTION WITH NON-UNIQUE DEFAULT KEY,
      DIGRESS_IN type STRING,
      DIGRESS_OUT type STRING,
      DIGRESS_OUT_SLOTS type STRING,
      USER_LABEL type STRING,
      DISABLED type BOOLEAN,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_UPDATE_DIALOG_NODE.
  types:
    "!
    begin of T_RUNTIME_RESPONSE_TYPE_PAUSE,
      TIME type INTEGER,
      TYPING type BOOLEAN,
    end of T_RUNTIME_RESPONSE_TYPE_PAUSE.
  types:
    "!
    begin of T_LOG_COLLECTION,
      LOGS type STANDARD TABLE OF T_LOG WITH NON-UNIQUE DEFAULT KEY,
      PAGINATION type T_LOG_PAGINATION,
    end of T_LOG_COLLECTION.
  types:
    "!
    begin of T_DIA_ND_OTPT_RESP_TYP_CNNCT_1,
      MESSAGE_TO_HUMAN_AGENT type STRING,
    end of T_DIA_ND_OTPT_RESP_TYP_CNNCT_1.
  types:
    "!
    begin of T_AUDIT_PROPERTIES,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_AUDIT_PROPERTIES.
  types:
    "!
    begin of T_CREATE_WORKSPACE,
      NAME type STRING,
      DESCRIPTION type STRING,
      LANGUAGE type STRING,
      METADATA type MAP,
      LEARNING_OPT_OUT type BOOLEAN,
      SYSTEM_SETTINGS type T_WORKSPACE_SYSTEM_SETTINGS,
      WORKSPACE_ID type STRING,
      STATUS type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
      INTENTS type STANDARD TABLE OF T_CREATE_INTENT WITH NON-UNIQUE DEFAULT KEY,
      ENTITIES type STANDARD TABLE OF T_CREATE_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      DIALOG_NODES type STANDARD TABLE OF T_DIALOG_NODE WITH NON-UNIQUE DEFAULT KEY,
      COUNTEREXAMPLES type STANDARD TABLE OF T_COUNTEREXAMPLE WITH NON-UNIQUE DEFAULT KEY,
    end of T_CREATE_WORKSPACE.
  types:
    "!
    begin of T_COUNTEREXAMPLE_COLLECTION,
      COUNTEREXAMPLES type STANDARD TABLE OF T_COUNTEREXAMPLE WITH NON-UNIQUE DEFAULT KEY,
      PAGINATION type T_PAGINATION,
    end of T_COUNTEREXAMPLE_COLLECTION.
  types:
    "!
    begin of T_WORKSPACE_COLLECTION,
      WORKSPACES type STANDARD TABLE OF T_WORKSPACE WITH NON-UNIQUE DEFAULT KEY,
      PAGINATION type T_PAGINATION,
    end of T_WORKSPACE_COLLECTION.
  types:
    "!
    begin of T_BASE_SYNONYM,
      SYNONYM type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_BASE_SYNONYM.
  types:
    "!
    begin of T_BASE_EXAMPLE,
      TEXT type STRING,
      MENTIONS type STANDARD TABLE OF T_MENTION WITH NON-UNIQUE DEFAULT KEY,
      CREATED type DATETIME,
      UPDATED type DATETIME,
    end of T_BASE_EXAMPLE.

constants:
  begin of C_REQUIRED_FIELDS,
    T_DIA_ND_OTPT_TEXT_VALUES_ELEM type string value '|',
    T_MENTION type string value '|ENTITY|LOCATION|',
    T_EXAMPLE type string value '|TEXT|',
    T_INTENT type string value '|INTENT|',
    T_DIALOG_NODE_ACTION type string value '|NAME|RESULT_VARIABLE|',
    T_WS_SYSTM_STTNGS_DSMBGTN type string value '|',
    T_DIALOG_NODE_OUTPUT_MODIFIERS type string value '|',
    T_DIALOG_NODE_NEXT_STEP type string value '|BEHAVIOR|',
    T_MESSAGE_INPUT type string value '|',
    T_CAPTURE_GROUP type string value '|GROUP|',
    T_RUNTIME_ENTITY type string value '|ENTITY|LOCATION|VALUE|',
    T_RUNTIME_INTENT type string value '|INTENT|CONFIDENCE|',
    T_DIA_ND_OUTPUT_OPT_ELEM_VALUE type string value '|',
    T_DIA_NODE_OUTPUT_OPT_ELEMENT type string value '|LABEL|VALUE|',
    T_DIALOG_NODE_OUTPUT_GENERIC type string value '|RESPONSE_TYPE|',
    T_DIALOG_NODE_OUTPUT type string value '|',
    T_WS_SYSTEM_SETTINGS_TOOLING type string value '|',
    T_WORKSPACE_SYSTEM_SETTINGS type string value '|',
    T_DIALOG_NODE type string value '|DIALOG_NODE|',
    T_VALUE type string value '|VALUE|TYPE|',
    T_COUNTEREXAMPLE type string value '|TEXT|',
    T_ENTITY type string value '|ENTITY|',
    T_WORKSPACE type string value '|NAME|LANGUAGE|LEARNING_OPT_OUT|WORKSPACE_ID|',
    T_RT_ENTTY_INTRPRTTN_SYS_NUM type string value '|',
    T_UPDATE_COUNTEREXAMPLE type string value '|',
    T_SYNONYM type string value '|SYNONYM|',
    T_PAGINATION type string value '|REFRESH_URL|',
    T_SYNONYM_COLLECTION type string value '|SYNONYMS|PAGINATION|',
    T_RUNTIME_RESPONSE_TYPE_OPTION type string value '|',
    T_LOG_MESSAGE type string value '|LEVEL|MSG|',
    T_ENTITY_COLLECTION type string value '|ENTITIES|PAGINATION|',
    T_DIA_ND_OUTPUT_RESP_TYPE_TEXT type string value '|',
    T_INTENT_COLLECTION type string value '|INTENTS|PAGINATION|',
    T_DIA_ND_OTPT_RESP_TYPE_PAUSE type string value '|',
    T_BASE_WORKSPACE type string value '|',
    T_DIA_SUGGESTION_RESP_GENERIC type string value '|RESPONSE_TYPE|',
    T_DIA_ND_OUTPUT_RESP_TYPE_IMG type string value '|',
    T_ERROR_DETAIL type string value '|MESSAGE|',
    T_ERROR_RESPONSE type string value '|ERROR|CODE|',
    T_WS_SYSTM_STTNGS_SYSTM_ENTTS type string value '|',
    T_RT_ENTITY_INTERPRETATION type string value '|',
    T_DIALOG_SUGGESTION_VALUE type string value '|',
    T_DIALOG_NODE_VISITED_DETAILS type string value '|',
    T_DIALOG_SUGGESTION_OUTPUT type string value '|TEXT|',
    T_BASE_ENTITY type string value '|',
    T_RUNTIME_RESPONSE_TYPE_TEXT type string value '|',
    T_MESSAGE_CONTEXT_METADATA type string value '|',
    T_CONTEXT type string value '|',
    T_RT_ENTTY_INTRPRTTN_SYS_TIME type string value '|',
    T_UPDATE_EXAMPLE type string value '|',
    T_DIALOG_SUGGESTION type string value '|LABEL|VALUE|',
    T_RUNTIME_RESPONSE_GENERIC type string value '|RESPONSE_TYPE|',
    T_OUTPUT_DATA type string value '|LOG_MESSAGES|TEXT|',
    T_BASE_MESSAGE type string value '|',
    T_ENTITY_MENTION type string value '|TEXT|INTENT|LOCATION|',
    T_RT_RESPONSE_TYPE_SUGGESTION type string value '|',
    T_ENTITY_MENTION_COLLECTION type string value '|EXAMPLES|PAGINATION|',
    T_UPDATE_SYNONYM type string value '|',
    T_DIA_ND_OTPT_RESP_TYP_SRCH_S1 type string value '|',
    T_EXAMPLE_COLLECTION type string value '|EXAMPLES|PAGINATION|',
    T_LOG_PAGINATION type string value '|',
    T_RT_RESP_TYP_CONNECT_TO_AGENT type string value '|',
    T_CREATE_VALUE type string value '|VALUE|',
    T_BASE_INTENT type string value '|',
    T_UPDATE_VALUE type string value '|',
    T_RUNTIME_ENTITY_ALTERNATIVE type string value '|',
    T_RT_ENTTY_INTRPRTTN_SYS_DATE type string value '|',
    T_UPDATE_INTENT type string value '|',
    T_VALUE_COLLECTION type string value '|VALUES|PAGINATION|',
    T_RUNTIME_ENTITY_ROLE type string value '|',
    T_DIA_ND_OUTPUT_RESP_TYPE_OPT type string value '|',
    T_BASE_COUNTEREXAMPLE type string value '|',
    T_RUNTIME_RESPONSE_TYPE_IMAGE type string value '|',
    T_CREATE_INTENT type string value '|INTENT|',
    T_CREATE_ENTITY type string value '|ENTITY|',
    T_UPDATE_WORKSPACE type string value '|',
    T_DIALOG_NODE_COLLECTION type string value '|DIALOG_NODES|PAGINATION|',
    T_BASE_DIALOG_NODE type string value '|',
    T_MESSAGE_RESPONSE type string value '|INPUT|INTENTS|ENTITIES|CONTEXT|OUTPUT|',
    T_BASE_VALUE type string value '|',
    T_MESSAGE_REQUEST type string value '|',
    T_LOG type string value '|REQUEST|RESPONSE|LOG_ID|REQUEST_TIMESTAMP|RESPONSE_TIMESTAMP|WORKSPACE_ID|LANGUAGE|',
    T_UPDATE_ENTITY type string value '|',
    T_BASE_OUTPUT type string value '|',
    T_UPDATE_DIALOG_NODE type string value '|',
    T_RUNTIME_RESPONSE_TYPE_PAUSE type string value '|',
    T_LOG_COLLECTION type string value '|LOGS|PAGINATION|',
    T_DIA_ND_OTPT_RESP_TYP_CNNCT_1 type string value '|',
    T_AUDIT_PROPERTIES type string value '|',
    T_CREATE_WORKSPACE type string value '|',
    T_COUNTEREXAMPLE_COLLECTION type string value '|COUNTEREXAMPLES|PAGINATION|',
    T_WORKSPACE_COLLECTION type string value '|WORKSPACES|PAGINATION|',
    T_BASE_SYNONYM type string value '|',
    T_BASE_EXAMPLE type string value '|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  begin of C_ABAPNAME_DICTIONARY,
     CREATED type string value 'created',
     UPDATED type string value 'updated',
     TEXT type string value 'text',
     DIALOG_NODE type string value 'dialog_node',
     DESCRIPTION type string value 'description',
     CONDITIONS type string value 'conditions',
     PARENT type string value 'parent',
     PREVIOUS_SIBLING type string value 'previous_sibling',
     OUTPUT type string value 'output',
     CONTEXT type string value 'context',
     INNER type string value 'inner',
     METADATA type string value 'metadata',
     NEXT_STEP type string value 'next_step',
     TITLE type string value 'title',
     TYPE type string value 'type',
     EVENT_NAME type string value 'event_name',
     VARIABLE type string value 'variable',
     ACTIONS type string value 'actions',
     DIGRESS_IN type string value 'digress_in',
     DIGRESS_OUT type string value 'digress_out',
     DIGRESS_OUT_SLOTS type string value 'digress_out_slots',
     USER_LABEL type string value 'user_label',
     DISABLED type string value 'disabled',
     ENTITY type string value 'entity',
     FUZZY_MATCH type string value 'fuzzy_match',
     MENTIONS type string value 'mentions',
     INTENT type string value 'intent',
     INPUT type string value 'input',
     INTENTS type string value 'intents',
     ENTITIES type string value 'entities',
     ALTERNATE_INTENTS type string value 'alternate_intents',
     SYNONYM type string value 'synonym',
     VALUE type string value 'value',
     SYNONYMS type string value 'synonyms',
     PATTERNS type string value 'patterns',
     PATTERN type string value 'pattern',
     NAME type string value 'name',
     LANGUAGE type string value 'language',
     LEARNING_OPT_OUT type string value 'learning_opt_out',
     SYSTEM_SETTINGS type string value 'system_settings',
     WORKSPACE_ID type string value 'workspace_id',
     STATUS type string value 'status',
     GROUP type string value 'group',
     LOCATION type string value 'location',
     CONVERSATION_ID type string value 'conversation_id',
     SYSTEM type string value 'system',
     COUNTEREXAMPLES type string value 'counterexamples',
     PAGINATION type string value 'pagination',
     VALUES type string value 'values',
     EXAMPLES type string value 'examples',
     EXAMPLE type string value 'example',
     DIALOG_NODES type string value 'dialog_nodes',
     DIALOGNODE type string value 'dialogNode',
     COUNTEREXAMPLE type string value 'counterexample',
     PARAMETERS type string value 'parameters',
     RESULT_VARIABLE type string value 'result_variable',
     CREDENTIALS type string value 'credentials',
     GENERIC type string value 'generic',
     MODIFIERS type string value 'modifiers',
     OVERWRITE type string value 'overwrite',
     RESPONSE_TYPE type string value 'response_type',
     SELECTION_POLICY type string value 'selection_policy',
     DELIMITER type string value 'delimiter',
     TIME type string value 'time',
     TYPING type string value 'typing',
     SOURCE type string value 'source',
     PREFERENCE type string value 'preference',
     OPTIONS type string value 'options',
     MESSAGE_TO_HUMAN_AGENT type string value 'message_to_human_agent',
     QUERY type string value 'query',
     QUERY_TYPE type string value 'query_type',
     FILTER type string value 'filter',
     DISCOVERY_VERSION type string value 'discovery_version',
     TOPIC type string value 'topic',
     SUGGESTIONS type string value 'suggestions',
     LABEL type string value 'label',
     NODES_VISITED type string value 'nodes_visited',
     NODESVISITED type string value 'nodesVisited',
     NODES_VISITED_DETAILS type string value 'nodes_visited_details',
     NODESVISITEDDETAILS type string value 'nodesVisitedDetails',
     DIALOGNODES type string value 'dialogNodes',
     BEHAVIOR type string value 'behavior',
     SELECTOR type string value 'selector',
     MESSAGE type string value 'message',
     PATH type string value 'path',
     ERROR type string value 'error',
     ERRORS type string value 'errors',
     CODE type string value 'code',
     LOGS type string value 'logs',
     LEVEL type string value 'level',
     MSG type string value 'msg',
     REQUEST type string value 'request',
     RESPONSE type string value 'response',
     LOG_ID type string value 'log_id',
     REQUEST_TIMESTAMP type string value 'request_timestamp',
     RESPONSE_TIMESTAMP type string value 'response_timestamp',
     NEXT_URL type string value 'next_url',
     MATCHED type string value 'matched',
     NEXT_CURSOR type string value 'next_cursor',
     DEPLOYMENT type string value 'deployment',
     USER_ID type string value 'user_id',
     LOG_MESSAGES type string value 'log_messages',
     LOGMESSAGES type string value 'logMessages',
     REFRESH_URL type string value 'refresh_url',
     TOTAL type string value 'total',
     REFRESH_CURSOR type string value 'refresh_cursor',
     CONFIDENCE type string value 'confidence',
     GROUPS type string value 'groups',
     CALENDAR_TYPE type string value 'calendar_type',
     DATETIME_LINK type string value 'datetime_link',
     FESTIVAL type string value 'festival',
     GRANULARITY type string value 'granularity',
     RANGE_LINK type string value 'range_link',
     RANGE_MODIFIER type string value 'range_modifier',
     RELATIVE_DAY type string value 'relative_day',
     RELATIVE_MONTH type string value 'relative_month',
     RELATIVE_WEEK type string value 'relative_week',
     RELATIVE_WEEKEND type string value 'relative_weekend',
     RELATIVE_YEAR type string value 'relative_year',
     SPECIFIC_DAY type string value 'specific_day',
     SPECIFIC_DAY_OF_WEEK type string value 'specific_day_of_week',
     SPECIFIC_MONTH type string value 'specific_month',
     SPECIFIC_QUARTER type string value 'specific_quarter',
     SPECIFIC_YEAR type string value 'specific_year',
     NUMERIC_VALUE type string value 'numeric_value',
     SUBTYPE type string value 'subtype',
     PART_OF_DAY type string value 'part_of_day',
     RELATIVE_HOUR type string value 'relative_hour',
     RELATIVE_MINUTE type string value 'relative_minute',
     RELATIVE_SECOND type string value 'relative_second',
     SPECIFIC_HOUR type string value 'specific_hour',
     SPECIFIC_MINUTE type string value 'specific_minute',
     SPECIFIC_SECOND type string value 'specific_second',
     TIMEZONE type string value 'timezone',
     TOOLING type string value 'tooling',
     DISAMBIGUATION type string value 'disambiguation',
     HUMAN_AGENT_ASSIST type string value 'human_agent_assist',
     ENABLED type string value 'enabled',
     STORE_GENERIC_RESPONSES type string value 'store_generic_responses',
     PROMPT type string value 'prompt',
     NONE_OF_THE_ABOVE_PROMPT type string value 'none_of_the_above_prompt',
     SENSITIVITY type string value 'sensitivity',
     WORKSPACES type string value 'workspaces',
  end of C_ABAPNAME_DICTIONARY .


  methods GET_APPNAME
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
  methods GET_SDK_VERSION_DATE
    redefinition .


    "! Get response to user input.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_body |
    "!   The message to be sent. This includes the user's input, along with optional
    "!    intents, entities, and context from the last response.
    "! @parameter I_nodes_visited_details |
    "!   Whether to include additional diagnostic information about the dialog nodes that
    "!    were visited during processing of the message.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_MESSAGE_RESPONSE
    "!
  methods MESSAGE
    importing
      !I_workspace_id type STRING
      !I_body type T_MESSAGE_REQUEST optional
      !I_nodes_visited_details type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_MESSAGE_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List workspaces.
    "!
    "! @parameter I_page_limit |
    "!   The number of records to return in each page of results.
    "! @parameter I_sort |
    "!   The attribute by which returned workspaces will be sorted. To reverse the sort
    "!    order, prefix the value with a minus sign (`-`).
    "! @parameter I_cursor |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_include_audit |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_WORKSPACE_COLLECTION
    "!
  methods LIST_WORKSPACES
    importing
      !I_page_limit type INTEGER optional
      !I_sort type STRING optional
      !I_cursor type STRING optional
      !I_include_audit type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_WORKSPACE_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Create workspace.
    "!
    "! @parameter I_body |
    "!   The content of the new workspace.
    "!
    "!   The maximum size for this data is 50MB. If you need to import a larger
    "!    workspace, consider importing the workspace without intents and entities and
    "!    then adding them separately.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_WORKSPACE
    "!
  methods CREATE_WORKSPACE
    importing
      !I_body type T_CREATE_WORKSPACE optional
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_WORKSPACE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get information about a workspace.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_export |
    "!   Whether to include all element content in the returned data. If
    "!    **export**=`false`, the returned data includes only information about the
    "!    element itself. If **export**=`true`, all content, including subelements, is
    "!    included.
    "! @parameter I_include_audit |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter I_sort |
    "!   Indicates how the returned workspace data will be sorted. This parameter is
    "!    valid only if **export**=`true`. Specify `sort=stable` to sort all workspace
    "!    objects by unique identifier, in ascending alphabetical order.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_WORKSPACE
    "!
  methods GET_WORKSPACE
    importing
      !I_workspace_id type STRING
      !I_export type BOOLEAN default c_boolean_false
      !I_include_audit type BOOLEAN default c_boolean_false
      !I_sort type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_WORKSPACE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Update workspace.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_body |
    "!   Valid data defining the new and updated workspace content.
    "!
    "!   The maximum size for this data is 50MB. If you need to import a larger amount of
    "!    workspace data, consider importing components such as intents and entities
    "!    using separate operations.
    "! @parameter I_append |
    "!   Whether the new data is to be appended to the existing data in the workspace. If
    "!    **append**=`false`, elements included in the new data completely replace the
    "!    corresponding existing elements, including all subelements. For example, if the
    "!    new data includes **entities** and **append**=`false`, all existing entities in
    "!    the workspace are discarded and replaced with the new entities.
    "!
    "!   If **append**=`true`, existing elements are preserved, and the new elements are
    "!    added. If any elements in the new data collide with existing elements, the
    "!    update request fails.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_WORKSPACE
    "!
  methods UPDATE_WORKSPACE
    importing
      !I_workspace_id type STRING
      !I_body type T_UPDATE_WORKSPACE optional
      !I_append type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_WORKSPACE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete workspace.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "!
  methods DELETE_WORKSPACE
    importing
      !I_workspace_id type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List intents.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_export |
    "!   Whether to include all element content in the returned data. If
    "!    **export**=`false`, the returned data includes only information about the
    "!    element itself. If **export**=`true`, all content, including subelements, is
    "!    included.
    "! @parameter I_page_limit |
    "!   The number of records to return in each page of results.
    "! @parameter I_sort |
    "!   The attribute by which returned intents will be sorted. To reverse the sort
    "!    order, prefix the value with a minus sign (`-`).
    "! @parameter I_cursor |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_include_audit |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_INTENT_COLLECTION
    "!
  methods LIST_INTENTS
    importing
      !I_workspace_id type STRING
      !I_export type BOOLEAN default c_boolean_false
      !I_page_limit type INTEGER optional
      !I_sort type STRING optional
      !I_cursor type STRING optional
      !I_include_audit type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_INTENT_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Create intent.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_body |
    "!   The content of the new intent.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_INTENT
    "!
  methods CREATE_INTENT
    importing
      !I_workspace_id type STRING
      !I_body type T_CREATE_INTENT
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_INTENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get intent.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_intent |
    "!   The intent name.
    "! @parameter I_export |
    "!   Whether to include all element content in the returned data. If
    "!    **export**=`false`, the returned data includes only information about the
    "!    element itself. If **export**=`true`, all content, including subelements, is
    "!    included.
    "! @parameter I_include_audit |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_INTENT
    "!
  methods GET_INTENT
    importing
      !I_workspace_id type STRING
      !I_intent type STRING
      !I_export type BOOLEAN default c_boolean_false
      !I_include_audit type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_INTENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Update intent.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_intent |
    "!   The intent name.
    "! @parameter I_body |
    "!   The updated content of the intent.
    "!
    "!   Any elements included in the new data will completely replace the equivalent
    "!    existing elements, including all subelements. (Previously existing subelements
    "!    are not retained unless they are also included in the new data.) For example,
    "!    if you update the user input examples for an intent, the previously existing
    "!    examples are discarded and replaced with the new examples specified in the
    "!    update.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_INTENT
    "!
  methods UPDATE_INTENT
    importing
      !I_workspace_id type STRING
      !I_intent type STRING
      !I_body type T_UPDATE_INTENT
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_INTENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete intent.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_intent |
    "!   The intent name.
    "!
  methods DELETE_INTENT
    importing
      !I_workspace_id type STRING
      !I_intent type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List user input examples.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_intent |
    "!   The intent name.
    "! @parameter I_page_limit |
    "!   The number of records to return in each page of results.
    "! @parameter I_sort |
    "!   The attribute by which returned examples will be sorted. To reverse the sort
    "!    order, prefix the value with a minus sign (`-`).
    "! @parameter I_cursor |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_include_audit |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_EXAMPLE_COLLECTION
    "!
  methods LIST_EXAMPLES
    importing
      !I_workspace_id type STRING
      !I_intent type STRING
      !I_page_limit type INTEGER optional
      !I_sort type STRING optional
      !I_cursor type STRING optional
      !I_include_audit type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_EXAMPLE_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Create user input example.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_intent |
    "!   The intent name.
    "! @parameter I_body |
    "!   The content of the new user input example.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_EXAMPLE
    "!
  methods CREATE_EXAMPLE
    importing
      !I_workspace_id type STRING
      !I_intent type STRING
      !I_body type T_EXAMPLE
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_EXAMPLE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get user input example.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_intent |
    "!   The intent name.
    "! @parameter I_text |
    "!   The text of the user input example.
    "! @parameter I_include_audit |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_EXAMPLE
    "!
  methods GET_EXAMPLE
    importing
      !I_workspace_id type STRING
      !I_intent type STRING
      !I_text type STRING
      !I_include_audit type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_EXAMPLE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Update user input example.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_intent |
    "!   The intent name.
    "! @parameter I_text |
    "!   The text of the user input example.
    "! @parameter I_body |
    "!   The new text of the user input example.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_EXAMPLE
    "!
  methods UPDATE_EXAMPLE
    importing
      !I_workspace_id type STRING
      !I_intent type STRING
      !I_text type STRING
      !I_body type T_UPDATE_EXAMPLE
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_EXAMPLE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete user input example.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_intent |
    "!   The intent name.
    "! @parameter I_text |
    "!   The text of the user input example.
    "!
  methods DELETE_EXAMPLE
    importing
      !I_workspace_id type STRING
      !I_intent type STRING
      !I_text type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List counterexamples.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_page_limit |
    "!   The number of records to return in each page of results.
    "! @parameter I_sort |
    "!   The attribute by which returned counterexamples will be sorted. To reverse the
    "!    sort order, prefix the value with a minus sign (`-`).
    "! @parameter I_cursor |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_include_audit |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COUNTEREXAMPLE_COLLECTION
    "!
  methods LIST_COUNTEREXAMPLES
    importing
      !I_workspace_id type STRING
      !I_page_limit type INTEGER optional
      !I_sort type STRING optional
      !I_cursor type STRING optional
      !I_include_audit type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COUNTEREXAMPLE_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Create counterexample.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_body |
    "!   The content of the new counterexample.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COUNTEREXAMPLE
    "!
  methods CREATE_COUNTEREXAMPLE
    importing
      !I_workspace_id type STRING
      !I_body type T_COUNTEREXAMPLE
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COUNTEREXAMPLE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get counterexample.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_text |
    "!   The text of a user input counterexample (for example, `What are you wearing?`).
    "! @parameter I_include_audit |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COUNTEREXAMPLE
    "!
  methods GET_COUNTEREXAMPLE
    importing
      !I_workspace_id type STRING
      !I_text type STRING
      !I_include_audit type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COUNTEREXAMPLE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Update counterexample.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_text |
    "!   The text of a user input counterexample (for example, `What are you wearing?`).
    "! @parameter I_body |
    "!   The text of the counterexample.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COUNTEREXAMPLE
    "!
  methods UPDATE_COUNTEREXAMPLE
    importing
      !I_workspace_id type STRING
      !I_text type STRING
      !I_body type T_UPDATE_COUNTEREXAMPLE
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COUNTEREXAMPLE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete counterexample.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_text |
    "!   The text of a user input counterexample (for example, `What are you wearing?`).
    "!
  methods DELETE_COUNTEREXAMPLE
    importing
      !I_workspace_id type STRING
      !I_text type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List entities.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_export |
    "!   Whether to include all element content in the returned data. If
    "!    **export**=`false`, the returned data includes only information about the
    "!    element itself. If **export**=`true`, all content, including subelements, is
    "!    included.
    "! @parameter I_page_limit |
    "!   The number of records to return in each page of results.
    "! @parameter I_sort |
    "!   The attribute by which returned entities will be sorted. To reverse the sort
    "!    order, prefix the value with a minus sign (`-`).
    "! @parameter I_cursor |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_include_audit |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENTITY_COLLECTION
    "!
  methods LIST_ENTITIES
    importing
      !I_workspace_id type STRING
      !I_export type BOOLEAN default c_boolean_false
      !I_page_limit type INTEGER optional
      !I_sort type STRING optional
      !I_cursor type STRING optional
      !I_include_audit type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENTITY_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Create entity.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_body |
    "!   The content of the new entity.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENTITY
    "!
  methods CREATE_ENTITY
    importing
      !I_workspace_id type STRING
      !I_body type T_CREATE_ENTITY
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENTITY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get entity.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_entity |
    "!   The name of the entity.
    "! @parameter I_export |
    "!   Whether to include all element content in the returned data. If
    "!    **export**=`false`, the returned data includes only information about the
    "!    element itself. If **export**=`true`, all content, including subelements, is
    "!    included.
    "! @parameter I_include_audit |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENTITY
    "!
  methods GET_ENTITY
    importing
      !I_workspace_id type STRING
      !I_entity type STRING
      !I_export type BOOLEAN default c_boolean_false
      !I_include_audit type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENTITY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Update entity.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_entity |
    "!   The name of the entity.
    "! @parameter I_body |
    "!   The updated content of the entity. Any elements included in the new data will
    "!    completely replace the equivalent existing elements, including all subelements.
    "!    (Previously existing subelements are not retained unless they are also included
    "!    in the new data.) For example, if you update the values for an entity, the
    "!    previously existing values are discarded and replaced with the new values
    "!    specified in the update.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENTITY
    "!
  methods UPDATE_ENTITY
    importing
      !I_workspace_id type STRING
      !I_entity type STRING
      !I_body type T_UPDATE_ENTITY
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENTITY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete entity.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_entity |
    "!   The name of the entity.
    "!
  methods DELETE_ENTITY
    importing
      !I_workspace_id type STRING
      !I_entity type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List entity mentions.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_entity |
    "!   The name of the entity.
    "! @parameter I_export |
    "!   Whether to include all element content in the returned data. If
    "!    **export**=`false`, the returned data includes only information about the
    "!    element itself. If **export**=`true`, all content, including subelements, is
    "!    included.
    "! @parameter I_include_audit |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENTITY_MENTION_COLLECTION
    "!
  methods LIST_MENTIONS
    importing
      !I_workspace_id type STRING
      !I_entity type STRING
      !I_export type BOOLEAN default c_boolean_false
      !I_include_audit type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENTITY_MENTION_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List entity values.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_entity |
    "!   The name of the entity.
    "! @parameter I_export |
    "!   Whether to include all element content in the returned data. If
    "!    **export**=`false`, the returned data includes only information about the
    "!    element itself. If **export**=`true`, all content, including subelements, is
    "!    included.
    "! @parameter I_page_limit |
    "!   The number of records to return in each page of results.
    "! @parameter I_sort |
    "!   The attribute by which returned entity values will be sorted. To reverse the
    "!    sort order, prefix the value with a minus sign (`-`).
    "! @parameter I_cursor |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_include_audit |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_VALUE_COLLECTION
    "!
  methods LIST_VALUES
    importing
      !I_workspace_id type STRING
      !I_entity type STRING
      !I_export type BOOLEAN default c_boolean_false
      !I_page_limit type INTEGER optional
      !I_sort type STRING optional
      !I_cursor type STRING optional
      !I_include_audit type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_VALUE_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Create entity value.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_entity |
    "!   The name of the entity.
    "! @parameter I_body |
    "!   The new entity value.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_VALUE
    "!
  methods CREATE_VALUE
    importing
      !I_workspace_id type STRING
      !I_entity type STRING
      !I_body type T_CREATE_VALUE
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_VALUE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get entity value.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_entity |
    "!   The name of the entity.
    "! @parameter I_value |
    "!   The text of the entity value.
    "! @parameter I_export |
    "!   Whether to include all element content in the returned data. If
    "!    **export**=`false`, the returned data includes only information about the
    "!    element itself. If **export**=`true`, all content, including subelements, is
    "!    included.
    "! @parameter I_include_audit |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_VALUE
    "!
  methods GET_VALUE
    importing
      !I_workspace_id type STRING
      !I_entity type STRING
      !I_value type STRING
      !I_export type BOOLEAN default c_boolean_false
      !I_include_audit type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_VALUE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Update entity value.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_entity |
    "!   The name of the entity.
    "! @parameter I_value |
    "!   The text of the entity value.
    "! @parameter I_body |
    "!   The updated content of the entity value.
    "!
    "!   Any elements included in the new data will completely replace the equivalent
    "!    existing elements, including all subelements. (Previously existing subelements
    "!    are not retained unless they are also included in the new data.) For example,
    "!    if you update the synonyms for an entity value, the previously existing
    "!    synonyms are discarded and replaced with the new synonyms specified in the
    "!    update.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_VALUE
    "!
  methods UPDATE_VALUE
    importing
      !I_workspace_id type STRING
      !I_entity type STRING
      !I_value type STRING
      !I_body type T_UPDATE_VALUE
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_VALUE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete entity value.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_entity |
    "!   The name of the entity.
    "! @parameter I_value |
    "!   The text of the entity value.
    "!
  methods DELETE_VALUE
    importing
      !I_workspace_id type STRING
      !I_entity type STRING
      !I_value type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List entity value synonyms.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_entity |
    "!   The name of the entity.
    "! @parameter I_value |
    "!   The text of the entity value.
    "! @parameter I_page_limit |
    "!   The number of records to return in each page of results.
    "! @parameter I_sort |
    "!   The attribute by which returned entity value synonyms will be sorted. To reverse
    "!    the sort order, prefix the value with a minus sign (`-`).
    "! @parameter I_cursor |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_include_audit |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SYNONYM_COLLECTION
    "!
  methods LIST_SYNONYMS
    importing
      !I_workspace_id type STRING
      !I_entity type STRING
      !I_value type STRING
      !I_page_limit type INTEGER optional
      !I_sort type STRING optional
      !I_cursor type STRING optional
      !I_include_audit type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SYNONYM_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Create entity value synonym.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_entity |
    "!   The name of the entity.
    "! @parameter I_value |
    "!   The text of the entity value.
    "! @parameter I_body |
    "!   The new synonym.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SYNONYM
    "!
  methods CREATE_SYNONYM
    importing
      !I_workspace_id type STRING
      !I_entity type STRING
      !I_value type STRING
      !I_body type T_SYNONYM
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SYNONYM
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get entity value synonym.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_entity |
    "!   The name of the entity.
    "! @parameter I_value |
    "!   The text of the entity value.
    "! @parameter I_synonym |
    "!   The text of the synonym.
    "! @parameter I_include_audit |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SYNONYM
    "!
  methods GET_SYNONYM
    importing
      !I_workspace_id type STRING
      !I_entity type STRING
      !I_value type STRING
      !I_synonym type STRING
      !I_include_audit type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SYNONYM
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Update entity value synonym.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_entity |
    "!   The name of the entity.
    "! @parameter I_value |
    "!   The text of the entity value.
    "! @parameter I_synonym |
    "!   The text of the synonym.
    "! @parameter I_body |
    "!   The updated entity value synonym.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SYNONYM
    "!
  methods UPDATE_SYNONYM
    importing
      !I_workspace_id type STRING
      !I_entity type STRING
      !I_value type STRING
      !I_synonym type STRING
      !I_body type T_UPDATE_SYNONYM
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SYNONYM
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete entity value synonym.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_entity |
    "!   The name of the entity.
    "! @parameter I_value |
    "!   The text of the entity value.
    "! @parameter I_synonym |
    "!   The text of the synonym.
    "!
  methods DELETE_SYNONYM
    importing
      !I_workspace_id type STRING
      !I_entity type STRING
      !I_value type STRING
      !I_synonym type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List dialog nodes.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_page_limit |
    "!   The number of records to return in each page of results.
    "! @parameter I_sort |
    "!   The attribute by which returned dialog nodes will be sorted. To reverse the sort
    "!    order, prefix the value with a minus sign (`-`).
    "! @parameter I_cursor |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_include_audit |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DIALOG_NODE_COLLECTION
    "!
  methods LIST_DIALOG_NODES
    importing
      !I_workspace_id type STRING
      !I_page_limit type INTEGER optional
      !I_sort type STRING optional
      !I_cursor type STRING optional
      !I_include_audit type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DIALOG_NODE_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Create dialog node.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_body |
    "!   A CreateDialogNode object defining the content of the new dialog node.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DIALOG_NODE
    "!
  methods CREATE_DIALOG_NODE
    importing
      !I_workspace_id type STRING
      !I_body type T_DIALOG_NODE
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DIALOG_NODE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get dialog node.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_dialog_node |
    "!   The dialog node ID (for example, `get_order`).
    "! @parameter I_include_audit |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DIALOG_NODE
    "!
  methods GET_DIALOG_NODE
    importing
      !I_workspace_id type STRING
      !I_dialog_node type STRING
      !I_include_audit type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DIALOG_NODE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Update dialog node.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_dialog_node |
    "!   The dialog node ID (for example, `get_order`).
    "! @parameter I_body |
    "!   The updated content of the dialog node.
    "!
    "!   Any elements included in the new data will completely replace the equivalent
    "!    existing elements, including all subelements. (Previously existing subelements
    "!    are not retained unless they are also included in the new data.) For example,
    "!    if you update the actions for a dialog node, the previously existing actions
    "!    are discarded and replaced with the new actions specified in the update.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DIALOG_NODE
    "!
  methods UPDATE_DIALOG_NODE
    importing
      !I_workspace_id type STRING
      !I_dialog_node type STRING
      !I_body type T_UPDATE_DIALOG_NODE
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DIALOG_NODE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete dialog node.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_dialog_node |
    "!   The dialog node ID (for example, `get_order`).
    "!
  methods DELETE_DIALOG_NODE
    importing
      !I_workspace_id type STRING
      !I_dialog_node type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List log events in a workspace.
    "!
    "! @parameter I_workspace_id |
    "!   Unique identifier of the workspace.
    "! @parameter I_sort |
    "!   How to sort the returned log events. You can sort by **request_timestamp**. To
    "!    reverse the sort order, prefix the parameter value with a minus sign (`-`).
    "! @parameter I_filter |
    "!   A cacheable parameter that limits the results to those matching the specified
    "!    filter. For more information, see the
    "!    [documentation](https://cloud.ibm.com/docs/services/assistant?topic=assistant-f
    "!   ilter-reference#filter-reference).
    "! @parameter I_page_limit |
    "!   The number of records to return in each page of results.
    "! @parameter I_cursor |
    "!   A token identifying the page of results to retrieve.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LOG_COLLECTION
    "!
  methods LIST_LOGS
    importing
      !I_workspace_id type STRING
      !I_sort type STRING optional
      !I_filter type STRING optional
      !I_page_limit type INTEGER optional
      !I_cursor type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LOG_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! List log events in all workspaces.
    "!
    "! @parameter I_filter |
    "!   A cacheable parameter that limits the results to those matching the specified
    "!    filter. You must specify a filter query that includes a value for `language`,
    "!    as well as a value for `workspace_id` or `request.context.metadata.deployment`.
    "!    For more information, see the
    "!    [documentation](https://cloud.ibm.com/docs/services/assistant?topic=assistant-f
    "!   ilter-reference#filter-reference).
    "! @parameter I_sort |
    "!   How to sort the returned log events. You can sort by **request_timestamp**. To
    "!    reverse the sort order, prefix the parameter value with a minus sign (`-`).
    "! @parameter I_page_limit |
    "!   The number of records to return in each page of results.
    "! @parameter I_cursor |
    "!   A token identifying the page of results to retrieve.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LOG_COLLECTION
    "!
  methods LIST_ALL_LOGS
    importing
      !I_filter type STRING
      !I_sort type STRING optional
      !I_page_limit type INTEGER optional
      !I_cursor type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LOG_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Delete labeled data.
    "!
    "! @parameter I_customer_id |
    "!   The customer ID for which all data is to be deleted.
    "!
  methods DELETE_USER_DATA
    importing
      !I_customer_id type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .


protected section.

private section.

  methods SET_DEFAULT_QUERY_PARAMETERS
    changing
      !C_URL type TS_URL .

ENDCLASS.

class ZCL_IBMC_ASSISTANT_V1 IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->GET_APPNAME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_APPNAME                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method GET_APPNAME.

    e_appname = 'Watson Assistant v1'.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method ZCL_IBMC_ASSISTANT_V1->GET_REQUEST_PROP
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_AUTH_METHOD                  TYPE        STRING (default =C_DEFAULT)
* | [<-()] E_REQUEST_PROP                 TYPE        TS_REQUEST_PROP
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_REQUEST_PROP.

  data:
    lv_auth_method type string  ##NEEDED.

  e_request_prop = super->get_request_prop( ).

  lv_auth_method = i_auth_method.
  if lv_auth_method eq c_default.
    lv_auth_method = 'IAM'.
  endif.
  if lv_auth_method is initial.
    e_request_prop-auth_basic      = c_boolean_false.
    e_request_prop-auth_oauth      = c_boolean_false.
    e_request_prop-auth_apikey     = c_boolean_false.
  elseif lv_auth_method eq 'IAM'.
    e_request_prop-auth_name       = 'IAM'.
    e_request_prop-auth_type       = 'apiKey'.
    e_request_prop-auth_headername = 'Authorization'.
    e_request_prop-auth_header     = c_boolean_true.
  elseif lv_auth_method eq 'ICP4D'.
    e_request_prop-auth_name       = 'ICP4D'.
    e_request_prop-auth_type       = 'apiKey'.
    e_request_prop-auth_headername = 'Authorization'.
    e_request_prop-auth_header     = c_boolean_true.
  elseif lv_auth_method eq 'basicAuth'.
    e_request_prop-auth_name       = 'basicAuth'.
    e_request_prop-auth_type       = 'http'.
    e_request_prop-auth_basic      = c_boolean_true.
  else.
  endif.

  e_request_prop-url-protocol    = 'http'.
  e_request_prop-url-host        = 'localhost'.
  e_request_prop-url-path_base   = '/assistant/api'.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20191002122834'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->MESSAGE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_body        TYPE T_MESSAGE_REQUEST(optional)
* | [--->] I_nodes_visited_details        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_MESSAGE_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method MESSAGE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/message'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_nodes_visited_details is supplied.
    lv_queryparam = i_nodes_visited_details.
    add_query_parameter(
      exporting
        i_parameter  = `nodes_visited_details`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.




    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    if not i_body is initial.
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    endif.
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
	  lv_body = `{` && lv_body && `}`.
	endif.

	if ls_request_prop-header_content_type cp '*charset=utf-8*'.
	  ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
	  replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
	else.
	  ls_request_prop-body = lv_body.
	endif.


    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->LIST_WORKSPACES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_page_limit        TYPE INTEGER(optional)
* | [--->] I_sort        TYPE STRING(optional)
* | [--->] I_cursor        TYPE STRING(optional)
* | [--->] I_include_audit        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_WORKSPACE_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_WORKSPACES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_page_limit is supplied.
    lv_queryparam = i_page_limit.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_sort is supplied.
    lv_queryparam = escape( val = i_sort format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_cursor is supplied.
    lv_queryparam = escape( val = i_cursor format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_include_audit is supplied.
    lv_queryparam = i_include_audit.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->CREATE_WORKSPACE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_body        TYPE T_CREATE_WORKSPACE(optional)
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_WORKSPACE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_WORKSPACE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces'.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).






    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    if not i_body is initial.
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    endif.
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
	  lv_body = `{` && lv_body && `}`.
	endif.

	if ls_request_prop-header_content_type cp '*charset=utf-8*'.
	  ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
	  replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
	else.
	  ls_request_prop-body = lv_body.
	endif.


    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->GET_WORKSPACE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_export        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_include_audit        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_sort        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_WORKSPACE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_WORKSPACE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_export is supplied.
    lv_queryparam = i_export.
    add_query_parameter(
      exporting
        i_parameter  = `export`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_include_audit is supplied.
    lv_queryparam = i_include_audit.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_sort is supplied.
    lv_queryparam = escape( val = i_sort format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->UPDATE_WORKSPACE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_body        TYPE T_UPDATE_WORKSPACE(optional)
* | [--->] I_append        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_WORKSPACE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_WORKSPACE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_append is supplied.
    lv_queryparam = i_append.
    add_query_parameter(
      exporting
        i_parameter  = `append`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.




    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    if not i_body is initial.
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    endif.
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
	  lv_body = `{` && lv_body && `}`.
	endif.

	if ls_request_prop-header_content_type cp '*charset=utf-8*'.
	  ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
	  replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
	else.
	  ls_request_prop-body = lv_body.
	endif.


    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->DELETE_WORKSPACE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_WORKSPACE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->LIST_INTENTS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_export        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_page_limit        TYPE INTEGER(optional)
* | [--->] I_sort        TYPE STRING(optional)
* | [--->] I_cursor        TYPE STRING(optional)
* | [--->] I_include_audit        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_INTENT_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_INTENTS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/intents'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_export is supplied.
    lv_queryparam = i_export.
    add_query_parameter(
      exporting
        i_parameter  = `export`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_page_limit is supplied.
    lv_queryparam = i_page_limit.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_sort is supplied.
    lv_queryparam = escape( val = i_sort format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_cursor is supplied.
    lv_queryparam = escape( val = i_cursor format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_include_audit is supplied.
    lv_queryparam = i_include_audit.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->CREATE_INTENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_body        TYPE T_CREATE_INTENT
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_INTENT
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_INTENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/intents'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).






    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
	  lv_body = `{` && lv_body && `}`.
	endif.

	if ls_request_prop-header_content_type cp '*charset=utf-8*'.
	  ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
	  replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
	else.
	  ls_request_prop-body = lv_body.
	endif.


    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->GET_INTENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_intent        TYPE STRING
* | [--->] I_export        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_include_audit        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_INTENT
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_INTENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/intents/{intent}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{intent}` in ls_request_prop-url-path with i_intent ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_export is supplied.
    lv_queryparam = i_export.
    add_query_parameter(
      exporting
        i_parameter  = `export`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_include_audit is supplied.
    lv_queryparam = i_include_audit.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->UPDATE_INTENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_intent        TYPE STRING
* | [--->] I_body        TYPE T_UPDATE_INTENT
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_INTENT
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_INTENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/intents/{intent}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{intent}` in ls_request_prop-url-path with i_intent ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).






    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
	  lv_body = `{` && lv_body && `}`.
	endif.

	if ls_request_prop-header_content_type cp '*charset=utf-8*'.
	  ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
	  replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
	else.
	  ls_request_prop-body = lv_body.
	endif.


    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->DELETE_INTENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_intent        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_INTENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/intents/{intent}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{intent}` in ls_request_prop-url-path with i_intent ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->LIST_EXAMPLES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_intent        TYPE STRING
* | [--->] I_page_limit        TYPE INTEGER(optional)
* | [--->] I_sort        TYPE STRING(optional)
* | [--->] I_cursor        TYPE STRING(optional)
* | [--->] I_include_audit        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_EXAMPLE_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_EXAMPLES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/intents/{intent}/examples'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{intent}` in ls_request_prop-url-path with i_intent ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_page_limit is supplied.
    lv_queryparam = i_page_limit.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_sort is supplied.
    lv_queryparam = escape( val = i_sort format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_cursor is supplied.
    lv_queryparam = escape( val = i_cursor format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_include_audit is supplied.
    lv_queryparam = i_include_audit.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->CREATE_EXAMPLE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_intent        TYPE STRING
* | [--->] I_body        TYPE T_EXAMPLE
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_EXAMPLE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_EXAMPLE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/intents/{intent}/examples'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{intent}` in ls_request_prop-url-path with i_intent ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).






    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
	  lv_body = `{` && lv_body && `}`.
	endif.

	if ls_request_prop-header_content_type cp '*charset=utf-8*'.
	  ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
	  replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
	else.
	  ls_request_prop-body = lv_body.
	endif.


    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->GET_EXAMPLE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_intent        TYPE STRING
* | [--->] I_text        TYPE STRING
* | [--->] I_include_audit        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_EXAMPLE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_EXAMPLE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/intents/{intent}/examples/{text}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{intent}` in ls_request_prop-url-path with i_intent ignoring case.
    replace all occurrences of `{text}` in ls_request_prop-url-path with i_text ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_include_audit is supplied.
    lv_queryparam = i_include_audit.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->UPDATE_EXAMPLE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_intent        TYPE STRING
* | [--->] I_text        TYPE STRING
* | [--->] I_body        TYPE T_UPDATE_EXAMPLE
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_EXAMPLE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_EXAMPLE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/intents/{intent}/examples/{text}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{intent}` in ls_request_prop-url-path with i_intent ignoring case.
    replace all occurrences of `{text}` in ls_request_prop-url-path with i_text ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).






    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
	  lv_body = `{` && lv_body && `}`.
	endif.

	if ls_request_prop-header_content_type cp '*charset=utf-8*'.
	  ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
	  replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
	else.
	  ls_request_prop-body = lv_body.
	endif.


    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->DELETE_EXAMPLE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_intent        TYPE STRING
* | [--->] I_text        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_EXAMPLE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/intents/{intent}/examples/{text}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{intent}` in ls_request_prop-url-path with i_intent ignoring case.
    replace all occurrences of `{text}` in ls_request_prop-url-path with i_text ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->LIST_COUNTEREXAMPLES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_page_limit        TYPE INTEGER(optional)
* | [--->] I_sort        TYPE STRING(optional)
* | [--->] I_cursor        TYPE STRING(optional)
* | [--->] I_include_audit        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_COUNTEREXAMPLE_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_COUNTEREXAMPLES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/counterexamples'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_page_limit is supplied.
    lv_queryparam = i_page_limit.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_sort is supplied.
    lv_queryparam = escape( val = i_sort format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_cursor is supplied.
    lv_queryparam = escape( val = i_cursor format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_include_audit is supplied.
    lv_queryparam = i_include_audit.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->CREATE_COUNTEREXAMPLE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_body        TYPE T_COUNTEREXAMPLE
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_COUNTEREXAMPLE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_COUNTEREXAMPLE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/counterexamples'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).






    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
	  lv_body = `{` && lv_body && `}`.
	endif.

	if ls_request_prop-header_content_type cp '*charset=utf-8*'.
	  ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
	  replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
	else.
	  ls_request_prop-body = lv_body.
	endif.


    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->GET_COUNTEREXAMPLE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_text        TYPE STRING
* | [--->] I_include_audit        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_COUNTEREXAMPLE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_COUNTEREXAMPLE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/counterexamples/{text}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{text}` in ls_request_prop-url-path with i_text ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_include_audit is supplied.
    lv_queryparam = i_include_audit.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->UPDATE_COUNTEREXAMPLE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_text        TYPE STRING
* | [--->] I_body        TYPE T_UPDATE_COUNTEREXAMPLE
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_COUNTEREXAMPLE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_COUNTEREXAMPLE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/counterexamples/{text}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{text}` in ls_request_prop-url-path with i_text ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).






    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
	  lv_body = `{` && lv_body && `}`.
	endif.

	if ls_request_prop-header_content_type cp '*charset=utf-8*'.
	  ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
	  replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
	else.
	  ls_request_prop-body = lv_body.
	endif.


    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->DELETE_COUNTEREXAMPLE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_text        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_COUNTEREXAMPLE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/counterexamples/{text}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{text}` in ls_request_prop-url-path with i_text ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->LIST_ENTITIES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_export        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_page_limit        TYPE INTEGER(optional)
* | [--->] I_sort        TYPE STRING(optional)
* | [--->] I_cursor        TYPE STRING(optional)
* | [--->] I_include_audit        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ENTITY_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_ENTITIES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/entities'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_export is supplied.
    lv_queryparam = i_export.
    add_query_parameter(
      exporting
        i_parameter  = `export`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_page_limit is supplied.
    lv_queryparam = i_page_limit.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_sort is supplied.
    lv_queryparam = escape( val = i_sort format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_cursor is supplied.
    lv_queryparam = escape( val = i_cursor format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_include_audit is supplied.
    lv_queryparam = i_include_audit.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->CREATE_ENTITY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_body        TYPE T_CREATE_ENTITY
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ENTITY
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_ENTITY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/entities'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).






    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
	  lv_body = `{` && lv_body && `}`.
	endif.

	if ls_request_prop-header_content_type cp '*charset=utf-8*'.
	  ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
	  replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
	else.
	  ls_request_prop-body = lv_body.
	endif.


    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->GET_ENTITY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_entity        TYPE STRING
* | [--->] I_export        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_include_audit        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ENTITY
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_ENTITY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/entities/{entity}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_entity ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_export is supplied.
    lv_queryparam = i_export.
    add_query_parameter(
      exporting
        i_parameter  = `export`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_include_audit is supplied.
    lv_queryparam = i_include_audit.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->UPDATE_ENTITY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_entity        TYPE STRING
* | [--->] I_body        TYPE T_UPDATE_ENTITY
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ENTITY
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_ENTITY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/entities/{entity}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_entity ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).






    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
	  lv_body = `{` && lv_body && `}`.
	endif.

	if ls_request_prop-header_content_type cp '*charset=utf-8*'.
	  ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
	  replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
	else.
	  ls_request_prop-body = lv_body.
	endif.


    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->DELETE_ENTITY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_entity        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_ENTITY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/entities/{entity}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_entity ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->LIST_MENTIONS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_entity        TYPE STRING
* | [--->] I_export        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_include_audit        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ENTITY_MENTION_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_MENTIONS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/entities/{entity}/mentions'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_entity ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_export is supplied.
    lv_queryparam = i_export.
    add_query_parameter(
      exporting
        i_parameter  = `export`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_include_audit is supplied.
    lv_queryparam = i_include_audit.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->LIST_VALUES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_entity        TYPE STRING
* | [--->] I_export        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_page_limit        TYPE INTEGER(optional)
* | [--->] I_sort        TYPE STRING(optional)
* | [--->] I_cursor        TYPE STRING(optional)
* | [--->] I_include_audit        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_VALUE_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_VALUES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/entities/{entity}/values'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_entity ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_export is supplied.
    lv_queryparam = i_export.
    add_query_parameter(
      exporting
        i_parameter  = `export`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_page_limit is supplied.
    lv_queryparam = i_page_limit.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_sort is supplied.
    lv_queryparam = escape( val = i_sort format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_cursor is supplied.
    lv_queryparam = escape( val = i_cursor format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_include_audit is supplied.
    lv_queryparam = i_include_audit.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->CREATE_VALUE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_entity        TYPE STRING
* | [--->] I_body        TYPE T_CREATE_VALUE
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_VALUE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_VALUE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/entities/{entity}/values'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_entity ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).






    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
	  lv_body = `{` && lv_body && `}`.
	endif.

	if ls_request_prop-header_content_type cp '*charset=utf-8*'.
	  ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
	  replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
	else.
	  ls_request_prop-body = lv_body.
	endif.


    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->GET_VALUE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_entity        TYPE STRING
* | [--->] I_value        TYPE STRING
* | [--->] I_export        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_include_audit        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_VALUE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_VALUE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/entities/{entity}/values/{value}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_entity ignoring case.
    replace all occurrences of `{value}` in ls_request_prop-url-path with i_value ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_export is supplied.
    lv_queryparam = i_export.
    add_query_parameter(
      exporting
        i_parameter  = `export`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_include_audit is supplied.
    lv_queryparam = i_include_audit.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->UPDATE_VALUE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_entity        TYPE STRING
* | [--->] I_value        TYPE STRING
* | [--->] I_body        TYPE T_UPDATE_VALUE
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_VALUE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_VALUE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/entities/{entity}/values/{value}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_entity ignoring case.
    replace all occurrences of `{value}` in ls_request_prop-url-path with i_value ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).






    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
	  lv_body = `{` && lv_body && `}`.
	endif.

	if ls_request_prop-header_content_type cp '*charset=utf-8*'.
	  ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
	  replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
	else.
	  ls_request_prop-body = lv_body.
	endif.


    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->DELETE_VALUE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_entity        TYPE STRING
* | [--->] I_value        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_VALUE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/entities/{entity}/values/{value}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_entity ignoring case.
    replace all occurrences of `{value}` in ls_request_prop-url-path with i_value ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->LIST_SYNONYMS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_entity        TYPE STRING
* | [--->] I_value        TYPE STRING
* | [--->] I_page_limit        TYPE INTEGER(optional)
* | [--->] I_sort        TYPE STRING(optional)
* | [--->] I_cursor        TYPE STRING(optional)
* | [--->] I_include_audit        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_SYNONYM_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_SYNONYMS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/entities/{entity}/values/{value}/synonyms'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_entity ignoring case.
    replace all occurrences of `{value}` in ls_request_prop-url-path with i_value ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_page_limit is supplied.
    lv_queryparam = i_page_limit.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_sort is supplied.
    lv_queryparam = escape( val = i_sort format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_cursor is supplied.
    lv_queryparam = escape( val = i_cursor format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_include_audit is supplied.
    lv_queryparam = i_include_audit.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->CREATE_SYNONYM
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_entity        TYPE STRING
* | [--->] I_value        TYPE STRING
* | [--->] I_body        TYPE T_SYNONYM
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_SYNONYM
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_SYNONYM.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/entities/{entity}/values/{value}/synonyms'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_entity ignoring case.
    replace all occurrences of `{value}` in ls_request_prop-url-path with i_value ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).






    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
	  lv_body = `{` && lv_body && `}`.
	endif.

	if ls_request_prop-header_content_type cp '*charset=utf-8*'.
	  ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
	  replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
	else.
	  ls_request_prop-body = lv_body.
	endif.


    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->GET_SYNONYM
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_entity        TYPE STRING
* | [--->] I_value        TYPE STRING
* | [--->] I_synonym        TYPE STRING
* | [--->] I_include_audit        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_SYNONYM
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_SYNONYM.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/entities/{entity}/values/{value}/synonyms/{synonym}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_entity ignoring case.
    replace all occurrences of `{value}` in ls_request_prop-url-path with i_value ignoring case.
    replace all occurrences of `{synonym}` in ls_request_prop-url-path with i_synonym ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_include_audit is supplied.
    lv_queryparam = i_include_audit.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->UPDATE_SYNONYM
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_entity        TYPE STRING
* | [--->] I_value        TYPE STRING
* | [--->] I_synonym        TYPE STRING
* | [--->] I_body        TYPE T_UPDATE_SYNONYM
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_SYNONYM
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_SYNONYM.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/entities/{entity}/values/{value}/synonyms/{synonym}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_entity ignoring case.
    replace all occurrences of `{value}` in ls_request_prop-url-path with i_value ignoring case.
    replace all occurrences of `{synonym}` in ls_request_prop-url-path with i_synonym ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).






    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
	  lv_body = `{` && lv_body && `}`.
	endif.

	if ls_request_prop-header_content_type cp '*charset=utf-8*'.
	  ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
	  replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
	else.
	  ls_request_prop-body = lv_body.
	endif.


    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->DELETE_SYNONYM
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_entity        TYPE STRING
* | [--->] I_value        TYPE STRING
* | [--->] I_synonym        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_SYNONYM.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/entities/{entity}/values/{value}/synonyms/{synonym}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_entity ignoring case.
    replace all occurrences of `{value}` in ls_request_prop-url-path with i_value ignoring case.
    replace all occurrences of `{synonym}` in ls_request_prop-url-path with i_synonym ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->LIST_DIALOG_NODES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_page_limit        TYPE INTEGER(optional)
* | [--->] I_sort        TYPE STRING(optional)
* | [--->] I_cursor        TYPE STRING(optional)
* | [--->] I_include_audit        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DIALOG_NODE_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_DIALOG_NODES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/dialog_nodes'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_page_limit is supplied.
    lv_queryparam = i_page_limit.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_sort is supplied.
    lv_queryparam = escape( val = i_sort format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_cursor is supplied.
    lv_queryparam = escape( val = i_cursor format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_include_audit is supplied.
    lv_queryparam = i_include_audit.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->CREATE_DIALOG_NODE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_body        TYPE T_DIALOG_NODE
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DIALOG_NODE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_DIALOG_NODE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/dialog_nodes'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).






    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
	  lv_body = `{` && lv_body && `}`.
	endif.

	if ls_request_prop-header_content_type cp '*charset=utf-8*'.
	  ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
	  replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
	else.
	  ls_request_prop-body = lv_body.
	endif.


    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->GET_DIALOG_NODE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_dialog_node        TYPE STRING
* | [--->] I_include_audit        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DIALOG_NODE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_DIALOG_NODE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/dialog_nodes/{dialog_node}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{dialog_node}` in ls_request_prop-url-path with i_dialog_node ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_include_audit is supplied.
    lv_queryparam = i_include_audit.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->UPDATE_DIALOG_NODE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_dialog_node        TYPE STRING
* | [--->] I_body        TYPE T_UPDATE_DIALOG_NODE
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_DIALOG_NODE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_DIALOG_NODE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/dialog_nodes/{dialog_node}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{dialog_node}` in ls_request_prop-url-path with i_dialog_node ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).






    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_body ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_body i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_body ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_body to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
	  lv_body = `{` && lv_body && `}`.
	endif.

	if ls_request_prop-header_content_type cp '*charset=utf-8*'.
	  ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
	  replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
	else.
	  ls_request_prop-body = lv_body.
	endif.


    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->DELETE_DIALOG_NODE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_dialog_node        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_DIALOG_NODE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/dialog_nodes/{dialog_node}'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.
    replace all occurrences of `{dialog_node}` in ls_request_prop-url-path with i_dialog_node ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->LIST_LOGS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_workspace_id        TYPE STRING
* | [--->] I_sort        TYPE STRING(optional)
* | [--->] I_filter        TYPE STRING(optional)
* | [--->] I_page_limit        TYPE INTEGER(optional)
* | [--->] I_cursor        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_LOG_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_LOGS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/workspaces/{workspace_id}/logs'.
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_workspace_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_sort is supplied.
    lv_queryparam = escape( val = i_sort format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_filter is supplied.
    lv_queryparam = escape( val = i_filter format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `filter`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_page_limit is supplied.
    lv_queryparam = i_page_limit.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_cursor is supplied.
    lv_queryparam = escape( val = i_cursor format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->LIST_ALL_LOGS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_filter        TYPE STRING
* | [--->] I_sort        TYPE STRING(optional)
* | [--->] I_page_limit        TYPE INTEGER(optional)
* | [--->] I_cursor        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_LOG_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_ALL_LOGS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/logs'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    lv_queryparam = escape( val = i_filter format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `filter`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.

    if i_sort is supplied.
    lv_queryparam = escape( val = i_sort format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_page_limit is supplied.
    lv_queryparam = i_page_limit.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_cursor is supplied.
    lv_queryparam = escape( val = i_cursor format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve JSON data
    lv_json = get_response_string( lo_response ).
    parse_json(
      exporting
        i_json       = lv_json
        i_dictionary = c_abapname_dictionary
      changing
        c_abap       = e_response ).

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->DELETE_USER_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customer_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_USER_DATA.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/user_data'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    lv_queryparam = escape( val = i_customer_id format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `customer_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.






    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.




* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_IBMC_ASSISTANT_V1->SET_DEFAULT_QUERY_PARAMETERS
* +-------------------------------------------------------------------------------------------------+
* | [<-->] C_URL                          TYPE        TS_URL
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method set_default_query_parameters.
    if not p_version is initial.
      add_query_parameter(
        exporting
          i_parameter = `version`
          i_value     = p_version
        changing
          c_url       = c_url ).
    endif.
  endmethod.

ENDCLASS.
