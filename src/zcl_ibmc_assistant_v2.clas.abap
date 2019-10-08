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
"! <h1>Watson Assistant v2</h1>
"! The IBM Watson&trade; Assistant service combines machine learning, natural
"!  language understanding, and an integrated dialog editor to create conversation
"!  flows between your apps and your users.
"!
"! The Assistant v2 API provides runtime methods your client application can use to
"!  send user input to an assistant and receive a response. <br/>
class ZCL_IBMC_ASSISTANT_V2 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "!   Dialog log message details.
    begin of T_DIALOG_LOG_MESSAGE,
      LEVEL type STRING,
      MESSAGE type STRING,
    end of T_DIALOG_LOG_MESSAGE.
  types:
    "!
    begin of T_DIALOG_NODES_VISITED,
      DIALOG_NODE type STRING,
      TITLE type STRING,
      CONDITIONS type STRING,
    end of T_DIALOG_NODES_VISITED.
  types:
    "!   Additional detailed information about a message response and how it was
    "!    generated.
    begin of T_MESSAGE_OUTPUT_DEBUG,
      NODES_VISITED type STANDARD TABLE OF T_DIALOG_NODES_VISITED WITH NON-UNIQUE DEFAULT KEY,
      LOG_MESSAGES type STANDARD TABLE OF T_DIALOG_LOG_MESSAGE WITH NON-UNIQUE DEFAULT KEY,
      BRANCH_EXITED type BOOLEAN,
      BRANCH_EXITED_REASON type STRING,
    end of T_MESSAGE_OUTPUT_DEBUG.
  types:
    "!
      T_EMPTY_RESPONSE type JSONOBJECT.
  types:
    "!
    begin of T_SESSION_RESPONSE,
      SESSION_ID type STRING,
    end of T_SESSION_RESPONSE.
  types:
    "!
    begin of T_RT_ENTTY_INTRPRTTN_SYS_NUM,
      NUMERIC_VALUE type NUMBER,
      RANGE_LINK type STRING,
      SUBTYPE type STRING,
    end of T_RT_ENTTY_INTRPRTTN_SYS_NUM.
  types:
    "!   An alternative value for the recognized entity.
    begin of T_RUNTIME_ENTITY_ALTERNATIVE,
      VALUE type STRING,
      CONFIDENCE type NUMBER,
    end of T_RUNTIME_ENTITY_ALTERNATIVE.
  types:
    "!   Optional properties that control how the assistant responds.
    begin of T_MESSAGE_INPUT_OPTIONS,
      DEBUG type BOOLEAN,
      RESTART type BOOLEAN,
      ALTERNATE_INTENTS type BOOLEAN,
      RETURN_CONTEXT type BOOLEAN,
    end of T_MESSAGE_INPUT_OPTIONS.
  types:
    "!   An intent identified in the user input.
    begin of T_RUNTIME_INTENT,
      INTENT type STRING,
      CONFIDENCE type DOUBLE,
    end of T_RUNTIME_INTENT.
  types:
    "!
    begin of T_CAPTURE_GROUP,
      GROUP type STRING,
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
    end of T_CAPTURE_GROUP.
  types:
    "!   The entity value that was recognized in the user input.
    begin of T_RUNTIME_ENTITY,
      ENTITY type STRING,
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
      VALUE type STRING,
      CONFIDENCE type NUMBER,
      METADATA type MAP,
      GROUPS type STANDARD TABLE OF T_CAPTURE_GROUP WITH NON-UNIQUE DEFAULT KEY,
    end of T_RUNTIME_ENTITY.
  types:
    "!   An input object that includes the input text.
    begin of T_MESSAGE_INPUT,
      MESSAGE_TYPE type STRING,
      TEXT type STRING,
      OPTIONS type T_MESSAGE_INPUT_OPTIONS,
      INTENTS type STANDARD TABLE OF T_RUNTIME_INTENT WITH NON-UNIQUE DEFAULT KEY,
      ENTITIES type STANDARD TABLE OF T_RUNTIME_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      SUGGESTION_ID type STRING,
    end of T_MESSAGE_INPUT.
  types:
    "!   An object defining the message input to be sent to the assistant if the user
    "!    selects the corresponding option.
    begin of T_DIA_ND_OUTPUT_OPT_ELEM_VALUE,
      INPUT type T_MESSAGE_INPUT,
    end of T_DIA_ND_OUTPUT_OPT_ELEM_VALUE.
  types:
    "!
    begin of T_DIA_NODE_OUTPUT_OPT_ELEMENT,
      LABEL type STRING,
      VALUE type T_DIA_ND_OUTPUT_OPT_ELEM_VALUE,
    end of T_DIA_NODE_OUTPUT_OPT_ELEMENT.
  types:
    "!
    begin of T_RUNTIME_RESPONSE_TYPE_OPTION,
      TITLE type STRING,
      DESCRIPTION type STRING,
      PREFERENCE type STRING,
      OPTIONS type STANDARD TABLE OF T_DIA_NODE_OUTPUT_OPT_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
    end of T_RUNTIME_RESPONSE_TYPE_OPTION.
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
    "!   An object containing segments of text from search results with query-matching
    "!    text highlighted using HTML <em> tags.
    begin of T_SEARCH_RESULT_HIGHLIGHT,
      BODY type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      TITLE type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      URL type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_SEARCH_RESULT_HIGHLIGHT.
  types:
    "!   An object defining the message input to be sent to the assistant if the user
    "!    selects the corresponding disambiguation option.
    begin of T_DIALOG_SUGGESTION_VALUE,
      INPUT type T_MESSAGE_INPUT,
    end of T_DIALOG_SUGGESTION_VALUE.
  types:
    "!   An object containing search result metadata from the Discovery service.
    begin of T_SEARCH_RESULT_METADATA,
      CONFIDENCE type DOUBLE,
      SCORE type DOUBLE,
    end of T_SEARCH_RESULT_METADATA.
  types:
    "!
    begin of T_SEARCH_RESULT,
      ID type STRING,
      RESULT_METADATA type T_SEARCH_RESULT_METADATA,
      BODY type STRING,
      TITLE type STRING,
      URL type STRING,
      HIGHLIGHT type T_SEARCH_RESULT_HIGHLIGHT,
    end of T_SEARCH_RESULT.
  types:
    "!
    begin of T_DIALOG_SUGGESTION,
      LABEL type STRING,
      VALUE type T_DIALOG_SUGGESTION_VALUE,
      OUTPUT type MAP,
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
      SUGGESTIONS type STANDARD TABLE OF T_DIALOG_SUGGESTION WITH NON-UNIQUE DEFAULT KEY,
      HEADER type STRING,
      RESULTS type STANDARD TABLE OF T_SEARCH_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_RUNTIME_RESPONSE_GENERIC.
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
    "!
    begin of T_RUNTIME_RESPONSE_TYPE_IMAGE,
      SOURCE type STRING,
      TITLE type STRING,
      DESCRIPTION type STRING,
    end of T_RUNTIME_RESPONSE_TYPE_IMAGE.
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
    "!   Built-in system properties that apply to all skills used by the assistant.
    begin of T_MSSG_CONTEXT_GLOBAL_SYSTEM,
      TIMEZONE type STRING,
      USER_ID type STRING,
      TURN_COUNT type INTEGER,
    end of T_MSSG_CONTEXT_GLOBAL_SYSTEM.
  types:
    "!   Information that is shared by all skills used by the Assistant.
    begin of T_MESSAGE_CONTEXT_GLOBAL,
      SYSTEM type T_MSSG_CONTEXT_GLOBAL_SYSTEM,
    end of T_MESSAGE_CONTEXT_GLOBAL.
  types:
    "!   Information specific to particular skills used by the Assistant.
    "!
    "!   **Note:** Currently, only a single property named `main skill` is supported.
    "!    This object contains variables that apply to the dialog skill used by the
    "!    assistant.
      T_MESSAGE_CONTEXT_SKILLS type MAP.
  types:
    "!
    begin of T_MESSAGE_CONTEXT,
      GLOBAL type T_MESSAGE_CONTEXT_GLOBAL,
      SKILLS type T_MESSAGE_CONTEXT_SKILLS,
    end of T_MESSAGE_CONTEXT.
  types:
    "!   Assistant output to be rendered or processed by the client.
    begin of T_MESSAGE_OUTPUT,
      GENERIC type STANDARD TABLE OF T_RUNTIME_RESPONSE_GENERIC WITH NON-UNIQUE DEFAULT KEY,
      INTENTS type STANDARD TABLE OF T_RUNTIME_INTENT WITH NON-UNIQUE DEFAULT KEY,
      ENTITIES type STANDARD TABLE OF T_RUNTIME_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      ACTIONS type STANDARD TABLE OF T_DIALOG_NODE_ACTION WITH NON-UNIQUE DEFAULT KEY,
      DEBUG type T_MESSAGE_OUTPUT_DEBUG,
      USER_DEFINED type MAP,
    end of T_MESSAGE_OUTPUT.
  types:
    "!   A response from the Watson Assistant service.
    begin of T_MESSAGE_RESPONSE,
      OUTPUT type T_MESSAGE_OUTPUT,
      CONTEXT type T_MESSAGE_CONTEXT,
    end of T_MESSAGE_RESPONSE.
  types:
    "!
    begin of T_RUNTIME_RESPONSE_TYPE_TEXT,
      TEXT type STRING,
    end of T_RUNTIME_RESPONSE_TYPE_TEXT.
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
    begin of T_RUNTIME_RESPONSE_TYPE_PAUSE,
      TIME type INTEGER,
      TYPING type BOOLEAN,
    end of T_RUNTIME_RESPONSE_TYPE_PAUSE.
  types:
    "!
    begin of T_RUNTIME_RESPONSE_TYPE_SEARCH,
      HEADER type STRING,
      RESULTS type STANDARD TABLE OF T_SEARCH_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_RUNTIME_RESPONSE_TYPE_SEARCH.
  types:
    "!
    begin of T_RT_RESPONSE_TYPE_SUGGESTION,
      TITLE type STRING,
      SUGGESTIONS type STANDARD TABLE OF T_DIALOG_SUGGESTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_RT_RESPONSE_TYPE_SUGGESTION.
  types:
    "!   Contains information specific to a particular skill used by the Assistant.
    begin of T_MESSAGE_CONTEXT_SKILL,
      USER_DEFINED type MAP,
    end of T_MESSAGE_CONTEXT_SKILL.
  types:
    "!
    begin of T_RT_RESP_TYP_CONNECT_TO_AGENT,
      MESSAGE_TO_HUMAN_AGENT type STRING,
      TOPIC type STRING,
    end of T_RT_RESP_TYP_CONNECT_TO_AGENT.
  types:
    "!   A request formatted for the Watson Assistant service.
    begin of T_MESSAGE_REQUEST,
      INPUT type T_MESSAGE_INPUT,
      CONTEXT type T_MESSAGE_CONTEXT,
    end of T_MESSAGE_REQUEST.

