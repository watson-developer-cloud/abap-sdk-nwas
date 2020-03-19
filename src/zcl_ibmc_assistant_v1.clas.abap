* Copyright 2019, 2020 IBM Corp. All Rights Reserved.
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
"! <p class="shorttext synchronized" lang="en">Watson Assistant v1</p>
"! The IBM Watson&trade; Assistant service combines machine learning, natural
"!  language understanding, and an integrated dialog editor to create conversation
"!  flows between your apps and your users.<br/>
"! <br/>
"! The Assistant v1 API provides authoring methods your application can use to
"!  create or update a workspace. <br/>
class ZCL_IBMC_ASSISTANT_V1 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Workspace settings related to detection of irrelevant input.</p>
    begin of T_WS_SYSTEM_SETTINGS_OFF_TOPIC,
      "!   Whether enhanced irrelevance detection is enabled for the workspace.
      ENABLED type BOOLEAN,
    end of T_WS_SYSTEM_SETTINGS_OFF_TOPIC.
  types:
    "! No documentation available.
    begin of T_RT_ENTITY_INTERPRETATION,
      "!   The calendar used to represent a recognized date (for example, `Gregorian`).
      CALENDAR_TYPE type STRING,
      "!   A unique identifier used to associate a recognized time and date. If the user
      "!    input contains a date and time that are mentioned together (for example, `Today
      "!    at 5`, the same **datetime_link** value is returned for both the
      "!    `&#64;sys-date` and `&#64;sys-time` entities).
      DATETIME_LINK type STRING,
      "!   A locale-specific holiday name (such as `thanksgiving` or `christmas`). This
      "!    property is included when a `&#64;sys-date` entity is recognized based on a
      "!    holiday name in the user input.
      FESTIVAL type STRING,
      "!   The precision or duration of a time range specified by a recognized
      "!    `&#64;sys-time` or `&#64;sys-date` entity.
      GRANULARITY type STRING,
      "!   A unique identifier used to associate multiple recognized `&#64;sys-date`,
      "!    `&#64;sys-time`, or `&#64;sys-number` entities that are recognized as a range
      "!    of values in the user&apos;s input (for example, `from July 4 until July 14` or
      "!    `from 20 to 25`).
      RANGE_LINK type STRING,
      "!   The word in the user input that indicates that a `sys-date` or `sys-time` entity
      "!    is part of an implied range where only one date or time is specified (for
      "!    example, `since` or `until`).
      RANGE_MODIFIER type STRING,
      "!   A recognized mention of a relative day, represented numerically as an offset
      "!    from the current date (for example, `-1` for `yesterday` or `10` for `in ten
      "!    days`).
      RELATIVE_DAY type NUMBER,
      "!   A recognized mention of a relative month, represented numerically as an offset
      "!    from the current month (for example, `1` for `next month` or `-3` for `three
      "!    months ago`).
      RELATIVE_MONTH type NUMBER,
      "!   A recognized mention of a relative week, represented numerically as an offset
      "!    from the current week (for example, `2` for `in two weeks` or `-1` for `last
      "!    week).
      RELATIVE_WEEK type NUMBER,
      "!   A recognized mention of a relative date range for a weekend, represented
      "!    numerically as an offset from the current weekend (for example, `0` for `this
      "!    weekend` or `-1` for `last weekend`).
      RELATIVE_WEEKEND type NUMBER,
      "!   A recognized mention of a relative year, represented numerically as an offset
      "!    from the current year (for example, `1` for `next year` or `-5` for `five years
      "!    ago`).
      RELATIVE_YEAR type NUMBER,
      "!   A recognized mention of a specific date, represented numerically as the date
      "!    within the month (for example, `30` for `June 30`.).
      SPECIFIC_DAY type NUMBER,
      "!   A recognized mention of a specific day of the week as a lowercase string (for
      "!    example, `monday`).
      SPECIFIC_DAY_OF_WEEK type STRING,
      "!   A recognized mention of a specific month, represented numerically (for example,
      "!    `7` for `July`).
      SPECIFIC_MONTH type NUMBER,
      "!   A recognized mention of a specific quarter, represented numerically (for
      "!    example, `3` for `the third quarter`).
      SPECIFIC_QUARTER type NUMBER,
      "!   A recognized mention of a specific year (for example, `2016`).
      SPECIFIC_YEAR type NUMBER,
      "!   A recognized numeric value, represented as an integer or double.
      NUMERIC_VALUE type NUMBER,
      "!   The type of numeric value recognized in the user input (`integer` or
      "!    `rational`).
      SUBTYPE type STRING,
      "!   A recognized term for a time that was mentioned as a part of the day in the
      "!    user&apos;s input (for example, `morning` or `afternoon`).
      PART_OF_DAY type STRING,
      "!   A recognized mention of a relative hour, represented numerically as an offset
      "!    from the current hour (for example, `3` for `in three hours` or `-1` for `an
      "!    hour ago`).
      RELATIVE_HOUR type NUMBER,
      "!   A recognized mention of a relative time, represented numerically as an offset in
      "!    minutes from the current time (for example, `5` for `in five minutes` or `-15`
      "!    for `fifteen minutes ago`).
      RELATIVE_MINUTE type NUMBER,
      "!   A recognized mention of a relative time, represented numerically as an offset in
      "!    seconds from the current time (for example, `10` for `in ten seconds` or `-30`
      "!    for `thirty seconds ago`).
      RELATIVE_SECOND type NUMBER,
      "!   A recognized specific hour mentioned as part of a time value (for example, `10`
      "!    for `10:15 AM`.).
      SPECIFIC_HOUR type NUMBER,
      "!   A recognized specific minute mentioned as part of a time value (for example,
      "!    `15` for `10:15 AM`.).
      SPECIFIC_MINUTE type NUMBER,
      "!   A recognized specific second mentioned as part of a time value (for example,
      "!    `30` for `10:15:30 AM`.).
      SPECIFIC_SECOND type NUMBER,
      "!   A recognized time zone mentioned as part of a time value (for example, `EST`).
      TIMEZONE type STRING,
    end of T_RT_ENTITY_INTERPRETATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A key/value pair defining an HTTP header and a value.</p>
    begin of T_WEBHOOK_HEADER,
      "!   The name of an HTTP header (for example, `Authorization`).
      NAME type STRING,
      "!   The value of an HTTP header.
      VALUE type STRING,
    end of T_WEBHOOK_HEADER.
  types:
    "! No documentation available.
    begin of T_DIALOG_NODE_ACTION,
      "!   The name of the action.
      NAME type STRING,
      "!   The type of action to invoke.
      TYPE type STRING,
      "!   A map of key/value pairs to be provided to the action.
      PARAMETERS type MAP,
      "!   The location in the dialog context where the result of the action is stored.
      RESULT_VARIABLE type STRING,
      "!   The name of the context variable that the client application will use to pass in
      "!    credentials for the action.
      CREDENTIALS type STRING,
    end of T_DIALOG_NODE_ACTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Workspace settings related to the disambiguation</p>
    "!     feature.<br/>
    "!    <br/>
    "!    **Note:** This feature is available only to Plus and Premium users.
    begin of T_WS_SYSTM_STTNGS_DSMBGTN,
      "!   The text of the introductory prompt that accompanies disambiguation options
      "!    presented to the user.
      PROMPT type STRING,
      "!   The user-facing label for the option users can select if none of the suggested
      "!    options is correct. If no value is specified for this property, this option
      "!    does not appear.
      NONE_OF_THE_ABOVE_PROMPT type STRING,
      "!   Whether the disambiguation feature is enabled for the workspace.
      ENABLED type BOOLEAN,
      "!   The sensitivity of the disambiguation feature to intent detection conflicts. Set
      "!    to **high** if you want the disambiguation feature to be triggered more often.
      "!    This can be useful for testing or demonstration purposes.
      SENSITIVITY type STRING,
      "!   Whether the order in which disambiguation suggestions are presented should be
      "!    randomized (but still influenced by relative confidence).
      RANDOMIZE type BOOLEAN,
      "!   The maximum number of disambigation suggestions that can be included in a
      "!    `suggestion` response.
      MAX_SUGGESTIONS type INTEGER,
      "!   For internal use only.
      SUGGESTION_TEXT_POLICY type STRING,
    end of T_WS_SYSTM_STTNGS_DSMBGTN.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Options that modify how specified output is handled.</p>
    begin of T_DIALOG_NODE_OUTPUT_MODIFIERS,
      "!   Whether values in the output will overwrite output values in an array specified
      "!    by previously executed dialog nodes. If this option is set to `false`, new
      "!    values will be appended to previously specified values.
      OVERWRITE type BOOLEAN,
    end of T_DIALOG_NODE_OUTPUT_MODIFIERS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The next step to execute following this dialog node.</p>
    begin of T_DIALOG_NODE_NEXT_STEP,
      "!   What happens after the dialog node completes. The valid values depend on the
      "!    node type:<br/>
      "!   - The following values are valid for any node:<br/>
      "!     - `get_user_input`<br/>
      "!     - `skip_user_input`<br/>
      "!     - `jump_to`<br/>
      "!   - If the node is of type `event_handler` and its parent node is of type `slot`
      "!    or `frame`, additional values are also valid:<br/>
      "!     - if **event_name**=`filled` and the type of the parent node is `slot`:<br/>
      "!       - `reprompt`<br/>
      "!       - `skip_all_slots`<br/>
      "!   - if **event_name**=`nomatch` and the type of the parent node is `slot`:<br/>
      "!       - `reprompt`<br/>
      "!       - `skip_slot`<br/>
      "!       - `skip_all_slots`<br/>
      "!   - if **event_name**=`generic` and the type of the parent node is `frame`:<br/>
      "!       - `reprompt`<br/>
      "!       - `skip_slot`<br/>
      "!       - `skip_all_slots`<br/>
      "!        If you specify `jump_to`, then you must also specify a value for the
      "!    `dialog_node` property.
      BEHAVIOR type STRING,
      "!   The ID of the dialog node to process next. This parameter is required if
      "!    **behavior**=`jump_to`.
      DIALOG_NODE type STRING,
      "!   Which part of the dialog node to process next.
      SELECTOR type STRING,
    end of T_DIALOG_NODE_NEXT_STEP.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An input object that includes the input text.</p>
    begin of T_MESSAGE_INPUT,
      "!   The text of the user input. This string cannot contain carriage return, newline,
      "!    or tab characters.
      TEXT type STRING,
    end of T_MESSAGE_INPUT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A recognized capture group for a pattern-based entity.</p>
    begin of T_CAPTURE_GROUP,
      "!   A recognized capture group for the entity.
      GROUP type STRING,
      "!   Zero-based character offsets that indicate where the entity value begins and
      "!    ends in the input text.
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
    end of T_CAPTURE_GROUP.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object describing the role played by a system entity that</p>
    "!     is specifies the beginning or end of a range recognized in the user input. This
    "!     property is included only if the new system entities are enabled for the
    "!     workspace.
    begin of T_RUNTIME_ENTITY_ROLE,
      "!   The relationship of the entity to the range.
      TYPE type STRING,
    end of T_RUNTIME_ENTITY_ROLE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A term from the request that was identified as an entity.</p>
    begin of T_RUNTIME_ENTITY,
      "!   An entity detected in the input.
      ENTITY type STRING,
      "!   An array of zero-based character offsets that indicate where the detected entity
      "!    values begin and end in the input text.
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
      "!   The entity value that was recognized in the user input.
      VALUE type STRING,
      "!   A decimal percentage that represents Watson&apos;s confidence in the recognized
      "!    entity.
      CONFIDENCE type NUMBER,
      "!   Any metadata for the entity.
      METADATA type MAP,
      "!   The recognized capture groups for the entity, as defined by the entity pattern.
      GROUPS type STANDARD TABLE OF T_CAPTURE_GROUP WITH NON-UNIQUE DEFAULT KEY,
      "!   An object containing detailed information about the entity recognized in the
      "!    user input. This property is included only if the new system entities are
      "!    enabled for the workspace.<br/>
      "!   <br/>
      "!   For more information about how the new system entities are interpreted, see the
      "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-beta-syste
      "!   m-entities).
      INTERPRETATION type T_RT_ENTITY_INTERPRETATION,
      "!   An object describing the role played by a system entity that is specifies the
      "!    beginning or end of a range recognized in the user input. This property is
      "!    included only if the new system entities are enabled for the workspace.
      ROLE type T_RUNTIME_ENTITY_ROLE,
    end of T_RUNTIME_ENTITY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An intent identified in the user input.</p>
    begin of T_RUNTIME_INTENT,
      "!   The name of the recognized intent.
      INTENT type STRING,
      "!   A decimal percentage that represents Watson&apos;s confidence in the intent.
      CONFIDENCE type DOUBLE,
    end of T_RUNTIME_INTENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object defining the message input to be sent to the</p>
    "!     Watson Assistant service if the user selects the corresponding option.
    begin of T_DIA_ND_OUTPUT_OPT_ELEM_VALUE,
      "!   An input object that includes the input text.
      INPUT type T_MESSAGE_INPUT,
      "!   An array of intents to be used while processing the input.<br/>
      "!   <br/>
      "!   **Note:** This property is supported for backward compatibility with
      "!    applications that use the v1 **Get response to user input** method.
      INTENTS type STANDARD TABLE OF T_RUNTIME_INTENT WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of entities to be used while processing the user input.<br/>
      "!   <br/>
      "!   **Note:** This property is supported for backward compatibility with
      "!    applications that use the v1 **Get response to user input** method.
      ENTITIES type STANDARD TABLE OF T_RUNTIME_ENTITY WITH NON-UNIQUE DEFAULT KEY,
    end of T_DIA_ND_OUTPUT_OPT_ELEM_VALUE.
  types:
    "! No documentation available.
    begin of T_DIA_NODE_OUTPUT_OPT_ELEMENT,
      "!   The user-facing label for the option.
      LABEL type STRING,
      "!   An object defining the message input to be sent to the Watson Assistant service
      "!    if the user selects the corresponding option.
      VALUE type T_DIA_ND_OUTPUT_OPT_ELEM_VALUE,
    end of T_DIA_NODE_OUTPUT_OPT_ELEMENT.
  types:
    "! No documentation available.
    begin of T_DIA_ND_OTPT_TEXT_VALUES_ELEM,
      "!   The text of a response. This string can include newline characters (`\n`),
      "!    Markdown tagging, or other special characters, if supported by the channel.
      TEXT type STRING,
    end of T_DIA_ND_OTPT_TEXT_VALUES_ELEM.
  types:
    "! No documentation available.
    begin of T_DIALOG_NODE_OUTPUT_GENERIC,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.<br/>
      "!   <br/>
      "!   **Note:** The **search_skill** response type is available only for Plus and
      "!    Premium users, and is used only by the v2 runtime API.
      RESPONSE_TYPE type STRING,
      "!   A list of one or more objects defining text responses. Required when
      "!    **response_type**=`text`.
      VALUES type STANDARD TABLE OF T_DIA_ND_OTPT_TEXT_VALUES_ELEM WITH NON-UNIQUE DEFAULT KEY,
      "!   How a response is selected from the list, if more than one response is
      "!    specified. Valid only when **response_type**=`text`.
      SELECTION_POLICY type STRING,
      "!   The delimiter to use as a separator between responses when
      "!    `selection_policy`=`multiline`.
      DELIMITER type STRING,
      "!   How long to pause, in milliseconds. The valid values are from 0 to 10000. Valid
      "!    only when **response_type**=`pause`.
      TIME type INTEGER,
      "!   Whether to send a &quot;user is typing&quot; event during the pause. Ignored if
      "!    the channel does not support this event. Valid only when
      "!    **response_type**=`pause`.
      TYPING type BOOLEAN,
      "!   The URL of the image. Required when **response_type**=`image`.
      SOURCE type STRING,
      "!   An optional title to show before the response. Valid only when
      "!    **response_type**=`image` or `option`.
      TITLE type STRING,
      "!   An optional description to show with the response. Valid only when
      "!    **response_type**=`image` or `option`.
      DESCRIPTION type STRING,
      "!   The preferred type of control to display, if supported by the channel. Valid
      "!    only when **response_type**=`option`.
      PREFERENCE type STRING,
      "!   An array of objects describing the options from which the user can choose. You
      "!    can include up to 20 options. Required when **response_type**=`option`.
      OPTIONS type STANDARD TABLE OF T_DIA_NODE_OUTPUT_OPT_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
      "!   An optional message to be sent to the human agent who will be taking over the
      "!    conversation. Valid only when **reponse_type**=`connect_to_agent`.
      MESSAGE_TO_HUMAN_AGENT type STRING,
      "!   The text of the search query. This can be either a natural-language query or a
      "!    query that uses the Discovery query language syntax, depending on the value of
      "!    the **query_type** property. For more information, see the [Discovery service
      "!    documentation](https://cloud.ibm.com/docs/services/discovery/query-operators.ht
      "!   ml#query-operators). Required when **response_type**=`search_skill`.
      QUERY type STRING,
      "!   The type of the search query. Required when **response_type**=`search_skill`.
      QUERY_TYPE type STRING,
      "!   An optional filter that narrows the set of documents to be searched. For more
      "!    information, see the [Discovery service documentation]([Discovery service
      "!    documentation](https://cloud.ibm.com/docs/services/discovery/query-parameters.h
      "!   tml#filter).
      FILTER type STRING,
      "!   The version of the Discovery service API to use for the query.
      DISCOVERY_VERSION type STRING,
    end of T_DIALOG_NODE_OUTPUT_GENERIC.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The output of the dialog node. For more information about</p>
    "!     how to specify dialog node output, see the
    "!     [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-dialog-ove
    "!    rview#dialog-overview-responses).
    begin of T_DIALOG_NODE_OUTPUT,
      "!   An array of objects describing the output defined for the dialog node.
      GENERIC type STANDARD TABLE OF T_DIALOG_NODE_OUTPUT_GENERIC WITH NON-UNIQUE DEFAULT KEY,
      "!   Options that modify how specified output is handled.
      MODIFIERS type T_DIALOG_NODE_OUTPUT_MODIFIERS,
    end of T_DIALOG_NODE_OUTPUT.
  types:
    "! No documentation available.
    begin of T_DIALOG_NODE,
      "!   The dialog node ID. This string must conform to the following restrictions:<br/>
      "!   - It can contain only Unicode alphanumeric, space, underscore, hyphen, and dot
      "!    characters.
      DIALOG_NODE type STRING,
      "!   The description of the dialog node. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   The condition that will trigger the dialog node. This string cannot contain
      "!    carriage return, newline, or tab characters.
      CONDITIONS type STRING,
      "!   The ID of the parent dialog node. This property is omitted if the dialog node
      "!    has no parent.
      PARENT type STRING,
      "!   The ID of the previous sibling dialog node. This property is omitted if the
      "!    dialog node has no previous sibling.
      PREVIOUS_SIBLING type STRING,
      "!   The output of the dialog node. For more information about how to specify dialog
      "!    node output, see the
      "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-dialog-ove
      "!   rview#dialog-overview-responses).
      OUTPUT type T_DIALOG_NODE_OUTPUT,
      "!   The context for the dialog node.
      CONTEXT type MAP,
      "!   The metadata for the dialog node.
      METADATA type MAP,
      "!   The next step to execute following this dialog node.
      NEXT_STEP type T_DIALOG_NODE_NEXT_STEP,
      "!   The alias used to identify the dialog node. This string must conform to the
      "!    following restrictions:<br/>
      "!   - It can contain only Unicode alphanumeric, space, underscore, hyphen, and dot
      "!    characters.
      TITLE type STRING,
      "!   How the dialog node is processed.
      TYPE type STRING,
      "!   How an `event_handler` node is processed.
      EVENT_NAME type STRING,
      "!   The location in the dialog context where output is stored.
      VARIABLE type STRING,
      "!   An array of objects describing any actions to be invoked by the dialog node.
      ACTIONS type STANDARD TABLE OF T_DIALOG_NODE_ACTION WITH NON-UNIQUE DEFAULT KEY,
      "!   Whether this top-level dialog node can be digressed into.
      DIGRESS_IN type STRING,
      "!   Whether this dialog node can be returned to after a digression.
      DIGRESS_OUT type STRING,
      "!   Whether the user can digress to top-level nodes while filling out slots.
      DIGRESS_OUT_SLOTS type STRING,
      "!   A label that can be displayed externally to describe the purpose of the node to
      "!    users.
      USER_LABEL type STRING,
      "!   Whether the dialog node should be excluded from disambiguation suggestions.
      DISAMBIGUATION_OPT_OUT type BOOLEAN,
      "!   For internal use only.
      DISABLED type BOOLEAN,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_DIALOG_NODE.
  types:
    "! No documentation available.
    begin of T_VALUE,
      "!   The text of the entity value. This string must conform to the following
      "!    restrictions:<br/>
      "!   - It cannot contain carriage return, newline, or tab characters.<br/>
      "!   - It cannot consist of only whitespace characters.
      VALUE type STRING,
      "!   Any metadata related to the entity value.
      METADATA type MAP,
      "!   Specifies the type of entity value.
      TYPE type STRING,
      "!   An array of synonyms for the entity value. A value can specify either synonyms
      "!    or patterns (depending on the value type), but not both. A synonym must conform
      "!    to the following resrictions:<br/>
      "!   - It cannot contain carriage return, newline, or tab characters.<br/>
      "!   - It cannot consist of only whitespace characters.
      SYNONYMS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of patterns for the entity value. A value can specify either synonyms
      "!    or patterns (depending on the value type), but not both. A pattern is a regular
      "!    expression; for more information about how to specify a pattern, see the
      "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-entities#e
      "!   ntities-create-dictionary-based).
      PATTERNS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_VALUE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A webhook that can be used by dialog nodes to make</p>
    "!     programmatic calls to an external function.<br/>
    "!    <br/>
    "!    **Note:** Currently, only a single webhook named `main_webhook` is supported.
    begin of T_WEBHOOK,
      "!   The URL for the external service or application to which you want to send HTTP
      "!    POST requests.
      URL type STRING,
      "!   The name of the webhook. Currently, `main_webhook` is the only supported value.
      NAME type STRING,
      "!   An optional array of HTTP headers to pass with the HTTP request.
      HEADERS type STANDARD TABLE OF T_WEBHOOK_HEADER WITH NON-UNIQUE DEFAULT KEY,
    end of T_WEBHOOK.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Workspace settings related to the behavior of system</p>
    "!     entities.
    begin of T_WS_SYSTM_STTNGS_SYSTM_ENTTS,
      "!   Whether the new system entities are enabled for the workspace.
      ENABLED type BOOLEAN,
    end of T_WS_SYSTM_STTNGS_SYSTM_ENTTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A mention of a contextual entity.</p>
    begin of T_MENTION,
      "!   The name of the entity.
      ENTITY type STRING,
      "!   An array of zero-based character offsets that indicate where the entity mentions
      "!    begin and end in the input text.
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
    end of T_MENTION.
  types:
    "! No documentation available.
    begin of T_EXAMPLE,
      "!   The text of a user input example. This string must conform to the following
      "!    restrictions:<br/>
      "!   - It cannot contain carriage return, newline, or tab characters.<br/>
      "!   - It cannot consist of only whitespace characters.
      TEXT type STRING,
      "!   An array of contextual entity mentions.
      MENTIONS type STANDARD TABLE OF T_MENTION WITH NON-UNIQUE DEFAULT KEY,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_EXAMPLE.
  types:
    "! No documentation available.
    begin of T_INTENT,
      "!   The name of the intent. This string must conform to the following
      "!    restrictions:<br/>
      "!   - It can contain only Unicode alphanumeric, underscore, hyphen, and dot
      "!    characters.<br/>
      "!   - It cannot begin with the reserved prefix `sys-`.
      INTENT type STRING,
      "!   The description of the intent. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
      "!   An array of user input examples for the intent.
      EXAMPLES type STANDARD TABLE OF T_EXAMPLE WITH NON-UNIQUE DEFAULT KEY,
    end of T_INTENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Workspace settings related to the Watson Assistant user</p>
    "!     interface.
    begin of T_WS_SYSTEM_SETTINGS_TOOLING,
      "!   Whether the dialog JSON editor displays text responses within the
      "!    `output.generic` object.
      STORE_GENERIC_RESPONSES type BOOLEAN,
    end of T_WS_SYSTEM_SETTINGS_TOOLING.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Global settings for the workspace.</p>
    begin of T_WORKSPACE_SYSTEM_SETTINGS,
      "!   Workspace settings related to the Watson Assistant user interface.
      TOOLING type T_WS_SYSTEM_SETTINGS_TOOLING,
      "!   Workspace settings related to the disambiguation feature.<br/>
      "!   <br/>
      "!   **Note:** This feature is available only to Plus and Premium users.
      DISAMBIGUATION type T_WS_SYSTM_STTNGS_DSMBGTN,
      "!   For internal use only.
      HUMAN_AGENT_ASSIST type MAP,
      "!   Workspace settings related to the behavior of system entities.
      SYSTEM_ENTITIES type T_WS_SYSTM_STTNGS_SYSTM_ENTTS,
      "!   Workspace settings related to detection of irrelevant input.
      OFF_TOPIC type T_WS_SYSTEM_SETTINGS_OFF_TOPIC,
    end of T_WORKSPACE_SYSTEM_SETTINGS.
  types:
    "! No documentation available.
    begin of T_COUNTEREXAMPLE,
      "!   The text of a user input marked as irrelevant input. This string must conform to
      "!    the following restrictions:<br/>
      "!   - It cannot contain carriage return, newline, or tab characters.<br/>
      "!   - It cannot consist of only whitespace characters.
      TEXT type STRING,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_COUNTEREXAMPLE.
  types:
    "! No documentation available.
    begin of T_ENTITY,
      "!   The name of the entity. This string must conform to the following
      "!    restrictions:<br/>
      "!   - It can contain only Unicode alphanumeric, underscore, and hyphen
      "!    characters.<br/>
      "!   - If you specify an entity name beginning with the reserved prefix `sys-`, it
      "!    must be the name of a system entity that you want to enable. (Any entity
      "!    content specified with the request is ignored.).
      ENTITY type STRING,
      "!   The description of the entity. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   Any metadata related to the entity.
      METADATA type MAP,
      "!   Whether to use fuzzy matching for the entity.
      FUZZY_MATCH type BOOLEAN,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
      "!   An array of objects describing the entity values.
      VALUES type STANDARD TABLE OF T_VALUE WITH NON-UNIQUE DEFAULT KEY,
    end of T_ENTITY.
  types:
    "! No documentation available.
    begin of T_WORKSPACE,
      "!   The name of the workspace. This string cannot contain carriage return, newline,
      "!    or tab characters.
      NAME type STRING,
      "!   The description of the workspace. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   The language of the workspace.
      LANGUAGE type STRING,
      "!   Any metadata related to the workspace.
      METADATA type MAP,
      "!   Whether training data from the workspace (including artifacts such as intents
      "!    and entities) can be used by IBM for general service improvements. `true`
      "!    indicates that workspace training data is not to be used.
      LEARNING_OPT_OUT type BOOLEAN,
      "!   Global settings for the workspace.
      SYSTEM_SETTINGS type T_WORKSPACE_SYSTEM_SETTINGS,
      "!   The workspace ID of the workspace.
      WORKSPACE_ID type STRING,
      "!   The current status of the workspace.
      STATUS type STRING,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
      "!   An array of intents.
      INTENTS type STANDARD TABLE OF T_INTENT WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects describing the entities for the workspace.
      ENTITIES type STANDARD TABLE OF T_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects describing the dialog nodes in the workspace.
      DIALOG_NODES type STANDARD TABLE OF T_DIALOG_NODE WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of counterexamples.
      COUNTEREXAMPLES type STANDARD TABLE OF T_COUNTEREXAMPLE WITH NON-UNIQUE DEFAULT KEY,
      "!   No documentation available.
      WEBHOOKS type STANDARD TABLE OF T_WEBHOOK WITH NON-UNIQUE DEFAULT KEY,
    end of T_WORKSPACE.
  types:
    "! No documentation available.
    begin of T_SYNONYM,
      "!   The text of the synonym. This string must conform to the following
      "!    restrictions:<br/>
      "!   - It cannot contain carriage return, newline, or tab characters.<br/>
      "!   - It cannot consist of only whitespace characters.
      SYNONYM type STRING,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_SYNONYM.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The pagination data for the returned objects.</p>
    begin of T_PAGINATION,
      "!   The URL that will return the same page of results.
      REFRESH_URL type STRING,
      "!   The URL that will return the next page of results.
      NEXT_URL type STRING,
      "!   Reserved for future use.
      TOTAL type INTEGER,
      "!   Reserved for future use.
      MATCHED type INTEGER,
      "!   A token identifying the current page of results.
      REFRESH_CURSOR type STRING,
      "!   A token identifying the next page of results.
      NEXT_CURSOR type STRING,
    end of T_PAGINATION.
  types:
    "! No documentation available.
    begin of T_SYNONYM_COLLECTION,
      "!   An array of synonyms.
      SYNONYMS type STANDARD TABLE OF T_SYNONYM WITH NON-UNIQUE DEFAULT KEY,
      "!   The pagination data for the returned objects.
      PAGINATION type T_PAGINATION,
    end of T_SYNONYM_COLLECTION.
  types:
    "! No documentation available.
    begin of T_RUNTIME_RESPONSE_TYPE_OPTION,
      "!   The title or introductory text to show before the response.
      TITLE type STRING,
      "!   The description to show with the the response.
      DESCRIPTION type STRING,
      "!   The preferred type of control to display.
      PREFERENCE type STRING,
      "!   An array of objects describing the options from which the user can choose.
      OPTIONS type STANDARD TABLE OF T_DIA_NODE_OUTPUT_OPT_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
    end of T_RUNTIME_RESPONSE_TYPE_OPTION.
  types:
    "! No documentation available.
    begin of T_DIA_ND_OUTPUT_RESP_TYPE_TEXT,
      "!   A list of one or more objects defining text responses. Required when
      "!    **response_type**=`text`.
      VALUES type STANDARD TABLE OF T_DIA_ND_OTPT_TEXT_VALUES_ELEM WITH NON-UNIQUE DEFAULT KEY,
      "!   How a response is selected from the list, if more than one response is
      "!    specified. Valid only when **response_type**=`text`.
      SELECTION_POLICY type STRING,
      "!   The delimiter to use as a separator between responses when
      "!    `selection_policy`=`multiline`.
      DELIMITER type STRING,
    end of T_DIA_ND_OUTPUT_RESP_TYPE_TEXT.
  types:
    "! No documentation available.
    begin of T_BASE_WORKSPACE,
      "!   The name of the workspace. This string cannot contain carriage return, newline,
      "!    or tab characters.
      NAME type STRING,
      "!   The description of the workspace. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   The language of the workspace.
      LANGUAGE type STRING,
      "!   Any metadata related to the workspace.
      METADATA type MAP,
      "!   Whether training data from the workspace (including artifacts such as intents
      "!    and entities) can be used by IBM for general service improvements. `true`
      "!    indicates that workspace training data is not to be used.
      LEARNING_OPT_OUT type BOOLEAN,
      "!   Global settings for the workspace.
      SYSTEM_SETTINGS type T_WORKSPACE_SYSTEM_SETTINGS,
      "!   The workspace ID of the workspace.
      WORKSPACE_ID type STRING,
      "!   The current status of the workspace.
      STATUS type STRING,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_BASE_WORKSPACE.
  types:
    "! No documentation available.
    begin of T_BASE_ENTITY,
      "!   The name of the entity. This string must conform to the following
      "!    restrictions:<br/>
      "!   - It can contain only Unicode alphanumeric, underscore, and hyphen
      "!    characters.<br/>
      "!   - It cannot begin with the reserved prefix `sys-`.
      ENTITY type STRING,
      "!   The description of the entity. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   Any metadata related to the entity.
      METADATA type MAP,
      "!   Whether to use fuzzy matching for the entity.
      FUZZY_MATCH type BOOLEAN,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_BASE_ENTITY.
  types:
    "! No documentation available.
    begin of T_RUNTIME_RESPONSE_TYPE_TEXT,
      "!   The text of the response.
      TEXT type STRING,
    end of T_RUNTIME_RESPONSE_TYPE_TEXT.
  types:
    "! No documentation available.
    begin of T_RT_ENTTY_INTRPRTTN_SYS_TIME,
      "!   A unique identifier used to associate a recognized time and date. If the user
      "!    input contains a date and time that are mentioned together (for example, `Today
      "!    at 5`, the same **datetime_link** value is returned for both the
      "!    `&#64;sys-date` and `&#64;sys-time` entities).
      DATETIME_LINK type STRING,
      "!   The precision or duration of a time range specified by a recognized
      "!    `&#64;sys-time` or `&#64;sys-date` entity.
      GRANULARITY type STRING,
      "!   A recognized term for a time that was mentioned as a part of the day in the
      "!    user&apos;s input (for example, `morning` or `afternoon`).
      PART_OF_DAY type STRING,
      "!   A unique identifier used to associate multiple recognized `&#64;sys-date`,
      "!    `&#64;sys-time`, or `&#64;sys-number` entities that are recognized as a range
      "!    of values in the user&apos;s input (for example, `from July 4 until July 14` or
      "!    `from 20 to 25`).
      RANGE_LINK type STRING,
      "!   A recognized mention of a relative hour, represented numerically as an offset
      "!    from the current hour (for example, `3` for `in three hours` or `-1` for `an
      "!    hour ago`).
      RELATIVE_HOUR type NUMBER,
      "!   A recognized mention of a relative time, represented numerically as an offset in
      "!    minutes from the current time (for example, `5` for `in five minutes` or `-15`
      "!    for `fifteen minutes ago`).
      RELATIVE_MINUTE type NUMBER,
      "!   A recognized mention of a relative time, represented numerically as an offset in
      "!    seconds from the current time (for example, `10` for `in ten seconds` or `-30`
      "!    for `thirty seconds ago`).
      RELATIVE_SECOND type NUMBER,
      "!   A recognized specific hour mentioned as part of a time value (for example, `10`
      "!    for `10:15 AM`.).
      SPECIFIC_HOUR type NUMBER,
      "!   A recognized specific minute mentioned as part of a time value (for example,
      "!    `15` for `10:15 AM`.).
      SPECIFIC_MINUTE type NUMBER,
      "!   A recognized specific second mentioned as part of a time value (for example,
      "!    `30` for `10:15:30 AM`.).
      SPECIFIC_SECOND type NUMBER,
      "!   A recognized time zone mentioned as part of a time value (for example, `EST`).
      TIMEZONE type STRING,
    end of T_RT_ENTTY_INTRPRTTN_SYS_TIME.
  types:
    "! No documentation available.
    begin of T_UPDATE_EXAMPLE,
      "!   The text of the user input example. This string must conform to the following
      "!    restrictions:<br/>
      "!   - It cannot contain carriage return, newline, or tab characters.<br/>
      "!   - It cannot consist of only whitespace characters.
      TEXT type STRING,
      "!   An array of contextual entity mentions.
      MENTIONS type STANDARD TABLE OF T_MENTION WITH NON-UNIQUE DEFAULT KEY,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_UPDATE_EXAMPLE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object describing a contextual entity mention.</p>
    begin of T_ENTITY_MENTION,
      "!   The text of the user input example.
      TEXT type STRING,
      "!   The name of the intent.
      INTENT type STRING,
      "!   An array of zero-based character offsets that indicate where the entity mentions
      "!    begin and end in the input text.
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
    end of T_ENTITY_MENTION.
  types:
    "! No documentation available.
    begin of T_DIA_ND_OTPT_RESP_TYP_SRCH_S1,
      "!   The text of the search query. This can be either a natural-language query or a
      "!    query that uses the Discovery query language syntax, depending on the value of
      "!    the **query_type** property. For more information, see the [Discovery service
      "!    documentation](https://cloud.ibm.com/docs/services/discovery/query-operators.ht
      "!   ml#query-operators). Required when **response_type**=`search_skill`.
      QUERY type STRING,
      "!   The type of the search query. Required when **response_type**=`search_skill`.
      QUERY_TYPE type STRING,
      "!   An optional filter that narrows the set of documents to be searched. For more
      "!    information, see the [Discovery service documentation]([Discovery service
      "!    documentation](https://cloud.ibm.com/docs/services/discovery/query-parameters.h
      "!   tml#filter).
      FILTER type STRING,
      "!   The version of the Discovery service API to use for the query.
      DISCOVERY_VERSION type STRING,
    end of T_DIA_ND_OTPT_RESP_TYP_SRCH_S1.
  types:
    "! No documentation available.
    begin of T_EXAMPLE_COLLECTION,
      "!   An array of objects describing the examples defined for the intent.
      EXAMPLES type STANDARD TABLE OF T_EXAMPLE WITH NON-UNIQUE DEFAULT KEY,
      "!   The pagination data for the returned objects.
      PAGINATION type T_PAGINATION,
    end of T_EXAMPLE_COLLECTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The pagination data for the returned objects.</p>
    begin of T_LOG_PAGINATION,
      "!   The URL that will return the next page of results, if any.
      NEXT_URL type STRING,
      "!   Reserved for future use.
      MATCHED type INTEGER,
      "!   A token identifying the next page of results.
      NEXT_CURSOR type STRING,
    end of T_LOG_PAGINATION.
  types:
    "! No documentation available.
    begin of T_RT_RESP_TYP_CONNECT_TO_AGENT,
      "!   A message to be sent to the human agent who will be taking over the
      "!    conversation.
      MESSAGE_TO_HUMAN_AGENT type STRING,
      "!   A label identifying the topic of the conversation, derived from the
      "!    **user_label** property of the relevant node.
      TOPIC type STRING,
      "!   The ID of the dialog node that the **topic** property is taken from. The
      "!    **topic** property is populated using the value of the dialog node&apos;s
      "!    **user_label** property.
      DIALOG_NODE type STRING,
    end of T_RT_RESP_TYP_CONNECT_TO_AGENT.
  types:
    "! No documentation available.
    begin of T_CREATE_VALUE,
      "!   The text of the entity value. This string must conform to the following
      "!    restrictions:<br/>
      "!   - It cannot contain carriage return, newline, or tab characters.<br/>
      "!   - It cannot consist of only whitespace characters.
      VALUE type STRING,
      "!   Any metadata related to the entity value.
      METADATA type MAP,
      "!   Specifies the type of entity value.
      TYPE type STRING,
      "!   An array of synonyms for the entity value. A value can specify either synonyms
      "!    or patterns (depending on the value type), but not both. A synonym must conform
      "!    to the following resrictions:<br/>
      "!   - It cannot contain carriage return, newline, or tab characters.<br/>
      "!   - It cannot consist of only whitespace characters.
      SYNONYMS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of patterns for the entity value. A value can specify either synonyms
      "!    or patterns (depending on the value type), but not both. A pattern is a regular
      "!    expression; for more information about how to specify a pattern, see the
      "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-entities#e
      "!   ntities-create-dictionary-based).
      PATTERNS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_CREATE_VALUE.
  types:
    "! No documentation available.
    begin of T_DIALOG_NODE_VISITED_DETAILS,
      "!   A dialog node that was triggered during processing of the input message.
      DIALOG_NODE type STRING,
      "!   The title of the dialog node.
      TITLE type STRING,
      "!   The conditions that trigger the dialog node.
      CONDITIONS type STRING,
    end of T_DIALOG_NODE_VISITED_DETAILS.
  types:
    "! No documentation available.
    begin of T_DIA_SUGGESTION_RESP_GENERIC,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.<br/>
      "!   <br/>
      "!   **Note:** The **suggestion** response type is part of the disambiguation
      "!    feature, which is only available for Plus and Premium users. The
      "!    **search_skill** response type is available only for Plus and Premium users,
      "!    and is used only by the v2 runtime API.
      RESPONSE_TYPE type STRING,
      "!   The text of the response.
      TEXT type STRING,
      "!   How long to pause, in milliseconds.
      TIME type INTEGER,
      "!   Whether to send a &quot;user is typing&quot; event during the pause.
      TYPING type BOOLEAN,
      "!   The URL of the image.
      SOURCE type STRING,
      "!   The title or introductory text to show before the response.
      TITLE type STRING,
      "!   The description to show with the the response.
      DESCRIPTION type STRING,
      "!   The preferred type of control to display.
      PREFERENCE type STRING,
      "!   An array of objects describing the options from which the user can choose.
      OPTIONS type STANDARD TABLE OF T_DIA_NODE_OUTPUT_OPT_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
      "!   A message to be sent to the human agent who will be taking over the
      "!    conversation.
      MESSAGE_TO_HUMAN_AGENT type STRING,
      "!   A label identifying the topic of the conversation, derived from the
      "!    **user_label** property of the relevant node.
      TOPIC type STRING,
      "!   The ID of the dialog node that the **topic** property is taken from. The
      "!    **topic** property is populated using the value of the dialog node&apos;s
      "!    **user_label** property.
      DIALOG_NODE type STRING,
    end of T_DIA_SUGGESTION_RESP_GENERIC.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object defining the message input, intents, and entities</p>
    "!     to be sent to the Watson Assistant service if the user selects the
    "!     corresponding disambiguation option.
    begin of T_DIALOG_SUGGESTION_VALUE,
      "!   An input object that includes the input text.
      INPUT type T_MESSAGE_INPUT,
      "!   An array of intents to be sent along with the user input.
      INTENTS type STANDARD TABLE OF T_RUNTIME_INTENT WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of entities to be sent along with the user input.
      ENTITIES type STANDARD TABLE OF T_RUNTIME_ENTITY WITH NON-UNIQUE DEFAULT KEY,
    end of T_DIALOG_SUGGESTION_VALUE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The dialog output that will be returned from the Watson</p>
    "!     Assistant service if the user selects the corresponding option.
    begin of T_DIALOG_SUGGESTION_OUTPUT,
      "!   An array of the nodes that were triggered to create the response, in the order
      "!    in which they were visited. This information is useful for debugging and for
      "!    tracing the path taken through the node tree.
      NODES_VISITED type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects containing detailed diagnostic information about the nodes
      "!    that were triggered during processing of the input message. Included only if
      "!    **nodes_visited_details** is set to `true` in the message request.
      NODES_VISITED_DETAILS type STANDARD TABLE OF T_DIALOG_NODE_VISITED_DETAILS WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of responses to the user.
      TEXT type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   Output intended for any channel. It is the responsibility of the client
      "!    application to implement the supported response types.
      GENERIC type STANDARD TABLE OF T_DIA_SUGGESTION_RESP_GENERIC WITH NON-UNIQUE DEFAULT KEY,
    end of T_DIALOG_SUGGESTION_OUTPUT.
  types:
    "! No documentation available.
    begin of T_DIALOG_SUGGESTION,
      "!   The user-facing label for the disambiguation option. This label is taken from
      "!    the **title** or **user_label** property of the corresponding dialog node,
      "!    depending on the disambiguation options.
      LABEL type STRING,
      "!   An object defining the message input, intents, and entities to be sent to the
      "!    Watson Assistant service if the user selects the corresponding disambiguation
      "!    option.
      VALUE type T_DIALOG_SUGGESTION_VALUE,
      "!   The dialog output that will be returned from the Watson Assistant service if the
      "!    user selects the corresponding option.
      OUTPUT type T_DIALOG_SUGGESTION_OUTPUT,
      "!   The ID of the dialog node that the **label** property is taken from. The
      "!    **label** property is populated using the value of the dialog node&apos;s
      "!    **user_label** property.
      DIALOG_NODE type STRING,
    end of T_DIALOG_SUGGESTION.
  types:
    "! No documentation available.
      T_EMPTY_RESPONSE type JSONOBJECT.
  types:
    "! No documentation available.
    begin of T_UPDATE_VALUE,
      "!   The text of the entity value. This string must conform to the following
      "!    restrictions:<br/>
      "!   - It cannot contain carriage return, newline, or tab characters.<br/>
      "!   - It cannot consist of only whitespace characters.
      VALUE type STRING,
      "!   Any metadata related to the entity value.
      METADATA type MAP,
      "!   Specifies the type of entity value.
      TYPE type STRING,
      "!   An array of synonyms for the entity value. A value can specify either synonyms
      "!    or patterns (depending on the value type), but not both. A synonym must conform
      "!    to the following resrictions:<br/>
      "!   - It cannot contain carriage return, newline, or tab characters.<br/>
      "!   - It cannot consist of only whitespace characters.
      SYNONYMS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of patterns for the entity value. A value can specify either synonyms
      "!    or patterns (depending on the value type), but not both. A pattern is a regular
      "!    expression; for more information about how to specify a pattern, see the
      "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-entities#e
      "!   ntities-create-dictionary-based).
      PATTERNS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_UPDATE_VALUE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An alternative value for the recognized entity.</p>
    begin of T_RUNTIME_ENTITY_ALTERNATIVE,
      "!   The entity value that was recognized in the user input.
      VALUE type STRING,
      "!   A decimal percentage that represents Watson&apos;s confidence in the recognized
      "!    entity.
      CONFIDENCE type NUMBER,
    end of T_RUNTIME_ENTITY_ALTERNATIVE.
  types:
    "! No documentation available.
    begin of T_UPDATE_INTENT,
      "!   The name of the intent. This string must conform to the following
      "!    restrictions:<br/>
      "!   - It can contain only Unicode alphanumeric, underscore, hyphen, and dot
      "!    characters.<br/>
      "!   - It cannot begin with the reserved prefix `sys-`.
      INTENT type STRING,
      "!   The description of the intent. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
      "!   An array of user input examples for the intent.
      EXAMPLES type STANDARD TABLE OF T_EXAMPLE WITH NON-UNIQUE DEFAULT KEY,
    end of T_UPDATE_INTENT.
  types:
    "! No documentation available.
    begin of T_VALUE_COLLECTION,
      "!   An array of entity values.
      VALUES type STANDARD TABLE OF T_VALUE WITH NON-UNIQUE DEFAULT KEY,
      "!   The pagination data for the returned objects.
      PAGINATION type T_PAGINATION,
    end of T_VALUE_COLLECTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Log message details.</p>
    begin of T_LOG_MESSAGE,
      "!   The severity of the log message.
      LEVEL type STRING,
      "!   The text of the log message.
      MSG type STRING,
    end of T_LOG_MESSAGE.
  types:
    "! No documentation available.
    begin of T_RUNTIME_RESPONSE_GENERIC,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.<br/>
      "!   <br/>
      "!   **Note:** The **suggestion** response type is part of the disambiguation
      "!    feature, which is only available for Plus and Premium users.
      RESPONSE_TYPE type STRING,
      "!   The text of the response.
      TEXT type STRING,
      "!   How long to pause, in milliseconds.
      TIME type INTEGER,
      "!   Whether to send a &quot;user is typing&quot; event during the pause.
      TYPING type BOOLEAN,
      "!   The URL of the image.
      SOURCE type STRING,
      "!   The title or introductory text to show before the response.
      TITLE type STRING,
      "!   The description to show with the the response.
      DESCRIPTION type STRING,
      "!   The preferred type of control to display.
      PREFERENCE type STRING,
      "!   An array of objects describing the options from which the user can choose.
      OPTIONS type STANDARD TABLE OF T_DIA_NODE_OUTPUT_OPT_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
      "!   A message to be sent to the human agent who will be taking over the
      "!    conversation.
      MESSAGE_TO_HUMAN_AGENT type STRING,
      "!   A label identifying the topic of the conversation, derived from the
      "!    **user_label** property of the relevant node.
      TOPIC type STRING,
      "!   The ID of the dialog node that the **topic** property is taken from. The
      "!    **topic** property is populated using the value of the dialog node&apos;s
      "!    **user_label** property.
      DIALOG_NODE type STRING,
      "!   An array of objects describing the possible matching dialog nodes from which the
      "!    user can choose.<br/>
      "!   <br/>
      "!   **Note:** The **suggestions** property is part of the disambiguation feature,
      "!    which is only available for Plus and Premium users.
      SUGGESTIONS type STANDARD TABLE OF T_DIALOG_SUGGESTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_RUNTIME_RESPONSE_GENERIC.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An output object that includes the response to the user, the</p>
    "!     dialog nodes that were triggered, and messages from the log.
    begin of T_OUTPUT_DATA,
      "!   An array of the nodes that were triggered to create the response, in the order
      "!    in which they were visited. This information is useful for debugging and for
      "!    tracing the path taken through the node tree.
      NODES_VISITED type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects containing detailed diagnostic information about the nodes
      "!    that were triggered during processing of the input message. Included only if
      "!    **nodes_visited_details** is set to `true` in the message request.
      NODES_VISITED_DETAILS type STANDARD TABLE OF T_DIALOG_NODE_VISITED_DETAILS WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of up to 50 messages logged with the request.
      LOG_MESSAGES type STANDARD TABLE OF T_LOG_MESSAGE WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of responses to the user.
      TEXT type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   Output intended for any channel. It is the responsibility of the client
      "!    application to implement the supported response types.
      GENERIC type STANDARD TABLE OF T_RUNTIME_RESPONSE_GENERIC WITH NON-UNIQUE DEFAULT KEY,
    end of T_OUTPUT_DATA.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An array of dialog nodes.</p>
    begin of T_DIALOG_NODE_COLLECTION,
      "!   An array of objects describing the dialog nodes defined for the workspace.
      DIALOG_NODES type STANDARD TABLE OF T_DIALOG_NODE WITH NON-UNIQUE DEFAULT KEY,
      "!   The pagination data for the returned objects.
      PAGINATION type T_PAGINATION,
    end of T_DIALOG_NODE_COLLECTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    For internal use only.</p>
      T_SYSTEM_RESPONSE type MAP.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Metadata related to the message.</p>
    begin of T_MESSAGE_CONTEXT_METADATA,
      "!   A label identifying the deployment environment, used for filtering log data.
      "!    This string cannot contain carriage return, newline, or tab characters.
      DEPLOYMENT type STRING,
      "!   A string value that identifies the user who is interacting with the workspace.
      "!    The client must provide a unique identifier for each individual end user who
      "!    accesses the application. For Plus and Premium plans, this user ID is used to
      "!    identify unique users for billing purposes. This string cannot contain carriage
      "!    return, newline, or tab characters.
      USER_ID type STRING,
    end of T_MESSAGE_CONTEXT_METADATA.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    State information for the conversation. To maintain state,</p>
    "!     include the context from the previous response.
    begin of T_CONTEXT,
      "!   The unique identifier of the conversation.
      CONVERSATION_ID type STRING,
      "!   For internal use only.
      SYSTEM type T_SYSTEM_RESPONSE,
      "!   Metadata related to the message.
      METADATA type T_MESSAGE_CONTEXT_METADATA,
    end of T_CONTEXT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The response sent by the workspace, including the output</p>
    "!     text, detected intents and entities, and context.
    begin of T_MESSAGE_RESPONSE,
      "!   An input object that includes the input text.
      INPUT type T_MESSAGE_INPUT,
      "!   An array of intents recognized in the user input, sorted in descending order of
      "!    confidence.
      INTENTS type STANDARD TABLE OF T_RUNTIME_INTENT WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of entities identified in the user input.
      ENTITIES type STANDARD TABLE OF T_RUNTIME_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      "!   Whether to return more than one intent. A value of `true` indicates that all
      "!    matching intents are returned.
      ALTERNATE_INTENTS type BOOLEAN,
      "!   State information for the conversation. To maintain state, include the context
      "!    from the previous response.
      CONTEXT type T_CONTEXT,
      "!   An output object that includes the response to the user, the dialog nodes that
      "!    were triggered, and messages from the log.
      OUTPUT type T_OUTPUT_DATA,
      "!   An array of objects describing any actions requested by the dialog node.
      ACTIONS type STANDARD TABLE OF T_DIALOG_NODE_ACTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_MESSAGE_RESPONSE.
  types:
    "! No documentation available.
    begin of T_BASE_VALUE,
      "!   The text of the entity value. This string must conform to the following
      "!    restrictions:<br/>
      "!   - It cannot contain carriage return, newline, or tab characters.<br/>
      "!   - It cannot consist of only whitespace characters.
      VALUE type STRING,
      "!   Any metadata related to the entity value.
      METADATA type MAP,
      "!   Specifies the type of entity value.
      TYPE type STRING,
      "!   An array of synonyms for the entity value. A value can specify either synonyms
      "!    or patterns (depending on the value type), but not both. A synonym must conform
      "!    to the following resrictions:<br/>
      "!   - It cannot contain carriage return, newline, or tab characters.<br/>
      "!   - It cannot consist of only whitespace characters.
      SYNONYMS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of patterns for the entity value. A value can specify either synonyms
      "!    or patterns (depending on the value type), but not both. A pattern is a regular
      "!    expression; for more information about how to specify a pattern, see the
      "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-entities#e
      "!   ntities-create-dictionary-based).
      PATTERNS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_BASE_VALUE.
  types:
    "! No documentation available.
    begin of T_UPDATE_ENTITY,
      "!   The name of the entity. This string must conform to the following
      "!    restrictions:<br/>
      "!   - It can contain only Unicode alphanumeric, underscore, and hyphen
      "!    characters.<br/>
      "!   - It cannot begin with the reserved prefix `sys-`.
      ENTITY type STRING,
      "!   The description of the entity. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   Any metadata related to the entity.
      METADATA type MAP,
      "!   Whether to use fuzzy matching for the entity.
      FUZZY_MATCH type BOOLEAN,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
      "!   An array of objects describing the entity values.
      VALUES type STANDARD TABLE OF T_CREATE_VALUE WITH NON-UNIQUE DEFAULT KEY,
    end of T_UPDATE_ENTITY.
  types:
    "! No documentation available.
    begin of T_UPDATE_DIALOG_NODE,
      "!   The dialog node ID. This string must conform to the following restrictions:<br/>
      "!   - It can contain only Unicode alphanumeric, space, underscore, hyphen, and dot
      "!    characters.
      DIALOG_NODE type STRING,
      "!   The description of the dialog node. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   The condition that will trigger the dialog node. This string cannot contain
      "!    carriage return, newline, or tab characters.
      CONDITIONS type STRING,
      "!   The ID of the parent dialog node. This property is omitted if the dialog node
      "!    has no parent.
      PARENT type STRING,
      "!   The ID of the previous sibling dialog node. This property is omitted if the
      "!    dialog node has no previous sibling.
      PREVIOUS_SIBLING type STRING,
      "!   The output of the dialog node. For more information about how to specify dialog
      "!    node output, see the
      "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-dialog-ove
      "!   rview#dialog-overview-responses).
      OUTPUT type T_DIALOG_NODE_OUTPUT,
      "!   The context for the dialog node.
      CONTEXT type MAP,
      "!   The metadata for the dialog node.
      METADATA type MAP,
      "!   The next step to execute following this dialog node.
      NEXT_STEP type T_DIALOG_NODE_NEXT_STEP,
      "!   The alias used to identify the dialog node. This string must conform to the
      "!    following restrictions:<br/>
      "!   - It can contain only Unicode alphanumeric, space, underscore, hyphen, and dot
      "!    characters.
      TITLE type STRING,
      "!   How the dialog node is processed.
      TYPE type STRING,
      "!   How an `event_handler` node is processed.
      EVENT_NAME type STRING,
      "!   The location in the dialog context where output is stored.
      VARIABLE type STRING,
      "!   An array of objects describing any actions to be invoked by the dialog node.
      ACTIONS type STANDARD TABLE OF T_DIALOG_NODE_ACTION WITH NON-UNIQUE DEFAULT KEY,
      "!   Whether this top-level dialog node can be digressed into.
      DIGRESS_IN type STRING,
      "!   Whether this dialog node can be returned to after a digression.
      DIGRESS_OUT type STRING,
      "!   Whether the user can digress to top-level nodes while filling out slots.
      DIGRESS_OUT_SLOTS type STRING,
      "!   A label that can be displayed externally to describe the purpose of the node to
      "!    users.
      USER_LABEL type STRING,
      "!   Whether the dialog node should be excluded from disambiguation suggestions.
      DISAMBIGUATION_OPT_OUT type BOOLEAN,
      "!   For internal use only.
      DISABLED type BOOLEAN,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_UPDATE_DIALOG_NODE.
  types:
    "! No documentation available.
    begin of T_RUNTIME_RESPONSE_TYPE_PAUSE,
      "!   How long to pause, in milliseconds.
      TIME type INTEGER,
      "!   Whether to send a &quot;user is typing&quot; event during the pause.
      TYPING type BOOLEAN,
    end of T_RUNTIME_RESPONSE_TYPE_PAUSE.
  types:
    "! No documentation available.
    begin of T_DIA_ND_OTPT_RESP_TYP_CNNCT_1,
      "!   An optional message to be sent to the human agent who will be taking over the
      "!    conversation. Valid only when **reponse_type**=`connect_to_agent`.
      MESSAGE_TO_HUMAN_AGENT type STRING,
    end of T_DIA_ND_OTPT_RESP_TYP_CNNCT_1.
  types:
    "! No documentation available.
    begin of T_ERROR_DETAIL,
      "!   Description of a specific constraint violation.
      MESSAGE type STRING,
      "!   The location of the constraint violation.
      PATH type STRING,
    end of T_ERROR_DETAIL.
  types:
    "! No documentation available.
    begin of T_CREATE_INTENT,
      "!   The name of the intent. This string must conform to the following
      "!    restrictions:<br/>
      "!   - It can contain only Unicode alphanumeric, underscore, hyphen, and dot
      "!    characters.<br/>
      "!   - It cannot begin with the reserved prefix `sys-`.
      INTENT type STRING,
      "!   The description of the intent. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
      "!   An array of user input examples for the intent.
      EXAMPLES type STANDARD TABLE OF T_EXAMPLE WITH NON-UNIQUE DEFAULT KEY,
    end of T_CREATE_INTENT.
  types:
    "! No documentation available.
    begin of T_CREATE_ENTITY,
      "!   The name of the entity. This string must conform to the following
      "!    restrictions:<br/>
      "!   - It can contain only Unicode alphanumeric, underscore, and hyphen
      "!    characters.<br/>
      "!   - If you specify an entity name beginning with the reserved prefix `sys-`, it
      "!    must be the name of a system entity that you want to enable. (Any entity
      "!    content specified with the request is ignored.).
      ENTITY type STRING,
      "!   The description of the entity. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   Any metadata related to the entity.
      METADATA type MAP,
      "!   Whether to use fuzzy matching for the entity.
      FUZZY_MATCH type BOOLEAN,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
      "!   An array of objects describing the entity values.
      VALUES type STANDARD TABLE OF T_CREATE_VALUE WITH NON-UNIQUE DEFAULT KEY,
    end of T_CREATE_ENTITY.
  types:
    "! No documentation available.
    begin of T_CREATE_WORKSPACE,
      "!   The name of the workspace. This string cannot contain carriage return, newline,
      "!    or tab characters.
      NAME type STRING,
      "!   The description of the workspace. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   The language of the workspace.
      LANGUAGE type STRING,
      "!   Any metadata related to the workspace.
      METADATA type MAP,
      "!   Whether training data from the workspace (including artifacts such as intents
      "!    and entities) can be used by IBM for general service improvements. `true`
      "!    indicates that workspace training data is not to be used.
      LEARNING_OPT_OUT type BOOLEAN,
      "!   Global settings for the workspace.
      SYSTEM_SETTINGS type T_WORKSPACE_SYSTEM_SETTINGS,
      "!   The workspace ID of the workspace.
      WORKSPACE_ID type STRING,
      "!   The current status of the workspace.
      STATUS type STRING,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
      "!   An array of objects defining the intents for the workspace.
      INTENTS type STANDARD TABLE OF T_CREATE_INTENT WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects describing the entities for the workspace.
      ENTITIES type STANDARD TABLE OF T_CREATE_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects describing the dialog nodes in the workspace.
      DIALOG_NODES type STANDARD TABLE OF T_DIALOG_NODE WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects defining input examples that have been marked as irrelevant
      "!    input.
      COUNTEREXAMPLES type STANDARD TABLE OF T_COUNTEREXAMPLE WITH NON-UNIQUE DEFAULT KEY,
      "!   No documentation available.
      WEBHOOKS type STANDARD TABLE OF T_WEBHOOK WITH NON-UNIQUE DEFAULT KEY,
    end of T_CREATE_WORKSPACE.
  types:
    "! No documentation available.
    begin of T_COUNTEREXAMPLE_COLLECTION,
      "!   An array of objects describing the examples marked as irrelevant input.
      COUNTEREXAMPLES type STANDARD TABLE OF T_COUNTEREXAMPLE WITH NON-UNIQUE DEFAULT KEY,
      "!   The pagination data for the returned objects.
      PAGINATION type T_PAGINATION,
    end of T_COUNTEREXAMPLE_COLLECTION.
  types:
    "! No documentation available.
    begin of T_BASE_EXAMPLE,
      "!   The text of the user input example. This string must conform to the following
      "!    restrictions:<br/>
      "!   - It cannot contain carriage return, newline, or tab characters.<br/>
      "!   - It cannot consist of only whitespace characters.
      TEXT type STRING,
      "!   An array of contextual entity mentions.
      MENTIONS type STANDARD TABLE OF T_MENTION WITH NON-UNIQUE DEFAULT KEY,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_BASE_EXAMPLE.
  types:
    "! No documentation available.
    begin of T_RT_ENTTY_INTRPRTTN_SYS_NUM,
      "!   A recognized numeric value, represented as an integer or double.
      NUMERIC_VALUE type NUMBER,
      "!   A unique identifier used to associate multiple recognized `&#64;sys-date`,
      "!    `&#64;sys-time`, or `&#64;sys-number` entities that are recognized as a range
      "!    of values in the user&apos;s input (for example, `from July 4 until July 14` or
      "!    `from 20 to 25`).
      RANGE_LINK type STRING,
      "!   The type of numeric value recognized in the user input (`integer` or
      "!    `rational`).
      SUBTYPE type STRING,
    end of T_RT_ENTTY_INTRPRTTN_SYS_NUM.
  types:
    "! No documentation available.
    begin of T_UPDATE_COUNTEREXAMPLE,
      "!   The text of a user input marked as irrelevant input. This string must conform to
      "!    the following restrictions:<br/>
      "!   - It cannot contain carriage return, newline, or tab characters.<br/>
      "!   - It cannot consist of only whitespace characters.
      TEXT type STRING,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_UPDATE_COUNTEREXAMPLE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An array of objects describing the entities for the</p>
    "!     workspace.
    begin of T_ENTITY_COLLECTION,
      "!   An array of objects describing the entities defined for the workspace.
      ENTITIES type STANDARD TABLE OF T_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      "!   The pagination data for the returned objects.
      PAGINATION type T_PAGINATION,
    end of T_ENTITY_COLLECTION.
  types:
    "! No documentation available.
    begin of T_INTENT_COLLECTION,
      "!   An array of objects describing the intents defined for the workspace.
      INTENTS type STANDARD TABLE OF T_INTENT WITH NON-UNIQUE DEFAULT KEY,
      "!   The pagination data for the returned objects.
      PAGINATION type T_PAGINATION,
    end of T_INTENT_COLLECTION.
  types:
    "! No documentation available.
    begin of T_DIA_ND_OTPT_RESP_TYPE_PAUSE,
      "!   How long to pause, in milliseconds. The valid values are from 0 to 10000. Valid
      "!    only when **response_type**=`pause`.
      TIME type INTEGER,
      "!   Whether to send a &quot;user is typing&quot; event during the pause. Ignored if
      "!    the channel does not support this event. Valid only when
      "!    **response_type**=`pause`.
      TYPING type BOOLEAN,
    end of T_DIA_ND_OTPT_RESP_TYPE_PAUSE.
  types:
    "! No documentation available.
    begin of T_DIA_ND_OUTPUT_RESP_TYPE_IMG,
      "!   The URL of the image. Required when **response_type**=`image`.
      SOURCE type STRING,
      "!   An optional title to show before the response. Valid only when
      "!    **response_type**=`image` or `option`.
      TITLE type STRING,
      "!   An optional description to show with the response. Valid only when
      "!    **response_type**=`image` or `option`.
      DESCRIPTION type STRING,
    end of T_DIA_ND_OUTPUT_RESP_TYPE_IMG.
  types:
    "! No documentation available.
    begin of T_ERROR_RESPONSE,
      "!   General description of an error.
      ERROR type STRING,
      "!   Collection of specific constraint violations associated with the error.
      ERRORS type STANDARD TABLE OF T_ERROR_DETAIL WITH NON-UNIQUE DEFAULT KEY,
      "!   HTTP status code for the error response.
      CODE type INTEGER,
    end of T_ERROR_RESPONSE.
  types:
    "! No documentation available.
    begin of T_BASE_MESSAGE,
      "!   An input object that includes the input text.
      INPUT type T_MESSAGE_INPUT,
      "!   An array of intents recognized in the user input, sorted in descending order of
      "!    confidence.
      INTENTS type STANDARD TABLE OF T_RUNTIME_INTENT WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of entities identified in the user input.
      ENTITIES type STANDARD TABLE OF T_RUNTIME_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      "!   Whether to return more than one intent. A value of `true` indicates that all
      "!    matching intents are returned.
      ALTERNATE_INTENTS type BOOLEAN,
      "!   State information for the conversation. To maintain state, include the context
      "!    from the previous response.
      CONTEXT type T_CONTEXT,
      "!   An output object that includes the response to the user, the dialog nodes that
      "!    were triggered, and messages from the log.
      OUTPUT type T_OUTPUT_DATA,
      "!   An array of objects describing any actions requested by the dialog node.
      ACTIONS type STANDARD TABLE OF T_DIALOG_NODE_ACTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_BASE_MESSAGE.
  types:
    "! No documentation available.
    begin of T_RT_RESPONSE_TYPE_SUGGESTION,
      "!   The title or introductory text to show before the response.
      TITLE type STRING,
      "!   An array of objects describing the possible matching dialog nodes from which the
      "!    user can choose.<br/>
      "!   <br/>
      "!   **Note:** The **suggestions** property is part of the disambiguation feature,
      "!    which is only available for Plus and Premium users.
      SUGGESTIONS type STANDARD TABLE OF T_DIALOG_SUGGESTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_RT_RESPONSE_TYPE_SUGGESTION.
  types:
    "! No documentation available.
    begin of T_ENTITY_MENTION_COLLECTION,
      "!   An array of objects describing the entity mentions defined for an entity.
      EXAMPLES type STANDARD TABLE OF T_ENTITY_MENTION WITH NON-UNIQUE DEFAULT KEY,
      "!   The pagination data for the returned objects.
      PAGINATION type T_PAGINATION,
    end of T_ENTITY_MENTION_COLLECTION.
  types:
    "! No documentation available.
    begin of T_UPDATE_SYNONYM,
      "!   The text of the synonym. This string must conform to the following
      "!    restrictions:<br/>
      "!   - It cannot contain carriage return, newline, or tab characters.<br/>
      "!   - It cannot consist of only whitespace characters.
      SYNONYM type STRING,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_UPDATE_SYNONYM.
  types:
    "! No documentation available.
    begin of T_BASE_INTENT,
      "!   The name of the intent. This string must conform to the following
      "!    restrictions:<br/>
      "!   - It can contain only Unicode alphanumeric, underscore, hyphen, and dot
      "!    characters.<br/>
      "!   - It cannot begin with the reserved prefix `sys-`.
      INTENT type STRING,
      "!   The description of the intent. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_BASE_INTENT.
  types:
    "! No documentation available.
    begin of T_RT_ENTTY_INTRPRTTN_SYS_DATE,
      "!   The calendar used to represent a recognized date (for example, `Gregorian`).
      CALENDAR_TYPE type STRING,
      "!   A unique identifier used to associate a time and date. If the user input
      "!    contains a date and time that are mentioned together (for example, `Today at
      "!    5`, the same **datetime_link** value is returned for both the `&#64;sys-date`
      "!    and `&#64;sys-time` entities).
      DATETIME_LINK type STRING,
      "!   A locale-specific holiday name (such as `thanksgiving` or `christmas`). This
      "!    property is included when a `&#64;sys-date` entity is recognized based on a
      "!    holiday name in the user input.
      FESTIVAL type STRING,
      "!   The precision or duration of a time range specified by a recognized
      "!    `&#64;sys-time` or `&#64;sys-date` entity.
      GRANULARITY type STRING,
      "!   A unique identifier used to associate multiple recognized `&#64;sys-date`,
      "!    `&#64;sys-time`, or `&#64;sys-number` entities that are recognized as a range
      "!    of values in the user&apos;s input (for example, `from July 4 until July 14` or
      "!    `from 20 to 25`).
      RANGE_LINK type STRING,
      "!   The word in the user input that indicates that a `sys-date` or `sys-time` entity
      "!    is part of an implied range where only one date or time is specified (for
      "!    example, `since` or `until`).
      RANGE_MODIFIER type STRING,
      "!   A recognized mention of a relative day, represented numerically as an offset
      "!    from the current date (for example, `-1` for `yesterday` or `10` for `in ten
      "!    days`).
      RELATIVE_DAY type NUMBER,
      "!   A recognized mention of a relative month, represented numerically as an offset
      "!    from the current month (for example, `1` for `next month` or `-3` for `three
      "!    months ago`).
      RELATIVE_MONTH type NUMBER,
      "!   A recognized mention of a relative week, represented numerically as an offset
      "!    from the current week (for example, `2` for `in two weeks` or `-1` for `last
      "!    week).
      RELATIVE_WEEK type NUMBER,
      "!   A recognized mention of a relative date range for a weekend, represented
      "!    numerically as an offset from the current weekend (for example, `0` for `this
      "!    weekend` or `-1` for `last weekend`).
      RELATIVE_WEEKEND type NUMBER,
      "!   A recognized mention of a relative year, represented numerically as an offset
      "!    from the current year (for example, `1` for `next year` or `-5` for `five years
      "!    ago`).
      RELATIVE_YEAR type NUMBER,
      "!   A recognized mention of a specific date, represented numerically as the date
      "!    within the month (for example, `30` for `June 30`.).
      SPECIFIC_DAY type NUMBER,
      "!   A recognized mention of a specific day of the week as a lowercase string (for
      "!    example, `monday`).
      SPECIFIC_DAY_OF_WEEK type STRING,
      "!   A recognized mention of a specific month, represented numerically (for example,
      "!    `7` for `July`).
      SPECIFIC_MONTH type NUMBER,
      "!   A recognized mention of a specific quarter, represented numerically (for
      "!    example, `3` for `the third quarter`).
      SPECIFIC_QUARTER type NUMBER,
      "!   A recognized mention of a specific year (for example, `2016`).
      SPECIFIC_YEAR type NUMBER,
    end of T_RT_ENTTY_INTRPRTTN_SYS_DATE.
  types:
    "! No documentation available.
    begin of T_DIA_ND_OUTPUT_RESP_TYPE_OPT,
      "!   An optional title to show before the response. Valid only when
      "!    **response_type**=`image` or `option`.
      TITLE type STRING,
      "!   An optional description to show with the response. Valid only when
      "!    **response_type**=`image` or `option`.
      DESCRIPTION type STRING,
      "!   The preferred type of control to display, if supported by the channel. Valid
      "!    only when **response_type**=`option`.
      PREFERENCE type STRING,
      "!   An array of objects describing the options from which the user can choose. You
      "!    can include up to 20 options. Required when **response_type**=`option`.
      OPTIONS type STANDARD TABLE OF T_DIA_NODE_OUTPUT_OPT_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
    end of T_DIA_ND_OUTPUT_RESP_TYPE_OPT.
  types:
    "! No documentation available.
    begin of T_BASE_COUNTEREXAMPLE,
      "!   The text of a user input marked as irrelevant input. This string must conform to
      "!    the following restrictions:<br/>
      "!   - It cannot contain carriage return, newline, or tab characters.<br/>
      "!   - It cannot consist of only whitespace characters.
      TEXT type STRING,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_BASE_COUNTEREXAMPLE.
  types:
    "! No documentation available.
    begin of T_RUNTIME_RESPONSE_TYPE_IMAGE,
      "!   The URL of the image.
      SOURCE type STRING,
      "!   The title or introductory text to show before the response.
      TITLE type STRING,
      "!   The description to show with the the response.
      DESCRIPTION type STRING,
    end of T_RUNTIME_RESPONSE_TYPE_IMAGE.
  types:
    "! No documentation available.
    begin of T_UPDATE_WORKSPACE,
      "!   The name of the workspace. This string cannot contain carriage return, newline,
      "!    or tab characters.
      NAME type STRING,
      "!   The description of the workspace. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   The language of the workspace.
      LANGUAGE type STRING,
      "!   Any metadata related to the workspace.
      METADATA type MAP,
      "!   Whether training data from the workspace (including artifacts such as intents
      "!    and entities) can be used by IBM for general service improvements. `true`
      "!    indicates that workspace training data is not to be used.
      LEARNING_OPT_OUT type BOOLEAN,
      "!   Global settings for the workspace.
      SYSTEM_SETTINGS type T_WORKSPACE_SYSTEM_SETTINGS,
      "!   The workspace ID of the workspace.
      WORKSPACE_ID type STRING,
      "!   The current status of the workspace.
      STATUS type STRING,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
      "!   An array of objects defining the intents for the workspace.
      INTENTS type STANDARD TABLE OF T_CREATE_INTENT WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects describing the entities for the workspace.
      ENTITIES type STANDARD TABLE OF T_CREATE_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects describing the dialog nodes in the workspace.
      DIALOG_NODES type STANDARD TABLE OF T_DIALOG_NODE WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects defining input examples that have been marked as irrelevant
      "!    input.
      COUNTEREXAMPLES type STANDARD TABLE OF T_COUNTEREXAMPLE WITH NON-UNIQUE DEFAULT KEY,
      "!   No documentation available.
      WEBHOOKS type STANDARD TABLE OF T_WEBHOOK WITH NON-UNIQUE DEFAULT KEY,
    end of T_UPDATE_WORKSPACE.
  types:
    "! No documentation available.
    begin of T_BASE_DIALOG_NODE,
      "!   The dialog node ID. This string must conform to the following restrictions:<br/>
      "!   - It can contain only Unicode alphanumeric, space, underscore, hyphen, and dot
      "!    characters.
      DIALOG_NODE type STRING,
      "!   The description of the dialog node. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   The condition that will trigger the dialog node. This string cannot contain
      "!    carriage return, newline, or tab characters.
      CONDITIONS type STRING,
      "!   The ID of the parent dialog node. This property is omitted if the dialog node
      "!    has no parent.
      PARENT type STRING,
      "!   The ID of the previous sibling dialog node. This property is omitted if the
      "!    dialog node has no previous sibling.
      PREVIOUS_SIBLING type STRING,
      "!   The output of the dialog node. For more information about how to specify dialog
      "!    node output, see the
      "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-dialog-ove
      "!   rview#dialog-overview-responses).
      OUTPUT type T_DIALOG_NODE_OUTPUT,
      "!   The context for the dialog node.
      CONTEXT type MAP,
      "!   The metadata for the dialog node.
      METADATA type MAP,
      "!   The next step to execute following this dialog node.
      NEXT_STEP type T_DIALOG_NODE_NEXT_STEP,
      "!   The alias used to identify the dialog node. This string must conform to the
      "!    following restrictions:<br/>
      "!   - It can contain only Unicode alphanumeric, space, underscore, hyphen, and dot
      "!    characters.
      TITLE type STRING,
      "!   How the dialog node is processed.
      TYPE type STRING,
      "!   How an `event_handler` node is processed.
      EVENT_NAME type STRING,
      "!   The location in the dialog context where output is stored.
      VARIABLE type STRING,
      "!   An array of objects describing any actions to be invoked by the dialog node.
      ACTIONS type STANDARD TABLE OF T_DIALOG_NODE_ACTION WITH NON-UNIQUE DEFAULT KEY,
      "!   Whether this top-level dialog node can be digressed into.
      DIGRESS_IN type STRING,
      "!   Whether this dialog node can be returned to after a digression.
      DIGRESS_OUT type STRING,
      "!   Whether the user can digress to top-level nodes while filling out slots.
      DIGRESS_OUT_SLOTS type STRING,
      "!   A label that can be displayed externally to describe the purpose of the node to
      "!    users.
      USER_LABEL type STRING,
      "!   Whether the dialog node should be excluded from disambiguation suggestions.
      DISAMBIGUATION_OPT_OUT type BOOLEAN,
      "!   For internal use only.
      DISABLED type BOOLEAN,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_BASE_DIALOG_NODE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A request sent to the workspace, including the user input</p>
    "!     and context.
    begin of T_MESSAGE_REQUEST,
      "!   An input object that includes the input text.
      INPUT type T_MESSAGE_INPUT,
      "!   Intents to use when evaluating the user input. Include intents from the previous
      "!    response to continue using those intents rather than trying to recognize
      "!    intents in the new input.
      INTENTS type STANDARD TABLE OF T_RUNTIME_INTENT WITH NON-UNIQUE DEFAULT KEY,
      "!   Entities to use when evaluating the message. Include entities from the previous
      "!    response to continue using those entities rather than detecting entities in the
      "!    new input.
      ENTITIES type STANDARD TABLE OF T_RUNTIME_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      "!   Whether to return more than one intent. A value of `true` indicates that all
      "!    matching intents are returned.
      ALTERNATE_INTENTS type BOOLEAN,
      "!   State information for the conversation. To maintain state, include the context
      "!    from the previous response.
      CONTEXT type T_CONTEXT,
      "!   An output object that includes the response to the user, the dialog nodes that
      "!    were triggered, and messages from the log.
      OUTPUT type T_OUTPUT_DATA,
      "!   An array of objects describing any actions requested by the dialog node.
      ACTIONS type STANDARD TABLE OF T_DIALOG_NODE_ACTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_MESSAGE_REQUEST.
  types:
    "! No documentation available.
    begin of T_LOG,
      "!   A request sent to the workspace, including the user input and context.
      REQUEST type T_MESSAGE_REQUEST,
      "!   The response sent by the workspace, including the output text, detected intents
      "!    and entities, and context.
      RESPONSE type T_MESSAGE_RESPONSE,
      "!   A unique identifier for the logged event.
      LOG_ID type STRING,
      "!   The timestamp for receipt of the message.
      REQUEST_TIMESTAMP type STRING,
      "!   The timestamp for the system response to the message.
      RESPONSE_TIMESTAMP type STRING,
      "!   The unique identifier of the workspace where the request was made.
      WORKSPACE_ID type STRING,
      "!   The language of the workspace where the message request was made.
      LANGUAGE type STRING,
    end of T_LOG.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An output object that includes the response to the user, the</p>
    "!     dialog nodes that were triggered, and messages from the log.
    begin of T_BASE_OUTPUT,
      "!   An array of the nodes that were triggered to create the response, in the order
      "!    in which they were visited. This information is useful for debugging and for
      "!    tracing the path taken through the node tree.
      NODES_VISITED type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects containing detailed diagnostic information about the nodes
      "!    that were triggered during processing of the input message. Included only if
      "!    **nodes_visited_details** is set to `true` in the message request.
      NODES_VISITED_DETAILS type STANDARD TABLE OF T_DIALOG_NODE_VISITED_DETAILS WITH NON-UNIQUE DEFAULT KEY,
    end of T_BASE_OUTPUT.
  types:
    "! No documentation available.
    begin of T_LOG_COLLECTION,
      "!   An array of objects describing log events.
      LOGS type STANDARD TABLE OF T_LOG WITH NON-UNIQUE DEFAULT KEY,
      "!   The pagination data for the returned objects.
      PAGINATION type T_LOG_PAGINATION,
    end of T_LOG_COLLECTION.
  types:
    "! No documentation available.
    begin of T_AUDIT_PROPERTIES,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_AUDIT_PROPERTIES.
  types:
    "! No documentation available.
    begin of T_WORKSPACE_COLLECTION,
      "!   An array of objects describing the workspaces associated with the service
      "!    instance.
      WORKSPACES type STANDARD TABLE OF T_WORKSPACE WITH NON-UNIQUE DEFAULT KEY,
      "!   The pagination data for the returned objects.
      PAGINATION type T_PAGINATION,
    end of T_WORKSPACE_COLLECTION.
  types:
    "! No documentation available.
    begin of T_BASE_SYNONYM,
      "!   The text of the synonym. This string must conform to the following
      "!    restrictions:<br/>
      "!   - It cannot contain carriage return, newline, or tab characters.<br/>
      "!   - It cannot consist of only whitespace characters.
      SYNONYM type STRING,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_BASE_SYNONYM.

