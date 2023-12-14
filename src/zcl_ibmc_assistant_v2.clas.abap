* Copyright 2019, 2023 IBM Corp. All Rights Reserved.
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
    "! No documentation available.
    begin of T_RESPONSE_GENERIC_CHANNEL,
      "!   A channel for which the response is intended.
      CHANNEL type STRING,
    end of T_RESPONSE_GENERIC_CHANNEL.
  types:
    "! No documentation available.
    begin of T_RUNTIME_RESPONSE_TYPE_VIDEO,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   The `https:` URL of the video.
      SOURCE type STRING,
      "!   The title or introductory text to show before the response.
      TITLE type STRING,
      "!   The description to show with the the response.
      DESCRIPTION type STRING,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
      "!   For internal use only.
      CHANNEL_OPTIONS type JSONOBJECT,
      "!   Descriptive text that can be used for screen readers or other situations where
      "!    the video cannot be seen.
      ALT_TEXT type STRING,
    end of T_RUNTIME_RESPONSE_TYPE_VIDEO.
  types:
    "! No documentation available.
    begin of T_TURN_EVENT_ACTION_SOURCE,
      "!   The type of turn event.
      TYPE type STRING,
      "!   An action that was visited during processing of the message.
      ACTION type STRING,
      "!   The title of the action.
      ACTION_TITLE type STRING,
      "!   The condition that triggered the dialog node.
      CONDITION type STRING,
    end of T_TURN_EVENT_ACTION_SOURCE.
  types:
    "! No documentation available.
    begin of T_TURN_EVENT_SEARCH_ERROR,
      "!   Any error message returned by a failed call to a search skill.
      MESSAGE type STRING,
    end of T_TURN_EVENT_SEARCH_ERROR.
  types:
    "! No documentation available.
    begin of T_TURN_EVENT_SEARCH,
      "!   The type of turn event.
      EVENT type STRING,
      "!   No documentation available.
      SOURCE type T_TURN_EVENT_ACTION_SOURCE,
      "!   No documentation available.
      ERROR type T_TURN_EVENT_SEARCH_ERROR,
    end of T_TURN_EVENT_SEARCH.
  types:
    "! No documentation available.
      T_MSSG_OUTPUT_DEBUG_TURN_EVENT type JSONOBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that identifies the dialog element that generated</p>
    "!     the error message.
      T_LOG_MESSAGE_SOURCE type JSONOBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Dialog log message details.</p>
    begin of T_DIALOG_LOG_MESSAGE,
      "!   The severity of the log message.
      LEVEL type STRING,
      "!   The text of the log message.
      MESSAGE type STRING,
      "!   A code that indicates the category to which the error message belongs.
      CODE type STRING,
      "!   An object that identifies the dialog element that generated the error message.
      SOURCE type T_LOG_MESSAGE_SOURCE,
    end of T_DIALOG_LOG_MESSAGE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An objects containing detailed diagnostic information about</p>
    "!     a dialog node that was visited during processing of the input message.
    begin of T_DIALOG_NODE_VISITED,
      "!   A dialog node that was visited during processing of the input message.
      DIALOG_NODE type STRING,
      "!   The title of the dialog node.
      TITLE type STRING,
      "!   The conditions that trigger the dialog node.
      CONDITIONS type STRING,
    end of T_DIALOG_NODE_VISITED.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Additional detailed information about a message response and</p>
    "!     how it was generated.
    begin of T_MESSAGE_OUTPUT_DEBUG,
      "!   An array of objects containing detailed diagnostic information about dialog
      "!    nodes that were visited during processing of the input message.
      NODES_VISITED type STANDARD TABLE OF T_DIALOG_NODE_VISITED WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of up to 50 messages logged with the request.
      LOG_MESSAGES type STANDARD TABLE OF T_DIALOG_LOG_MESSAGE WITH NON-UNIQUE DEFAULT KEY,
      "!   Assistant sets this to true when this message response concludes or interrupts a
      "!    dialog.
      BRANCH_EXITED type BOOLEAN,
      "!   When `branch_exited` is set to `true` by the assistant, the
      "!    `branch_exited_reason` specifies whether the dialog completed by itself or got
      "!    interrupted.
      BRANCH_EXITED_REASON type STRING,
      "!   An array of objects containing detailed diagnostic information about dialog
      "!    nodes and actions that were visited during processing of the input
      "!    message.<br/>
      "!   <br/>
      "!   This property is present only if the assistant has an action skill.
      TURN_EVENTS type STANDARD TABLE OF T_MSSG_OUTPUT_DEBUG_TURN_EVENT WITH NON-UNIQUE DEFAULT KEY,
    end of T_MESSAGE_OUTPUT_DEBUG.
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
    "!    Spelling correction options for the message. Any options</p>
    "!     specified on an individual message override the settings configured for the
    "!     skill.
    begin of T_MESSAGE_INPUT_OPT_SPELLING,
      "!   Whether to use spelling correction when processing the input. If spelling
      "!    correction is used and **auto_correct** is `true`, any spelling corrections are
      "!    automatically applied to the user input. If **auto_correct** is `false`, any
      "!    suggested corrections are returned in the **output.spelling** property.<br/>
      "!   <br/>
      "!   This property overrides the value of the **spelling_suggestions** property in
      "!    the workspace settings for the skill.
      SUGGESTIONS type BOOLEAN,
      "!   Whether to use autocorrection when processing the input. If this property is
      "!    `true`, any corrections are automatically applied to the user input, and the
      "!    original text is returned in the **output.spelling** property of the message
      "!    response. This property overrides the value of the **spelling_auto_correct**
      "!    property in the workspace settings for the skill.
      AUTO_CORRECT type BOOLEAN,
    end of T_MESSAGE_INPUT_OPT_SPELLING.
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
      "!   The skill that recognized the entity value. Currently, the only possible values
      "!    are `main skill` for the dialog skill (if enabled) and `actions skill` for the
      "!    action skill.<br/>
      "!   <br/>
      "!   This property is present only if the assistant has both a dialog skill and an
      "!    action skill.
      SKILL type STRING,
    end of T_RUNTIME_ENTITY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An optional object containing analytics data. Currently,</p>
    "!     this data is used only for events sent to the Segment extension.
    begin of T_REQUEST_ANALYTICS,
      "!   The browser that was used to send the message that triggered the event.
      BROWSER type STRING,
      "!   The type of device that was used to send the message that triggered the event.
      DEVICE type STRING,
      "!   The URL of the web page that was used to send the message that triggered the
      "!    event.
      PAGEURL type STRING,
    end of T_REQUEST_ANALYTICS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A reference to a media file to be sent as an attachment with</p>
    "!     the message.
    begin of T_MESSAGE_INPUT_ATTACHMENT,
      "!   The URL of the media file.
      URL type STRING,
      "!   The media content type (such as a MIME type) of the attachment.
      MEDIA_TYPE type STRING,
    end of T_MESSAGE_INPUT_ATTACHMENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Optional properties that control how the assistant responds.</p>
    begin of T_MESSAGE_INPUT_OPTIONS,
      "!   Whether to restart dialog processing at the root of the dialog, regardless of
      "!    any previously visited nodes. **Note:** This does not affect `turn_count` or
      "!    any other context variables.
      RESTART type BOOLEAN,
      "!   Whether to return more than one intent. Set to `true` to return all matching
      "!    intents.
      ALTERNATE_INTENTS type BOOLEAN,
      "!   Spelling correction options for the message. Any options specified on an
      "!    individual message override the settings configured for the skill.
      SPELLING type T_MESSAGE_INPUT_OPT_SPELLING,
      "!   Whether to return additional diagnostic information. Set to `true` to return
      "!    additional information in the `output.debug` property. If you also specify
      "!    **return_context**=`true`, the returned skill context includes the
      "!    `system.state` property.
      DEBUG type BOOLEAN,
      "!   Whether to return session context with the response. If you specify `true`, the
      "!    response includes the `context` property. If you also specify **debug**=`true`,
      "!    the returned skill context includes the `system.state` property.
      RETURN_CONTEXT type BOOLEAN,
      "!   Whether to return session context, including full conversation state. If you
      "!    specify `true`, the response includes the `context` property, and the skill
      "!    context includes the `system.state` property.<br/>
      "!   <br/>
      "!   **Note:** If **export**=`true`, the context is returned regardless of the value
      "!    of **return_context**.
      EXPORT type BOOLEAN,
    end of T_MESSAGE_INPUT_OPTIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An intent identified in the user input.</p>
    begin of T_RUNTIME_INTENT,
      "!   The name of the recognized intent.
      INTENT type STRING,
      "!   A decimal percentage that represents Watson&apos;s confidence in the intent. If
      "!    you are specifying an intent as part of a request, but you do not have a
      "!    calculated confidence value, specify `1`.
      CONFIDENCE type DOUBLE,
      "!   The skill that identified the intent. Currently, the only possible values are
      "!    `main skill` for the dialog skill (if enabled) and `actions skill` for the
      "!    action skill.<br/>
      "!   <br/>
      "!   This property is present only if the assistant has both a dialog skill and an
      "!    action skill.
      SKILL type STRING,
    end of T_RUNTIME_INTENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An input object that includes the input text.</p>
    begin of T_MESSAGE_INPUT,
      "!   The type of the message:<br/>
      "!   <br/>
      "!   - `text`: The user input is processed normally by the assistant.<br/>
      "!   - `search`: Only search results are returned. (Any dialog or action skill is
      "!    bypassed.)<br/>
      "!   <br/>
      "!   **Note:** A `search` message results in an error if no search skill is
      "!    configured for the assistant.
      MESSAGE_TYPE type STRING,
      "!   The text of the user input. This string cannot contain carriage return, newline,
      "!    or tab characters.
      TEXT type STRING,
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
      "!   An array of multimedia attachments to be sent with the message. Attachments are
      "!    not processed by the assistant itself, but can be sent to external services by
      "!    webhooks. <br/>
      "!   <br/>
      "!    **Note:** Attachments are not supported on IBM Cloud Pak for Data.
      ATTACHMENTS type STANDARD TABLE OF T_MESSAGE_INPUT_ATTACHMENT WITH NON-UNIQUE DEFAULT KEY,
      "!   An optional object containing analytics data. Currently, this data is used only
      "!    for events sent to the Segment extension.
      ANALYTICS type T_REQUEST_ANALYTICS,
      "!   Optional properties that control how the assistant responds.
      OPTIONS type T_MESSAGE_INPUT_OPTIONS,
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
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   The title or introductory text to show before the response.
      TITLE type STRING,
      "!   The description to show with the the response.
      DESCRIPTION type STRING,
      "!   The preferred type of control to display.
      PREFERENCE type STRING,
      "!   An array of objects describing the options from which the user can choose.
      OPTIONS type STANDARD TABLE OF T_DIA_NODE_OUTPUT_OPT_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RUNTIME_RESPONSE_TYPE_OPTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object describing an error that occurred during</p>
    "!     processing of an asynchronous operation.
    begin of T_STATUS_ERROR,
      "!   The text of the error message.
      MESSAGE type STRING,
    end of T_STATUS_ERROR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The messages included with responses from the search</p>
    "!     integration.
    begin of T_SEARCH_SETTINGS_MESSAGES,
      "!   The message to include in the response to a successful query.
      SUCCESS type STRING,
      "!   The message to include in the response when the query encounters an error.
      ERROR type STRING,
      "!   The message to include in the response when there is no result from the query.
      NO_RESULT type STRING,
    end of T_SEARCH_SETTINGS_MESSAGES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The mapping between fields in the Watson Discovery</p>
    "!     collection and properties in the search response.
    begin of T_SRCH_SETTINGS_SCHEMA_MAPPING,
      "!   The field in the collection to map to the **url** property of the response.
      URL type STRING,
      "!   The field in the collection to map to the **body** property in the response.
      BODY type STRING,
      "!   The field in the collection to map to the **title** property for the schema.
      TITLE type STRING,
    end of T_SRCH_SETTINGS_SCHEMA_MAPPING.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Authentication information for the Watson Discovery service.</p>
    "!     For more information, see the [Watson Discovery
    "!     documentation](https://cloud.ibm.com/apidocs/discovery-data#authentication).
    "!     <br/>
    "!    <br/>
    "!     **Note:** You must specify either **basic** or **bearer**, but not both.
    begin of T_SRCH_STTNGS_DSCVRY_ATHNTCTN,
      "!   The HTTP basic authentication credentials for Watson Discovery. Specify your
      "!    Watson Discovery API key in the format `apikey:&#123;apikey&#125;`.
      BASIC type STRING,
      "!   The authentication bearer token for Watson Discovery.
      BEARER type STRING,
    end of T_SRCH_STTNGS_DSCVRY_ATHNTCTN.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Configuration settings for the Watson Discovery service</p>
    "!     instance used by the search integration.
    begin of T_SEARCH_SETTINGS_DISCOVERY,
      "!   The ID for the Watson Discovery service instance.
      INSTANCE_ID type STRING,
      "!   The ID for the Watson Discovery project.
      PROJECT_ID type STRING,
      "!   The URL for the Watson Discovery service instance.
      URL type STRING,
      "!   The maximum number of primary results to include in the response.
      MAX_PRIMARY_RESULTS type INTEGER,
      "!   The maximum total number of primary and additional results to include in the
      "!    response.
      MAX_TOTAL_RESULTS type INTEGER,
      "!   The minimum confidence threshold for included results. Any results with a
      "!    confidence below this threshold will be discarded.
      CONFIDENCE_THRESHOLD type DOUBLE,
      "!   Whether to include the most relevant passages of text in the **highlight**
      "!    property of each result.
      HIGHLIGHT type BOOLEAN,
      "!   Whether to use the answer finding feature to emphasize answers within
      "!    highlighted passages. This property is ignored if **highlight**=`false`.<br/>
      "!   <br/>
      "!   **Notes:** <br/>
      "!    - Answer finding is available only if the search skill is connected to a
      "!    Discovery v2 service instance. <br/>
      "!    - Answer finding is not supported on IBM Cloud Pak for Data.
      FIND_ANSWERS type BOOLEAN,
      "!   Authentication information for the Watson Discovery service. For more
      "!    information, see the [Watson Discovery
      "!    documentation](https://cloud.ibm.com/apidocs/discovery-data#authentication).
      "!    <br/>
      "!   <br/>
      "!    **Note:** You must specify either **basic** or **bearer**, but not both.
      AUTHENTICATION type T_SRCH_STTNGS_DSCVRY_ATHNTCTN,
    end of T_SEARCH_SETTINGS_DISCOVERY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object describing the search skill configuration.</p>
    begin of T_SEARCH_SETTINGS,
      "!   Configuration settings for the Watson Discovery service instance used by the
      "!    search integration.
      DISCOVERY type T_SEARCH_SETTINGS_DISCOVERY,
      "!   The messages included with responses from the search integration.
      MESSAGES type T_SEARCH_SETTINGS_MESSAGES,
      "!   The mapping between fields in the Watson Discovery collection and properties in
      "!    the search response.
      SCHEMA_MAPPING type T_SRCH_SETTINGS_SCHEMA_MAPPING,
    end of T_SEARCH_SETTINGS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A warning describing an error in the search skill</p>
    "!     configuration.
    begin of T_SEARCH_SKILL_WARNING,
      "!   The error code.
      CODE type STRING,
      "!   The location of the error in the search skill configuration object.
      PATH type STRING,
      "!   The error message.
      MESSAGE type STRING,
    end of T_SEARCH_SKILL_WARNING.
  types:
    "! No documentation available.
    begin of T_SKILL_IMPORT,
      "!   The name of the skill. This string cannot contain carriage return, newline, or
      "!    tab characters.
      NAME type STRING,
      "!   The description of the skill. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   An object containing the conversational content of an action or dialog skill.
      WORKSPACE type JSONOBJECT,
      "!   The skill ID of the skill.
      SKILL_ID type STRING,
      "!   The current status of the skill: <br/>
      "!    - **Available**: The skill is available and ready to process messages. <br/>
      "!    - **Failed**: An asynchronous operation has failed. See the **status_errors**
      "!    property for more information about the cause of the failure. <br/>
      "!    - **Non Existent**: The skill does not exist. <br/>
      "!    - **Processing**: An asynchronous operation has not yet completed. <br/>
      "!    - **Training**: The skill is training based on new data.
      STATUS type STRING,
      "!   An array of messages about errors that caused an asynchronous operation to fail.
      "!    Included only if **status**=`Failed`.
      STATUS_ERRORS type STANDARD TABLE OF T_STATUS_ERROR WITH NON-UNIQUE DEFAULT KEY,
      "!   The description of the failed asynchronous operation. Included only if
      "!    **status**=`Failed`.
      STATUS_DESCRIPTION type STRING,
      "!   For internal use only.
      DIALOG_SETTINGS type JSONOBJECT,
      "!   The unique identifier of the assistant the skill is associated with.
      ASSISTANT_ID type STRING,
      "!   The unique identifier of the workspace that contains the skill content. Included
      "!    only for action and dialog skills.
      WORKSPACE_ID type STRING,
      "!   The unique identifier of the environment where the skill is defined. For action
      "!    and dialog skills, this is always the draft environment.
      ENVIRONMENT_ID type STRING,
      "!   Whether the skill is structurally valid.
      VALID type BOOLEAN,
      "!   The name that will be given to the next snapshot that is created for the skill.
      "!    A snapshot of each versionable skill is saved for each new release of an
      "!    assistant.
      NEXT_SNAPSHOT_VERSION type STRING,
      "!   An object describing the search skill configuration.
      SEARCH_SETTINGS type T_SEARCH_SETTINGS,
      "!   An array of warnings describing errors with the search skill configuration.
      "!    Included only for search skills.
      WARNINGS type STANDARD TABLE OF T_SEARCH_SKILL_WARNING WITH NON-UNIQUE DEFAULT KEY,
      "!   The language of the skill.
      LANGUAGE type STRING,
      "!   The type of skill.
      TYPE type STRING,
    end of T_SKILL_IMPORT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Status information about the skills for the assistant.</p>
    "!     Included in responses only if **status**=`Available`.
    begin of T_ASSISTANT_STATE,
      "!   Whether the action skill is disabled in the draft environment.
      ACTION_DISABLED type BOOLEAN,
      "!   Whether the dialog skill is disabled in the draft environment.
      DIALOG_DISABLED type BOOLEAN,
    end of T_ASSISTANT_STATE.
  types:
    "! No documentation available.
    begin of T_SKILLS_IMPORT,
      "!   The assistant ID of the assistant.
      ASSISTANT_ID type STRING,
      "!   The current status of the asynchronous operation: <br/>
      "!    - `Available`: An asynchronous export is available. <br/>
      "!    - `Completed`: An asynchronous import operation has completed successfully.
      "!    <br/>
      "!    - `Failed`: An asynchronous operation has failed. See the **status_errors**
      "!    property for more information about the cause of the failure. <br/>
      "!    - `Processing`: An asynchronous operation has not yet completed.
      STATUS type STRING,
      "!   The description of the failed asynchronous operation. Included only if
      "!    **status**=`Failed`.
      STATUS_DESCRIPTION type STRING,
      "!   An array of messages about errors that caused an asynchronous operation to fail.
      "!    Included only if **status**=`Failed`.
      STATUS_ERRORS type STANDARD TABLE OF T_STATUS_ERROR WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects describing the skills for the assistant. Included in
      "!    responses only if **status**=`Available`.
      ASSISTANT_SKILLS type STANDARD TABLE OF T_SKILL_IMPORT WITH NON-UNIQUE DEFAULT KEY,
      "!   Status information about the skills for the assistant. Included in responses
      "!    only if **status**=`Available`.
      ASSISTANT_STATE type T_ASSISTANT_STATE,
    end of T_SKILLS_IMPORT.
  types:
    "! No documentation available.
    begin of T_MSSG_OTPT_DBG_TRN_EVNT_TRN_3,
      "!   The type of turn event.
      EVENT type STRING,
      "!   No documentation available.
      SOURCE type T_TURN_EVENT_ACTION_SOURCE,
      "!   The type of condition (if any) that is defined for the action.
      CONDITION_TYPE type STRING,
      "!   The time when the action started processing the message.
      ACTION_START_TIME type STRING,
      "!   Whether the step collects a customer response.
      HAS_QUESTION type BOOLEAN,
    end of T_MSSG_OTPT_DBG_TRN_EVNT_TRN_3.
  types:
    "! No documentation available.
    begin of T_SKILL,
      "!   The name of the skill. This string cannot contain carriage return, newline, or
      "!    tab characters.
      NAME type STRING,
      "!   The description of the skill. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   An object containing the conversational content of an action or dialog skill.
      WORKSPACE type JSONOBJECT,
      "!   The skill ID of the skill.
      SKILL_ID type STRING,
      "!   The current status of the skill: <br/>
      "!    - **Available**: The skill is available and ready to process messages. <br/>
      "!    - **Failed**: An asynchronous operation has failed. See the **status_errors**
      "!    property for more information about the cause of the failure. <br/>
      "!    - **Non Existent**: The skill does not exist. <br/>
      "!    - **Processing**: An asynchronous operation has not yet completed. <br/>
      "!    - **Training**: The skill is training based on new data.
      STATUS type STRING,
      "!   An array of messages about errors that caused an asynchronous operation to fail.
      "!    Included only if **status**=`Failed`.
      STATUS_ERRORS type STANDARD TABLE OF T_STATUS_ERROR WITH NON-UNIQUE DEFAULT KEY,
      "!   The description of the failed asynchronous operation. Included only if
      "!    **status**=`Failed`.
      STATUS_DESCRIPTION type STRING,
      "!   For internal use only.
      DIALOG_SETTINGS type JSONOBJECT,
      "!   The unique identifier of the assistant the skill is associated with.
      ASSISTANT_ID type STRING,
      "!   The unique identifier of the workspace that contains the skill content. Included
      "!    only for action and dialog skills.
      WORKSPACE_ID type STRING,
      "!   The unique identifier of the environment where the skill is defined. For action
      "!    and dialog skills, this is always the draft environment.
      ENVIRONMENT_ID type STRING,
      "!   Whether the skill is structurally valid.
      VALID type BOOLEAN,
      "!   The name that will be given to the next snapshot that is created for the skill.
      "!    A snapshot of each versionable skill is saved for each new release of an
      "!    assistant.
      NEXT_SNAPSHOT_VERSION type STRING,
      "!   An object describing the search skill configuration.
      SEARCH_SETTINGS type T_SEARCH_SETTINGS,
      "!   An array of warnings describing errors with the search skill configuration.
      "!    Included only for search skills.
      WARNINGS type STANDARD TABLE OF T_SEARCH_SKILL_WARNING WITH NON-UNIQUE DEFAULT KEY,
      "!   The language of the skill.
      LANGUAGE type STRING,
      "!   The type of skill.
      TYPE type STRING,
    end of T_SKILL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The search skill orchestration settings for the environment.</p>
    begin of T_BASE_ENV_ORCHESTRATION,
      "!   Whether assistants deployed to the environment fall back to a search skill when
      "!    responding to messages that do not match any intent. If no search skill is
      "!    configured for the assistant, this property is ignored.
      SEARCH_SKILL_FALLBACK type BOOLEAN,
    end of T_BASE_ENV_ORCHESTRATION.
  types:
    "! No documentation available.
    begin of T_RT_RESP_GNRC_RT_RESP_TYP_VD,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   The `https:` URL of the video.
      SOURCE type STRING,
      "!   The title or introductory text to show before the response.
      TITLE type STRING,
      "!   The description to show with the the response.
      DESCRIPTION type STRING,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
      "!   For internal use only.
      CHANNEL_OPTIONS type JSONOBJECT,
      "!   Descriptive text that can be used for screen readers or other situations where
      "!    the video cannot be seen.
      ALT_TEXT type STRING,
    end of T_RT_RESP_GNRC_RT_RESP_TYP_VD.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information for transferring to the web chat integration.</p>
    begin of T_CHANNEL_TRANSFER_TARGET_CHAT,
      "!   The URL of the target web chat.
      URL type STRING,
    end of T_CHANNEL_TRANSFER_TARGET_CHAT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object specifying target channels available for the</p>
    "!     transfer. Each property of this object represents an available transfer target.
    "!     Currently, the only supported property is **chat**, representing the web chat
    "!     integration.
    begin of T_CHANNEL_TRANSFER_TARGET,
      "!   Information for transferring to the web chat integration.
      CHAT type T_CHANNEL_TRANSFER_TARGET_CHAT,
    end of T_CHANNEL_TRANSFER_TARGET.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information used by an integration to transfer the</p>
    "!     conversation to a different channel.
    begin of T_CHANNEL_TRANSFER_INFO,
      "!   An object specifying target channels available for the transfer. Each property
      "!    of this object represents an available transfer target. Currently, the only
      "!    supported property is **chat**, representing the web chat integration.
      TARGET type T_CHANNEL_TRANSFER_TARGET,
    end of T_CHANNEL_TRANSFER_INFO.
  types:
    "! No documentation available.
    begin of T_RT_RESP_TYPE_CHANNEL_TRANS,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel. <br/>
      "!   <br/>
      "!    **Note:** The `channel_transfer` response type is not supported on IBM Cloud
      "!    Pak for Data.
      RESPONSE_TYPE type STRING,
      "!   The message to display to the user when initiating a channel transfer.
      MESSAGE_TO_USER type STRING,
      "!   Information used by an integration to transfer the conversation to a different
      "!    channel.
      TRANSFER_INFO type T_CHANNEL_TRANSFER_INFO,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RT_RESP_TYPE_CHANNEL_TRANS.
  types:
    "! No documentation available.
    begin of T_RUNTIME_RESPONSE_TYPE_TEXT,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   The text of the response.
      TEXT type STRING,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RUNTIME_RESPONSE_TYPE_TEXT.
  types:
    "! No documentation available.
    begin of T_DIALOG_NODE_ACTION,
      "!   The name of the action.
      NAME type STRING,
      "!   The type of action to invoke.
      TYPE type STRING,
      "!   A map of key/value pairs to be provided to the action.
      PARAMETERS type JSONOBJECT,
      "!   The location in the dialog context where the result of the action is stored.
      RESULT_VARIABLE type STRING,
      "!   The name of the context variable that the client application will use to pass in
      "!    credentials for the action.
      CREDENTIALS type STRING,
    end of T_DIALOG_NODE_ACTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object describing the release that is currently deployed</p>
    "!     in the environment.
    begin of T_BASE_ENV_RELEASE_REFERENCE,
      "!   The name of the deployed release.
      RELEASE type STRING,
    end of T_BASE_ENV_RELEASE_REFERENCE.
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
    begin of T_RELEASE_SKILL,
      "!   The skill ID of the skill.
      SKILL_ID type STRING,
      "!   The type of the skill.
      TYPE type STRING,
      "!   The name of the skill snapshot that is saved as part of the release (for
      "!    example, `draft` or `1`).
      SNAPSHOT type STRING,
    end of T_RELEASE_SKILL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object identifying the versionable content objects (such</p>
    "!     as skill snapshots) that are included in the release.
    begin of T_RELEASE_CONTENT,
      "!   The skill snapshots that are included in the release.
      SKILLS type STANDARD TABLE OF T_RELEASE_SKILL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RELEASE_CONTENT.
  types:
    "! No documentation available.
    begin of T_ENVIRONMENT_REFERENCE,
      "!   The name of the environment.
      NAME type STRING,
      "!   The unique identifier of the environment.
      ENVIRONMENT_ID type STRING,
      "!   The type of the environment. All environments other than the draft and live
      "!    environments have the type `staging`.
      ENVIRONMENT type STRING,
    end of T_ENVIRONMENT_REFERENCE.
  types:
    "! No documentation available.
    begin of T_RELEASE,
      "!   The name of the release. The name is the version number (an integer), returned
      "!    as a string.
      RELEASE type STRING,
      "!   The description of the release.
      DESCRIPTION type STRING,
      "!   An array of objects describing the environments where this release has been
      "!    deployed.
      ENVIRONMENT_REFERENCES type STANDARD TABLE OF T_ENVIRONMENT_REFERENCE WITH NON-UNIQUE DEFAULT KEY,
      "!   An object identifying the versionable content objects (such as skill snapshots)
      "!    that are included in the release.
      CONTENT type T_RELEASE_CONTENT,
      "!   The current status of the release: <br/>
      "!    - **Available**: The release is available for deployment. <br/>
      "!    - **Failed**: An asynchronous publish operation has failed. <br/>
      "!    - **Processing**: An asynchronous publish operation has not yet completed.
      STATUS type STRING,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_RELEASE.
  types:
    "! No documentation available.
    begin of T_INTEGRATION_REFERENCE,
      "!   The integration ID of the integration.
      INTEGRATION_ID type STRING,
      "!   The type of the integration.
      TYPE type STRING,
    end of T_INTEGRATION_REFERENCE.
  types:
    "! No documentation available.
    begin of T_ENVIRONMENT_SKILL,
      "!   The skill ID of the skill.
      SKILL_ID type STRING,
      "!   The type of the skill.
      TYPE type STRING,
      "!   Whether the skill is disabled. A disabled skill in the draft environment does
      "!    not handle any messages at run time, and it is not included in saved releases.
      DISABLED type BOOLEAN,
      "!   The name of the skill snapshot that is deployed to the environment (for example,
      "!    `draft` or `1`).
      SNAPSHOT type STRING,
      "!   The type of skill identified by the skill reference. The possible values are
      "!    `main skill` (for a dialog skill), `actions skill`, and `search skill`.
      SKILL_REFERENCE type STRING,
    end of T_ENVIRONMENT_SKILL.
  types:
    "! No documentation available.
    begin of T_UPDATE_ENVIRONMENT,
      "!   The name of the environment.
      NAME type STRING,
      "!   The description of the environment.
      DESCRIPTION type STRING,
      "!   The assistant ID of the assistant the environment is associated with.
      ASSISTANT_ID type STRING,
      "!   The environment ID of the environment.
      ENVIRONMENT_ID type STRING,
      "!   The type of the environment. All environments other than the `draft` and `live`
      "!    environments have the type `staging`.
      ENVIRONMENT type STRING,
      "!   An object describing the release that is currently deployed in the environment.
      RELEASE_REFERENCE type T_BASE_ENV_RELEASE_REFERENCE,
      "!   The search skill orchestration settings for the environment.
      ORCHESTRATION type T_BASE_ENV_ORCHESTRATION,
      "!   The session inactivity timeout setting for the environment (in seconds).
      SESSION_TIMEOUT type INTEGER,
      "!   An array of objects describing the integrations that exist in the environment.
      INTEGRATION_REFERENCES type STANDARD TABLE OF T_INTEGRATION_REFERENCE WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects identifying the skills (such as action and dialog) that
      "!    exist in the environment.
      SKILL_REFERENCES type STANDARD TABLE OF T_ENVIRONMENT_SKILL WITH NON-UNIQUE DEFAULT KEY,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_UPDATE_ENVIRONMENT.
  types:
    "! No documentation available.
    begin of T_MSSG_OTPT_DBG_TRN_EVNT_TRN_2,
      "!   The type of turn event.
      EVENT type STRING,
      "!   No documentation available.
      SOURCE type T_TURN_EVENT_ACTION_SOURCE,
      "!   The time when the action started processing the message.
      ACTION_START_TIME type STRING,
      "!   The type of condition (if any) that is defined for the action.
      CONDITION_TYPE type STRING,
      "!   The reason the action finished processing.
      REASON type STRING,
      "!   The state of all action variables at the time the action finished.
      ACTION_VARIABLES type JSONOBJECT,
    end of T_MSSG_OTPT_DBG_TRN_EVNT_TRN_2.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Autolearning options for the message. For more information</p>
    "!     about autolearning, see the
    "!     [documentation](/docs/watson-assistant?topic=watson-assistant-autolearn). <br/>
    "!    <br/>
    "!     **Note:** Autolearning is a beta feature.
    begin of T_MESSAGE_INPUT_OPT_AUTO_LEARN,
      "!   Whether the message should be used for autolearning. Specify `false` to exclude
      "!    a message from autolearning (for example, if you are running tests on a
      "!    production assistant). <br/>
      "!   <br/>
      "!    If specified, this option overrides the **Autolearn in live environment**
      "!    setting for the assistant. (This option does not apply to environments other
      "!    than the live environment.).
      LEARN type BOOLEAN,
      "!   Whether the autolearned model should be applied when responding to the message.
      "!    You can use this option to compare responses with and without autolearning.
      "!    This option can be used for messages sent to any environment.
      APPLY type BOOLEAN,
    end of T_MESSAGE_INPUT_OPT_AUTO_LEARN.
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
      "!    accesses the application. For user-based plans, this user ID is used to
      "!    identify unique users for billing purposes. This string cannot contain carriage
      "!    return, newline, or tab characters. If no value is specified in the input,
      "!    **user_id** is automatically set to the value of
      "!    **context.global.session_id**.<br/>
      "!   <br/>
      "!   **Note:** This property is the same as the **user_id** property at the root of
      "!    the message body. If **user_id** is specified in both locations in a message
      "!    request, the value specified at the root is used.
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
      "!    example, `2021-06-26T12:00:00Z` for noon UTC on 26 June 2021).<br/>
      "!   <br/>
      "!   This property is included only if the new system entities are enabled for the
      "!    skill.
      REFERENCE_TIME type STRING,
      "!   The time at which the session started. With the stateful `message` method, the
      "!    start time is always present, and is set by the service based on the time the
      "!    session was created. With the stateless `message` method, the start time is set
      "!    by the service in the response to the first message, and should be returned as
      "!    part of the context with each subsequent message in the session.<br/>
      "!   <br/>
      "!   This value is a UTC time value formatted according to ISO 8601 (for example,
      "!    `2021-06-26T12:00:00Z` for noon UTC on 26 June 2021).
      SESSION_START_TIME type STRING,
      "!   An encoded string that represents the configuration state of the assistant at
      "!    the beginning of the conversation. If you are using the stateless `message`
      "!    method, save this value and then send it in the context of the subsequent
      "!    message request to avoid disruptions if there are configuration changes during
      "!    the conversation (such as a change to a skill the assistant uses).
      STATE type STRING,
      "!   For internal use only.
      SKIP_USER_INPUT type BOOLEAN,
    end of T_MSSG_CONTEXT_GLOBAL_SYSTEM.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Session context data that is shared by all skills used by</p>
    "!     the assistant.
    begin of T_MESSAGE_CONTEXT_GLOBAL,
      "!   Built-in system properties that apply to all skills used by the assistant.
      SYSTEM type T_MSSG_CONTEXT_GLOBAL_SYSTEM,
      "!   The session ID.
      SESSION_ID type STRING,
    end of T_MESSAGE_CONTEXT_GLOBAL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    System context data used by the skill.</p>
    begin of T_MESSAGE_CONTEXT_SKILL_SYSTEM,
      "!   An encoded string that represents the current conversation state. By saving this
      "!    value and then sending it in the context of a subsequent message request, you
      "!    can return to an earlier point in the conversation. If you are using stateful
      "!    sessions, you can also use a stored state value to restore a paused
      "!    conversation whose session is expired.
      STATE type STRING,
    end of T_MESSAGE_CONTEXT_SKILL_SYSTEM.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Context variables that are used by the action skill.</p>
    begin of T_MESSAGE_CONTEXT_SKILL_ACTION,
      "!   An object containing any arbitrary variables that can be read and written by a
      "!    particular skill.
      USER_DEFINED type JSONOBJECT,
      "!   System context data used by the skill.
      SYSTEM type T_MESSAGE_CONTEXT_SKILL_SYSTEM,
      "!   An object containing action variables. Action variables can be accessed only by
      "!    steps in the same action, and do not persist after the action ends.
      ACTION_VARIABLES type JSONOBJECT,
      "!   An object containing skill variables. (In the Watson Assistant user interface,
      "!    skill variables are called _session variables_.) Skill variables can be
      "!    accessed by any action and persist for the duration of the session.
      SKILL_VARIABLES type JSONOBJECT,
    end of T_MESSAGE_CONTEXT_SKILL_ACTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Context variables that are used by the dialog skill.</p>
    begin of T_MESSAGE_CONTEXT_SKILL_DIALOG,
      "!   An object containing any arbitrary variables that can be read and written by a
      "!    particular skill.
      USER_DEFINED type JSONOBJECT,
      "!   System context data used by the skill.
      SYSTEM type T_MESSAGE_CONTEXT_SKILL_SYSTEM,
    end of T_MESSAGE_CONTEXT_SKILL_DIALOG.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Context data specific to particular skills used by the</p>
    "!     assistant.
    begin of T_MESSAGE_CONTEXT_SKILLS,
      "!   Context variables that are used by the dialog skill.
      MAIN_SKILL type T_MESSAGE_CONTEXT_SKILL_DIALOG,
      "!   Context variables that are used by the action skill.
      ACTIONS_SKILL type T_MESSAGE_CONTEXT_SKILL_ACTION,
    end of T_MESSAGE_CONTEXT_SKILLS.
  types:
    "! No documentation available.
    begin of T_MESSAGE_CONTEXT,
      "!   Session context data that is shared by all skills used by the assistant.
      GLOBAL type T_MESSAGE_CONTEXT_GLOBAL,
      "!   Context data specific to particular skills used by the assistant.
      SKILLS type T_MESSAGE_CONTEXT_SKILLS,
      "!   An object containing context data that is specific to particular integrations.
      "!    For more information, see the
      "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-dialog-int
      "!   egrations).
      INTEGRATIONS type JSONOBJECT,
    end of T_MESSAGE_CONTEXT.
  types:
    "! No documentation available.
    begin of T_RT_RESP_GNRC_RT_RESP_TYP_IMG,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   The `https:` URL of the image.
      SOURCE type STRING,
      "!   The title to show before the response.
      TITLE type STRING,
      "!   The description to show with the the response.
      DESCRIPTION type STRING,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
      "!   Descriptive text that can be used for screen readers or other situations where
      "!    the image cannot be seen.
      ALT_TEXT type STRING,
    end of T_RT_RESP_GNRC_RT_RESP_TYP_IMG.
  types:
    "! No documentation available.
    begin of T_TURN_EVENT_NODE_SOURCE,
      "!   The type of turn event.
      TYPE type STRING,
      "!   A dialog node that was visited during processing of the input message.
      DIALOG_NODE type STRING,
      "!   The title of the dialog node.
      TITLE type STRING,
      "!   The condition that triggered the dialog node.
      CONDITION type STRING,
    end of T_TURN_EVENT_NODE_SOURCE.
  types:
    "! No documentation available.
    begin of T_MSSG_OTPT_DBG_TRN_EVNT_TRN_8,
      "!   The type of turn event.
      EVENT type STRING,
      "!   No documentation available.
      SOURCE type T_TURN_EVENT_NODE_SOURCE,
      "!   The reason the dialog node was visited.
      REASON type STRING,
    end of T_MSSG_OTPT_DBG_TRN_EVNT_TRN_8.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Session context data that is shared by all skills used by</p>
    "!     the assistant.
    begin of T_MSSG_CNTXT_GLOBAL_STATELESS,
      "!   Built-in system properties that apply to all skills used by the assistant.
      SYSTEM type T_MSSG_CONTEXT_GLOBAL_SYSTEM,
      "!   The unique identifier of the session.
      SESSION_ID type STRING,
    end of T_MSSG_CNTXT_GLOBAL_STATELESS.
  types:
    "! No documentation available.
    begin of T_MESSAGE_CONTEXT_STATELESS,
      "!   Session context data that is shared by all skills used by the assistant.
      GLOBAL type T_MSSG_CNTXT_GLOBAL_STATELESS,
      "!   Context data specific to particular skills used by the assistant.
      SKILLS type T_MESSAGE_CONTEXT_SKILLS,
      "!   An object containing context data that is specific to particular integrations.
      "!    For more information, see the
      "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-dialog-int
      "!   egrations).
      INTEGRATIONS type JSONOBJECT,
    end of T_MESSAGE_CONTEXT_STATELESS.
  types:
    "! No documentation available.
    begin of T_RT_RESP_TYPE_USER_DEFINED,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   An object containing any properties for the user-defined response type.
      USER_DEFINED type JSONOBJECT,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RT_RESP_TYPE_USER_DEFINED.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The pagination data for the returned objects. For more</p>
    "!     information about using pagination, see [Pagination](#pagination).
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
    begin of T_AGENT_AVAILABILITY_MESSAGE,
      "!   The text of the message.
      MESSAGE type STRING,
    end of T_AGENT_AVAILABILITY_MESSAGE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Routing or other contextual information to be used by target</p>
    "!     service desk systems.
    begin of T_DIA_ND_OTPT_CNNCT_T_AGNT_TR1,
      "!   No documentation available.
      TARGET type MAP,
    end of T_DIA_ND_OTPT_CNNCT_T_AGNT_TR1.
  types:
    "! No documentation available.
    begin of T_RT_RESP_TYP_CONNECT_TO_AGENT,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   A message to be sent to the human agent who will be taking over the
      "!    conversation.
      MESSAGE_TO_HUMAN_AGENT type STRING,
      "!   An optional message to be displayed to the user to indicate that the
      "!    conversation will be transferred to the next available agent.
      AGENT_AVAILABLE type T_AGENT_AVAILABILITY_MESSAGE,
      "!   An optional message to be displayed to the user to indicate that no online agent
      "!    is available to take over the conversation.
      AGENT_UNAVAILABLE type T_AGENT_AVAILABILITY_MESSAGE,
      "!   Routing or other contextual information to be used by target service desk
      "!    systems.
      TRANSFER_INFO type T_DIA_ND_OTPT_CNNCT_T_AGNT_TR1,
      "!   A label identifying the topic of the conversation, derived from the **title**
      "!    property of the relevant node or the **topic** property of the dialog node
      "!    response.
      TOPIC type STRING,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RT_RESP_TYP_CONNECT_TO_AGENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Properties describing any spelling corrections in the user</p>
    "!     input that was received.
    begin of T_MESSAGE_OUTPUT_SPELLING,
      "!   The user input text that was used to generate the response. If spelling
      "!    autocorrection is enabled, this text reflects any spelling corrections that
      "!    were applied.
      TEXT type STRING,
      "!   The original user input text. This property is returned only if autocorrection
      "!    is enabled and the user input was corrected.
      ORIGINAL_TEXT type STRING,
      "!   Any suggested corrections of the input text. This property is returned only if
      "!    spelling correction is enabled and autocorrection is disabled.
      SUGGESTED_TEXT type STRING,
    end of T_MESSAGE_OUTPUT_SPELLING.
  types:
    "! No documentation available.
      T_RUNTIME_RESPONSE_GENERIC type JSONOBJECT.
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
      USER_DEFINED type JSONOBJECT,
      "!   Properties describing any spelling corrections in the user input that was
      "!    received.
      SPELLING type T_MESSAGE_OUTPUT_SPELLING,
    end of T_MESSAGE_OUTPUT.
  types:
    "! No documentation available.
    begin of T_RT_RESP_GNRC_RT_RESP_TYP_CH1,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel. <br/>
      "!   <br/>
      "!    **Note:** The `channel_transfer` response type is not supported on IBM Cloud
      "!    Pak for Data.
      RESPONSE_TYPE type STRING,
      "!   The message to display to the user when initiating a channel transfer.
      MESSAGE_TO_USER type STRING,
      "!   Information used by an integration to transfer the conversation to a different
      "!    channel.
      TRANSFER_INFO type T_CHANNEL_TRANSFER_INFO,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RT_RESP_GNRC_RT_RESP_TYP_CH1.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object defining the message input to be sent to the</p>
    "!     assistant if the user selects the corresponding disambiguation option. <br/>
    "!    <br/>
    "!     **Note:** This entire message input object must be included in the request body
    "!     of the next message sent to the assistant. Do not modify or remove any of the
    "!     included properties.
    begin of T_DIALOG_SUGGESTION_VALUE,
      "!   An input object that includes the input text.
      INPUT type T_MESSAGE_INPUT,
    end of T_DIALOG_SUGGESTION_VALUE.
  types:
    "! No documentation available.
    begin of T_DIALOG_SUGGESTION,
      "!   The user-facing label for the suggestion. This label is taken from the **title**
      "!    or **user_label** property of the corresponding dialog node, depending on the
      "!    disambiguation options.
      LABEL type STRING,
      "!   An object defining the message input to be sent to the assistant if the user
      "!    selects the corresponding disambiguation option. <br/>
      "!   <br/>
      "!    **Note:** This entire message input object must be included in the request body
      "!    of the next message sent to the assistant. Do not modify or remove any of the
      "!    included properties.
      VALUE type T_DIALOG_SUGGESTION_VALUE,
      "!   The dialog output that will be returned from the Watson Assistant service if the
      "!    user selects the corresponding option.
      OUTPUT type JSONOBJECT,
    end of T_DIALOG_SUGGESTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Optional properties that control how the assistant responds.</p>
    begin of T_BASE_MESSAGE_INPUT_OPTIONS,
      "!   Whether to restart dialog processing at the root of the dialog, regardless of
      "!    any previously visited nodes. **Note:** This does not affect `turn_count` or
      "!    any other context variables.
      RESTART type BOOLEAN,
      "!   Whether to return more than one intent. Set to `true` to return all matching
      "!    intents.
      ALTERNATE_INTENTS type BOOLEAN,
      "!   Spelling correction options for the message. Any options specified on an
      "!    individual message override the settings configured for the skill.
      SPELLING type T_MESSAGE_INPUT_OPT_SPELLING,
    end of T_BASE_MESSAGE_INPUT_OPTIONS.
  types:
    "! No documentation available.
      T_EMPTY_RESPONSE type JSONOBJECT.
  types:
    "! No documentation available.
    begin of T_RT_RESP_GNRC_RT_RESP_TYP_DT,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
    end of T_RT_RESP_GNRC_RT_RESP_TYP_DT.
  types:
    "! No documentation available.
    begin of T_TURN_EVENT_CALLOUT_CALLOUT,
      "!   The type of callout. Currently, the only supported value is
      "!    `integration_interaction` (for calls to extensions).
      TYPE type STRING,
      "!   For internal use only.
      INTERNAL type JSONOBJECT,
      "!   The name of the variable where the callout result is stored.
      RESULT_VARIABLE type STRING,
    end of T_TURN_EVENT_CALLOUT_CALLOUT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The user input utterance to classify.</p>
    begin of T_BULK_CLASSIFY_UTTERANCE,
      "!   The text of the input utterance.
      TEXT type STRING,
    end of T_BULK_CLASSIFY_UTTERANCE.
  types:
    "! No documentation available.
    begin of T_BULK_CLASSIFY_OUTPUT,
      "!   The user input utterance to classify.
      INPUT type T_BULK_CLASSIFY_UTTERANCE,
      "!   An array of entities identified in the utterance.
      ENTITIES type STANDARD TABLE OF T_RUNTIME_ENTITY WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of intents recognized in the utterance.
      INTENTS type STANDARD TABLE OF T_RUNTIME_INTENT WITH NON-UNIQUE DEFAULT KEY,
    end of T_BULK_CLASSIFY_OUTPUT.
  types:
    "! No documentation available.
    begin of T_BULK_CLASSIFY_RESPONSE,
      "!   An array of objects that contain classification information for the submitted
      "!    input utterances.
      OUTPUT type STANDARD TABLE OF T_BULK_CLASSIFY_OUTPUT WITH NON-UNIQUE DEFAULT KEY,
    end of T_BULK_CLASSIFY_RESPONSE.
  types:
    "! No documentation available.
    begin of T_ENVIRONMENT,
      "!   The name of the environment.
      NAME type STRING,
      "!   The description of the environment.
      DESCRIPTION type STRING,
      "!   The assistant ID of the assistant the environment is associated with.
      ASSISTANT_ID type STRING,
      "!   The environment ID of the environment.
      ENVIRONMENT_ID type STRING,
      "!   The type of the environment. All environments other than the `draft` and `live`
      "!    environments have the type `staging`.
      ENVIRONMENT type STRING,
      "!   An object describing the release that is currently deployed in the environment.
      RELEASE_REFERENCE type T_BASE_ENV_RELEASE_REFERENCE,
      "!   The search skill orchestration settings for the environment.
      ORCHESTRATION type T_BASE_ENV_ORCHESTRATION,
      "!   The session inactivity timeout setting for the environment (in seconds).
      SESSION_TIMEOUT type INTEGER,
      "!   An array of objects describing the integrations that exist in the environment.
      INTEGRATION_REFERENCES type STANDARD TABLE OF T_INTEGRATION_REFERENCE WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects identifying the skills (such as action and dialog) that
      "!    exist in the environment.
      SKILL_REFERENCES type STANDARD TABLE OF T_ENVIRONMENT_SKILL WITH NON-UNIQUE DEFAULT KEY,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_ENVIRONMENT.
  types:
    "! No documentation available.
    begin of T_BULK_CLASSIFY_INPUT,
      "!   An array of input utterances to classify.
      INPUT type STANDARD TABLE OF T_BULK_CLASSIFY_UTTERANCE WITH NON-UNIQUE DEFAULT KEY,
    end of T_BULK_CLASSIFY_INPUT.
  types:
    "! No documentation available.
    begin of T_BASE_ENVIRONMENT,
      "!   The name of the environment.
      NAME type STRING,
      "!   The description of the environment.
      DESCRIPTION type STRING,
      "!   The assistant ID of the assistant the environment is associated with.
      ASSISTANT_ID type STRING,
      "!   The environment ID of the environment.
      ENVIRONMENT_ID type STRING,
      "!   The type of the environment. All environments other than the `draft` and `live`
      "!    environments have the type `staging`.
      ENVIRONMENT type STRING,
      "!   An object describing the release that is currently deployed in the environment.
      RELEASE_REFERENCE type T_BASE_ENV_RELEASE_REFERENCE,
      "!   The search skill orchestration settings for the environment.
      ORCHESTRATION type T_BASE_ENV_ORCHESTRATION,
      "!   The session inactivity timeout setting for the environment (in seconds).
      SESSION_TIMEOUT type INTEGER,
      "!   An array of objects describing the integrations that exist in the environment.
      INTEGRATION_REFERENCES type STANDARD TABLE OF T_INTEGRATION_REFERENCE WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects identifying the skills (such as action and dialog) that
      "!    exist in the environment.
      SKILL_REFERENCES type STANDARD TABLE OF T_ENVIRONMENT_SKILL WITH NON-UNIQUE DEFAULT KEY,
      "!   The timestamp for creation of the object.
      CREATED type DATETIME,
      "!   The timestamp for the most recent update to the object.
      UPDATED type DATETIME,
    end of T_BASE_ENVIRONMENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that identifies the dialog element that generated</p>
    "!     the error message.
    begin of T_LOG_MESSAGE_SOURCE_HANDLER,
      "!   A string that indicates the type of dialog element that generated the error
      "!    message.
      TYPE type STRING,
      "!   The unique identifier of the action that generated the error message.
      ACTION type STRING,
      "!   The unique identifier of the step that generated the error message.
      STEP type STRING,
      "!   The unique identifier of the handler that generated the error message.
      HANDLER type STRING,
    end of T_LOG_MESSAGE_SOURCE_HANDLER.
  types:
    "! No documentation available.
    begin of T_BASE_MESSAGE_CONTEXT_SKILL,
      "!   An object containing any arbitrary variables that can be read and written by a
      "!    particular skill.
      USER_DEFINED type JSONOBJECT,
      "!   System context data used by the skill.
      SYSTEM type T_MESSAGE_CONTEXT_SKILL_SYSTEM,
    end of T_BASE_MESSAGE_CONTEXT_SKILL.
  types:
    "! No documentation available.
    begin of T_TURN_EVENT_ACTION_FINISHED,
      "!   The type of turn event.
      EVENT type STRING,
      "!   No documentation available.
      SOURCE type T_TURN_EVENT_ACTION_SOURCE,
      "!   The time when the action started processing the message.
      ACTION_START_TIME type STRING,
      "!   The type of condition (if any) that is defined for the action.
      CONDITION_TYPE type STRING,
      "!   The reason the action finished processing.
      REASON type STRING,
      "!   The state of all action variables at the time the action finished.
      ACTION_VARIABLES type JSONOBJECT,
    end of T_TURN_EVENT_ACTION_FINISHED.
  types:
    "! No documentation available.
    begin of T_RT_RESP_GNRC_RT_RESP_TYP_CN1,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   A message to be sent to the human agent who will be taking over the
      "!    conversation.
      MESSAGE_TO_HUMAN_AGENT type STRING,
      "!   An optional message to be displayed to the user to indicate that the
      "!    conversation will be transferred to the next available agent.
      AGENT_AVAILABLE type T_AGENT_AVAILABILITY_MESSAGE,
      "!   An optional message to be displayed to the user to indicate that no online agent
      "!    is available to take over the conversation.
      AGENT_UNAVAILABLE type T_AGENT_AVAILABILITY_MESSAGE,
      "!   Routing or other contextual information to be used by target service desk
      "!    systems.
      TRANSFER_INFO type T_DIA_ND_OTPT_CNNCT_T_AGNT_TR1,
      "!   A label identifying the topic of the conversation, derived from the **title**
      "!    property of the relevant node or the **topic** property of the dialog node
      "!    response.
      TOPIC type STRING,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RT_RESP_GNRC_RT_RESP_TYP_CN1.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A response from the Watson Assistant service.</p>
    begin of T_MESSAGE_RESPONSE,
      "!   Assistant output to be rendered or processed by the client.
      OUTPUT type T_MESSAGE_OUTPUT,
      "!   Context data for the conversation. You can use this property to access context
      "!    variables. The context is stored by the assistant on a per-session basis.<br/>
      "!   <br/>
      "!   **Note:** The context is included in message responses only if
      "!    **return_context**=`true` in the message request. Full context is always
      "!    included in logs.
      CONTEXT type T_MESSAGE_CONTEXT,
      "!   A string value that identifies the user who is interacting with the assistant.
      "!    The client must provide a unique identifier for each individual end user who
      "!    accesses the application. For user-based plans, this user ID is used to
      "!    identify unique users for billing purposes. This string cannot contain carriage
      "!    return, newline, or tab characters. If no value is specified in the input,
      "!    **user_id** is automatically set to the value of
      "!    **context.global.session_id**.<br/>
      "!   <br/>
      "!   **Note:** This property is the same as the **user_id** property in the global
      "!    system context.
      USER_ID type STRING,
    end of T_MESSAGE_RESPONSE.
  types:
    "! No documentation available.
    begin of T_TURN_EVENT_CALLOUT_ERROR,
      "!   Any error message returned by a failed call to an external service.
      MESSAGE type STRING,
    end of T_TURN_EVENT_CALLOUT_ERROR.
  types:
    "! No documentation available.
    begin of T_TURN_EVENT_CALLOUT,
      "!   The type of turn event.
      EVENT type STRING,
      "!   No documentation available.
      SOURCE type T_TURN_EVENT_ACTION_SOURCE,
      "!   No documentation available.
      CALLOUT type T_TURN_EVENT_CALLOUT_CALLOUT,
      "!   No documentation available.
      ERROR type T_TURN_EVENT_CALLOUT_ERROR,
    end of T_TURN_EVENT_CALLOUT.
  types:
    "! No documentation available.
    begin of T_ASSISTANT_SKILL,
      "!   The skill ID of the skill.
      SKILL_ID type STRING,
      "!   The type of the skill.
      TYPE type STRING,
    end of T_ASSISTANT_SKILL.
  types:
    "! No documentation available.
    begin of T_ASSISTANT_DATA,
      "!   The unique identifier of the assistant.
      ASSISTANT_ID type STRING,
      "!   The name of the assistant. This string cannot contain carriage return, newline,
      "!    or tab characters.
      NAME type STRING,
      "!   The description of the assistant. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   The language of the assistant.
      LANGUAGE type STRING,
      "!   An array of skill references identifying the skills associated with the
      "!    assistant.
      ASSISTANT_SKILLS type STANDARD TABLE OF T_ASSISTANT_SKILL WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects describing the environments defined for the assistant.
      ASSISTANT_ENVIRONMENTS type STANDARD TABLE OF T_ENVIRONMENT_REFERENCE WITH NON-UNIQUE DEFAULT KEY,
    end of T_ASSISTANT_DATA.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The pagination data for the returned objects. For more</p>
    "!     information about using pagination, see [Pagination](#pagination).
    begin of T_PAGINATION,
      "!   The URL that will return the same page of results.
      REFRESH_URL type STRING,
      "!   The URL that will return the next page of results.
      NEXT_URL type STRING,
      "!   The total number of objects that satisfy the request. This total includes all
      "!    results, not just those included in the current page.
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
    begin of T_ENVIRONMENT_COLLECTION,
      "!   An array of objects describing the environments associated with an assistant.
      ENVIRONMENTS type STANDARD TABLE OF T_ENVIRONMENT WITH NON-UNIQUE DEFAULT KEY,
      "!   The pagination data for the returned objects. For more information about using
      "!    pagination, see [Pagination](#pagination).
      PAGINATION type T_PAGINATION,
    end of T_ENVIRONMENT_COLLECTION.
  types:
    "! No documentation available.
    begin of T_RUNTIME_RESPONSE_TYPE_PAUSE,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   How long to pause, in milliseconds.
      TIME type INTEGER,
      "!   Whether to send a &quot;user is typing&quot; event during the pause.
      TYPING type BOOLEAN,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RUNTIME_RESPONSE_TYPE_PAUSE.
  types:
    "! No documentation available.
    begin of T_RT_RESP_GNRC_RT_RESP_TYP_US1,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   An object containing any properties for the user-defined response type.
      USER_DEFINED type JSONOBJECT,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RT_RESP_GNRC_RT_RESP_TYP_US1.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object containing segments of text from search results</p>
    "!     with query-matching text highlighted using HTML `&lt;em&gt;` tags.
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
    "!    An object containing search result metadata from the</p>
    "!     Discovery service.
    begin of T_SEARCH_RESULT_METADATA,
      "!   The confidence score for the given result, as returned by the Discovery service.
      "!
      CONFIDENCE type DOUBLE,
      "!   An unbounded measure of the relevance of a particular result, dependent on the
      "!    query and matching document. A higher score indicates a greater match to the
      "!    query parameters.
      SCORE type DOUBLE,
    end of T_SEARCH_RESULT_METADATA.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object specifing a segment of text that was identified as</p>
    "!     a direct answer to the search query.
    begin of T_SEARCH_RESULT_ANSWER,
      "!   The text of the answer.
      TEXT type STRING,
      "!   The confidence score for the answer, as returned by the Discovery service.
      CONFIDENCE type DOUBLE,
    end of T_SEARCH_RESULT_ANSWER.
  types:
    "! No documentation available.
    begin of T_SEARCH_RESULT,
      "!   The unique identifier of the document in the Discovery service collection.<br/>
      "!   <br/>
      "!   This property is included in responses from search skills, which are available
      "!    only to Plus or Enterprise plan users.
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
      "!    text highlighted using HTML `&lt;em&gt;` tags.
      HIGHLIGHT type T_SEARCH_RESULT_HIGHLIGHT,
      "!   An array specifying segments of text within the result that were identified as
      "!    direct answers to the search query. Currently, only the single answer with the
      "!    highest confidence (if any) is returned.<br/>
      "!   <br/>
      "!   **Notes:** <br/>
      "!    - Answer finding is available only if the search skill is connected to a
      "!    Discovery v2 service instance. <br/>
      "!    - Answer finding is not supported on IBM Cloud Pak for Data.
      ANSWERS type STANDARD TABLE OF T_SEARCH_RESULT_ANSWER WITH NON-UNIQUE DEFAULT KEY,
    end of T_SEARCH_RESULT.
  types:
    "! No documentation available.
    begin of T_RUNTIME_RESPONSE_TYPE_SEARCH,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   The title or introductory text to show before the response. This text is defined
      "!    in the search skill configuration.
      HEADER type STRING,
      "!   An array of objects that contains the search results to be displayed in the
      "!    initial response to the user.
      PRIMARY_RESULTS type STANDARD TABLE OF T_SEARCH_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects that contains additional search results that can be
      "!    displayed to the user upon request.
      ADDITIONAL_RESULTS type STANDARD TABLE OF T_SEARCH_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RUNTIME_RESPONSE_TYPE_SEARCH.
  types:
    "! No documentation available.
    begin of T_SKILLS_EXPORT,
      "!   An array of objects describing the skills for the assistant. Included in
      "!    responses only if **status**=`Available`.
      ASSISTANT_SKILLS type STANDARD TABLE OF T_SKILL WITH NON-UNIQUE DEFAULT KEY,
      "!   Status information about the skills for the assistant. Included in responses
      "!    only if **status**=`Available`.
      ASSISTANT_STATE type T_ASSISTANT_STATE,
    end of T_SKILLS_EXPORT.
  types:
    "! No documentation available.
    begin of T_RUNTIME_RESPONSE_TYPE_IFRAME,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   The `https:` URL of the embeddable content.
      SOURCE type STRING,
      "!   The title or introductory text to show before the response.
      TITLE type STRING,
      "!   The description to show with the the response.
      DESCRIPTION type STRING,
      "!   The URL of an image that shows a preview of the embedded content.
      IMAGE_URL type STRING,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RUNTIME_RESPONSE_TYPE_IFRAME.
  types:
    "! No documentation available.
    begin of T_RT_RESP_GNRC_RT_RESP_TYP_PS,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   How long to pause, in milliseconds.
      TIME type INTEGER,
      "!   Whether to send a &quot;user is typing&quot; event during the pause.
      TYPING type BOOLEAN,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RT_RESP_GNRC_RT_RESP_TYP_PS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A stateless response from the Watson Assistant service.</p>
    begin of T_MESSAGE_RESPONSE_STATELESS,
      "!   Assistant output to be rendered or processed by the client.
      OUTPUT type T_MESSAGE_OUTPUT,
      "!   Context data for the conversation. You can use this property to access context
      "!    variables. The context is not stored by the assistant; to maintain session
      "!    state, include the context from the response in the next message.
      CONTEXT type T_MESSAGE_CONTEXT_STATELESS,
      "!   A string value that identifies the user who is interacting with the assistant.
      "!    The client must provide a unique identifier for each individual end user who
      "!    accesses the application. For user-based plans, this user ID is used to
      "!    identify unique users for billing purposes. This string cannot contain carriage
      "!    return, newline, or tab characters. If no value is specified in the input,
      "!    **user_id** is automatically set to the value of
      "!    **context.global.session_id**.<br/>
      "!   <br/>
      "!   **Note:** This property is the same as the **user_id** property in the global
      "!    system context.
      USER_ID type STRING,
    end of T_MESSAGE_RESPONSE_STATELESS.
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
    begin of T_TURN_EVENT_HANDLER_VISITED,
      "!   The type of turn event.
      EVENT type STRING,
      "!   No documentation available.
      SOURCE type T_TURN_EVENT_ACTION_SOURCE,
      "!   The time when the action started processing the message.
      ACTION_START_TIME type STRING,
    end of T_TURN_EVENT_HANDLER_VISITED.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Session context data that is shared by all skills used by</p>
    "!     the assistant.
    begin of T_BASE_MESSAGE_CONTEXT_GLOBAL,
      "!   Built-in system properties that apply to all skills used by the assistant.
      SYSTEM type T_MSSG_CONTEXT_GLOBAL_SYSTEM,
    end of T_BASE_MESSAGE_CONTEXT_GLOBAL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that identifies the dialog element that generated</p>
    "!     the error message.
    begin of T_LOG_MESSAGE_SOURCE_DIA_NODE,
      "!   A string that indicates the type of dialog element that generated the error
      "!    message.
      TYPE type STRING,
      "!   The unique identifier of the dialog node that generated the error message.
      DIALOG_NODE type STRING,
    end of T_LOG_MESSAGE_SOURCE_DIA_NODE.
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
    begin of T_RT_RESP_GNRC_RT_RESP_TYP_SG1,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   The title or introductory text to show before the response.
      TITLE type STRING,
      "!   An array of objects describing the possible matching dialog nodes from which the
      "!    user can choose.
      SUGGESTIONS type STANDARD TABLE OF T_DIALOG_SUGGESTION WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RT_RESP_GNRC_RT_RESP_TYP_SG1.
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
    "! <p class="shorttext synchronized" lang="en">
    "!    Optional properties that control how the assistant responds.</p>
    begin of T_MESSAGE_INPUT_OPT_STATELESS,
      "!   Whether to restart dialog processing at the root of the dialog, regardless of
      "!    any previously visited nodes. **Note:** This does not affect `turn_count` or
      "!    any other context variables.
      RESTART type BOOLEAN,
      "!   Whether to return more than one intent. Set to `true` to return all matching
      "!    intents.
      ALTERNATE_INTENTS type BOOLEAN,
      "!   Spelling correction options for the message. Any options specified on an
      "!    individual message override the settings configured for the skill.
      SPELLING type T_MESSAGE_INPUT_OPT_SPELLING,
      "!   Whether to return additional diagnostic information. Set to `true` to return
      "!    additional information in the `output.debug` property.
      DEBUG type BOOLEAN,
    end of T_MESSAGE_INPUT_OPT_STATELESS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An input object that includes the input text.</p>
    begin of T_BASE_MESSAGE_INPUT,
      "!   The type of the message:<br/>
      "!   <br/>
      "!   - `text`: The user input is processed normally by the assistant.<br/>
      "!   - `search`: Only search results are returned. (Any dialog or action skill is
      "!    bypassed.)<br/>
      "!   <br/>
      "!   **Note:** A `search` message results in an error if no search skill is
      "!    configured for the assistant.
      MESSAGE_TYPE type STRING,
      "!   The text of the user input. This string cannot contain carriage return, newline,
      "!    or tab characters.
      TEXT type STRING,
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
      "!   An array of multimedia attachments to be sent with the message. Attachments are
      "!    not processed by the assistant itself, but can be sent to external services by
      "!    webhooks. <br/>
      "!   <br/>
      "!    **Note:** Attachments are not supported on IBM Cloud Pak for Data.
      ATTACHMENTS type STANDARD TABLE OF T_MESSAGE_INPUT_ATTACHMENT WITH NON-UNIQUE DEFAULT KEY,
      "!   An optional object containing analytics data. Currently, this data is used only
      "!    for events sent to the Segment extension.
      ANALYTICS type T_REQUEST_ANALYTICS,
    end of T_BASE_MESSAGE_INPUT.
  types:
    "! No documentation available.
    begin of T_UPDATE_SKILL,
      "!   The name of the skill. This string cannot contain carriage return, newline, or
      "!    tab characters.
      NAME type STRING,
      "!   The description of the skill. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   An object containing the conversational content of an action or dialog skill.
      WORKSPACE type JSONOBJECT,
      "!   The skill ID of the skill.
      SKILL_ID type STRING,
      "!   The current status of the skill: <br/>
      "!    - **Available**: The skill is available and ready to process messages. <br/>
      "!    - **Failed**: An asynchronous operation has failed. See the **status_errors**
      "!    property for more information about the cause of the failure. <br/>
      "!    - **Non Existent**: The skill does not exist. <br/>
      "!    - **Processing**: An asynchronous operation has not yet completed. <br/>
      "!    - **Training**: The skill is training based on new data.
      STATUS type STRING,
      "!   An array of messages about errors that caused an asynchronous operation to fail.
      "!    Included only if **status**=`Failed`.
      STATUS_ERRORS type STANDARD TABLE OF T_STATUS_ERROR WITH NON-UNIQUE DEFAULT KEY,
      "!   The description of the failed asynchronous operation. Included only if
      "!    **status**=`Failed`.
      STATUS_DESCRIPTION type STRING,
      "!   For internal use only.
      DIALOG_SETTINGS type JSONOBJECT,
      "!   The unique identifier of the assistant the skill is associated with.
      ASSISTANT_ID type STRING,
      "!   The unique identifier of the workspace that contains the skill content. Included
      "!    only for action and dialog skills.
      WORKSPACE_ID type STRING,
      "!   The unique identifier of the environment where the skill is defined. For action
      "!    and dialog skills, this is always the draft environment.
      ENVIRONMENT_ID type STRING,
      "!   Whether the skill is structurally valid.
      VALID type BOOLEAN,
      "!   The name that will be given to the next snapshot that is created for the skill.
      "!    A snapshot of each versionable skill is saved for each new release of an
      "!    assistant.
      NEXT_SNAPSHOT_VERSION type STRING,
      "!   An object describing the search skill configuration.
      SEARCH_SETTINGS type T_SEARCH_SETTINGS,
      "!   An array of warnings describing errors with the search skill configuration.
      "!    Included only for search skills.
      WARNINGS type STANDARD TABLE OF T_SEARCH_SKILL_WARNING WITH NON-UNIQUE DEFAULT KEY,
    end of T_UPDATE_SKILL.
  types:
    "! No documentation available.
    begin of T_BASE_SKILL,
      "!   The name of the skill. This string cannot contain carriage return, newline, or
      "!    tab characters.
      NAME type STRING,
      "!   The description of the skill. This string cannot contain carriage return,
      "!    newline, or tab characters.
      DESCRIPTION type STRING,
      "!   An object containing the conversational content of an action or dialog skill.
      WORKSPACE type JSONOBJECT,
      "!   The skill ID of the skill.
      SKILL_ID type STRING,
      "!   The current status of the skill: <br/>
      "!    - **Available**: The skill is available and ready to process messages. <br/>
      "!    - **Failed**: An asynchronous operation has failed. See the **status_errors**
      "!    property for more information about the cause of the failure. <br/>
      "!    - **Non Existent**: The skill does not exist. <br/>
      "!    - **Processing**: An asynchronous operation has not yet completed. <br/>
      "!    - **Training**: The skill is training based on new data.
      STATUS type STRING,
      "!   An array of messages about errors that caused an asynchronous operation to fail.
      "!    Included only if **status**=`Failed`.
      STATUS_ERRORS type STANDARD TABLE OF T_STATUS_ERROR WITH NON-UNIQUE DEFAULT KEY,
      "!   The description of the failed asynchronous operation. Included only if
      "!    **status**=`Failed`.
      STATUS_DESCRIPTION type STRING,
      "!   For internal use only.
      DIALOG_SETTINGS type JSONOBJECT,
      "!   The unique identifier of the assistant the skill is associated with.
      ASSISTANT_ID type STRING,
      "!   The unique identifier of the workspace that contains the skill content. Included
      "!    only for action and dialog skills.
      WORKSPACE_ID type STRING,
      "!   The unique identifier of the environment where the skill is defined. For action
      "!    and dialog skills, this is always the draft environment.
      ENVIRONMENT_ID type STRING,
      "!   Whether the skill is structurally valid.
      VALID type BOOLEAN,
      "!   The name that will be given to the next snapshot that is created for the skill.
      "!    A snapshot of each versionable skill is saved for each new release of an
      "!    assistant.
      NEXT_SNAPSHOT_VERSION type STRING,
      "!   An object describing the search skill configuration.
      SEARCH_SETTINGS type T_SEARCH_SETTINGS,
      "!   An array of warnings describing errors with the search skill configuration.
      "!    Included only for search skills.
      WARNINGS type STANDARD TABLE OF T_SEARCH_SKILL_WARNING WITH NON-UNIQUE DEFAULT KEY,
    end of T_BASE_SKILL.
  types:
    "! No documentation available.
    begin of T_RUNTIME_RESPONSE_TYPE_DATE,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
    end of T_RUNTIME_RESPONSE_TYPE_DATE.
  types:
    "! No documentation available.
    begin of T_RELEASE_COLLECTION,
      "!   An array of objects describing the releases associated with an assistant.
      RELEASES type STANDARD TABLE OF T_RELEASE WITH NON-UNIQUE DEFAULT KEY,
      "!   The pagination data for the returned objects. For more information about using
      "!    pagination, see [Pagination](#pagination).
      PAGINATION type T_PAGINATION,
    end of T_RELEASE_COLLECTION.
  types:
    "! No documentation available.
    begin of T_ASSISTANT_COLLECTION,
      "!   An array of objects describing the assistants associated with the instance.
      ASSISTANTS type STANDARD TABLE OF T_ASSISTANT_DATA WITH NON-UNIQUE DEFAULT KEY,
      "!   The pagination data for the returned objects. For more information about using
      "!    pagination, see [Pagination](#pagination).
      PAGINATION type T_PAGINATION,
    end of T_ASSISTANT_COLLECTION.
  types:
    "! No documentation available.
    begin of T_TURN_EVENT_NODE_VISITED,
      "!   The type of turn event.
      EVENT type STRING,
      "!   No documentation available.
      SOURCE type T_TURN_EVENT_NODE_SOURCE,
      "!   The reason the dialog node was visited.
      REASON type STRING,
    end of T_TURN_EVENT_NODE_VISITED.
  types:
    "! No documentation available.
    begin of T_MSSG_OTPT_DBG_TRN_EVNT_TRN_5,
      "!   The type of turn event.
      EVENT type STRING,
      "!   No documentation available.
      SOURCE type T_TURN_EVENT_ACTION_SOURCE,
      "!   The time when the action started processing the message.
      ACTION_START_TIME type STRING,
    end of T_MSSG_OTPT_DBG_TRN_EVNT_TRN_5.
  types:
    "! No documentation available.
    begin of T_MSSG_OTPT_DBG_TRN_EVNT_TRN_6,
      "!   The type of turn event.
      EVENT type STRING,
      "!   No documentation available.
      SOURCE type T_TURN_EVENT_ACTION_SOURCE,
      "!   No documentation available.
      CALLOUT type T_TURN_EVENT_CALLOUT_CALLOUT,
      "!   No documentation available.
      ERROR type T_TURN_EVENT_CALLOUT_ERROR,
    end of T_MSSG_OTPT_DBG_TRN_EVNT_TRN_6.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An input object that includes the input text.</p>
    begin of T_MESSAGE_INPUT_STATELESS,
      "!   The type of the message:<br/>
      "!   <br/>
      "!   - `text`: The user input is processed normally by the assistant.<br/>
      "!   - `search`: Only search results are returned. (Any dialog or action skill is
      "!    bypassed.)<br/>
      "!   <br/>
      "!   **Note:** A `search` message results in an error if no search skill is
      "!    configured for the assistant.
      MESSAGE_TYPE type STRING,
      "!   The text of the user input. This string cannot contain carriage return, newline,
      "!    or tab characters.
      TEXT type STRING,
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
      "!   An array of multimedia attachments to be sent with the message. Attachments are
      "!    not processed by the assistant itself, but can be sent to external services by
      "!    webhooks. <br/>
      "!   <br/>
      "!    **Note:** Attachments are not supported on IBM Cloud Pak for Data.
      ATTACHMENTS type STANDARD TABLE OF T_MESSAGE_INPUT_ATTACHMENT WITH NON-UNIQUE DEFAULT KEY,
      "!   An optional object containing analytics data. Currently, this data is used only
      "!    for events sent to the Segment extension.
      ANALYTICS type T_REQUEST_ANALYTICS,
      "!   Optional properties that control how the assistant responds.
      OPTIONS type T_MESSAGE_INPUT_OPT_STATELESS,
    end of T_MESSAGE_INPUT_STATELESS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A stateless message request formatted for the Watson</p>
    "!     Assistant service.
    begin of T_MESSAGE_REQUEST_STATELESS,
      "!   An input object that includes the input text.
      INPUT type T_MESSAGE_INPUT_STATELESS,
      "!   Context data for the conversation. You can use this property to set or modify
      "!    context variables, which can also be accessed by dialog nodes. The context is
      "!    not stored by the assistant. To maintain session state, include the context
      "!    from the previous response.<br/>
      "!   <br/>
      "!   **Note:** The total size of the context data for a stateless session cannot
      "!    exceed 250KB.
      CONTEXT type T_MESSAGE_CONTEXT_STATELESS,
      "!   A string value that identifies the user who is interacting with the assistant.
      "!    The client must provide a unique identifier for each individual end user who
      "!    accesses the application. For user-based plans, this user ID is used to
      "!    identify unique users for billing purposes. This string cannot contain carriage
      "!    return, newline, or tab characters. If no value is specified in the input,
      "!    **user_id** is automatically set to the value of
      "!    **context.global.session_id**.<br/>
      "!   <br/>
      "!   **Note:** This property is the same as the **user_id** property in the global
      "!    system context. If **user_id** is specified in both locations in a message
      "!    request, the value specified at the root is used.
      USER_ID type STRING,
    end of T_MESSAGE_REQUEST_STATELESS.
  types:
    "! No documentation available.
    begin of T_RT_RESPONSE_TYPE_SUGGESTION,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   The title or introductory text to show before the response.
      TITLE type STRING,
      "!   An array of objects describing the possible matching dialog nodes from which the
      "!    user can choose.
      SUGGESTIONS type STANDARD TABLE OF T_DIALOG_SUGGESTION WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RT_RESPONSE_TYPE_SUGGESTION.
  types:
    "! No documentation available.
    begin of T_MSSG_OTPT_DBG_TRN_EVNT_TRN_4,
      "!   The type of turn event.
      EVENT type STRING,
      "!   No documentation available.
      SOURCE type T_TURN_EVENT_ACTION_SOURCE,
      "!   The type of condition (if any) that is defined for the action.
      CONDITION_TYPE type STRING,
      "!   The time when the action started processing the message.
      ACTION_START_TIME type STRING,
      "!   Whether the step was answered in response to a prompt from the assistant. If
      "!    this property is `false`, the user provided the answer without visiting the
      "!    step.
      PROMPTED type BOOLEAN,
    end of T_MSSG_OTPT_DBG_TRN_EVNT_TRN_4.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that identifies the dialog element that generated</p>
    "!     the error message.
    begin of T_LOG_MESSAGE_SOURCE_STEP,
      "!   A string that indicates the type of dialog element that generated the error
      "!    message.
      TYPE type STRING,
      "!   The unique identifier of the action that generated the error message.
      ACTION type STRING,
      "!   The unique identifier of the step that generated the error message.
      STEP type STRING,
    end of T_LOG_MESSAGE_SOURCE_STEP.
  types:
    "! No documentation available.
    begin of T_TURN_EVENT_STEP_ANSWERED,
      "!   The type of turn event.
      EVENT type STRING,
      "!   No documentation available.
      SOURCE type T_TURN_EVENT_ACTION_SOURCE,
      "!   The type of condition (if any) that is defined for the action.
      CONDITION_TYPE type STRING,
      "!   The time when the action started processing the message.
      ACTION_START_TIME type STRING,
      "!   Whether the step was answered in response to a prompt from the assistant. If
      "!    this property is `false`, the user provided the answer without visiting the
      "!    step.
      PROMPTED type BOOLEAN,
    end of T_TURN_EVENT_STEP_ANSWERED.
  types:
    "! No documentation available.
    begin of T_SKILLS_ASYNC_REQUEST_STATUS,
      "!   The assistant ID of the assistant.
      ASSISTANT_ID type STRING,
      "!   The current status of the asynchronous operation: <br/>
      "!    - `Available`: An asynchronous export is available. <br/>
      "!    - `Completed`: An asynchronous import operation has completed successfully.
      "!    <br/>
      "!    - `Failed`: An asynchronous operation has failed. See the **status_errors**
      "!    property for more information about the cause of the failure. <br/>
      "!    - `Processing`: An asynchronous operation has not yet completed.
      STATUS type STRING,
      "!   The description of the failed asynchronous operation. Included only if
      "!    **status**=`Failed`.
      STATUS_DESCRIPTION type STRING,
      "!   An array of messages about errors that caused an asynchronous operation to fail.
      "!    Included only if **status**=`Failed`.
      STATUS_ERRORS type STANDARD TABLE OF T_STATUS_ERROR WITH NON-UNIQUE DEFAULT KEY,
    end of T_SKILLS_ASYNC_REQUEST_STATUS.
  types:
    "! No documentation available.
    begin of T_RT_RESP_GNRC_RT_RESP_TYP_TXT,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   The text of the response.
      TEXT type STRING,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RT_RESP_GNRC_RT_RESP_TYP_TXT.
  types:
    "! No documentation available.
    begin of T_SESSION_RESPONSE,
      "!   The session ID.
      SESSION_ID type STRING,
    end of T_SESSION_RESPONSE.
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
    begin of T_RUNTIME_RESPONSE_TYPE_AUDIO,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   The `https:` URL of the audio clip.
      SOURCE type STRING,
      "!   The title or introductory text to show before the response.
      TITLE type STRING,
      "!   The description to show with the the response.
      DESCRIPTION type STRING,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
      "!   For internal use only.
      CHANNEL_OPTIONS type JSONOBJECT,
      "!   Descriptive text that can be used for screen readers or other situations where
      "!    the audio player cannot be seen.
      ALT_TEXT type STRING,
    end of T_RUNTIME_RESPONSE_TYPE_AUDIO.
  types:
    "! No documentation available.
    begin of T_MSSG_OTPT_DBG_TRN_EVNT_TRN_7,
      "!   The type of turn event.
      EVENT type STRING,
      "!   No documentation available.
      SOURCE type T_TURN_EVENT_ACTION_SOURCE,
      "!   No documentation available.
      ERROR type T_TURN_EVENT_SEARCH_ERROR,
    end of T_MSSG_OTPT_DBG_TRN_EVNT_TRN_7.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An object that identifies the dialog element that generated</p>
    "!     the error message.
    begin of T_LOG_MESSAGE_SOURCE_ACTION,
      "!   A string that indicates the type of dialog element that generated the error
      "!    message.
      TYPE type STRING,
      "!   The unique identifier of the action that generated the error message.
      ACTION type STRING,
    end of T_LOG_MESSAGE_SOURCE_ACTION.
  types:
    "! No documentation available.
    begin of T_RUNTIME_RESPONSE_TYPE_IMAGE,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   The `https:` URL of the image.
      SOURCE type STRING,
      "!   The title to show before the response.
      TITLE type STRING,
      "!   The description to show with the the response.
      DESCRIPTION type STRING,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
      "!   Descriptive text that can be used for screen readers or other situations where
      "!    the image cannot be seen.
      ALT_TEXT type STRING,
    end of T_RUNTIME_RESPONSE_TYPE_IMAGE.
  types:
    "! No documentation available.
    begin of T_TURN_EVENT_STEP_VISITED,
      "!   The type of turn event.
      EVENT type STRING,
      "!   No documentation available.
      SOURCE type T_TURN_EVENT_ACTION_SOURCE,
      "!   The type of condition (if any) that is defined for the action.
      CONDITION_TYPE type STRING,
      "!   The time when the action started processing the message.
      ACTION_START_TIME type STRING,
      "!   Whether the step collects a customer response.
      HAS_QUESTION type BOOLEAN,
    end of T_TURN_EVENT_STEP_VISITED.
  types:
    "! No documentation available.
    begin of T_RT_RESP_GNRC_RT_RESP_TYP_AD,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   The `https:` URL of the audio clip.
      SOURCE type STRING,
      "!   The title or introductory text to show before the response.
      TITLE type STRING,
      "!   The description to show with the the response.
      DESCRIPTION type STRING,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
      "!   For internal use only.
      CHANNEL_OPTIONS type JSONOBJECT,
      "!   Descriptive text that can be used for screen readers or other situations where
      "!    the audio player cannot be seen.
      ALT_TEXT type STRING,
    end of T_RT_RESP_GNRC_RT_RESP_TYP_AD.
  types:
    "! No documentation available.
    begin of T_TURN_EVENT_ACTION_VISITED,
      "!   The type of turn event.
      EVENT type STRING,
      "!   No documentation available.
      SOURCE type T_TURN_EVENT_ACTION_SOURCE,
      "!   The time when the action started processing the message.
      ACTION_START_TIME type STRING,
      "!   The type of condition (if any) that is defined for the action.
      CONDITION_TYPE type STRING,
      "!   The reason the action was visited.
      REASON type STRING,
      "!   The variable where the result of the call to the action is stored. Included only
      "!    if **reason**=`subaction_return`.
      RESULT_VARIABLE type STRING,
    end of T_TURN_EVENT_ACTION_VISITED.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A stateful message request formatted for the Watson</p>
    "!     Assistant service.
    begin of T_MESSAGE_REQUEST,
      "!   An input object that includes the input text.
      INPUT type T_MESSAGE_INPUT,
      "!   Context data for the conversation. You can use this property to set or modify
      "!    context variables, which can also be accessed by dialog nodes. The context is
      "!    stored by the assistant on a per-session basis.<br/>
      "!   <br/>
      "!   **Note:** The total size of the context data stored for a stateful session
      "!    cannot exceed 100KB.
      CONTEXT type T_MESSAGE_CONTEXT,
      "!   A string value that identifies the user who is interacting with the assistant.
      "!    The client must provide a unique identifier for each individual end user who
      "!    accesses the application. For user-based plans, this user ID is used to
      "!    identify unique users for billing purposes. This string cannot contain carriage
      "!    return, newline, or tab characters. If no value is specified in the input,
      "!    **user_id** is automatically set to the value of
      "!    **context.global.session_id**.<br/>
      "!   <br/>
      "!   **Note:** This property is the same as the **user_id** property in the global
      "!    system context. If **user_id** is specified in both locations, the value
      "!    specified at the root is used.
      USER_ID type STRING,
    end of T_MESSAGE_REQUEST.
  types:
    "! No documentation available.
    begin of T_LOG,
      "!   A unique identifier for the logged event.
      LOG_ID type STRING,
      "!   A stateful message request formatted for the Watson Assistant service.
      REQUEST type T_MESSAGE_REQUEST,
      "!   A response from the Watson Assistant service.
      RESPONSE type T_MESSAGE_RESPONSE,
      "!   Unique identifier of the assistant.
      ASSISTANT_ID type STRING,
      "!   The ID of the session the message was part of.
      SESSION_ID type STRING,
      "!   The unique identifier of the skill that responded to the message.
      SKILL_ID type STRING,
      "!   The name of the snapshot (dialog skill version) that responded to the message
      "!    (for example, `draft`).
      SNAPSHOT type STRING,
      "!   The timestamp for receipt of the message.
      REQUEST_TIMESTAMP type STRING,
      "!   The timestamp for the system response to the message.
      RESPONSE_TIMESTAMP type STRING,
      "!   The language of the assistant to which the message request was made.
      LANGUAGE type STRING,
      "!   The customer ID specified for the message, if any.
      CUSTOMER_ID type STRING,
    end of T_LOG.
  types:
    "! No documentation available.
    begin of T_MSSG_OTPT_DBG_TRN_EVNT_TRN_1,
      "!   The type of turn event.
      EVENT type STRING,
      "!   No documentation available.
      SOURCE type T_TURN_EVENT_ACTION_SOURCE,
      "!   The time when the action started processing the message.
      ACTION_START_TIME type STRING,
      "!   The type of condition (if any) that is defined for the action.
      CONDITION_TYPE type STRING,
      "!   The reason the action was visited.
      REASON type STRING,
      "!   The variable where the result of the call to the action is stored. Included only
      "!    if **reason**=`subaction_return`.
      RESULT_VARIABLE type STRING,
    end of T_MSSG_OTPT_DBG_TRN_EVNT_TRN_1.
  types:
    "! No documentation available.
    begin of T_LOG_COLLECTION,
      "!   An array of objects describing log events.
      LOGS type STANDARD TABLE OF T_LOG WITH NON-UNIQUE DEFAULT KEY,
      "!   The pagination data for the returned objects. For more information about using
      "!    pagination, see [Pagination](#pagination).
      PAGINATION type T_LOG_PAGINATION,
    end of T_LOG_COLLECTION.
  types:
    "! No documentation available.
    begin of T_BASE_SKILL_REFERENCE,
      "!   The skill ID of the skill.
      SKILL_ID type STRING,
      "!   The type of the skill.
      TYPE type STRING,
    end of T_BASE_SKILL_REFERENCE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A request to deploy a release to the specified environment.</p>
    begin of T_DEPLOY_RELEASE_REQUEST,
      "!   The environment ID of the environment where the release is to be deployed.
      ENVIRONMENT_ID type STRING,
    end of T_DEPLOY_RELEASE_REQUEST.
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
    begin of T_CREATE_SESSION,
      "!   An optional object containing analytics data. Currently, this data is used only
      "!    for events sent to the Segment extension.
      ANALYTICS type T_REQUEST_ANALYTICS,
    end of T_CREATE_SESSION.
  types:
    "! No documentation available.
    begin of T_RT_RESP_GNRC_RT_RESP_TYP_SR1,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   The title or introductory text to show before the response. This text is defined
      "!    in the search skill configuration.
      HEADER type STRING,
      "!   An array of objects that contains the search results to be displayed in the
      "!    initial response to the user.
      PRIMARY_RESULTS type STANDARD TABLE OF T_SEARCH_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects that contains additional search results that can be
      "!    displayed to the user upon request.
      ADDITIONAL_RESULTS type STANDARD TABLE OF T_SEARCH_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RT_RESP_GNRC_RT_RESP_TYP_SR1.
  types:
    "! No documentation available.
    begin of T_RT_RESP_GNRC_RT_RESP_TYP_IF1,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   The `https:` URL of the embeddable content.
      SOURCE type STRING,
      "!   The title or introductory text to show before the response.
      TITLE type STRING,
      "!   The description to show with the the response.
      DESCRIPTION type STRING,
      "!   The URL of an image that shows a preview of the embedded content.
      IMAGE_URL type STRING,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RT_RESP_GNRC_RT_RESP_TYP_IF1.
  types:
    "! No documentation available.
    begin of T_RT_RESP_GNRC_RT_RESP_TYP_OPT,
      "!   The type of response returned by the dialog node. The specified response type
      "!    must be supported by the client application or channel.
      RESPONSE_TYPE type STRING,
      "!   The title or introductory text to show before the response.
      TITLE type STRING,
      "!   The description to show with the the response.
      DESCRIPTION type STRING,
      "!   The preferred type of control to display.
      PREFERENCE type STRING,
      "!   An array of objects describing the options from which the user can choose.
      OPTIONS type STANDARD TABLE OF T_DIA_NODE_OUTPUT_OPT_ELEMENT WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of objects specifying channels for which the response is intended. If
      "!    **channels** is present, the response is intended for a built-in integration
      "!    and should not be handled by an API client.
      CHANNELS type STANDARD TABLE OF T_RESPONSE_GENERIC_CHANNEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_RT_RESP_GNRC_RT_RESP_TYP_OPT.

constants:
  "! <p class="shorttext synchronized" lang="en">List of required fields per type.</p>
  begin of C_REQUIRED_FIELDS,
    T_RESPONSE_GENERIC_CHANNEL type string value '|',
    T_RUNTIME_RESPONSE_TYPE_VIDEO type string value '|RESPONSE_TYPE|SOURCE|',
    T_TURN_EVENT_ACTION_SOURCE type string value '|',
    T_TURN_EVENT_SEARCH_ERROR type string value '|',
    T_TURN_EVENT_SEARCH type string value '|',
    T_DIALOG_LOG_MESSAGE type string value '|LEVEL|MESSAGE|CODE|',
    T_DIALOG_NODE_VISITED type string value '|',
    T_MESSAGE_OUTPUT_DEBUG type string value '|',
    T_RT_ENTITY_INTERPRETATION type string value '|',
    T_MESSAGE_INPUT_OPT_SPELLING type string value '|',
    T_CAPTURE_GROUP type string value '|GROUP|',
    T_RUNTIME_ENTITY_ALTERNATIVE type string value '|',
    T_RUNTIME_ENTITY_ROLE type string value '|',
    T_RUNTIME_ENTITY type string value '|ENTITY|VALUE|',
    T_REQUEST_ANALYTICS type string value '|',
    T_MESSAGE_INPUT_ATTACHMENT type string value '|URL|',
    T_MESSAGE_INPUT_OPTIONS type string value '|',
    T_RUNTIME_INTENT type string value '|INTENT|',
    T_MESSAGE_INPUT type string value '|',
    T_DIA_ND_OUTPUT_OPT_ELEM_VALUE type string value '|',
    T_DIA_NODE_OUTPUT_OPT_ELEMENT type string value '|LABEL|VALUE|',
    T_RUNTIME_RESPONSE_TYPE_OPTION type string value '|RESPONSE_TYPE|TITLE|OPTIONS|',
    T_STATUS_ERROR type string value '|',
    T_SEARCH_SETTINGS_MESSAGES type string value '|SUCCESS|ERROR|NO_RESULT|',
    T_SRCH_SETTINGS_SCHEMA_MAPPING type string value '|URL|BODY|TITLE|',
    T_SRCH_STTNGS_DSCVRY_ATHNTCTN type string value '|',
    T_SEARCH_SETTINGS_DISCOVERY type string value '|INSTANCE_ID|PROJECT_ID|URL|AUTHENTICATION|',
    T_SEARCH_SETTINGS type string value '|DISCOVERY|MESSAGES|SCHEMA_MAPPING|',
    T_SEARCH_SKILL_WARNING type string value '|',
    T_SKILL_IMPORT type string value '|LANGUAGE|TYPE|',
    T_ASSISTANT_STATE type string value '|ACTION_DISABLED|DIALOG_DISABLED|',
    T_SKILLS_IMPORT type string value '|ASSISTANT_SKILLS|ASSISTANT_STATE|',
    T_MSSG_OTPT_DBG_TRN_EVNT_TRN_3 type string value '|',
    T_SKILL type string value '|LANGUAGE|TYPE|',
    T_BASE_ENV_ORCHESTRATION type string value '|',
    T_RT_RESP_GNRC_RT_RESP_TYP_VD type string value '|RESPONSE_TYPE|SOURCE|',
    T_CHANNEL_TRANSFER_TARGET_CHAT type string value '|',
    T_CHANNEL_TRANSFER_TARGET type string value '|',
    T_CHANNEL_TRANSFER_INFO type string value '|TARGET|',
    T_RT_RESP_TYPE_CHANNEL_TRANS type string value '|RESPONSE_TYPE|MESSAGE_TO_USER|TRANSFER_INFO|',
    T_RUNTIME_RESPONSE_TYPE_TEXT type string value '|RESPONSE_TYPE|TEXT|',
    T_DIALOG_NODE_ACTION type string value '|NAME|RESULT_VARIABLE|',
    T_BASE_ENV_RELEASE_REFERENCE type string value '|',
    T_RT_ENTTY_INTRPRTTN_SYS_TIME type string value '|',
    T_RELEASE_SKILL type string value '|SKILL_ID|',
    T_RELEASE_CONTENT type string value '|',
    T_ENVIRONMENT_REFERENCE type string value '|',
    T_RELEASE type string value '|',
    T_INTEGRATION_REFERENCE type string value '|',
    T_ENVIRONMENT_SKILL type string value '|SKILL_ID|',
    T_UPDATE_ENVIRONMENT type string value '|',
    T_MSSG_OTPT_DBG_TRN_EVNT_TRN_2 type string value '|',
    T_MESSAGE_INPUT_OPT_AUTO_LEARN type string value '|',
    T_MSSG_CONTEXT_GLOBAL_SYSTEM type string value '|',
    T_MESSAGE_CONTEXT_GLOBAL type string value '|',
    T_MESSAGE_CONTEXT_SKILL_SYSTEM type string value '|',
    T_MESSAGE_CONTEXT_SKILL_ACTION type string value '|',
    T_MESSAGE_CONTEXT_SKILL_DIALOG type string value '|',
    T_MESSAGE_CONTEXT_SKILLS type string value '|',
    T_MESSAGE_CONTEXT type string value '|',
    T_RT_RESP_GNRC_RT_RESP_TYP_IMG type string value '|RESPONSE_TYPE|SOURCE|',
    T_TURN_EVENT_NODE_SOURCE type string value '|',
    T_MSSG_OTPT_DBG_TRN_EVNT_TRN_8 type string value '|',
    T_MSSG_CNTXT_GLOBAL_STATELESS type string value '|',
    T_MESSAGE_CONTEXT_STATELESS type string value '|',
    T_RT_RESP_TYPE_USER_DEFINED type string value '|RESPONSE_TYPE|USER_DEFINED|',
    T_LOG_PAGINATION type string value '|',
    T_AGENT_AVAILABILITY_MESSAGE type string value '|',
    T_DIA_ND_OTPT_CNNCT_T_AGNT_TR1 type string value '|',
    T_RT_RESP_TYP_CONNECT_TO_AGENT type string value '|RESPONSE_TYPE|',
    T_MESSAGE_OUTPUT_SPELLING type string value '|',
    T_MESSAGE_OUTPUT type string value '|',
    T_RT_RESP_GNRC_RT_RESP_TYP_CH1 type string value '|RESPONSE_TYPE|MESSAGE_TO_USER|TRANSFER_INFO|',
    T_DIALOG_SUGGESTION_VALUE type string value '|',
    T_DIALOG_SUGGESTION type string value '|LABEL|VALUE|',
    T_BASE_MESSAGE_INPUT_OPTIONS type string value '|',
    T_RT_RESP_GNRC_RT_RESP_TYP_DT type string value '|RESPONSE_TYPE|',
    T_TURN_EVENT_CALLOUT_CALLOUT type string value '|',
    T_BULK_CLASSIFY_UTTERANCE type string value '|TEXT|',
    T_BULK_CLASSIFY_OUTPUT type string value '|',
    T_BULK_CLASSIFY_RESPONSE type string value '|',
    T_ENVIRONMENT type string value '|SESSION_TIMEOUT|SKILL_REFERENCES|',
    T_BULK_CLASSIFY_INPUT type string value '|INPUT|',
    T_BASE_ENVIRONMENT type string value '|',
    T_LOG_MESSAGE_SOURCE_HANDLER type string value '|TYPE|ACTION|HANDLER|',
    T_BASE_MESSAGE_CONTEXT_SKILL type string value '|',
    T_TURN_EVENT_ACTION_FINISHED type string value '|',
    T_RT_RESP_GNRC_RT_RESP_TYP_CN1 type string value '|RESPONSE_TYPE|',
    T_MESSAGE_RESPONSE type string value '|OUTPUT|USER_ID|',
    T_TURN_EVENT_CALLOUT_ERROR type string value '|',
    T_TURN_EVENT_CALLOUT type string value '|',
    T_ASSISTANT_SKILL type string value '|SKILL_ID|',
    T_ASSISTANT_DATA type string value '|LANGUAGE|',
    T_PAGINATION type string value '|REFRESH_URL|',
    T_ENVIRONMENT_COLLECTION type string value '|ENVIRONMENTS|PAGINATION|',
    T_RUNTIME_RESPONSE_TYPE_PAUSE type string value '|RESPONSE_TYPE|TIME|',
    T_RT_RESP_GNRC_RT_RESP_TYP_US1 type string value '|RESPONSE_TYPE|USER_DEFINED|',
    T_SEARCH_RESULT_HIGHLIGHT type string value '|',
    T_SEARCH_RESULT_METADATA type string value '|',
    T_SEARCH_RESULT_ANSWER type string value '|TEXT|CONFIDENCE|',
    T_SEARCH_RESULT type string value '|ID|RESULT_METADATA|',
    T_RUNTIME_RESPONSE_TYPE_SEARCH type string value '|RESPONSE_TYPE|HEADER|PRIMARY_RESULTS|ADDITIONAL_RESULTS|',
    T_SKILLS_EXPORT type string value '|ASSISTANT_SKILLS|ASSISTANT_STATE|',
    T_RUNTIME_RESPONSE_TYPE_IFRAME type string value '|RESPONSE_TYPE|SOURCE|',
    T_RT_RESP_GNRC_RT_RESP_TYP_PS type string value '|RESPONSE_TYPE|TIME|',
    T_MESSAGE_RESPONSE_STATELESS type string value '|OUTPUT|CONTEXT|',
    T_ERROR_DETAIL type string value '|MESSAGE|',
    T_TURN_EVENT_HANDLER_VISITED type string value '|',
    T_BASE_MESSAGE_CONTEXT_GLOBAL type string value '|',
    T_LOG_MESSAGE_SOURCE_DIA_NODE type string value '|TYPE|DIALOG_NODE|',
    T_RT_ENTTY_INTRPRTTN_SYS_NUM type string value '|',
    T_RT_RESP_GNRC_RT_RESP_TYP_SG1 type string value '|RESPONSE_TYPE|TITLE|SUGGESTIONS|',
    T_ERROR_RESPONSE type string value '|ERROR|CODE|',
    T_MESSAGE_INPUT_OPT_STATELESS type string value '|',
    T_BASE_MESSAGE_INPUT type string value '|',
    T_UPDATE_SKILL type string value '|',
    T_BASE_SKILL type string value '|',
    T_RUNTIME_RESPONSE_TYPE_DATE type string value '|RESPONSE_TYPE|',
    T_RELEASE_COLLECTION type string value '|RELEASES|PAGINATION|',
    T_ASSISTANT_COLLECTION type string value '|ASSISTANTS|PAGINATION|',
    T_TURN_EVENT_NODE_VISITED type string value '|',
    T_MSSG_OTPT_DBG_TRN_EVNT_TRN_5 type string value '|',
    T_MSSG_OTPT_DBG_TRN_EVNT_TRN_6 type string value '|',
    T_MESSAGE_INPUT_STATELESS type string value '|',
    T_MESSAGE_REQUEST_STATELESS type string value '|',
    T_RT_RESPONSE_TYPE_SUGGESTION type string value '|RESPONSE_TYPE|TITLE|SUGGESTIONS|',
    T_MSSG_OTPT_DBG_TRN_EVNT_TRN_4 type string value '|',
    T_LOG_MESSAGE_SOURCE_STEP type string value '|TYPE|ACTION|STEP|',
    T_TURN_EVENT_STEP_ANSWERED type string value '|',
    T_SKILLS_ASYNC_REQUEST_STATUS type string value '|',
    T_RT_RESP_GNRC_RT_RESP_TYP_TXT type string value '|RESPONSE_TYPE|TEXT|',
    T_SESSION_RESPONSE type string value '|SESSION_ID|',
    T_RT_ENTTY_INTRPRTTN_SYS_DATE type string value '|',
    T_RUNTIME_RESPONSE_TYPE_AUDIO type string value '|RESPONSE_TYPE|SOURCE|',
    T_MSSG_OTPT_DBG_TRN_EVNT_TRN_7 type string value '|',
    T_LOG_MESSAGE_SOURCE_ACTION type string value '|TYPE|ACTION|',
    T_RUNTIME_RESPONSE_TYPE_IMAGE type string value '|RESPONSE_TYPE|SOURCE|',
    T_TURN_EVENT_STEP_VISITED type string value '|',
    T_RT_RESP_GNRC_RT_RESP_TYP_AD type string value '|RESPONSE_TYPE|SOURCE|',
    T_TURN_EVENT_ACTION_VISITED type string value '|',
    T_MESSAGE_REQUEST type string value '|',
    T_LOG type string value '|LOG_ID|REQUEST|RESPONSE|ASSISTANT_ID|SESSION_ID|SKILL_ID|SNAPSHOT|REQUEST_TIMESTAMP|RESPONSE_TIMESTAMP|LANGUAGE|',
    T_MSSG_OTPT_DBG_TRN_EVNT_TRN_1 type string value '|',
    T_LOG_COLLECTION type string value '|LOGS|PAGINATION|',
    T_BASE_SKILL_REFERENCE type string value '|SKILL_ID|',
    T_DEPLOY_RELEASE_REQUEST type string value '|ENVIRONMENT_ID|',
    T_AUDIT_PROPERTIES type string value '|',
    T_CREATE_SESSION type string value '|',
    T_RT_RESP_GNRC_RT_RESP_TYP_SR1 type string value '|RESPONSE_TYPE|HEADER|PRIMARY_RESULTS|ADDITIONAL_RESULTS|',
    T_RT_RESP_GNRC_RT_RESP_TYP_IF1 type string value '|RESPONSE_TYPE|SOURCE|',
    T_RT_RESP_GNRC_RT_RESP_TYP_OPT type string value '|RESPONSE_TYPE|TITLE|OPTIONS|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  "! <p class="shorttext synchronized" lang="en">Map ABAP identifiers to service identifiers.</p>
  begin of C_ABAPNAME_DICTIONARY,
     MESSAGE type string value 'message',
     ASSISTANTS type string value 'assistants',
     PAGINATION type string value 'pagination',
     ASSISTANT_ID type string value 'assistant_id',
     NAME type string value 'name',
     DESCRIPTION type string value 'description',
     LANGUAGE type string value 'language',
     ASSISTANT_SKILLS type string value 'assistant_skills',
     ASSISTANT_SKILL type string value 'assistant_skill',
     ASSISTANT_ENVIRONMENTS type string value 'assistant_environments',
     ASSISTANT_ENVIRONMENT type string value 'assistant_environment',
     SKILL_ID type string value 'skill_id',
     TYPE type string value 'type',
     ACTION_DISABLED type string value 'action_disabled',
     DIALOG_DISABLED type string value 'dialog_disabled',
     CREATED type string value 'created',
     UPDATED type string value 'updated',
     ENVIRONMENT_ID type string value 'environment_id',
     ENVIRONMENT type string value 'environment',
     RELEASE_REFERENCE type string value 'release_reference',
     ORCHESTRATION type string value 'orchestration',
     SESSION_TIMEOUT type string value 'session_timeout',
     INTEGRATION_REFERENCES type string value 'integration_references',
     INTEGRATION_REFERENCE type string value 'integration_reference',
     SKILL_REFERENCES type string value 'skill_references',
     SKILL_REFERENCE type string value 'skill_reference',
     SYSTEM type string value 'system',
     MESSAGE_TYPE type string value 'message_type',
     TEXT type string value 'text',
     INTENTS type string value 'intents',
     INTENT type string value 'intent',
     ENTITIES type string value 'entities',
     ENTITY type string value 'entity',
     SUGGESTION_ID type string value 'suggestion_id',
     ATTACHMENTS type string value 'attachments',
     ANALYTICS type string value 'analytics',
     RESTART type string value 'restart',
     ALTERNATE_INTENTS type string value 'alternate_intents',
     SPELLING type string value 'spelling',
     USER_DEFINED type string value 'user_defined',
     INNER type string value 'inner',
     WORKSPACE type string value 'workspace',
     STATUS type string value 'status',
     STATUS_ERRORS type string value 'status_errors',
     STATUS_DESCRIPTION type string value 'status_description',
     DIALOG_SETTINGS type string value 'dialog_settings',
     WORKSPACE_ID type string value 'workspace_id',
     VALID type string value 'valid',
     NEXT_SNAPSHOT_VERSION type string value 'next_snapshot_version',
     SEARCH_SETTINGS type string value 'search_settings',
     WARNINGS type string value 'warnings',
     INPUT type string value 'input',
     OUTPUT type string value 'output',
     TARGET type string value 'target',
     CHAT type string value 'chat',
     URL type string value 'url',
     LEVEL type string value 'level',
     CODE type string value 'code',
     SOURCE type string value 'source',
     PARAMETERS type string value 'parameters',
     RESULT_VARIABLE type string value 'result_variable',
     CREDENTIALS type string value 'credentials',
     LABEL type string value 'label',
     VALUE type string value 'value',
     DIALOG_NODE type string value 'dialog_node',
     TITLE type string value 'title',
     CONDITIONS type string value 'conditions',
     ENVIRONMENTS type string value 'environments',
     DISABLED type string value 'disabled',
     SNAPSHOT type string value 'snapshot',
     PATH type string value 'path',
     ERROR type string value 'error',
     ERRORS type string value 'errors',
     INTEGRATION_ID type string value 'integration_id',
     LOG_ID type string value 'log_id',
     REQUEST type string value 'request',
     RESPONSE type string value 'response',
     SESSION_ID type string value 'session_id',
     REQUEST_TIMESTAMP type string value 'request_timestamp',
     RESPONSE_TIMESTAMP type string value 'response_timestamp',
     CUSTOMER_ID type string value 'customer_id',
     LOGS type string value 'logs',
     ACTION type string value 'action',
     STEP type string value 'step',
     HANDLER type string value 'handler',
     NEXT_URL type string value 'next_url',
     MATCHED type string value 'matched',
     NEXT_CURSOR type string value 'next_cursor',
     GLOBAL type string value 'global',
     SKILLS type string value 'skills',
     INTEGRATIONS type string value 'integrations',
     ACTION_VARIABLES type string value 'action_variables',
     SKILL_VARIABLES type string value 'skill_variables',
     TIMEZONE type string value 'timezone',
     USER_ID type string value 'user_id',
     TURN_COUNT type string value 'turn_count',
     LOCALE type string value 'locale',
     REFERENCE_TIME type string value 'reference_time',
     SESSION_START_TIME type string value 'session_start_time',
     STATE type string value 'state',
     SKIP_USER_INPUT type string value 'skip_user_input',
     MAIN_SKILL type string value 'main skill',
     ACTIONS_SKILL type string value 'actions skill',
     OPTIONS type string value 'options',
     MEDIA_TYPE type string value 'media_type',
     DEBUG type string value 'debug',
     RETURN_CONTEXT type string value 'return_context',
     EXPORT type string value 'export',
     LEARN type string value 'learn',
     APPLY type string value 'apply',
     SUGGESTIONS type string value 'suggestions',
     AUTO_CORRECT type string value 'auto_correct',
     GENERIC type string value 'generic',
     ACTIONS type string value 'actions',
     NODES_VISITED type string value 'nodes_visited',
     LOG_MESSAGES type string value 'log_messages',
     BRANCH_EXITED type string value 'branch_exited',
     BRANCH_EXITED_REASON type string value 'branch_exited_reason',
     TURN_EVENTS type string value 'turn_events',
     ORIGINAL_TEXT type string value 'original_text',
     SUGGESTED_TEXT type string value 'suggested_text',
     CONTEXT type string value 'context',
     REFRESH_URL type string value 'refresh_url',
     TOTAL type string value 'total',
     REFRESH_CURSOR type string value 'refresh_cursor',
     RELEASE type string value 'release',
     ENVIRONMENT_REFERENCES type string value 'environment_references',
     CONTENT type string value 'content',
     RELEASES type string value 'releases',
     BROWSER type string value 'browser',
     DEVICE type string value 'device',
     PAGEURL type string value 'pageUrl',
     CHANNEL type string value 'channel',
     LOCATION type string value 'location',
     CONFIDENCE type string value 'confidence',
     GROUPS type string value 'groups',
     INTERPRETATION type string value 'interpretation',
     ALTERNATIVES type string value 'alternatives',
     ROLE type string value 'role',
     SKILL type string value 'skill',
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
     RESPONSE_TYPE type string value 'response_type',
     CHANNELS type string value 'channels',
     CHANNEL_OPTIONS type string value 'channel_options',
     ALT_TEXT type string value 'alt_text',
     MESSAGE_TO_USER type string value 'message_to_user',
     TRANSFER_INFO type string value 'transfer_info',
     MESSAGE_TO_HUMAN_AGENT type string value 'message_to_human_agent',
     AGENT_AVAILABLE type string value 'agent_available',
     AGENT_UNAVAILABLE type string value 'agent_unavailable',
     TOPIC type string value 'topic',
     IMAGE_URL type string value 'image_url',
     PREFERENCE type string value 'preference',
     TIME type string value 'time',
     TYPING type string value 'typing',
     HEADER type string value 'header',
     PRIMARY_RESULTS type string value 'primary_results',
     ADDITIONAL_RESULTS type string value 'additional_results',
     ID type string value 'id',
     RESULT_METADATA type string value 'result_metadata',
     BODY type string value 'body',
     HIGHLIGHT type string value 'highlight',
     ANSWERS type string value 'answers',
     SCORE type string value 'score',
     DISCOVERY type string value 'discovery',
     MESSAGES type string value 'messages',
     SCHEMA_MAPPING type string value 'schema_mapping',
     INSTANCE_ID type string value 'instance_id',
     PROJECT_ID type string value 'project_id',
     MAX_PRIMARY_RESULTS type string value 'max_primary_results',
     MAX_TOTAL_RESULTS type string value 'max_total_results',
     CONFIDENCE_THRESHOLD type string value 'confidence_threshold',
     FIND_ANSWERS type string value 'find_answers',
     AUTHENTICATION type string value 'authentication',
     BASIC type string value 'basic',
     BEARER type string value 'bearer',
     SUCCESS type string value 'success',
     NO_RESULT type string value 'no_result',
     ASSISTANT_STATE type string value 'assistant_state',
     EVENT type string value 'event',
     ACTION_START_TIME type string value 'action_start_time',
     CONDITION_TYPE type string value 'condition_type',
     REASON type string value 'reason',
     ACTION_TITLE type string value 'action_title',
     CONDITION type string value 'condition',
     CALLOUT type string value 'callout',
     INTERNAL type string value 'internal',
     PROMPTED type string value 'prompted',
     HAS_QUESTION type string value 'has_question',
     SEARCH_SKILL_FALLBACK type string value 'search_skill_fallback',
     GROUP type string value 'group',
  end of C_ABAPNAME_DICTIONARY .


  methods GET_APPNAME
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
  methods GET_SDK_VERSION_DATE
    redefinition .


    "! <p class="shorttext synchronized" lang="en">Create an assistant</p>
    "!   Create a new assistant.<br/>
    "!   <br/>
    "!   This method is available only with Enterprise plans.
    "!
    "! @parameter I_REQUEST |
    "!   The properties of the new assistant.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ASSISTANT_DATA
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_ASSISTANT
    importing
      !I_REQUEST type T_ASSISTANT_DATA optional
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ASSISTANT_DATA
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List assistants</p>
    "!   List the assistants associated with a Watson Assistant service instance.<br/>
    "!   <br/>
    "!   This method is available only with Enterprise plans.
    "!
    "! @parameter I_PAGE_LIMIT |
    "!   The number of records to return in each page of results.
    "! @parameter I_INCLUDE_COUNT |
    "!   Whether to include information about the number of records that satisfy the
    "!    request, regardless of the page limit. If this parameter is `true`, the
    "!    `pagination` object in the response includes the `total` property.
    "! @parameter I_SORT |
    "!   The attribute by which returned assistants will be sorted. To reverse the sort
    "!    order, prefix the value with a minus sign (`-`).
    "! @parameter I_CURSOR |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ASSISTANT_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_ASSISTANTS
    importing
      !I_PAGE_LIMIT type INTEGER default 100
      !I_INCLUDE_COUNT type BOOLEAN default c_boolean_false
      !I_SORT type STRING optional
      !I_CURSOR type STRING optional
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ASSISTANT_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete assistant</p>
    "!   Delete an assistant.<br/>
    "!   <br/>
    "!   This method is available only with Enterprise plans.
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_ASSISTANT
    importing
      !I_ASSISTANT_ID type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Create a session</p>
    "!   Create a new session. A session is used to send user input to a skill and
    "!    receive responses. It also maintains the state of the conversation. A session
    "!    persists until it is deleted, or until it times out because of inactivity. (For
    "!    more information, see the
    "!    [documentation](https://cloud.ibm.com/docs/assistant?topic=assistant-assistant-
    "!   settings).
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
    "! @parameter I_CREATESESSION |
    "!   No documentation available.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SESSION_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_SESSION
    importing
      !I_ASSISTANT_ID type STRING
      !I_CREATESESSION type T_CREATE_SESSION optional
      !I_contenttype type string default 'application/json'
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
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
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

    "! <p class="shorttext synchronized" lang="en">Send user input to assistant (stateful)</p>
    "!   Send user input to an assistant and receive a response, with conversation state
    "!    (including context data) stored by Watson Assistant for the duration of the
    "!    session.
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
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
    "! <p class="shorttext synchronized" lang="en">Send user input to assistant (stateless)</p>
    "!   Send user input to an assistant and receive a response, with conversation state
    "!    (including context data) managed by your application.
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
    "! @parameter I_REQUEST |
    "!   The message to be sent. This includes the user&apos;s input, context data, and
    "!    optional content such as intents and entities.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_MESSAGE_RESPONSE_STATELESS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods MESSAGE_STATELESS
    importing
      !I_ASSISTANT_ID type STRING
      !I_REQUEST type T_MESSAGE_REQUEST_STATELESS optional
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_MESSAGE_RESPONSE_STATELESS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Identify intents and entities in multiple user utterances</p>
    "!   Send multiple user inputs to a dialog skill in a single request and receive
    "!    information about the intents and entities recognized in each input. This
    "!    method is useful for testing and comparing the performance of different skills
    "!    or skill versions.<br/>
    "!   <br/>
    "!   This method is available only with Enterprise with Data Isolation plans.
    "!
    "! @parameter I_SKILL_ID |
    "!   Unique identifier of the skill. To find the skill ID in the Watson Assistant
    "!    user interface, open the skill settings and click **API Details**.
    "! @parameter I_REQUEST |
    "!   An input object that includes the text to classify.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_BULK_CLASSIFY_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods BULK_CLASSIFY
    importing
      !I_SKILL_ID type STRING
      !I_REQUEST type T_BULK_CLASSIFY_INPUT
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_BULK_CLASSIFY_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List log events for an assistant</p>
    "!   List the events from the log of an assistant.<br/>
    "!   <br/>
    "!   This method requires Manager access, and is available only with Plus and
    "!    Enterprise plans.<br/>
    "!   <br/>
    "!   **Note:** If you use the **cursor** parameter to retrieve results one page at a
    "!    time, subsequent requests must be no more than 5 minutes apart. Any returned
    "!    value for the **cursor** parameter becomes invalid after 5 minutes. For more
    "!    information about using pagination, see [Pagination](#pagination).
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
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
      !I_ASSISTANT_ID type STRING
      !I_SORT type STRING optional
      !I_FILTER type STRING optional
      !I_PAGE_LIMIT type INTEGER default 100
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
    "!   **Note:** This operation is intended only for deleting data associated with a
    "!    single specific customer, not for deleting data associated with multiple
    "!    customers or for any other purpose. For more information, see [Labeling and
    "!    deleting data in Watson
    "!    Assistant](https://cloud.ibm.com/docs/assistant?topic=assistant-information-sec
    "!   urity#information-security-gdpr-wa).
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

    "! <p class="shorttext synchronized" lang="en">List environments</p>
    "!   List the environments associated with an assistant.<br/>
    "!   <br/>
    "!   This method is available only with Enterprise plans.
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
    "! @parameter I_PAGE_LIMIT |
    "!   The number of records to return in each page of results.
    "! @parameter I_INCLUDE_COUNT |
    "!   Whether to include information about the number of records that satisfy the
    "!    request, regardless of the page limit. If this parameter is `true`, the
    "!    `pagination` object in the response includes the `total` property.
    "! @parameter I_SORT |
    "!   The attribute by which returned environments will be sorted. To reverse the sort
    "!    order, prefix the value with a minus sign (`-`).
    "! @parameter I_CURSOR |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENVIRONMENT_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_ENVIRONMENTS
    importing
      !I_ASSISTANT_ID type STRING
      !I_PAGE_LIMIT type INTEGER default 100
      !I_INCLUDE_COUNT type BOOLEAN default c_boolean_false
      !I_SORT type STRING optional
      !I_CURSOR type STRING optional
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENVIRONMENT_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get environment</p>
    "!   Get information about an environment. For more information about environments,
    "!    see
    "!    [Environments](https://cloud.ibm.com/docs/watson-assistant?topic=watson-assista
    "!   nt-publish-overview#environments).<br/>
    "!   <br/>
    "!   This method is available only with Enterprise plans.
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
    "! @parameter I_ENVIRONMENT_ID |
    "!   Unique identifier of the environment. To find the environment ID in the Watson
    "!    Assistant user interface, open the environment settings and click **API
    "!    Details**. **Note:** Currently, the API does not support creating environments.
    "!
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENVIRONMENT
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_ENVIRONMENT
    importing
      !I_ASSISTANT_ID type STRING
      !I_ENVIRONMENT_ID type STRING
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENVIRONMENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update environment</p>
    "!   Update an environment with new or modified data. For more information about
    "!    environments, see
    "!    [Environments](https://cloud.ibm.com/docs/watson-assistant?topic=watson-assista
    "!   nt-publish-overview#environments).<br/>
    "!   <br/>
    "!   This method is available only with Enterprise plans.
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
    "! @parameter I_ENVIRONMENT_ID |
    "!   Unique identifier of the environment. To find the environment ID in the Watson
    "!    Assistant user interface, open the environment settings and click **API
    "!    Details**. **Note:** Currently, the API does not support creating environments.
    "!
    "! @parameter I_UPDATEENVIRONMENT |
    "!   The updated properties of the environment.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENVIRONMENT
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_ENVIRONMENT
    importing
      !I_ASSISTANT_ID type STRING
      !I_ENVIRONMENT_ID type STRING
      !I_UPDATEENVIRONMENT type T_UPDATE_ENVIRONMENT optional
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENVIRONMENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Create release</p>
    "!   Create a new release using the current content of the dialog and action skills
    "!    in the draft environment. (In the Watson Assistant user interface, a release is
    "!    called a *version*.)<br/>
    "!   <br/>
    "!   This method is available only with Enterprise plans.
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
    "! @parameter I_RELEASE |
    "!   An object describing the release.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_RELEASE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_RELEASE
    importing
      !I_ASSISTANT_ID type STRING
      !I_RELEASE type T_RELEASE optional
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_RELEASE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List releases</p>
    "!   List the releases associated with an assistant. (In the Watson Assistant user
    "!    interface, a release is called a *version*.)<br/>
    "!   <br/>
    "!   This method is available only with Enterprise plans.
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
    "! @parameter I_PAGE_LIMIT |
    "!   The number of records to return in each page of results.
    "! @parameter I_INCLUDE_COUNT |
    "!   Whether to include information about the number of records that satisfy the
    "!    request, regardless of the page limit. If this parameter is `true`, the
    "!    `pagination` object in the response includes the `total` property.
    "! @parameter I_SORT |
    "!   The attribute by which returned workspaces will be sorted. To reverse the sort
    "!    order, prefix the value with a minus sign (`-`).
    "! @parameter I_CURSOR |
    "!   A token identifying the page of results to retrieve.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_RELEASE_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_RELEASES
    importing
      !I_ASSISTANT_ID type STRING
      !I_PAGE_LIMIT type INTEGER default 100
      !I_INCLUDE_COUNT type BOOLEAN default c_boolean_false
      !I_SORT type STRING optional
      !I_CURSOR type STRING optional
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_RELEASE_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get release</p>
    "!   Get information about a release.<br/>
    "!   <br/>
    "!   Release data is not available until publishing of the release completes. If
    "!    publishing is still in progress, you can continue to poll by calling the same
    "!    request again and checking the value of the **status** property. When
    "!    processing has completed, the request returns the release data.<br/>
    "!   <br/>
    "!   This method is available only with Enterprise plans.
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
    "! @parameter I_RELEASE |
    "!   Unique identifier of the release.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_RELEASE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_RELEASE
    importing
      !I_ASSISTANT_ID type STRING
      !I_RELEASE type STRING
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_RELEASE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete release</p>
    "!   Delete a release. (In the Watson Assistant user interface, a release is called a
    "!    *version*.)<br/>
    "!   <br/>
    "!   This method is available only with Enterprise plans.
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
    "! @parameter I_RELEASE |
    "!   Unique identifier of the release.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_RELEASE
    importing
      !I_ASSISTANT_ID type STRING
      !I_RELEASE type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Deploy release</p>
    "!   Update the environment with the content of the release. All snapshots saved as
    "!    part of the release become active in the environment.<br/>
    "!   <br/>
    "!   This method is available only with Enterprise plans.
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
    "! @parameter I_RELEASE |
    "!   Unique identifier of the release.
    "! @parameter I_REQUEST |
    "!   An input object that identifies the environment where the release is to be
    "!    deployed.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ENVIRONMENT
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DEPLOY_RELEASE
    importing
      !I_ASSISTANT_ID type STRING
      !I_RELEASE type STRING
      !I_REQUEST type T_DEPLOY_RELEASE_REQUEST
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ENVIRONMENT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Get skill</p>
    "!   Get information about a skill.<br/>
    "!   <br/>
    "!   This method is available only with Enterprise plans.
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
    "! @parameter I_SKILL_ID |
    "!   Unique identifier of the skill. To find the skill ID in the Watson Assistant
    "!    user interface, open the skill settings and click **API Details**.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SKILL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_SKILL
    importing
      !I_ASSISTANT_ID type STRING
      !I_SKILL_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SKILL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update skill</p>
    "!   Update a skill with new or modified data. <br/>
    "!   <br/>
    "!     **Note:** The update is performed asynchronously; you can see the status of
    "!    the update by calling the **Get skill** method and checking the value of the
    "!    **status** property.<br/>
    "!   <br/>
    "!   This method is available only with Enterprise plans.
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
    "! @parameter I_SKILL_ID |
    "!   Unique identifier of the skill. To find the skill ID in the Watson Assistant
    "!    user interface, open the skill settings and click **API Details**.
    "! @parameter I_UPDATESKILL |
    "!   The updated properties of the skill.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SKILL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_SKILL
    importing
      !I_ASSISTANT_ID type STRING
      !I_SKILL_ID type STRING
      !I_UPDATESKILL type T_UPDATE_SKILL
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SKILL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Export skills</p>
    "!   Asynchronously export the action skill and dialog skill (if enabled) for the
    "!    assistant. Use this method to save all skill data so that you can import it to
    "!    a different assistant using the **Import skills** method. <br/>
    "!   <br/>
    "!    A successful call to this method only initiates an asynchronous export. The
    "!    exported JSON data is not available until processing completes. <br/>
    "!   <br/>
    "!    After the initial request is submitted, you can poll the status of the
    "!    operation by calling the same request again and checking the value of the
    "!    **status** property. If an error occurs (indicated by a **status** value of
    "!    `Failed`), the `status_description` property provides more information about
    "!    the error, and the `status_errors` property contains an array of error messages
    "!    that caused the failure. <br/>
    "!   <br/>
    "!    When processing has completed, the request returns the exported JSON data.
    "!    Remember that the usual rate limits apply.<br/>
    "!   <br/>
    "!   This method is available only with Enterprise plans.
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SKILLS_EXPORT
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods EXPORT_SKILLS
    importing
      !I_ASSISTANT_ID type STRING
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SKILLS_EXPORT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Import skills</p>
    "!   Asynchronously import skills into an existing assistant from a previously
    "!    exported file. <br/>
    "!   <br/>
    "!    The request body for this method should contain the response data that was
    "!    received from a previous call to the **Export skills** method, without
    "!    modification. <br/>
    "!   <br/>
    "!    A successful call to this method initiates an asynchronous import. The updated
    "!    skills belonging to the assistant are not available until processing completes.
    "!    To check the status of the asynchronous import operation, use the **Get status
    "!    of skills import** method.<br/>
    "!   <br/>
    "!   This method is available only with Enterprise plans.
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
    "! @parameter I_SKILLSIMPORT |
    "!   An input object that contains the skills to import.
    "! @parameter I_INCLUDE_AUDIT |
    "!   Whether to include the audit properties (`created` and `updated` timestamps) in
    "!    the response.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SKILLS_ASYNC_REQUEST_STATUS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods IMPORT_SKILLS
    importing
      !I_ASSISTANT_ID type STRING
      !I_SKILLSIMPORT type T_SKILLS_IMPORT
      !I_INCLUDE_AUDIT type BOOLEAN default c_boolean_false
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SKILLS_ASYNC_REQUEST_STATUS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get status of skills import</p>
    "!   Retrieve the status of an asynchronous import operation previously initiated by
    "!    using the **Import skills** method.<br/>
    "!   <br/>
    "!   This method is available only with Enterprise plans.
    "!
    "! @parameter I_ASSISTANT_ID |
    "!   The assistant ID or the environment ID of the environment where the assistant is
    "!    deployed, depending on the type of request: <br/>
    "!    - For message, session, and log requests, specify the environment ID of the
    "!    environment where the assistant is deployed. <br/>
    "!    - For all other requests, specify the assistant ID of the assistant. <br/>
    "!   <br/>
    "!    To find the environment ID or assistant ID in the Watson Assistant user
    "!    interface, open the assistant settings and scroll to the **Environments**
    "!    section.<br/>
    "!   <br/>
    "!   **Note:** If you are using the classic Watson Assistant experience, always use
    "!    the assistant ID. To find the assistant ID in the user interface, open the
    "!    assistant settings and click API Details.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SKILLS_ASYNC_REQUEST_STATUS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods IMPORT_SKILLS_STATUS
    importing
      !I_ASSISTANT_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SKILLS_ASYNC_REQUEST_STATUS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .


protected section.

private section.

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
    e_request_prop-auth_query      = c_boolean_false.
    e_request_prop-auth_header     = c_boolean_true.
  else.
  endif.

  e_request_prop-url-protocol    = 'https'.
  e_request_prop-url-host        = 'api.us-south.assistant.watson.cloud.ibm.com'.
  e_request_prop-url-path_base   = ''.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20231212104231'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->CREATE_ASSISTANT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_REQUEST        TYPE T_ASSISTANT_DATA(optional)
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ASSISTANT_DATA
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_ASSISTANT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants'.

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
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->LIST_ASSISTANTS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_PAGE_LIMIT        TYPE INTEGER (default =100)
* | [--->] I_INCLUDE_COUNT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_SORT        TYPE STRING(optional)
* | [--->] I_CURSOR        TYPE STRING(optional)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ASSISTANT_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_ASSISTANTS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants'.

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

    if i_INCLUDE_COUNT is supplied.
    lv_queryparam = i_INCLUDE_COUNT.
    add_query_parameter(
      exporting
        i_parameter  = `include_count`
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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->DELETE_ASSISTANT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_ASSISTANT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->CREATE_SESSION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_CREATESESSION        TYPE T_CREATE_SESSION(optional)
* | [--->] I_contenttype       TYPE string (default ='application/json')
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
    if not i_CREATESESSION is initial.
    lv_datatype = get_datatype( i_CREATESESSION ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_CREATESESSION i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'CreateSession' i_value = i_CREATESESSION ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_CREATESESSION to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    endif.
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->MESSAGE_STATELESS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_REQUEST        TYPE T_MESSAGE_REQUEST_STATELESS(optional)
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_MESSAGE_RESPONSE_STATELESS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method MESSAGE_STATELESS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}/message'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.

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
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->BULK_CLASSIFY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_SKILL_ID        TYPE STRING
* | [--->] I_REQUEST        TYPE T_BULK_CLASSIFY_INPUT
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_BULK_CLASSIFY_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method BULK_CLASSIFY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/skills/{skill_id}/workspace/bulk_classify'.
    replace all occurrences of `{skill_id}` in ls_request_prop-url-path with i_SKILL_ID ignoring case.

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
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->LIST_LOGS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_SORT        TYPE STRING(optional)
* | [--->] I_FILTER        TYPE STRING(optional)
* | [--->] I_PAGE_LIMIT        TYPE INTEGER (default =100)
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

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}/logs'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->DELETE_USER_DATA
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

    ls_request_prop-url-path = '/v2/user_data'.

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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->LIST_ENVIRONMENTS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_PAGE_LIMIT        TYPE INTEGER (default =100)
* | [--->] I_INCLUDE_COUNT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_SORT        TYPE STRING(optional)
* | [--->] I_CURSOR        TYPE STRING(optional)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ENVIRONMENT_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_ENVIRONMENTS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}/environments'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.

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

    if i_INCLUDE_COUNT is supplied.
    lv_queryparam = i_INCLUDE_COUNT.
    add_query_parameter(
      exporting
        i_parameter  = `include_count`
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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->GET_ENVIRONMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ENVIRONMENT
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_ENVIRONMENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}/environments/{environment_id}'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->UPDATE_ENVIRONMENT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_ENVIRONMENT_ID        TYPE STRING
* | [--->] I_UPDATEENVIRONMENT        TYPE T_UPDATE_ENVIRONMENT(optional)
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ENVIRONMENT
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_ENVIRONMENT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}/environments/{environment_id}'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.
    replace all occurrences of `{environment_id}` in ls_request_prop-url-path with i_ENVIRONMENT_ID ignoring case.

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
    if not i_UPDATEENVIRONMENT is initial.
    lv_datatype = get_datatype( i_UPDATEENVIRONMENT ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_UPDATEENVIRONMENT i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'UpdateEnvironment' i_value = i_UPDATEENVIRONMENT ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_UPDATEENVIRONMENT to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    endif.
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->CREATE_RELEASE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_RELEASE        TYPE T_RELEASE(optional)
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_RELEASE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_RELEASE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}/releases'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.

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
    if not i_RELEASE is initial.
    lv_datatype = get_datatype( i_RELEASE ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_RELEASE i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'Release' i_value = i_RELEASE ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_RELEASE to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    endif.
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->LIST_RELEASES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_PAGE_LIMIT        TYPE INTEGER (default =100)
* | [--->] I_INCLUDE_COUNT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_SORT        TYPE STRING(optional)
* | [--->] I_CURSOR        TYPE STRING(optional)
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_RELEASE_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_RELEASES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}/releases'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.

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

    if i_INCLUDE_COUNT is supplied.
    lv_queryparam = i_INCLUDE_COUNT.
    add_query_parameter(
      exporting
        i_parameter  = `include_count`
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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->GET_RELEASE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_RELEASE        TYPE STRING
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_RELEASE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_RELEASE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}/releases/{release}'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.
    replace all occurrences of `{release}` in ls_request_prop-url-path with i_RELEASE ignoring case.

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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->DELETE_RELEASE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_RELEASE        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_RELEASE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}/releases/{release}'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.
    replace all occurrences of `{release}` in ls_request_prop-url-path with i_RELEASE ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->DEPLOY_RELEASE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_RELEASE        TYPE STRING