constants:
  begin of C_REQUIRED_FIELDS,
    T_DIALOG_LOG_MESSAGE type string value '|LEVEL|MESSAGE|',
    T_DIALOG_NODES_VISITED type string value '|',
    T_MESSAGE_OUTPUT_DEBUG type string value '|',
    T_SESSION_RESPONSE type string value '|SESSION_ID|',
    T_RT_ENTTY_INTRPRTTN_SYS_NUM type string value '|',
    T_RUNTIME_ENTITY_ALTERNATIVE type string value '|',
    T_MESSAGE_INPUT_OPTIONS type string value '|',
    T_RUNTIME_INTENT type string value '|INTENT|CONFIDENCE|',
    T_CAPTURE_GROUP type string value '|GROUP|',
    T_RUNTIME_ENTITY type string value '|ENTITY|LOCATION|VALUE|',
    T_MESSAGE_INPUT type string value '|',
    T_DIA_ND_OUTPUT_OPT_ELEM_VALUE type string value '|',
    T_DIA_NODE_OUTPUT_OPT_ELEMENT type string value '|LABEL|VALUE|',
    T_RUNTIME_RESPONSE_TYPE_OPTION type string value '|',
    T_RT_ENTTY_INTRPRTTN_SYS_DATE type string value '|',
    T_SEARCH_RESULT_HIGHLIGHT type string value '|',
    T_DIALOG_SUGGESTION_VALUE type string value '|',
    T_SEARCH_RESULT_METADATA type string value '|',
    T_SEARCH_RESULT type string value '|ID|RESULT_METADATA|',
    T_DIALOG_SUGGESTION type string value '|LABEL|VALUE|',
    T_RUNTIME_RESPONSE_GENERIC type string value '|RESPONSE_TYPE|',
    T_RUNTIME_ENTITY_ROLE type string value '|',
    T_ERROR_DETAIL type string value '|MESSAGE|',
    T_ERROR_RESPONSE type string value '|ERROR|CODE|',
    T_RT_ENTITY_INTERPRETATION type string value '|',
    T_RUNTIME_RESPONSE_TYPE_IMAGE type string value '|',
    T_DIALOG_NODE_ACTION type string value '|NAME|RESULT_VARIABLE|',
    T_MSSG_CONTEXT_GLOBAL_SYSTEM type string value '|',
    T_MESSAGE_CONTEXT_GLOBAL type string value '|',
    T_MESSAGE_CONTEXT type string value '|',
    T_MESSAGE_OUTPUT type string value '|',
    T_MESSAGE_RESPONSE type string value '|OUTPUT|',
    T_RUNTIME_RESPONSE_TYPE_TEXT type string value '|',
    T_RT_ENTTY_INTRPRTTN_SYS_TIME type string value '|',
    T_RUNTIME_RESPONSE_TYPE_PAUSE type string value '|',
    T_RUNTIME_RESPONSE_TYPE_SEARCH type string value '|',
    T_RT_RESPONSE_TYPE_SUGGESTION type string value '|',
    T_MESSAGE_CONTEXT_SKILL type string value '|',
    T_RT_RESP_TYP_CONNECT_TO_AGENT type string value '|',
    T_MESSAGE_REQUEST type string value '|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  begin of C_ABAPNAME_DICTIONARY,
     DEBUG type string value 'debug',
     RESTART type string value 'restart',
     ALTERNATE_INTENTS type string value 'alternate_intents',
     RETURN_CONTEXT type string value 'return_context',
     INTENT type string value 'intent',
     CONFIDENCE type string value 'confidence',
     ENTITY type string value 'entity',
     LOCATION type string value 'location',
     VALUE type string value 'value',
     METADATA type string value 'metadata',
     INNER type string value 'inner',
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
     TYPE type string value 'type',
     MESSAGE_TYPE type string value 'message_type',
     TEXT type string value 'text',
     OPTIONS type string value 'options',
     INTENTS type string value 'intents',
     ENTITIES type string value 'entities',
     SUGGESTION_ID type string value 'suggestion_id',
     USER_ID type string value 'user_id',
     TURN_COUNT type string value 'turn_count',
     SYSTEM type string value 'system',
     USER_DEFINED type string value 'user_defined',
     GLOBAL type string value 'global',
     SKILLS type string value 'skills',
     INPUT type string value 'input',
     CONTEXT type string value 'context',
     LEVEL type string value 'level',
     MESSAGE type string value 'message',
     TIME type string value 'time',
     TYPING type string value 'typing',
     SOURCE type string value 'source',
     TITLE type string value 'title',
     DESCRIPTION type string value 'description',
     LABEL type string value 'label',
     PREFERENCE type string value 'preference',
     MESSAGE_TO_HUMAN_AGENT type string value 'message_to_human_agent',
     TOPIC type string value 'topic',
     SUGGESTIONS type string value 'suggestions',
     OUTPUT type string value 'output',
     RESPONSE_TYPE type string value 'response_type',
     HEADER type string value 'header',
     RESULTS type string value 'results',
     NAME type string value 'name',
     PARAMETERS type string value 'parameters',
     RESULT_VARIABLE type string value 'result_variable',
     CREDENTIALS type string value 'credentials',
     NODES_VISITED type string value 'nodes_visited',
     NODESVISITED type string value 'nodesVisited',
     LOG_MESSAGES type string value 'log_messages',
     LOGMESSAGES type string value 'logMessages',
     BRANCH_EXITED type string value 'branch_exited',
     BRANCH_EXITED_REASON type string value 'branch_exited_reason',
     GENERIC type string value 'generic',
     ACTIONS type string value 'actions',
     PATH type string value 'path',
     ERROR type string value 'error',
     ERRORS type string value 'errors',
     CODE type string value 'code',
     BODY type string value 'body',
     URL type string value 'url',
     SCORE type string value 'score',
     ID type string value 'id',
     RESULT_METADATA type string value 'result_metadata',
     HIGHLIGHT type string value 'highlight',
     SESSION_ID type string value 'session_id',
     GROUP type string value 'group',
     DIALOG_NODE type string value 'dialog_node',
     CONDITIONS type string value 'conditions',
  end of C_ABAPNAME_DICTIONARY .


  methods GET_APPNAME
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
  methods GET_SDK_VERSION_DATE
    redefinition .


    "! Create a session.
    "!
    "! @parameter I_assistant_id |
    "!   Unique identifier of the assistant. To find the assistant ID in the Watson
    "!    Assistant user interface, open the assistant settings and click **API
    "!    Details**. For information about creating assistants, see the
    "!    [documentation](https://cloud.ibm.com/docs/services/assistant?topic=assistant-a
    "!   ssistant-add#assistant-add-task).
    "!
    "!   **Note:** Currently, the v2 API does not support creating assistants.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SESSION_RESPONSE
    "!
  methods CREATE_SESSION
    importing
      !I_assistant_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SESSION_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete session.
    "!
    "! @parameter I_assistant_id |
    "!   Unique identifier of the assistant. To find the assistant ID in the Watson
    "!    Assistant user interface, open the assistant settings and click **API
    "!    Details**. For information about creating assistants, see the
    "!    [documentation](https://cloud.ibm.com/docs/services/assistant?topic=assistant-a
    "!   ssistant-add#assistant-add-task).
    "!
    "!   **Note:** Currently, the v2 API does not support creating assistants.
    "! @parameter I_session_id |
    "!   Unique identifier of the session.
    "!
  methods DELETE_SESSION
    importing
      !I_assistant_id type STRING
      !I_session_id type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Send user input to assistant.
    "!
    "! @parameter I_assistant_id |
    "!   Unique identifier of the assistant. To find the assistant ID in the Watson
    "!    Assistant user interface, open the assistant settings and click **API
    "!    Details**. For information about creating assistants, see the
    "!    [documentation](https://cloud.ibm.com/docs/services/assistant?topic=assistant-a
    "!   ssistant-add#assistant-add-task).
    "!
    "!   **Note:** Currently, the v2 API does not support creating assistants.
    "! @parameter I_session_id |
    "!   Unique identifier of the session.
    "! @parameter I_request |
    "!   The message to be sent. This includes the user's input, along with optional
    "!    content such as intents and entities.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_MESSAGE_RESPONSE
    "!
  methods MESSAGE
    importing
      !I_assistant_id type STRING
      !I_session_id type STRING
      !I_request type T_MESSAGE_REQUEST optional
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_MESSAGE_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .


