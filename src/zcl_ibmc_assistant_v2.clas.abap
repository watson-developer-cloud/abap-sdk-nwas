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
"! <p class="shorttext synchronized" lang="en">Watson Assistant v2</p>
"! The IBM Watson&trade; Assistant service combines machine learning, natural
"!  language understanding, and an integrated dialog editor to create conversation
"!  flows between your apps and your users.<br/>
"! <br/>
"! The Assistant v2 API provides runtime methods your client application can use to
"!  send user input to an assistant and receive a response. <br/>
class ZCL_IBMC_ASSISTANT_V2 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Dialog log message details.</p>
    begin of T_DIALOG_LOG_MESSAGE,
      "!   The severity of the log message.
      LEVEL type STRING,
      "!   The text of the log message.
      MESSAGE type STRING,
    end of T_DIALOG_LOG_MESSAGE.
  types:
    "! No documentation available.
    begin of T_DIALOG_NODES_VISITED,
      "!   A dialog node that was triggered during processing of the input message.
      DIALOG_NODE type STRING,
      "!   The title of the dialog node.
      TITLE type STRING,
      "!   The conditions that trigger the dialog node.
      CONDITIONS type STRING,
    end of T_DIALOG_NODES_VISITED.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Additional detailed information about a message response and</p>
    "!     how it was generated.
    begin of T_MESSAGE_OUTPUT_DEBUG,
      "!   An array of objects containing detailed diagnostic information about the nodes
      "!    that were triggered during processing of the input message.
      NODES_VISITED type STANDARD TABLE OF T_DIALOG_NODES_VISITED WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of up to 50 messages logged with the request.
      LOG_MESSAGES type STANDARD TABLE OF T_DIALOG_LOG_MESSAGE WITH NON-UNIQUE DEFAULT KEY,
      "!   Assistant sets this to true when this message response concludes or interrupts a
      "!    dialog.
      BRANCH_EXITED type BOOLEAN,
      "!   When `branch_exited` is set to `true` by the Assistant, the
      "!    `branch_exited_reason` specifies whether the dialog completed by itself or got
      "!    interrupted.
      BRANCH_EXITED_REASON type STRING,
    end of T_MESSAGE_OUTPUT_DEBUG.
  types:
    "! No documentation available.
      T_EMPTY_RESPONSE type JSONOBJECT.
  types:
    "! No documentation available.
    begin of T_SESSION_RESPONSE,
      "!   The session ID.
      SESSION_ID type STRING,
    end of T_SESSION_RESPONSE.
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
    "! <p class="shorttext synchronized" lang="en">
    "!    An object describing the role played by a system entity that</p>
    "!     is specifies the beginning or end of a range recognized in the user input. This
    "!     property is included only if the new system entities are enabled for the skill.
    begin of T_RUNTIME_ENTITY_ROLE,
      "!   The relationship of the entity to the range.
      TYPE type STRING,
    end of T_RUNTIME_ENTITY_ROLE.
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
    "!    Optional properties that control how the assistant responds.</p>
    begin of T_MESSAGE_INPUT_OPTIONS,
      "!   Whether to return additional diagnostic information. Set to `true` to return
      "!    additional information under the `output.debug` key.
      DEBUG type BOOLEAN,
      "!   Whether to restart dialog processing at the root of the dialog, regardless of
      "!    any previously visited nodes. **Note:** This does not affect `turn_count` or
      "!    any other context variables.
      RESTART type BOOLEAN,
      "!   Whether to return more than one intent. Set to `true` to return all matching
      "!    intents.
      ALTERNATE_INTENTS type BOOLEAN,
      "!   Whether to return session context with the response. If you specify `true`, the
      "!    response will include the `context` property.
      RETURN_CONTEXT type BOOLEAN,
    end of T_MESSAGE_INPUT_OPTIONS.
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
    "! No documentation available.
    begin of T_CAPTURE_GROUP,
      "!   A recognized capture group for the entity.
      GROUP type STRING,
      "!   Zero-based character offsets that indicate where the entity value begins and
      "!    ends in the input text.
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
    end of T_CAPTURE_GROUP.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The entity value that was recognized in the user input.</p>
    begin of T_RUNTIME_ENTITY,
      "!   An entity detected in the input.
      ENTITY type STRING,
      "!   An array of zero-based character offsets that indicate where the detected entity
      "!    values begin and end in the input text.
      LOCATION type STANDARD TABLE OF INTEGER WITH NON-UNIQUE DEFAULT KEY,
      "!   The term in the input text that was recognized as an entity value.
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
      "!    enabled for the skill.<br/>
      "!   <br/>
      "!   For more information about how the new system entities are interpreted, see the
      "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-beta-syste
      "!   m-entities).
      INTERPRETATION type T_RT_ENTITY_INTERPRETATION,
      "!   An array of possible alternative values that the user might have intended
      "!    instead of the value returned in the **value** property. This property is
      "!    returned only for `&#64;sys-time` and `&#64;sys-date` entities when the
      "!    user&apos;s input is ambiguous.<br/>
      "!   <br/>
      "!   This property is included only if the new system entities are enabled for the
      "!    skill.
      ALTERNATIVES type STANDARD TABLE OF T_RUNTIME_ENTITY_ALTERNATIVE WITH NON-UNIQUE DEFAULT KEY,
      "!   An object describing the role played by a system entity that is specifies the
      "!    beginning or end of a range recognized in the user input. This property is
      "!    included only if the new system entities are enabled for the skill.
      ROLE type T_RUNTIME_ENTITY_ROLE,
    end of T_RUNTIME_ENTITY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An input object that includes the input text.</p>
    begin of T_MESSAGE_INPUT,
      "!   The type of user input. Currently, only text input is supported.
      MESSAGE_TYPE type STRING,
      "!   The text of the user input. This string cannot contain carriage return, newline,
      "!    or tab characters.
      TEXT type STRING,
      "!   Optional properties that control how the assistant responds.
      OPTIONS type T_MESSAGE_INPUT_OPTIONS,
      "!   Intents to use when evaluating the user input. Include intents from the previous
      "!    response to continue using those intents rather than trying to recognize
      "!    intents in the new input.
      INTENTS type STANDARD TABLE OF T_RUNTIME_INTENT WITH NON-UNIQUE DEFAULT KEY,
      "!   Entities to use when evaluating the message. Include entities from the previous
      "!    response to continue using those entities rather than detecting entities in the
      "!    new input.
      ENTITIES type STANDARD TABLE OF T_RUNTIME_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      "!   For internal use only.
      SUGGESTION_ID type STRING,
    end of T_MESSAGE_INPUT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object defining the message input to be sent to the</p>
    "!     assistant if the user selects the corresponding option.
    begin of T_DIA_ND_OUTPUT_OPT_ELEM_VALUE,
      "!   An input object that includes the input text.
      INPUT type T_MESSAGE_INPUT,
    end of T_DIA_ND_OUTPUT_OPT_ELEM_VALUE.
  types:
    "! No documentation available.
    begin of T_DIA_NODE_OUTPUT_OPT_ELEMENT,
      "!   The user-facing label for the option.
      LABEL type STRING,
      "!   An object defining the message input to be sent to the assistant if the user
      "!    selects the corresponding option.
      VALUE type T_DIA_ND_OUTPUT_OPT_ELEM_VALUE,
    end of T_DIA_NODE_OUTPUT_OPT_ELEMENT.
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
    "! <p class="shorttext synchronized" lang="en">
    "!    An object containing segments of text from search results</p>
    "!     with query-matching text highlighted using HTML &lt;em&gt; tags.
    begin of T_SEARCH_RESULT_HIGHLIGHT,
      "!   An array of strings containing segments taken from body text in the search
      "!    results, with query-matching substrings highlighted.
      BODY type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of strings containing segments taken from title text in the search
      "!    results, with query-matching substrings highlighted.
      TITLE type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of strings containing segments taken from URLs in the search results,
      "!    with query-matching substrings highlighted.
      URL type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_SEARCH_RESULT_HIGHLIGHT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object defining the message input to be sent to the</p>
    "!     assistant if the user selects the corresponding disambiguation option.
    begin of T_DIALOG_SUGGESTION_VALUE,
      "!   An input object that includes the input text.
      INPUT type T_MESSAGE_INPUT,
    end of T_DIALOG_SUGGESTION_VALUE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object containing search result metadata from the</p>
    "!     Discovery service.
    begin of T_SEARCH_RESULT_METADATA,
      "!   The confidence score for the given result. For more information about how the
      "!    confidence is calculated, see the Discovery service
      "!    [documentation](../discovery#query-your-collection).
      CONFIDENCE type DOUBLE,
      "!   An unbounded measure of the relevance of a particular result, dependent on the
      "!    query and matching document. A higher score indicates a greater match to the
      "!    query parameters.
      SCORE type DOUBLE,
    end of T_SEARCH_RESULT_METADATA.
  types:
    "! No documentation available.
    begin of T_SEARCH_RESULT,
      "!   The unique identifier of the document in the Discovery service collection.<br/>
      "!   <br/>
      "!   This property is included in responses from search skills, which are a beta
      "!    feature available only to Plus or Premium plan users.
      ID type STRING,
      "!   An object containing search result metadata from the Discovery service.
      RESULT_METADATA type T_SEARCH_RESULT_METADATA,
      "!   A description of the search result. This is taken from an abstract, summary, or
      "!    highlight field in the Discovery service response, as specified in the search
      "!    skill configuration.
      BODY type STRING,
      "!   The title of the search result. This is taken from a title or name field in the
      "!    Discovery service response, as specified in the search skill configuration.
      TITLE type STRING,
      "!   The URL of the original data object in its native data source.
      URL type STRING,
      "!   An object containing segments of text from search results with query-matching
      "!    text highlighted using HTML &lt;em&gt; tags.
      HIGHLIGHT type T_SEARCH_RESULT_HIGHLIGHT,
    end of T_SEARCH_RESULT.
  types:
    "! No documentation available.
    begin of T_DIALOG_SUGGESTION,
      "!   The user-facing label for the disambiguation option. This label is taken from
      "!    the **title** or **user_label** property of the corresponding dialog node,
      "!    depending on the disambiguation options.
      LABEL type STRING,
      "!   An object defining the message input to be sent to the assistant if the user
      "!    selects the corresponding disambiguation option.
      VALUE type T_DIALOG_SUGGESTION_VALUE,
      "!   The dialog output that will be returned from the Watson Assistant service if the
      "!    user selects the corresponding option.
      OUTPUT type MAP,
    end of T_DIALOG_SUGGESTION.
  types:
    "! No documentation available.
    begin of T_RUNTIME_RESPONSE_GENERIC,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.<br/>
      "!   <br/>
      "!   **Note:** The **suggestion** response type is part of the disambiguation
      "!    feature, which is only available for Premium users.
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
      "!   An array of objects describing the possible matching dialog nodes from which the
      "!    user can choose.<br/>
      "!   <br/>
      "!   **Note:** The **suggestions** property is part of the disambiguation feature,
      "!    which is only available for Premium users.
      SUGGESTIONS type STANDARD TABLE OF T_DIALOG_SUGGESTION WITH NON-UNIQUE DEFAULT KEY,
      "!   The title or introductory text to show before the response. This text is defined
      "!    in the search skill configuration.
      HEADER type STRING,
      "!   An array of objects containing search results.
      RESULTS type STANDARD TABLE OF T_SEARCH_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_RUNTIME_RESPONSE_GENERIC.
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
    begin of T_RUNTIME_RESPONSE_TYPE_IMAGE,
      "!   The URL of the image.
      SOURCE type STRING,
      "!   The title to show before the response.
      TITLE type STRING,
      "!   The description to show with the the response.
      DESCRIPTION type STRING,
    end of T_RUNTIME_RESPONSE_TYPE_IMAGE.
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
    "!    Built-in system properties that apply to all skills used by</p>
    "!     the assistant.
    begin of T_MSSG_CONTEXT_GLOBAL_SYSTEM,
      "!   The user time zone. The assistant uses the time zone to correctly resolve
      "!    relative time references.
      TIMEZONE type STRING,
      "!   A string value that identifies the user who is interacting with the assistant.
      "!    The client must provide a unique identifier for each individual end user who
      "!    accesses the application. For Plus and Premium plans, this user ID is used to
      "!    identify unique users for billing purposes. This string cannot contain carriage
      "!    return, newline, or tab characters.
      USER_ID type STRING,
      "!   A counter that is automatically incremented with each turn of the conversation.
      "!    A value of 1 indicates that this is the the first turn of a new conversation,
      "!    which can affect the behavior of some skills (for example, triggering the start
      "!    node of a dialog).
      TURN_COUNT type INTEGER,
      "!   The language code for localization in the user input. The specified locale
      "!    overrides the default for the assistant, and is used for interpreting entity
      "!    values in user input such as date values. For example, `04/03/2018` might be
      "!    interpreted either as April 3 or March 4, depending on the locale.<br/>
      "!   <br/>
      "!    This property is included only if the new system entities are enabled for the
      "!    skill.
      LOCALE type STRING,
      "!   The base time for interpreting any relative time mentions in the user input. The
      "!    specified time overrides the current server time, and is used to calculate
      "!    times mentioned in relative terms such as `now` or `tomorrow`. This can be
      "!    useful for simulating past or future times for testing purposes, or when
      "!    analyzing documents such as news articles.<br/>
      "!   <br/>
      "!   This value must be a UTC time value formatted according to ISO 8601 (for
      "!    example, `2019-06-26T12:00:00Z` for noon on 26 June 2019.<br/>
      "!   <br/>
      "!   This property is included only if the new system entities are enabled for the
      "!    skill.
      REFERENCE_TIME type STRING,
    end of T_MSSG_CONTEXT_GLOBAL_SYSTEM.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information that is shared by all skills used by the</p>
    "!     Assistant.
    begin of T_MESSAGE_CONTEXT_GLOBAL,
      "!   Built-in system properties that apply to all skills used by the assistant.
      SYSTEM type T_MSSG_CONTEXT_GLOBAL_SYSTEM,
    end of T_MESSAGE_CONTEXT_GLOBAL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information specific to particular skills used by the</p>
    "!     Assistant.<br/>
    "!    <br/>
    "!    **Note:** Currently, only a single property named `main skill` is supported.
    "!     This object contains variables that apply to the dialog skill used by the
    "!     assistant.
      T_MESSAGE_CONTEXT_SKILLS type MAP.
  types:
    "! No documentation available.
    begin of T_MESSAGE_CONTEXT,
      "!   Information that is shared by all skills used by the Assistant.
      GLOBAL type T_MESSAGE_CONTEXT_GLOBAL,
      "!   Information specific to particular skills used by the Assistant.<br/>
      "!   <br/>
      "!   **Note:** Currently, only a single property named `main skill` is supported.
      "!    This object contains variables that apply to the dialog skill used by the
      "!    assistant.
      SKILLS type T_MESSAGE_CONTEXT_SKILLS,
    end of T_MESSAGE_CONTEXT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Assistant output to be rendered or processed by the client.</p>
    begin of T_MESSAGE_OUTPUT,
      "!   Output intended for any channel. It is the responsibility of the client
      "!    application to implement the supported response types.
      GENERIC type STANDARD TABLE OF T_RUNTIME_RESPONSE_GENERIC WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of intents recognized in the user input, sorted in descending order of
      "!    confidence.
      INTENTS type STANDARD TABLE OF T_RUNTIME_INTENT WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of entities identified in the user input.
      ENTITIES type STANDARD TABLE OF T_RUNTIME_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects describing any actions requested by the dialog node.
      ACTIONS type STANDARD TABLE OF T_DIALOG_NODE_ACTION WITH NON-UNIQUE DEFAULT KEY,
      "!   Additional detailed information about a message response and how it was
      "!    generated.
      DEBUG type T_MESSAGE_OUTPUT_DEBUG,
      "!   An object containing any custom properties included in the response. This object
      "!    includes any arbitrary properties defined in the dialog JSON editor as part of
      "!    the dialog node output.
      USER_DEFINED type MAP,
    end of T_MESSAGE_OUTPUT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A response from the Watson Assistant service.</p>
    begin of T_MESSAGE_RESPONSE,
      "!   Assistant output to be rendered or processed by the client.
      OUTPUT type T_MESSAGE_OUTPUT,
      "!   State information for the conversation. The context is stored by the assistant
      "!    on a per-session basis. You can use this property to access context
      "!    variables.<br/>
      "!   <br/>
      "!   **Note:** The context is included in message responses only if
      "!    **return_context**=`true` in the message request.
      CONTEXT type T_MESSAGE_CONTEXT,
    end of T_MESSAGE_RESPONSE.
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
    begin of T_RUNTIME_RESPONSE_TYPE_PAUSE,
      "!   How long to pause, in milliseconds.
      TIME type INTEGER,
      "!   Whether to send a &quot;user is typing&quot; event during the pause.
      TYPING type BOOLEAN,
    end of T_RUNTIME_RESPONSE_TYPE_PAUSE.
  types:
    "! No documentation available.
    begin of T_RUNTIME_RESPONSE_TYPE_SEARCH,
      "!   The title or introductory text to show before the response. This text is defined
      "!    in the search skill configuration.
      HEADER type STRING,
      "!   An array of objects containing search results.
      RESULTS type STANDARD TABLE OF T_SEARCH_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_RUNTIME_RESPONSE_TYPE_SEARCH.
  types:
    "! No documentation available.
    begin of T_RT_RESPONSE_TYPE_SUGGESTION,
      "!   The title or introductory text to show before the response.
      TITLE type STRING,
      "!   An array of objects describing the possible matching dialog nodes from which the
      "!    user can choose.<br/>
      "!   <br/>
      "!   **Note:** The **suggestions** property is part of the disambiguation feature,
      "!    which is only available for Premium users.
      SUGGESTIONS type STANDARD TABLE OF T_DIALOG_SUGGESTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_RT_RESPONSE_TYPE_SUGGESTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Contains information specific to a particular skill used by</p>
    "!     the Assistant.
    begin of T_MESSAGE_CONTEXT_SKILL,
      "!   Arbitrary variables that can be read and written by a particular skill.
      USER_DEFINED type MAP,
      "!   For internal use only.
      SYSTEM type MAP,
    end of T_MESSAGE_CONTEXT_SKILL.
  types:
    "! No documentation available.
    begin of T_RT_RESP_TYP_CONNECT_TO_AGENT,
      "!   A message to be sent to the human agent who will be taking over the
      "!    conversation.
      MESSAGE_TO_HUMAN_AGENT type STRING,
      "!   A label identifying the topic of the conversation, derived from the
      "!    **user_label** property of the relevant node.
      TOPIC type STRING,
    end of T_RT_RESP_TYP_CONNECT_TO_AGENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A request formatted for the Watson Assistant service.</p>
    begin of T_MESSAGE_REQUEST,
      "!   An input object that includes the input text.
      INPUT type T_MESSAGE_INPUT,
      "!   State information for the conversation. The context is stored by the assistant
      "!    on a per-session basis. You can use this property to set or modify context
      "!    variables, which can also be accessed by dialog nodes.
      CONTEXT type T_MESSAGE_CONTEXT,
    end of T_MESSAGE_REQUEST.