* | [--->] I_REQUEST        TYPE T_DEPLOY_RELEASE_REQUEST
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ENVIRONMENT
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DEPLOY_RELEASE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}/releases/{release}/deploy'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.
    replace all occurrences of `{release}` in ls_request_prop-url-path with i_RELEASE ignoring case.

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
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->GET_SKILL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_SKILL_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_SKILL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_SKILL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}/skills/{skill_id}'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.
    replace all occurrences of `{skill_id}` in ls_request_prop-url-path with i_SKILL_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->UPDATE_SKILL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_SKILL_ID        TYPE STRING
* | [--->] I_UPDATESKILL        TYPE T_UPDATE_SKILL
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_SKILL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_SKILL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}/skills/{skill_id}'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.
    replace all occurrences of `{skill_id}` in ls_request_prop-url-path with i_SKILL_ID ignoring case.

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
    lv_datatype = get_datatype( i_UPDATESKILL ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_UPDATESKILL i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'UpdateSkill' i_value = i_UPDATESKILL ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_UPDATESKILL to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->EXPORT_SKILLS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_SKILLS_EXPORT
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method EXPORT_SKILLS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}/skills_export'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->IMPORT_SKILLS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_SKILLSIMPORT        TYPE T_SKILLS_IMPORT
* | [--->] I_INCLUDE_AUDIT        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_SKILLS_ASYNC_REQUEST_STATUS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method IMPORT_SKILLS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}/skills_import'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.

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
    lv_datatype = get_datatype( i_SKILLSIMPORT ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_SKILLSIMPORT i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'SkillsImport' i_value = i_SKILLSIMPORT ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_SKILLSIMPORT to <lv_text>.
      lv_bodyparam = <lv_text>.
      concatenate lv_body lv_bodyparam into lv_body.
    endif.
    if ls_request_prop-header_content_type cp '*json*'.
      if lv_body is initial.
        lv_body = '{}'.
      elseif lv_body(1) ne '{'.
        lv_body = `{` && lv_body && `}`.
      endif.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      "replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
      find_regex(
        exporting
          i_regex = ';\s*charset=utf-8'
          i_with = ''
          i_ignoring_case = 'X'
        changing
          c_in = ls_request_prop-header_content_type ).
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
* | Instance Public Method ZCL_IBMC_ASSISTANT_V2->IMPORT_SKILLS_STATUS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_ASSISTANT_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_SKILLS_ASYNC_REQUEST_STATUS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method IMPORT_SKILLS_STATUS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v2/assistants/{assistant_id}/skills_import/status'.
    replace all occurrences of `{assistant_id}` in ls_request_prop-url-path with i_ASSISTANT_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








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


ENDCLASS.