constants:
  "! <p class="shorttext synchronized" lang="en">List of required fields per type.</p>
  begin of C_REQUIRED_FIELDS,
    T_WS_SYSTEM_SETTINGS_OFF_TOPIC type string value '|',
    T_RT_ENTITY_INTERPRETATION type string value '|',
    T_WEBHOOK_HEADER type string value '|NAME|VALUE|',
    T_DIALOG_NODE_ACTION type string value '|NAME|RESULT_VARIABLE|',
    T_WS_SYSTM_STTNGS_DSMBGTN type string value '|',
    T_DIALOG_NODE_OUTPUT_MODIFIERS type string value '|',
    T_DIALOG_NODE_NEXT_STEP type string value '|BEHAVIOR|',
    T_MESSAGE_INPUT type string value '|',
    T_CAPTURE_GROUP type string value '|GROUP|',
    T_RUNTIME_ENTITY_ROLE type string value '|',
    T_RUNTIME_ENTITY type string value '|ENTITY|LOCATION|VALUE|',
    T_RUNTIME_INTENT type string value '|INTENT|CONFIDENCE|',
    T_DIA_ND_OUTPUT_OPT_ELEM_VALUE type string value '|',
    T_DIA_NODE_OUTPUT_OPT_ELEMENT type string value '|LABEL|VALUE|',
    T_DIA_ND_OTPT_TEXT_VALUES_ELEM type string value '|',
    T_DIALOG_NODE_OUTPUT_GENERIC type string value '|RESPONSE_TYPE|',
    T_DIALOG_NODE_OUTPUT type string value '|',
    T_DIALOG_NODE type string value '|DIALOG_NODE|',
    T_VALUE type string value '|VALUE|TYPE|',
    T_WEBHOOK type string value '|URL|NAME|',
    T_WS_SYSTM_STTNGS_SYSTM_ENTTS type string value '|',
    T_MENTION type string value '|ENTITY|LOCATION|',
    T_EXAMPLE type string value '|TEXT|',
    T_INTENT type string value '|INTENT|',
    T_WS_SYSTEM_SETTINGS_TOOLING type string value '|',
    T_WORKSPACE_SYSTEM_SETTINGS type string value '|',
    T_COUNTEREXAMPLE type string value '|TEXT|',
    T_ENTITY type string value '|ENTITY|',
    T_WORKSPACE type string value '|NAME|LANGUAGE|LEARNING_OPT_OUT|WORKSPACE_ID|',
    T_SYNONYM type string value '|SYNONYM|',
    T_PAGINATION type string value '|REFRESH_URL|',
    T_SYNONYM_COLLECTION type string value '|SYNONYMS|PAGINATION|',
    T_RUNTIME_RESPONSE_TYPE_OPTION type string value '|',
    T_DIA_ND_OUTPUT_RESP_TYPE_TEXT type string value '|',
    T_BASE_WORKSPACE type string value '|',
    T_BASE_ENTITY type string value '|',
    T_RUNTIME_RESPONSE_TYPE_TEXT type string value '|',
    T_RT_ENTTY_INTRPRTTN_SYS_TIME type string value '|',
    T_UPDATE_EXAMPLE type string value '|',
    T_ENTITY_MENTION type string value '|TEXT|INTENT|LOCATION|',
    T_DIA_ND_OTPT_RESP_TYP_SRCH_S1 type string value '|',
    T_EXAMPLE_COLLECTION type string value '|EXAMPLES|PAGINATION|',
    T_LOG_PAGINATION type string value '|',
    T_RT_RESP_TYP_CONNECT_TO_AGENT type string value '|',
    T_CREATE_VALUE type string value '|VALUE|',
    T_DIALOG_NODE_VISITED_DETAILS type string value '|',
    T_DIA_SUGGESTION_RESP_GENERIC type string value '|RESPONSE_TYPE|',
    T_DIALOG_SUGGESTION_VALUE type string value '|',
    T_DIALOG_SUGGESTION_OUTPUT type string value '|TEXT|',
    T_DIALOG_SUGGESTION type string value '|LABEL|VALUE|',
    T_UPDATE_VALUE type string value '|',
    T_RUNTIME_ENTITY_ALTERNATIVE type string value '|',
    T_UPDATE_INTENT type string value '|',
    T_VALUE_COLLECTION type string value '|VALUES|PAGINATION|',
    T_LOG_MESSAGE type string value '|LEVEL|MSG|',
    T_RUNTIME_RESPONSE_GENERIC type string value '|RESPONSE_TYPE|',
    T_OUTPUT_DATA type string value '|LOG_MESSAGES|TEXT|',
    T_DIALOG_NODE_COLLECTION type string value '|DIALOG_NODES|PAGINATION|',
    T_MESSAGE_CONTEXT_METADATA type string value '|',
    T_CONTEXT type string value '|',
    T_MESSAGE_RESPONSE type string value '|INPUT|INTENTS|ENTITIES|CONTEXT|OUTPUT|',
    T_BASE_VALUE type string value '|',
    T_UPDATE_ENTITY type string value '|',
    T_UPDATE_DIALOG_NODE type string value '|',
    T_RUNTIME_RESPONSE_TYPE_PAUSE type string value '|',
    T_DIA_ND_OTPT_RESP_TYP_CNNCT_1 type string value '|',
    T_ERROR_DETAIL type string value '|MESSAGE|',
    T_CREATE_INTENT type string value '|INTENT|',
    T_CREATE_ENTITY type string value '|ENTITY|',
    T_CREATE_WORKSPACE type string value '|',
    T_COUNTEREXAMPLE_COLLECTION type string value '|COUNTEREXAMPLES|PAGINATION|',
    T_BASE_EXAMPLE type string value '|',
    T_RT_ENTTY_INTRPRTTN_SYS_NUM type string value '|',
    T_UPDATE_COUNTEREXAMPLE type string value '|',
    T_ENTITY_COLLECTION type string value '|ENTITIES|PAGINATION|',
    T_INTENT_COLLECTION type string value '|INTENTS|PAGINATION|',
    T_DIA_ND_OTPT_RESP_TYPE_PAUSE type string value '|',
    T_DIA_ND_OUTPUT_RESP_TYPE_IMG type string value '|',
    T_ERROR_RESPONSE type string value '|ERROR|CODE|',
    T_BASE_MESSAGE type string value '|',
    T_RT_RESPONSE_TYPE_SUGGESTION type string value '|',
    T_ENTITY_MENTION_COLLECTION type string value '|EXAMPLES|PAGINATION|',
    T_UPDATE_SYNONYM type string value '|',
    T_BASE_INTENT type string value '|',
    T_RT_ENTTY_INTRPRTTN_SYS_DATE type string value '|',
    T_DIA_ND_OUTPUT_RESP_TYPE_OPT type string value '|',
    T_BASE_COUNTEREXAMPLE type string value '|',
    T_RUNTIME_RESPONSE_TYPE_IMAGE type string value '|',
    T_UPDATE_WORKSPACE type string value '|',
    T_BASE_DIALOG_NODE type string value '|',
    T_MESSAGE_REQUEST type string value '|',
    T_LOG type string value '|REQUEST|RESPONSE|LOG_ID|REQUEST_TIMESTAMP|RESPONSE_TIMESTAMP|WORKSPACE_ID|LANGUAGE|',
    T_BASE_OUTPUT type string value '|',
    T_LOG_COLLECTION type string value '|LOGS|PAGINATION|',
    T_AUDIT_PROPERTIES type string value '|',
    T_WORKSPACE_COLLECTION type string value '|WORKSPACES|PAGINATION|',
    T_BASE_SYNONYM type string value '|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  "! <p class="shorttext synchronized" lang="en">Map ABAP identifiers to service identifiers.</p>
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
     DISAMBIGUATION_OPT_OUT type string value 'disambiguation_opt_out',
     DISABLED type string value 'disabled',
     ENTITY type string value 'entity',
     FUZZY_MATCH type string value 'fuzzy_match',
     MENTIONS type string value 'mentions',
     INTENT type string value 'intent',
     INPUT type string value 'input',
     INTENTS type string value 'intents',
     ENTITIES type string value 'entities',
     ALTERNATE_INTENTS type string value 'alternate_intents',
     NODES_VISITED type string value 'nodes_visited',
     NODESVISITED type string value 'nodesVisited',
     NODES_VISITED_DETAILS type string value 'nodes_visited_details',
     NODESVISITEDDETAILS type string value 'nodesVisitedDetails',
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
     WEBHOOKS type string value 'webhooks',
     PARAMETERS type string value 'parameters',
     RESULT_VARIABLE type string value 'result_variable',
     CREDENTIALS type string value 'credentials',
     DIALOGNODES type string value 'dialogNodes',
     BEHAVIOR type string value 'behavior',
     SELECTOR type string value 'selector',
     GENERIC type string value 'generic',
     MODIFIERS type string value 'modifiers',
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
     OVERWRITE type string value 'overwrite',
     LABEL type string value 'label',
     TOPIC type string value 'topic',
     MESSAGE type string value 'message',
     PATH type string value 'path',
     ERROR type string value 'error',
     ERRORS type string value 'errors',
     CODE type string value 'code',
     REQUEST type string value 'request',
     RESPONSE type string value 'response',
     LOG_ID type string value 'log_id',
     REQUEST_TIMESTAMP type string value 'request_timestamp',
     RESPONSE_TIMESTAMP type string value 'response_timestamp',
     LOGS type string value 'logs',
     LEVEL type string value 'level',
     MSG type string value 'msg',
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
     INTERPRETATION type string value 'interpretation',
     ROLE type string value 'role',
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
     SUGGESTIONS type string value 'suggestions',
     URL type string value 'url',
     HEADERS type string value 'headers',
     WORKSPACES type string value 'workspaces',
     TOOLING type string value 'tooling',
     DISAMBIGUATION type string value 'disambiguation',
     HUMAN_AGENT_ASSIST type string value 'human_agent_assist',
     SYSTEM_ENTITIES type string value 'system_entities',
     OFF_TOPIC type string value 'off_topic',
     PROMPT type string value 'prompt',
     NONE_OF_THE_ABOVE_PROMPT type string value 'none_of_the_above_prompt',
     ENABLED type string value 'enabled',
     SENSITIVITY type string value 'sensitivity',
     RANDOMIZE type string value 'randomize',
     MAX_SUGGESTIONS type string value 'max_suggestions',
     SUGGESTION_TEXT_POLICY type string value 'suggestion_text_policy',
     STORE_GENERIC_RESPONSES type string value 'store_generic_responses',
  end of C_ABAPNAME_DICTIONARY .


  methods GET_APPNAME
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
  methods GET_SDK_VERSION_DATE
    redefinition .


    "! <p class="shorttext synchronized" lang="en">Get response to user input</p>
    "!   Send user input to a workspace and receive a response.<br/>
    "!   <br/>
    "!   **Important:** This method has been superseded by the new v2 runtime API. The v2
    "!    API offers significant advantages, including ease of deployment, automatic
    "!    state management, versioning, and search capabilities. For more information,
    "!    see the
    "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-api-overvi
    "!   ew).<br/>
    "!   <br/>
    "!   There is no rate limit for this operation.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_BODY |
    "!   The message to be sent. This includes the user&apos;s input, along with optional
    "!    intents, entities, and context from the last response.
    "! @parameter I_NODES_VISITED_DETAILS |
    "!   Whether to include additional diagnostic information about the dialog nodes that
    "!    were visited during processing of the message.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_MESSAGE_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods MESSAGE
    importing
      !I_WORKSPACE_ID type STRING
      !I_BODY type T_MESSAGE_REQUEST optional
      !I_NODES_VISITED_DETAILS type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_MESSAGE_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List workspaces</p>
    "!   List the workspaces associated with a Watson Assistant service instance.<br/>
    "!   <br/>
    "!   This operation is limited to 500 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_PAGE_LIMIT |
    "!   The number of records to return in each page of results.
    "! @parameter I_SORT |
    "!   The attribute by which returned workspaces will be sorted. To reverse the sort
    "!    order, prefix the value with a minus sign (`-`).
    "! @parameter I_CURSOR |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_WORKSPACE_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_WORKSPACES
    importing
      !I_PAGE_LIMIT type INTEGER optional
      !I_SORT type STRING optional
      !I_CURSOR type STRING optional
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_WORKSPACE_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create workspace</p>
    "!   Create a workspace based on component objects. You must provide workspace
    "!    components defining the content of the new workspace.<br/>
    "!   <br/>
    "!   This operation is limited to 30 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_BODY |
    "!   The content of the new workspace.<br/>
    "!   <br/>
    "!   The maximum size for this data is 50MB. If you need to import a larger
    "!    workspace, consider importing the workspace without intents and entities and
    "!    then adding them separately.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_WORKSPACE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_WORKSPACE
    importing
      !I_BODY type T_CREATE_WORKSPACE optional
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_WORKSPACE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get information about a workspace</p>
    "!   Get information about a workspace, optionally including all workspace
    "!    content.<br/>
    "!   <br/>
    "!   With **export**=`false`, this operation is limited to 6000 requests per 5
    "!    minutes. With **export**=`true`, the limit is 20 requests per 30 minutes. For
    "!    more information, see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_EXPORT |
    "!   Whether to include all element content in the returned data. If
    "!    **export**=`false`, the returned data includes only information about the
    "!    element itself. If **export**=`true`, all content, including subelements, is
    "!    included.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter I_SORT |
    "!   Indicates how the returned workspace data will be sorted. This parameter is
    "!    valid only if **export**=`true`. Specify `sort=stable` to sort all workspace
    "!    objects by unique identifier, in ascending alphabetical order.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_WORKSPACE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_WORKSPACE
    importing
      !I_WORKSPACE_ID type STRING
      !I_EXPORT type BOOLEAN default c_boolean_false
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_SORT type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_WORKSPACE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update workspace</p>
    "!   Update an existing workspace with new or modified data. You must provide
    "!    component objects defining the content of the updated workspace.<br/>
    "!   <br/>
    "!   This operation is limited to 30 request per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_BODY |
    "!   Valid data defining the new and updated workspace content.<br/>
    "!   <br/>
    "!   The maximum size for this data is 50MB. If you need to import a larger amount of
    "!    workspace data, consider importing components such as intents and entities
    "!    using separate operations.
    "! @parameter I_APPEND |
    "!   Whether the new data is to be appended to the existing data in the object. If
    "!    **append**=`false`, elements included in the new data completely replace the
    "!    corresponding existing elements, including all subelements. For example, if the
    "!    new data for a workspace includes **entities** and **append**=`false`, all
    "!    existing entities in the workspace are discarded and replaced with the new
    "!    entities.<br/>
    "!   <br/>
    "!   If **append**=`true`, existing elements are preserved, and the new elements are
    "!    added. If any elements in the new data collide with existing elements, the
    "!    update request fails.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_WORKSPACE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_WORKSPACE
    importing
      !I_WORKSPACE_ID type STRING
      !I_BODY type T_UPDATE_WORKSPACE optional
      !I_APPEND type BOOLEAN default c_boolean_false
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_WORKSPACE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete workspace</p>
    "!   Delete a workspace from the service instance.<br/>
    "!   <br/>
    "!   This operation is limited to 30 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_WORKSPACE
    importing
      !I_WORKSPACE_ID type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List intents</p>
    "!   List the intents for a workspace.<br/>
    "!   <br/>
    "!   With **export**=`false`, this operation is limited to 2000 requests per 30
    "!    minutes. With **export**=`true`, the limit is 400 requests per 30 minutes. For
    "!    more information, see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_EXPORT |
    "!   Whether to include all element content in the returned data. If
    "!    **export**=`false`, the returned data includes only information about the
    "!    element itself. If **export**=`true`, all content, including subelements, is
    "!    included.
    "! @parameter I_PAGE_LIMIT |
    "!   The number of records to return in each page of results.
    "! @parameter I_SORT |
    "!   The attribute by which returned intents will be sorted. To reverse the sort
    "!    order, prefix the value with a minus sign (`-`).
    "! @parameter I_CURSOR |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_INTENT_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_INTENTS
    importing
      !I_WORKSPACE_ID type STRING
      !I_EXPORT type BOOLEAN default c_boolean_false
      !I_PAGE_LIMIT type INTEGER optional
      !I_SORT type STRING optional
      !I_CURSOR type STRING optional
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_INTENT_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create intent</p>
    "!   Create a new intent.<br/>
    "!   <br/>
    "!   If you want to create multiple intents with a single API call, consider using
    "!    the **[Update workspace](#update-workspace)** method instead.<br/>
    "!   <br/>
    "!   This operation is limited to 2000 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_BODY |
    "!   The content of the new intent.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_INTENT
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_INTENT
    importing
      !I_WORKSPACE_ID type STRING
      !I_BODY type T_CREATE_INTENT
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_INTENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get intent</p>
    "!   Get information about an intent, optionally including all intent content.<br/>
    "!   <br/>
    "!   With **export**=`false`, this operation is limited to 6000 requests per 5
    "!    minutes. With **export**=`true`, the limit is 400 requests per 30 minutes. For
    "!    more information, see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_INTENT |
    "!   The intent name.
    "! @parameter I_EXPORT |
    "!   Whether to include all element content in the returned data. If
    "!    **export**=`false`, the returned data includes only information about the
    "!    element itself. If **export**=`true`, all content, including subelements, is
    "!    included.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_INTENT
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_INTENT
    importing
      !I_WORKSPACE_ID type STRING
      !I_INTENT type STRING
      !I_EXPORT type BOOLEAN default c_boolean_false
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_INTENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update intent</p>
    "!   Update an existing intent with new or modified data. You must provide component
    "!    objects defining the content of the updated intent.<br/>
    "!   <br/>
    "!   If you want to update multiple intents with a single API call, consider using
    "!    the **[Update workspace](#update-workspace)** method instead.<br/>
    "!   <br/>
    "!   This operation is limited to 2000 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_INTENT |
    "!   The intent name.
    "! @parameter I_BODY |
    "!   The updated content of the intent.<br/>
    "!   <br/>
    "!   Any elements included in the new data will completely replace the equivalent
    "!    existing elements, including all subelements. (Previously existing subelements
    "!    are not retained unless they are also included in the new data.) For example,
    "!    if you update the user input examples for an intent, the previously existing
    "!    examples are discarded and replaced with the new examples specified in the
    "!    update.
    "! @parameter I_APPEND |
    "!   Whether the new data is to be appended to the existing data in the object. If
    "!    **append**=`false`, elements included in the new data completely replace the
    "!    corresponding existing elements, including all subelements. For example, if the
    "!    new data for the intent includes **examples** and **append**=`false`, all
    "!    existing examples for the intent are discarded and replaced with the new
    "!    examples.<br/>
    "!   <br/>
    "!   If **append**=`true`, existing elements are preserved, and the new elements are
    "!    added. If any elements in the new data collide with existing elements, the
    "!    update request fails.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_INTENT
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_INTENT
    importing
      !I_WORKSPACE_ID type STRING
      !I_INTENT type STRING
      !I_BODY type T_UPDATE_INTENT
      !I_APPEND type BOOLEAN default c_boolean_false
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_INTENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete intent</p>
    "!   Delete an intent from a workspace.<br/>
    "!   <br/>
    "!   This operation is limited to 2000 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_INTENT |
    "!   The intent name.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_INTENT
    importing
      !I_WORKSPACE_ID type STRING
      !I_INTENT type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List user input examples</p>
    "!   List the user input examples for an intent, optionally including contextual
    "!    entity mentions.<br/>
    "!   <br/>
    "!   This operation is limited to 2500 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_INTENT |
    "!   The intent name.
    "! @parameter I_PAGE_LIMIT |
    "!   The number of records to return in each page of results.
    "! @parameter I_SORT |
    "!   The attribute by which returned examples will be sorted. To reverse the sort
    "!    order, prefix the value with a minus sign (`-`).
    "! @parameter I_CURSOR |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_EXAMPLE_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_EXAMPLES
    importing
      !I_WORKSPACE_ID type STRING
      !I_INTENT type STRING
      !I_PAGE_LIMIT type INTEGER optional
      !I_SORT type STRING optional
      !I_CURSOR type STRING optional
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_EXAMPLE_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create user input example</p>
    "!   Add a new user input example to an intent.<br/>
    "!   <br/>
    "!   If you want to add multiple exaples with a single API call, consider using the
    "!    **[Update intent](#update-intent)** method instead.<br/>
    "!   <br/>
    "!   This operation is limited to 1000 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_INTENT |
    "!   The intent name.
    "! @parameter I_BODY |
    "!   The content of the new user input example.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_EXAMPLE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_EXAMPLE
    importing
      !I_WORKSPACE_ID type STRING
      !I_INTENT type STRING
      !I_BODY type T_EXAMPLE
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_EXAMPLE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get user input example</p>
    "!   Get information about a user input example.<br/>
    "!   <br/>
    "!   This operation is limited to 6000 requests per 5 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_INTENT |
    "!   The intent name.
    "! @parameter I_TEXT |
    "!   The text of the user input example.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_EXAMPLE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_EXAMPLE
    importing
      !I_WORKSPACE_ID type STRING
      !I_INTENT type STRING
      !I_TEXT type STRING
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_EXAMPLE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update user input example</p>
    "!   Update the text of a user input example.<br/>
    "!   <br/>
    "!   If you want to update multiple examples with a single API call, consider using
    "!    the **[Update intent](#update-intent)** method instead.<br/>
    "!   <br/>
    "!   This operation is limited to 1000 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_INTENT |
    "!   The intent name.
    "! @parameter I_TEXT |
    "!   The text of the user input example.
    "! @parameter I_BODY |
    "!   The new text of the user input example.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_EXAMPLE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_EXAMPLE
    importing
      !I_WORKSPACE_ID type STRING
      !I_INTENT type STRING
      !I_TEXT type STRING
      !I_BODY type T_UPDATE_EXAMPLE
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_EXAMPLE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete user input example</p>
    "!   Delete a user input example from an intent.<br/>
    "!   <br/>
    "!   This operation is limited to 1000 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_INTENT |
    "!   The intent name.
    "! @parameter I_TEXT |
    "!   The text of the user input example.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_EXAMPLE
    importing
      !I_WORKSPACE_ID type STRING
      !I_INTENT type STRING
      !I_TEXT type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List counterexamples</p>
    "!   List the counterexamples for a workspace. Counterexamples are examples that have
    "!    been marked as irrelevant input.<br/>
    "!   <br/>
    "!   This operation is limited to 2500 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_PAGE_LIMIT |
    "!   The number of records to return in each page of results.
    "! @parameter I_SORT |
    "!   The attribute by which returned counterexamples will be sorted. To reverse the
    "!    sort order, prefix the value with a minus sign (`-`).
    "! @parameter I_CURSOR |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COUNTEREXAMPLE_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_COUNTEREXAMPLES
    importing
      !I_WORKSPACE_ID type STRING
      !I_PAGE_LIMIT type INTEGER optional
      !I_SORT type STRING optional
      !I_CURSOR type STRING optional
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COUNTEREXAMPLE_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create counterexample</p>
    "!   Add a new counterexample to a workspace. Counterexamples are examples that have
    "!    been marked as irrelevant input.<br/>
    "!   <br/>
    "!   If you want to add multiple counterexamples with a single API call, consider
    "!    using the **[Update workspace](#update-workspace)** method instead.<br/>
    "!   <br/>
    "!   This operation is limited to 1000 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_BODY |
    "!   The content of the new counterexample.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COUNTEREXAMPLE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_COUNTEREXAMPLE
    importing
      !I_WORKSPACE_ID type STRING
      !I_BODY type T_COUNTEREXAMPLE
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COUNTEREXAMPLE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get counterexample</p>
    "!   Get information about a counterexample. Counterexamples are examples that have
    "!    been marked as irrelevant input.<br/>
    "!   <br/>
    "!   This operation is limited to 6000 requests per 5 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_TEXT |
    "!   The text of a user input counterexample (for example, `What are you wearing?`).
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COUNTEREXAMPLE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_COUNTEREXAMPLE
    importing
      !I_WORKSPACE_ID type STRING
      !I_TEXT type STRING
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COUNTEREXAMPLE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update counterexample</p>
    "!   Update the text of a counterexample. Counterexamples are examples that have been
    "!    marked as irrelevant input.<br/>
    "!   <br/>
    "!   If you want to update multiple counterexamples with a single API call, consider
    "!    using the **[Update workspace](#update-workspace)** method instead.<br/>
    "!   <br/>
    "!   This operation is limited to 1000 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_TEXT |
    "!   The text of a user input counterexample (for example, `What are you wearing?`).
    "! @parameter I_BODY |
    "!   The text of the counterexample.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COUNTEREXAMPLE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_COUNTEREXAMPLE
    importing
      !I_WORKSPACE_ID type STRING
      !I_TEXT type STRING
      !I_BODY type T_UPDATE_COUNTEREXAMPLE
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COUNTEREXAMPLE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete counterexample</p>
    "!   Delete a counterexample from a workspace. Counterexamples are examples that have
    "!    been marked as irrelevant input.<br/>
    "!   <br/>
    "!   This operation is limited to 1000 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_TEXT |
    "!   The text of a user input counterexample (for example, `What are you wearing?`).
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_COUNTEREXAMPLE
    importing
      !I_WORKSPACE_ID type STRING
      !I_TEXT type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List entities</p>
    "!   List the entities for a workspace.<br/>
    "!   <br/>
    "!   With **export**=`false`, this operation is limited to 1000 requests per 30
    "!    minutes. With **export**=`true`, the limit is 200 requests per 30 minutes. For
    "!    more information, see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_EXPORT |
    "!   Whether to include all element content in the returned data. If
    "!    **export**=`false`, the returned data includes only information about the
    "!    element itself. If **export**=`true`, all content, including subelements, is
    "!    included.
    "! @parameter I_PAGE_LIMIT |
    "!   The number of records to return in each page of results.
    "! @parameter I_SORT |
    "!   The attribute by which returned entities will be sorted. To reverse the sort
    "!    order, prefix the value with a minus sign (`-`).
    "! @parameter I_CURSOR |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENTITY_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_ENTITIES
    importing
      !I_WORKSPACE_ID type STRING
      !I_EXPORT type BOOLEAN default c_boolean_false
      !I_PAGE_LIMIT type INTEGER optional
      !I_SORT type STRING optional
      !I_CURSOR type STRING optional
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENTITY_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create entity</p>
    "!   Create a new entity, or enable a system entity.<br/>
    "!   <br/>
    "!   If you want to create multiple entities with a single API call, consider using
    "!    the **[Update workspace](#update-workspace)** method instead.<br/>
    "!   <br/>
    "!   This operation is limited to 1000 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_BODY |
    "!   The content of the new entity.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENTITY
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_ENTITY
    importing
      !I_WORKSPACE_ID type STRING
      !I_BODY type T_CREATE_ENTITY
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENTITY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get entity</p>
    "!   Get information about an entity, optionally including all entity content.<br/>
    "!   <br/>
    "!   With **export**=`false`, this operation is limited to 6000 requests per 5
    "!    minutes. With **export**=`true`, the limit is 200 requests per 30 minutes. For
    "!    more information, see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_ENTITY |
    "!   The name of the entity.
    "! @parameter I_EXPORT |
    "!   Whether to include all element content in the returned data. If
    "!    **export**=`false`, the returned data includes only information about the
    "!    element itself. If **export**=`true`, all content, including subelements, is
    "!    included.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENTITY
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_ENTITY
    importing
      !I_WORKSPACE_ID type STRING
      !I_ENTITY type STRING
      !I_EXPORT type BOOLEAN default c_boolean_false
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENTITY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update entity</p>
    "!   Update an existing entity with new or modified data. You must provide component
    "!    objects defining the content of the updated entity.<br/>
    "!   <br/>
    "!   If you want to update multiple entities with a single API call, consider using
    "!    the **[Update workspace](#update-workspace)** method instead.<br/>
    "!   <br/>
    "!   This operation is limited to 1000 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_ENTITY |
    "!   The name of the entity.
    "! @parameter I_BODY |
    "!   The updated content of the entity. Any elements included in the new data will
    "!    completely replace the equivalent existing elements, including all subelements.
    "!    (Previously existing subelements are not retained unless they are also included
    "!    in the new data.) For example, if you update the values for an entity, the
    "!    previously existing values are discarded and replaced with the new values
    "!    specified in the update.
    "! @parameter I_APPEND |
    "!   Whether the new data is to be appended to the existing data in the entity. If
    "!    **append**=`false`, elements included in the new data completely replace the
    "!    corresponding existing elements, including all subelements. For example, if the
    "!    new data for the entity includes **values** and **append**=`false`, all
    "!    existing values for the entity are discarded and replaced with the new
    "!    values.<br/>
    "!   <br/>
    "!   If **append**=`true`, existing elements are preserved, and the new elements are
    "!    added. If any elements in the new data collide with existing elements, the
    "!    update request fails.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENTITY
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_ENTITY
    importing
      !I_WORKSPACE_ID type STRING
      !I_ENTITY type STRING
      !I_BODY type T_UPDATE_ENTITY
      !I_APPEND type BOOLEAN default c_boolean_false
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENTITY
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete entity</p>
    "!   Delete an entity from a workspace, or disable a system entity.<br/>
    "!   <br/>
    "!   This operation is limited to 1000 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_ENTITY |
    "!   The name of the entity.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_ENTITY
    importing
      !I_WORKSPACE_ID type STRING
      !I_ENTITY type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List entity mentions</p>
    "!   List mentions for a contextual entity. An entity mention is an occurrence of a
    "!    contextual entity in the context of an intent user input example.<br/>
    "!   <br/>
    "!   This operation is limited to 200 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_ENTITY |
    "!   The name of the entity.
    "! @parameter I_EXPORT |
    "!   Whether to include all element content in the returned data. If
    "!    **export**=`false`, the returned data includes only information about the
    "!    element itself. If **export**=`true`, all content, including subelements, is
    "!    included.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENTITY_MENTION_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_MENTIONS
    importing
      !I_WORKSPACE_ID type STRING
      !I_ENTITY type STRING
      !I_EXPORT type BOOLEAN default c_boolean_false
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENTITY_MENTION_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List entity values</p>
    "!   List the values for an entity.<br/>
    "!   <br/>
    "!   This operation is limited to 2500 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_ENTITY |
    "!   The name of the entity.
    "! @parameter I_EXPORT |
    "!   Whether to include all element content in the returned data. If
    "!    **export**=`false`, the returned data includes only information about the
    "!    element itself. If **export**=`true`, all content, including subelements, is
    "!    included.
    "! @parameter I_PAGE_LIMIT |
    "!   The number of records to return in each page of results.
    "! @parameter I_SORT |
    "!   The attribute by which returned entity values will be sorted. To reverse the
    "!    sort order, prefix the value with a minus sign (`-`).
    "! @parameter I_CURSOR |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_VALUE_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_VALUES
    importing
      !I_WORKSPACE_ID type STRING
      !I_ENTITY type STRING
      !I_EXPORT type BOOLEAN default c_boolean_false
      !I_PAGE_LIMIT type INTEGER optional
      !I_SORT type STRING optional
      !I_CURSOR type STRING optional
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_VALUE_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create entity value</p>
    "!   Create a new value for an entity.<br/>
    "!   <br/>
    "!   If you want to create multiple entity values with a single API call, consider
    "!    using the **[Update entity](#update-entity)** method instead.<br/>
    "!   <br/>
    "!   This operation is limited to 1000 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_ENTITY |
    "!   The name of the entity.
    "! @parameter I_BODY |
    "!   The new entity value.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_VALUE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_VALUE
    importing
      !I_WORKSPACE_ID type STRING
      !I_ENTITY type STRING
      !I_BODY type T_CREATE_VALUE
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_VALUE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get entity value</p>
    "!   Get information about an entity value.<br/>
    "!   <br/>
    "!   This operation is limited to 6000 requests per 5 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_ENTITY |
    "!   The name of the entity.
    "! @parameter I_VALUE |
    "!   The text of the entity value.
    "! @parameter I_EXPORT |
    "!   Whether to include all element content in the returned data. If
    "!    **export**=`false`, the returned data includes only information about the
    "!    element itself. If **export**=`true`, all content, including subelements, is
    "!    included.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_VALUE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_VALUE
    importing
      !I_WORKSPACE_ID type STRING
      !I_ENTITY type STRING
      !I_VALUE type STRING
      !I_EXPORT type BOOLEAN default c_boolean_false
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_VALUE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update entity value</p>
    "!   Update an existing entity value with new or modified data. You must provide
    "!    component objects defining the content of the updated entity value.<br/>
    "!   <br/>
    "!   If you want to update multiple entity values with a single API call, consider
    "!    using the **[Update entity](#update-entity)** method instead.<br/>
    "!   <br/>
    "!   This operation is limited to 1000 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_ENTITY |
    "!   The name of the entity.
    "! @parameter I_VALUE |
    "!   The text of the entity value.
    "! @parameter I_BODY |
    "!   The updated content of the entity value.<br/>
    "!   <br/>
    "!   Any elements included in the new data will completely replace the equivalent
    "!    existing elements, including all subelements. (Previously existing subelements
    "!    are not retained unless they are also included in the new data.) For example,
    "!    if you update the synonyms for an entity value, the previously existing
    "!    synonyms are discarded and replaced with the new synonyms specified in the
    "!    update.
    "! @parameter I_APPEND |
    "!   Whether the new data is to be appended to the existing data in the entity value.
    "!    If **append**=`false`, elements included in the new data completely replace the
    "!    corresponding existing elements, including all subelements. For example, if the
    "!    new data for the entity value includes **synonyms** and **append**=`false`, all
    "!    existing synonyms for the entity value are discarded and replaced with the new
    "!    synonyms.<br/>
    "!   <br/>
    "!   If **append**=`true`, existing elements are preserved, and the new elements are
    "!    added. If any elements in the new data collide with existing elements, the
    "!    update request fails.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_VALUE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_VALUE
    importing
      !I_WORKSPACE_ID type STRING
      !I_ENTITY type STRING
      !I_VALUE type STRING
      !I_BODY type T_UPDATE_VALUE
      !I_APPEND type BOOLEAN default c_boolean_false
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_VALUE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete entity value</p>
    "!   Delete a value from an entity.<br/>
    "!   <br/>
    "!   This operation is limited to 1000 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_ENTITY |
    "!   The name of the entity.
    "! @parameter I_VALUE |
    "!   The text of the entity value.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_VALUE
    importing
      !I_WORKSPACE_ID type STRING
      !I_ENTITY type STRING
      !I_VALUE type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List entity value synonyms</p>
    "!   List the synonyms for an entity value.<br/>
    "!   <br/>
    "!   This operation is limited to 2500 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_ENTITY |
    "!   The name of the entity.
    "! @parameter I_VALUE |
    "!   The text of the entity value.
    "! @parameter I_PAGE_LIMIT |
    "!   The number of records to return in each page of results.
    "! @parameter I_SORT |
    "!   The attribute by which returned entity value synonyms will be sorted. To reverse
    "!    the sort order, prefix the value with a minus sign (`-`).
    "! @parameter I_CURSOR |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SYNONYM_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_SYNONYMS
    importing
      !I_WORKSPACE_ID type STRING
      !I_ENTITY type STRING
      !I_VALUE type STRING
      !I_PAGE_LIMIT type INTEGER optional
      !I_SORT type STRING optional
      !I_CURSOR type STRING optional
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SYNONYM_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create entity value synonym</p>
    "!   Add a new synonym to an entity value.<br/>
    "!   <br/>
    "!   If you want to create multiple synonyms with a single API call, consider using
    "!    the **[Update entity](#update-entity)** or **[Update entity
    "!    value](#update-entity-value)** method instead.<br/>
    "!   <br/>
    "!   This operation is limited to 1000 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_ENTITY |
    "!   The name of the entity.
    "! @parameter I_VALUE |
    "!   The text of the entity value.
    "! @parameter I_BODY |
    "!   The new synonym.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SYNONYM
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_SYNONYM
    importing
      !I_WORKSPACE_ID type STRING
      !I_ENTITY type STRING
      !I_VALUE type STRING
      !I_BODY type T_SYNONYM
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SYNONYM
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get entity value synonym</p>
    "!   Get information about a synonym of an entity value.<br/>
    "!   <br/>
    "!   This operation is limited to 6000 requests per 5 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_ENTITY |
    "!   The name of the entity.
    "! @parameter I_VALUE |
    "!   The text of the entity value.
    "! @parameter I_SYNONYM |
    "!   The text of the synonym.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SYNONYM
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_SYNONYM
    importing
      !I_WORKSPACE_ID type STRING
      !I_ENTITY type STRING
      !I_VALUE type STRING
      !I_SYNONYM type STRING
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SYNONYM
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update entity value synonym</p>
    "!   Update an existing entity value synonym with new text.<br/>
    "!   <br/>
    "!   If you want to update multiple synonyms with a single API call, consider using
    "!    the **[Update entity](#update-entity)** or **[Update entity
    "!    value](#update-entity-value)** method instead.<br/>
    "!   <br/>
    "!   This operation is limited to 1000 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_ENTITY |
    "!   The name of the entity.
    "! @parameter I_VALUE |
    "!   The text of the entity value.
    "! @parameter I_SYNONYM |
    "!   The text of the synonym.
    "! @parameter I_BODY |
    "!   The updated entity value synonym.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SYNONYM
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_SYNONYM
    importing
      !I_WORKSPACE_ID type STRING
      !I_ENTITY type STRING
      !I_VALUE type STRING
      !I_SYNONYM type STRING
      !I_BODY type T_UPDATE_SYNONYM
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SYNONYM
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete entity value synonym</p>
    "!   Delete a synonym from an entity value.<br/>
    "!   <br/>
    "!   This operation is limited to 1000 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_ENTITY |
    "!   The name of the entity.
    "! @parameter I_VALUE |
    "!   The text of the entity value.
    "! @parameter I_SYNONYM |
    "!   The text of the synonym.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_SYNONYM
    importing
      !I_WORKSPACE_ID type STRING
      !I_ENTITY type STRING
      !I_VALUE type STRING
      !I_SYNONYM type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List dialog nodes</p>
    "!   List the dialog nodes for a workspace.<br/>
    "!   <br/>
    "!   This operation is limited to 2500 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_PAGE_LIMIT |
    "!   The number of records to return in each page of results.
    "! @parameter I_SORT |
    "!   The attribute by which returned dialog nodes will be sorted. To reverse the sort
    "!    order, prefix the value with a minus sign (`-`).
    "! @parameter I_CURSOR |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DIALOG_NODE_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_DIALOG_NODES
    importing
      !I_WORKSPACE_ID type STRING
      !I_PAGE_LIMIT type INTEGER optional
      !I_SORT type STRING optional
      !I_CURSOR type STRING optional
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DIALOG_NODE_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create dialog node</p>
    "!   Create a new dialog node.<br/>
    "!   <br/>
    "!   If you want to create multiple dialog nodes with a single API call, consider
    "!    using the **[Update workspace](#update-workspace)** method instead.<br/>
    "!   <br/>
    "!   This operation is limited to 500 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_BODY |
    "!   A CreateDialogNode object defining the content of the new dialog node.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DIALOG_NODE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_DIALOG_NODE
    importing
      !I_WORKSPACE_ID type STRING
      !I_BODY type T_DIALOG_NODE
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DIALOG_NODE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get dialog node</p>
    "!   Get information about a dialog node.<br/>
    "!   <br/>
    "!   This operation is limited to 6000 requests per 5 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_DIALOG_NODE |
    "!   The dialog node ID (for example, `get_order`).
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DIALOG_NODE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_DIALOG_NODE
    importing
      !I_WORKSPACE_ID type STRING
      !I_DIALOG_NODE type STRING
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DIALOG_NODE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update dialog node</p>
    "!   Update an existing dialog node with new or modified data.<br/>
    "!   <br/>
    "!   If you want to update multiple dialog nodes with a single API call, consider
    "!    using the **[Update workspace](#update-workspace)** method instead.<br/>
    "!   <br/>
    "!   This operation is limited to 500 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_DIALOG_NODE |
    "!   The dialog node ID (for example, `get_order`).
    "! @parameter I_BODY |
    "!   The updated content of the dialog node.<br/>
    "!   <br/>
    "!   Any elements included in the new data will completely replace the equivalent
    "!    existing elements, including all subelements. (Previously existing subelements
    "!    are not retained unless they are also included in the new data.) For example,
    "!    if you update the actions for a dialog node, the previously existing actions
    "!    are discarded and replaced with the new actions specified in the update.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_DIALOG_NODE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_DIALOG_NODE
    importing
      !I_WORKSPACE_ID type STRING
      !I_DIALOG_NODE type STRING
      !I_BODY type T_UPDATE_DIALOG_NODE
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_DIALOG_NODE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete dialog node</p>
    "!   Delete a dialog node from a workspace.<br/>
    "!   <br/>
    "!   This operation is limited to 500 requests per 30 minutes. For more information,
    "!    see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_DIALOG_NODE |
    "!   The dialog node ID (for example, `get_order`).
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_DIALOG_NODE
    importing
      !I_WORKSPACE_ID type STRING
      !I_DIALOG_NODE type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List log events in a workspace</p>
    "!   List the events from the log of a specific workspace.<br/>
    "!   <br/>
    "!   If **cursor** is not specified, this operation is limited to 40 requests per 30
    "!    minutes. If **cursor** is specified, the limit is 120 requests per minute. For
    "!    more information, see **Rate limiting**.
    "!
    "! @parameter I_WORKSPACE_ID |
    "!   Unique identifier of the workspace.
    "! @parameter I_SORT |
    "!   How to sort the returned log events. You can sort by **request_timestamp**. To
    "!    reverse the sort order, prefix the parameter value with a minus sign (`-`).
    "! @parameter I_FILTER |
    "!   A cacheable parameter that limits the results to those matching the specified
    "!    filter. For more information, see the
    "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-filter-ref
    "!   erence#filter-reference).
    "! @parameter I_PAGE_LIMIT |
    "!   The number of records to return in each page of results.
    "! @parameter I_CURSOR |
    "!   A token identifying the page of results to retrieve.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LOG_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_LOGS
    importing
      !I_WORKSPACE_ID type STRING
      !I_SORT type STRING optional
      !I_FILTER type STRING optional
      !I_PAGE_LIMIT type INTEGER optional
      !I_CURSOR type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LOG_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List log events in all workspaces</p>
    "!   List the events from the logs of all workspaces in the service instance.<br/>
    "!   <br/>
    "!   If **cursor** is not specified, this operation is limited to 40 requests per 30
    "!    minutes. If **cursor** is specified, the limit is 120 requests per minute. For
    "!    more information, see **Rate limiting**.
    "!
    "! @parameter I_FILTER |
    "!   A cacheable parameter that limits the results to those matching the specified
    "!    filter. You must specify a filter query that includes a value for `language`,
    "!    as well as a value for `request.context.system.assistant_id`, `workspace_id`,
    "!    or `request.context.metadata.deployment`. For more information, see the
    "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-filter-ref
    "!   erence#filter-reference).
    "! @parameter I_SORT |
    "!   How to sort the returned log events. You can sort by **request_timestamp**. To
    "!    reverse the sort order, prefix the parameter value with a minus sign (`-`).
    "! @parameter I_PAGE_LIMIT |
    "!   The number of records to return in each page of results.
    "! @parameter I_CURSOR |
    "!   A token identifying the page of results to retrieve.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LOG_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_ALL_LOGS
    importing
      !I_FILTER type STRING
      !I_SORT type STRING optional
      !I_PAGE_LIMIT type INTEGER optional
      !I_CURSOR type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LOG_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Delete labeled data</p>
    "!   Deletes all data associated with a specified customer ID. The method has no
    "!    effect if no data is associated with the customer ID. <br/>
    "!   <br/>
    "!   You associate a customer ID with data by passing the `X-Watson-Metadata` header
    "!    with a request that passes data. For more information about personal data and
    "!    customer IDs, see [Information
    "!    security](https://cloud.ibm.com/docs/assistant?topic=assistant-information-secu
    "!   rity#information-security).<br/>
    "!   <br/>
    "!   This operation is limited to 4 requests per minute. For more information, see
    "!    **Rate limiting**.
    "!
    "! @parameter I_CUSTOMER_ID |
    "!   The customer ID for which all data is to be deleted.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_USER_DATA
    importing
      !I_CUSTOMER_ID type STRING
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

  e_request_prop = super->get_request_prop( i_auth_method = i_auth_method ).

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

    e_sdk_version_date = '20200310173420'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V1->MESSAGE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_BODY        TYPE T_MESSAGE_REQUEST(optional)