constants:
  "! <p class="shorttext synchronized" lang="en">List of required fields per type.</p>
  begin of C_REQUIRED_FIELDS,
    T_DIALOG_LOG_MESSAGE type string value '|LEVEL|MESSAGE|',
    T_DIALOG_NODES_VISITED type string value '|',
    T_MESSAGE_OUTPUT_DEBUG type string value '|',
    T_SESSION_RESPONSE type string value '|SESSION_ID|',
    T_RT_ENTTY_INTRPRTTN_SYS_NUM type string value '|',
    T_RUNTIME_ENTITY_ALTERNATIVE type string value '|',
    T_RUNTIME_ENTITY_ROLE type string value '|',
    T_RT_ENTITY_INTERPRETATION type string value '|',
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
    T_ERROR_DETAIL type string value '|MESSAGE|',
    T_ERROR_RESPONSE type string value '|ERROR|CODE|',
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
  "! <p class="shorttext synchronized" lang="en">Map ABAP identifiers to service identifiers.</p>
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
     INTERPRETATION type string value 'interpretation',
     ALTERNATIVES type string value 'alternatives',
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
     TYPE type string value 'type',
     MESSAGE_TYPE type string value 'message_type',
     TEXT type string value 'text',
     OPTIONS type string value 'options',
     INTENTS type string value 'intents',
     ENTITIES type string value 'entities',
     SUGGESTION_ID type string value 'suggestion_id',
     USER_ID type string value 'user_id',
     TURN_COUNT type string value 'turn_count',
     LOCALE type string value 'locale',
     REFERENCE_TIME type string value 'reference_time',
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


    "! <p class="shorttext synchronized" lang="en">Create a session</p>
    "!   Create a new session. A session is used to send user input to a skill and
    "!    receive responses. It also maintains the state of the conversation. A session
    "!    persists until it is deleted, or until it times out because of inactivity. (For
    "!    more information, see the
    "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-assistant-
    "!   settings).
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   Unique identifier of the assistant. To find the assistant ID in the Watson
    "!    Assistant user interface, open the assistant settings and click **API
    "!    Details**. For information about creating assistants, see the
    "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-assistant-
    "!   add#assistant-add-task).<br/>
    "!   <br/>
    "!   **Note:** Currently, the v2 API does not support creating assistants.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SESSION_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_SESSION
    importing
      !I_ASSISTANT_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SESSION_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete session</p>
    "!   Deletes a session explicitly before it times out. (For more information about
    "!    the session inactivity timeout, see the
    "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-assistant-
    "!   settings)).
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   Unique identifier of the assistant. To find the assistant ID in the Watson
    "!    Assistant user interface, open the assistant settings and click **API
    "!    Details**. For information about creating assistants, see the
    "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-assistant-
    "!   add#assistant-add-task).<br/>
    "!   <br/>
    "!   **Note:** Currently, the v2 API does not support creating assistants.
    "! @parameter I_SESSION_ID |
    "!   Unique identifier of the session.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_SESSION
    importing
      !I_ASSISTANT_ID type STRING
      !I_SESSION_ID type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Send user input to assistant</p>
    "!   Send user input to an assistant and receive a response.<br/>
    "!   <br/>
    "!   There is no rate limit for this operation.
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   Unique identifier of the assistant. To find the assistant ID in the Watson
    "!    Assistant user interface, open the assistant settings and click **API
    "!    Details**. For information about creating assistants, see the
    "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-assistant-
    "!   add#assistant-add-task).<br/>
    "!   <br/>
    "!   **Note:** Currently, the v2 API does not support creating assistants.
    "! @parameter I_SESSION_ID |
    "!   Unique identifier of the session.
    "! @parameter I_REQUEST |
    "!   The message to be sent. This includes the user&apos;s input, along with optional
    "!    content such as intents and entities.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_MESSAGE_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods MESSAGE
    importing
      !I_ASSISTANT_ID type STRING
      !I_SESSION_ID type STRING
      !I_REQUEST type T_MESSAGE_REQUEST optional
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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20200310173422'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->CREATE_SESSION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ASSISTANT_ID        TYPE STRING
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
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.

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
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_SESSION_ID        TYPE STRING
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
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.
    replace all occurrences of `{session_id}` in ls_request_prop-url-path with i_SESSION_ID ignoring case.

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
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_SESSION_ID        TYPE STRING
* | [--->] I_REQUEST        TYPE T_MESSAGE_REQUEST(optional)
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
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.
    replace all occurrences of `{session_id}` in ls_request_prop-url-path with i_SESSION_ID ignoring case.

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
    if not i_REQUEST is initial.
    lv_datatype = get_datatype( i_REQUEST ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_REQUEST i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'request' i_value = i_REQUEST ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_REQUEST to <lv_text>.
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