protected section.

private section.

  methods SET_DEFAULT_QUERY_PARAMETERS
    changing
      !C_URL type TS_URL .

ENDCLASS.

class ZCL_IBMC_ASSISTANT_V2 IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->GET_APPNAME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_APPNAME                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method GET_APPNAME.

    e_appname = 'Watson Assistant v2'.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method ZCL_IBMC_ASSISTANT_V2->GET_REQUEST_PROP
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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20191002122836'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->CREATE_SESSION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_assistant_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_SESSION_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_SESSION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}/sessions'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_assistant_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->DELETE_SESSION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_assistant_id        TYPE STRING
* | [--->] I_session_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_SESSION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}/sessions/{session_id}'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_assistant_id ignoring case.
    replace all occurrences of `{session_id}` in ls_request_prop-url-path with i_session_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->MESSAGE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_assistant_id        TYPE STRING
* | [--->] I_session_id        TYPE STRING
* | [--->] I_request        TYPE T_MESSAGE_REQUEST(optional)
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

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}/sessions/{session_id}/message'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_assistant_id ignoring case.
    replace all occurrences of `{session_id}` in ls_request_prop-url-path with i_session_id ignoring case.

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
    if not i_request is initial.
    lv_datatype = get_datatype( i_request ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_request i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'request' i_value = i_request ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_request to <lv_text>.
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
* | Instance Private Method ZCL_IBMC_ASSISTANT_V2->SET_DEFAULT_QUERY_PARAMETERS
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