* | [--->] I_NODES_VISITED_DETAILS        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_NODES_VISITED_DETAILS is supplied.
    lv_queryparam = i_NODES_VISITED_DETAILS.
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
    if not i_BODY is initial.
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
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
* | [--->] I_PAGE_LIMIT        TYPE INTEGER(optional)
* | [--->] I_SORT        TYPE STRING(optional)
* | [--->] I_CURSOR        TYPE STRING(optional)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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

    if i_PAGE_LIMIT is supplied.
    lv_queryparam = i_PAGE_LIMIT.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SORT is supplied.
    lv_queryparam = escape( val = i_SORT format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CURSOR is supplied.
    lv_queryparam = escape( val = i_CURSOR format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
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
* | [--->] I_BODY        TYPE T_CREATE_WORKSPACE(optional)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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

    " process query parameters
    data:
      lv_queryparam type string.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
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
    if not i_BODY is initial.
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_EXPORT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_SORT        TYPE STRING(optional)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_EXPORT is supplied.
    lv_queryparam = i_EXPORT.
    add_query_parameter(
      exporting
        i_parameter  = `export`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SORT is supplied.
    lv_queryparam = escape( val = i_SORT format = cl_abap_format=>e_uri_full ).
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_BODY        TYPE T_UPDATE_WORKSPACE(optional)
* | [--->] I_APPEND        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_APPEND is supplied.
    lv_queryparam = i_APPEND.
    add_query_parameter(
      exporting
        i_parameter  = `append`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
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
    if not i_BODY is initial.
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.

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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_EXPORT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_PAGE_LIMIT        TYPE INTEGER(optional)
* | [--->] I_SORT        TYPE STRING(optional)
* | [--->] I_CURSOR        TYPE STRING(optional)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_EXPORT is supplied.
    lv_queryparam = i_EXPORT.
    add_query_parameter(
      exporting
        i_parameter  = `export`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_PAGE_LIMIT is supplied.
    lv_queryparam = i_PAGE_LIMIT.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SORT is supplied.
    lv_queryparam = escape( val = i_SORT format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CURSOR is supplied.
    lv_queryparam = escape( val = i_CURSOR format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_BODY        TYPE T_CREATE_INTENT
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
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
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_INTENT        TYPE STRING
* | [--->] I_EXPORT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{intent}` in ls_request_prop-url-path with i_INTENT ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_EXPORT is supplied.
    lv_queryparam = i_EXPORT.
    add_query_parameter(
      exporting
        i_parameter  = `export`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_INTENT        TYPE STRING
* | [--->] I_BODY        TYPE T_UPDATE_INTENT
* | [--->] I_APPEND        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{intent}` in ls_request_prop-url-path with i_INTENT ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_APPEND is supplied.
    lv_queryparam = i_APPEND.
    add_query_parameter(
      exporting
        i_parameter  = `append`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
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
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_INTENT        TYPE STRING
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{intent}` in ls_request_prop-url-path with i_INTENT ignoring case.

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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_INTENT        TYPE STRING
* | [--->] I_PAGE_LIMIT        TYPE INTEGER(optional)
* | [--->] I_SORT        TYPE STRING(optional)
* | [--->] I_CURSOR        TYPE STRING(optional)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{intent}` in ls_request_prop-url-path with i_INTENT ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_PAGE_LIMIT is supplied.
    lv_queryparam = i_PAGE_LIMIT.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SORT is supplied.
    lv_queryparam = escape( val = i_SORT format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CURSOR is supplied.
    lv_queryparam = escape( val = i_CURSOR format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_INTENT        TYPE STRING
* | [--->] I_BODY        TYPE T_EXAMPLE
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{intent}` in ls_request_prop-url-path with i_INTENT ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
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
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_INTENT        TYPE STRING
* | [--->] I_TEXT        TYPE STRING
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{intent}` in ls_request_prop-url-path with i_INTENT ignoring case.
    replace all occurrences of `{text}` in ls_request_prop-url-path with i_TEXT ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_INTENT        TYPE STRING
* | [--->] I_TEXT        TYPE STRING
* | [--->] I_BODY        TYPE T_UPDATE_EXAMPLE
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{intent}` in ls_request_prop-url-path with i_INTENT ignoring case.
    replace all occurrences of `{text}` in ls_request_prop-url-path with i_TEXT ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
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
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_INTENT        TYPE STRING
* | [--->] I_TEXT        TYPE STRING
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{intent}` in ls_request_prop-url-path with i_INTENT ignoring case.
    replace all occurrences of `{text}` in ls_request_prop-url-path with i_TEXT ignoring case.

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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_PAGE_LIMIT        TYPE INTEGER(optional)
* | [--->] I_SORT        TYPE STRING(optional)
* | [--->] I_CURSOR        TYPE STRING(optional)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_PAGE_LIMIT is supplied.
    lv_queryparam = i_PAGE_LIMIT.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SORT is supplied.
    lv_queryparam = escape( val = i_SORT format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CURSOR is supplied.
    lv_queryparam = escape( val = i_CURSOR format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_BODY        TYPE T_COUNTEREXAMPLE
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
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
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_TEXT        TYPE STRING
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{text}` in ls_request_prop-url-path with i_TEXT ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_TEXT        TYPE STRING
* | [--->] I_BODY        TYPE T_UPDATE_COUNTEREXAMPLE
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{text}` in ls_request_prop-url-path with i_TEXT ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
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
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_TEXT        TYPE STRING
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{text}` in ls_request_prop-url-path with i_TEXT ignoring case.

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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_EXPORT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_PAGE_LIMIT        TYPE INTEGER(optional)
* | [--->] I_SORT        TYPE STRING(optional)
* | [--->] I_CURSOR        TYPE STRING(optional)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_EXPORT is supplied.
    lv_queryparam = i_EXPORT.
    add_query_parameter(
      exporting
        i_parameter  = `export`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_PAGE_LIMIT is supplied.
    lv_queryparam = i_PAGE_LIMIT.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SORT is supplied.
    lv_queryparam = escape( val = i_SORT format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CURSOR is supplied.
    lv_queryparam = escape( val = i_CURSOR format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_BODY        TYPE T_CREATE_ENTITY
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
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
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_ENTITY        TYPE STRING
* | [--->] I_EXPORT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_ENTITY ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_EXPORT is supplied.
    lv_queryparam = i_EXPORT.
    add_query_parameter(
      exporting
        i_parameter  = `export`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_ENTITY        TYPE STRING
* | [--->] I_BODY        TYPE T_UPDATE_ENTITY
* | [--->] I_APPEND        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_ENTITY ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_APPEND is supplied.
    lv_queryparam = i_APPEND.
    add_query_parameter(
      exporting
        i_parameter  = `append`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
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
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_ENTITY        TYPE STRING
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_ENTITY ignoring case.

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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_ENTITY        TYPE STRING
* | [--->] I_EXPORT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_ENTITY ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_EXPORT is supplied.
    lv_queryparam = i_EXPORT.
    add_query_parameter(
      exporting
        i_parameter  = `export`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_ENTITY        TYPE STRING
* | [--->] I_EXPORT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_PAGE_LIMIT        TYPE INTEGER(optional)
* | [--->] I_SORT        TYPE STRING(optional)
* | [--->] I_CURSOR        TYPE STRING(optional)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_ENTITY ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_EXPORT is supplied.
    lv_queryparam = i_EXPORT.
    add_query_parameter(
      exporting
        i_parameter  = `export`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_PAGE_LIMIT is supplied.
    lv_queryparam = i_PAGE_LIMIT.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SORT is supplied.
    lv_queryparam = escape( val = i_SORT format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CURSOR is supplied.
    lv_queryparam = escape( val = i_CURSOR format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_ENTITY        TYPE STRING
* | [--->] I_BODY        TYPE T_CREATE_VALUE
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_ENTITY ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
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
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_ENTITY        TYPE STRING
* | [--->] I_VALUE        TYPE STRING
* | [--->] I_EXPORT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_ENTITY ignoring case.
    replace all occurrences of `{value}` in ls_request_prop-url-path with i_VALUE ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_EXPORT is supplied.
    lv_queryparam = i_EXPORT.
    add_query_parameter(
      exporting
        i_parameter  = `export`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_ENTITY        TYPE STRING
* | [--->] I_VALUE        TYPE STRING
* | [--->] I_BODY        TYPE T_UPDATE_VALUE
* | [--->] I_APPEND        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_ENTITY ignoring case.
    replace all occurrences of `{value}` in ls_request_prop-url-path with i_VALUE ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_APPEND is supplied.
    lv_queryparam = i_APPEND.
    add_query_parameter(
      exporting
        i_parameter  = `append`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
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
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_ENTITY        TYPE STRING
* | [--->] I_VALUE        TYPE STRING
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_ENTITY ignoring case.
    replace all occurrences of `{value}` in ls_request_prop-url-path with i_VALUE ignoring case.

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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_ENTITY        TYPE STRING
* | [--->] I_VALUE        TYPE STRING
* | [--->] I_PAGE_LIMIT        TYPE INTEGER(optional)
* | [--->] I_SORT        TYPE STRING(optional)
* | [--->] I_CURSOR        TYPE STRING(optional)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_ENTITY ignoring case.
    replace all occurrences of `{value}` in ls_request_prop-url-path with i_VALUE ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_PAGE_LIMIT is supplied.
    lv_queryparam = i_PAGE_LIMIT.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SORT is supplied.
    lv_queryparam = escape( val = i_SORT format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CURSOR is supplied.
    lv_queryparam = escape( val = i_CURSOR format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_ENTITY        TYPE STRING
* | [--->] I_VALUE        TYPE STRING
* | [--->] I_BODY        TYPE T_SYNONYM
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_ENTITY ignoring case.
    replace all occurrences of `{value}` in ls_request_prop-url-path with i_VALUE ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
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
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_ENTITY        TYPE STRING
* | [--->] I_VALUE        TYPE STRING
* | [--->] I_SYNONYM        TYPE STRING
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_ENTITY ignoring case.
    replace all occurrences of `{value}` in ls_request_prop-url-path with i_VALUE ignoring case.
    replace all occurrences of `{synonym}` in ls_request_prop-url-path with i_SYNONYM ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_ENTITY        TYPE STRING
* | [--->] I_VALUE        TYPE STRING
* | [--->] I_SYNONYM        TYPE STRING
* | [--->] I_BODY        TYPE T_UPDATE_SYNONYM
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_ENTITY ignoring case.
    replace all occurrences of `{value}` in ls_request_prop-url-path with i_VALUE ignoring case.
    replace all occurrences of `{synonym}` in ls_request_prop-url-path with i_SYNONYM ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
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
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_ENTITY        TYPE STRING
* | [--->] I_VALUE        TYPE STRING
* | [--->] I_SYNONYM        TYPE STRING
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{entity}` in ls_request_prop-url-path with i_ENTITY ignoring case.
    replace all occurrences of `{value}` in ls_request_prop-url-path with i_VALUE ignoring case.
    replace all occurrences of `{synonym}` in ls_request_prop-url-path with i_SYNONYM ignoring case.

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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_PAGE_LIMIT        TYPE INTEGER(optional)
* | [--->] I_SORT        TYPE STRING(optional)
* | [--->] I_CURSOR        TYPE STRING(optional)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_PAGE_LIMIT is supplied.
    lv_queryparam = i_PAGE_LIMIT.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SORT is supplied.
    lv_queryparam = escape( val = i_SORT format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CURSOR is supplied.
    lv_queryparam = escape( val = i_CURSOR format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `cursor`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_BODY        TYPE T_DIALOG_NODE
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
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
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_DIALOG_NODE        TYPE STRING
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{dialog_node}` in ls_request_prop-url-path with i_DIALOG_NODE ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_DIALOG_NODE        TYPE STRING
* | [--->] I_BODY        TYPE T_UPDATE_DIALOG_NODE
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{dialog_node}` in ls_request_prop-url-path with i_DIALOG_NODE ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_INCLUDE_AUDIT is supplied.
    lv_queryparam = i_INCLUDE_AUDIT.
    add_query_parameter(
      exporting
        i_parameter  = `include_audit`
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
    lv_datatype = get_datatype( i_BODY ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_BODY i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'body' i_value = i_BODY ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_BODY to <lv_text>.
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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_DIALOG_NODE        TYPE STRING
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.
    replace all occurrences of `{dialog_node}` in ls_request_prop-url-path with i_DIALOG_NODE ignoring case.

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
* | [--->] I_WORKSPACE_ID        TYPE STRING
* | [--->] I_SORT        TYPE STRING(optional)
* | [--->] I_FILTER        TYPE STRING(optional)
* | [--->] I_PAGE_LIMIT        TYPE INTEGER(optional)
* | [--->] I_CURSOR        TYPE STRING(optional)
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
    replace all occurrences of `{workspace_id}` in ls_request_prop-url-path with i_WORKSPACE_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_SORT is supplied.
    lv_queryparam = escape( val = i_SORT format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_FILTER is supplied.
    lv_queryparam = escape( val = i_FILTER format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `filter`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_PAGE_LIMIT is supplied.
    lv_queryparam = i_PAGE_LIMIT.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CURSOR is supplied.
    lv_queryparam = escape( val = i_CURSOR format = cl_abap_format=>e_uri_full ).
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
* | [--->] I_FILTER        TYPE STRING
* | [--->] I_SORT        TYPE STRING(optional)
* | [--->] I_PAGE_LIMIT        TYPE INTEGER(optional)
* | [--->] I_CURSOR        TYPE STRING(optional)
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

    lv_queryparam = escape( val = i_FILTER format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `filter`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.

    if i_SORT is supplied.
    lv_queryparam = escape( val = i_SORT format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `sort`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_PAGE_LIMIT is supplied.
    lv_queryparam = i_PAGE_LIMIT.
    add_query_parameter(
      exporting
        i_parameter  = `page_limit`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CURSOR is supplied.
    lv_queryparam = escape( val = i_CURSOR format = cl_abap_format=>e_uri_full ).
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
* | [--->] I_CUSTOMER_ID        TYPE STRING
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

    lv_queryparam = escape( val = i_CUSTOMER_ID format = cl_abap_format=>e_uri_full ).
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
