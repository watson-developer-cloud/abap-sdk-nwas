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
"! <p class="shorttext synchronized" lang="en">Personality Insights</p>
"! The IBM Watson&trade; Personality Insights service enables applications to
"!  derive insights from social media, enterprise data, or other digital
"!  communications. The service uses linguistic analytics to infer
"!  individuals&apos; intrinsic personality characteristics, including Big Five,
"!  Needs, and Values, from digital communications such as email, text messages,
"!  tweets, and forum posts.<br/>
"! <br/>
"! The service can automatically infer, from potentially noisy social media,
"!  portraits of individuals that reflect their personality characteristics. The
"!  service can infer consumption preferences based on the results of its analysis
"!  and, for JSON content that is timestamped, can report temporal behavior.<br/>
"! * For information about the meaning of the models that the service uses to
"!  describe personality characteristics, see [Personality
"!  models](https://cloud.ibm.com/docs/personality-insights?topic=personality-insig
"! hts-models#models).<br/>
"! * For information about the meaning of the consumption preferences, see
"!  [Consumption
"!  preferences](https://cloud.ibm.com/docs/personality-insights?topic=personality-
"! insights-preferences#preferences). <br/>
"! <br/>
"! **Note:** Request logging is disabled for the Personality Insights service.
"!  Regardless of whether you set the `X-Watson-Learning-Opt-Out` request header,
"!  the service does not log or retain data from requests and responses. <br/>
class ZCL_IBMC_PERSONAL_INSIGHTS_V3 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The characteristics that the service inferred from the input</p>
    "!     content.
    begin of T_TRAIT,
      "!   The unique, non-localized identifier of the characteristic to which the results
      "!    pertain. IDs have the form<br/>
      "!   * `big5_&#123;characteristic&#125;` for Big Five personality dimensions<br/>
      "!   * `facet_&#123;characteristic&#125;` for Big Five personality facets<br/>
      "!   * `need_&#123;characteristic&#125;` for Needs<br/>
      "!    *`value_&#123;characteristic&#125;` for Values.
      TRAIT_ID type STRING,
      "!   The user-visible, localized name of the characteristic.
      NAME type STRING,
      "!   The category of the characteristic: `personality` for Big Five personality
      "!    characteristics, `needs` for Needs, and `values` for Values.
      CATEGORY type STRING,
      "!   The normalized percentile score for the characteristic. The range is 0 to 1. For
      "!    example, if the percentage for Openness is 0.60, the author scored in the 60th
      "!    percentile; the author is more open than 59 percent of the population and less
      "!    open than 39 percent of the population.
      PERCENTILE type DOUBLE,
      "!   The raw score for the characteristic. The range is 0 to 1. A higher score
      "!    generally indicates a greater likelihood that the author has that
      "!    characteristic, but raw scores must be considered in aggregate: The range of
      "!    values in practice might be much smaller than 0 to 1, so an individual score
      "!    must be considered in the context of the overall scores and their range. <br/>
      "!   <br/>
      "!   The raw score is computed based on the input and the service model; it is not
      "!    normalized or compared with a sample population. The raw score enables
      "!    comparison of the results against a different sampling population and with a
      "!    custom normalization approach.
      RAW_SCORE type DOUBLE,
      "!   **`2017-10-13`**: Indicates whether the characteristic is meaningful for the
      "!    input language. The field is always `true` for all characteristics of English,
      "!    Spanish, and Japanese input. The field is `false` for the subset of
      "!    characteristics of Arabic and Korean input for which the service&apos;s models
      "!    are unable to generate meaningful results. **`2016-10-19`**: Not returned.
      SIGNIFICANT type BOOLEAN,
      "!   For `personality` (Big Five) dimensions, more detailed results for the facets of
      "!    each dimension as inferred from the input text.
      CHILDREN type STANDARD TABLE OF DATA_REFERENCE WITH NON-UNIQUE DEFAULT KEY,
    end of T_TRAIT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The temporal behavior for the input content.</p>
    begin of T_BEHAVIOR,
      "!   The unique, non-localized identifier of the characteristic to which the results
      "!    pertain. IDs have the form `behavior_&#123;value&#125;`.
      TRAIT_ID type STRING,
      "!   The user-visible, localized name of the characteristic.
      NAME type STRING,
      "!   The category of the characteristic: `behavior` for temporal data.
      CATEGORY type STRING,
      "!   For JSON content that is timestamped, the percentage of timestamped input data
      "!    that occurred during that day of the week or hour of the day. The range is 0 to
      "!    1.
      PERCENTAGE type DOUBLE,
    end of T_BEHAVIOR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A consumption preference that the service inferred from the</p>
    "!     input content.
    begin of T_CONSUMPTION_PREFERENCES,
      "!   The unique, non-localized identifier of the consumption preference to which the
      "!    results pertain. IDs have the form
      "!    `consumption_preferences_&#123;preference&#125;`.
      CONSUMPTION_PREFERENCE_ID type STRING,
      "!   The user-visible, localized name of the consumption preference.
      NAME type STRING,
      "!   The score for the consumption preference:<br/>
      "!   * `0.0`: Unlikely<br/>
      "!   * `0.5`: Neutral<br/>
      "!   * `1.0`: Likely <br/>
      "!   <br/>
      "!   The scores for some preferences are binary and do not allow a neutral value. The
      "!    score is an indication of preference based on the results inferred from the
      "!    input text, not a normalized percentile.
      SCORE type DOUBLE,
    end of T_CONSUMPTION_PREFERENCES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A warning message that is associated with the input content.</p>
    begin of T_WARNING,
      "!   The identifier of the warning message.
      WARNING_ID type STRING,
      "!   The message associated with the `warning_id`:<br/>
      "!   * `WORD_COUNT_MESSAGE`: &quot;There were &#123;number&#125; words in the input.
      "!    We need a minimum of 600, preferably 1,200 or more, to compute statistically
      "!    significant estimates.&quot;<br/>
      "!   * `JSON_AS_TEXT`: &quot;Request input was processed as text/plain as indicated,
      "!    however detected a JSON input. Did you mean application/json?&quot;<br/>
      "!   * `CONTENT_TRUNCATED`: &quot;For maximum accuracy while also optimizing
      "!    processing time, only the first 250KB of input text (excluding markup) was
      "!    analyzed. Accuracy levels off at approximately 3,000 words so this did not
      "!    affect the accuracy of the profile.&quot;<br/>
      "!   * `PARTIAL_TEXT_USED`, &quot;The text provided to compute the profile was
      "!    trimmed for performance reasons. This action does not affect the accuracy of
      "!    the output, as not all of the input text was required.&quot; Applies only when
      "!    Arabic input text exceeds a threshold at which additional words do not
      "!    contribute to the accuracy of the profile.
      MESSAGE type STRING,
    end of T_WARNING.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The consumption preferences that the service inferred from</p>
    "!     the input content.
    begin of T_CNSMPTN_PREFERENCES_CATEGORY,
      "!   The unique, non-localized identifier of the consumption preferences category to
      "!    which the results pertain. IDs have the form
      "!    `consumption_preferences_&#123;category&#125;`.
      CNSMPTN_PREFERENCE_CATEGORY_ID type STRING,
      "!   The user-visible name of the consumption preferences category.
      NAME type STRING,
      "!   Detailed results inferred from the input text for the individual preferences of
      "!    the category.
      CONSUMPTION_PREFERENCES type STANDARD TABLE OF T_CONSUMPTION_PREFERENCES WITH NON-UNIQUE DEFAULT KEY,
    end of T_CNSMPTN_PREFERENCES_CATEGORY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The personality profile that the service generated for the</p>
    "!     input content.
    begin of T_PROFILE,
      "!   The language model that was used to process the input.
      PROCESSED_LANGUAGE type STRING,
      "!   The number of words from the input that were used to produce the profile.
      WORD_COUNT type INTEGER,
      "!   When guidance is appropriate, a string that provides a message that indicates
      "!    the number of words found and where that value falls in the range of required
      "!    or suggested number of words.
      WORD_COUNT_MESSAGE type STRING,
      "!   A recursive array of `Trait` objects that provides detailed results for the Big
      "!    Five personality characteristics (dimensions and facets) inferred from the
      "!    input text.
      PERSONALITY type STANDARD TABLE OF T_TRAIT WITH NON-UNIQUE DEFAULT KEY,
      "!   Detailed results for the Needs characteristics inferred from the input text.
      NEEDS type STANDARD TABLE OF T_TRAIT WITH NON-UNIQUE DEFAULT KEY,
      "!   Detailed results for the Values characteristics inferred from the input text.
      VALUES type STANDARD TABLE OF T_TRAIT WITH NON-UNIQUE DEFAULT KEY,
      "!   For JSON content that is timestamped, detailed results about the social behavior
      "!    disclosed by the input in terms of temporal characteristics. The results
      "!    include information about the distribution of the content over the days of the
      "!    week and the hours of the day.
      BEHAVIOR type STANDARD TABLE OF T_BEHAVIOR WITH NON-UNIQUE DEFAULT KEY,
      "!   If the **consumption_preferences** parameter is `true`, detailed results for
      "!    each category of consumption preferences. Each element of the array provides
      "!    information inferred from the input text for the individual preferences of that
      "!    category.
      CONSUMPTION_PREFERENCES type STANDARD TABLE OF T_CNSMPTN_PREFERENCES_CATEGORY WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of warning messages that are associated with the input text for the
      "!    request. The array is empty if the input generated no warnings.
      WARNINGS type STANDARD TABLE OF T_WARNING WITH NON-UNIQUE DEFAULT KEY,
    end of T_PROFILE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An input content item that the service is to analyze.</p>
    begin of T_CONTENT_ITEM,
      "!   The content that is to be analyzed. The service supports up to 20 MB of content
      "!    for all `ContentItem` objects combined.
      CONTENT type STRING,
      "!   A unique identifier for this content item.
      ID type STRING,
      "!   A timestamp that identifies when this content was created. Specify a value in
      "!    milliseconds since the UNIX Epoch (January 1, 1970, at 0:00 UTC). Required only
      "!    for results that include temporal behavior data.
      CREATED type LONG,
      "!   A timestamp that identifies when this content was last updated. Specify a value
      "!    in milliseconds since the UNIX Epoch (January 1, 1970, at 0:00 UTC). Required
      "!    only for results that include temporal behavior data.
      UPDATED type LONG,
      "!   The MIME type of the content. The default is plain text. The tags are stripped
      "!    from HTML content before it is analyzed; plain text is processed as submitted.
      CONTENTTYPE type STRING,
      "!   The language identifier (two-letter ISO 639-1 identifier) for the language of
      "!    the content item. The default is `en` (English). Regional variants are treated
      "!    as their parent language; for example, `en-US` is interpreted as `en`. A
      "!    language specified with the **Content-Type** parameter overrides the value of
      "!    this parameter; any content items that specify a different language are
      "!    ignored. Omit the **Content-Type** parameter to base the language on the most
      "!    prevalent specification among the content items; again, content items that
      "!    specify a different language are ignored. You can specify any combination of
      "!    languages for the input and response content.
      LANGUAGE type STRING,
      "!   The unique ID of the parent content item for this item. Used to identify
      "!    hierarchical relationships between posts/replies, messages/replies, and so on.
      PARENTID type STRING,
      "!   Indicates whether this content item is a reply to another content item.
      REPLY type BOOLEAN,
      "!   Indicates whether this content item is a forwarded/copied version of another
      "!    content item.
      FORWARD type BOOLEAN,
    end of T_CONTENT_ITEM.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A CSV file that contains the results of the personality</p>
    "!     profile that the service generated for the input content.
      T_CSV_FILE type String.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The error response from a failed request.</p>
    begin of T_ERROR_MODEL,
      "!   The HTTP status code.
      CODE type INTEGER,
      "!   A service-specific error code.
      SUB_CODE type STRING,
      "!   A description of the error.
      ERROR type STRING,
      "!   A URL to documentation explaining the cause and possibly solutions for the
      "!    error.
      HELP type STRING,
    end of T_ERROR_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The full input content that the service is to analyze.</p>
    begin of T_CONTENT,
      "!   An array of `ContentItem` objects that provides the text that is to be analyzed.
      "!
      CONTENTITEMS type STANDARD TABLE OF T_CONTENT_ITEM WITH NON-UNIQUE DEFAULT KEY,
    end of T_CONTENT.

constants:
  "! <p class="shorttext synchronized" lang="en">List of required fields per type.</p>
  begin of C_REQUIRED_FIELDS,
    T_TRAIT type string value '|TRAIT_ID|NAME|CATEGORY|PERCENTILE|',
    T_BEHAVIOR type string value '|TRAIT_ID|NAME|CATEGORY|PERCENTAGE|',
    T_CONSUMPTION_PREFERENCES type string value '|CONSUMPTION_PREFERENCE_ID|NAME|SCORE|',
    T_WARNING type string value '|WARNING_ID|MESSAGE|',
    T_CNSMPTN_PREFERENCES_CATEGORY type string value '|CNSMPTN_PREFERENCE_CATEGORY_ID|NAME|CONSUMPTION_PREFERENCES|',
    T_PROFILE type string value '|PROCESSED_LANGUAGE|WORD_COUNT|PERSONALITY|NEEDS|VALUES|WARNINGS|',
    T_CONTENT_ITEM type string value '|CONTENT|',
    T_ERROR_MODEL type string value '|CODE|ERROR|',
    T_CONTENT type string value '|CONTENTITEMS|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  "! <p class="shorttext synchronized" lang="en">Map ABAP identifiers to service identifiers.</p>
  begin of C_ABAPNAME_DICTIONARY,
     PROCESSED_LANGUAGE type string value 'processed_language',
     WORD_COUNT type string value 'word_count',
     WORD_COUNT_MESSAGE type string value 'word_count_message',
     PERSONALITY type string value 'personality',
     NEEDS type string value 'needs',
     VALUES type string value 'values',
     BEHAVIOR type string value 'behavior',
     CONSUMPTION_PREFERENCES type string value 'consumption_preferences',
     CONSUMPTIONPREFERENCES type string value 'consumptionPreferences',
     WARNINGS type string value 'warnings',
     TRAIT_ID type string value 'trait_id',
     NAME type string value 'name',
     CATEGORY type string value 'category',
     PERCENTILE type string value 'percentile',
     RAW_SCORE type string value 'raw_score',
     SIGNIFICANT type string value 'significant',
     CHILDREN type string value 'children',
     PERCENTAGE type string value 'percentage',
     CNSMPTN_PREFERENCE_CATEGORY_ID type string value 'consumption_preference_category_id',
     CONSUMPTION_PREFERENCE_ID type string value 'consumption_preference_id',
     SCORE type string value 'score',
     WARNING_ID type string value 'warning_id',
     MESSAGE type string value 'message',
     CONTENTITEMS type string value 'contentItems',
     CONTENTITEM type string value 'contentItem',
     CONTENT type string value 'content',
     ID type string value 'id',
     CREATED type string value 'created',
     UPDATED type string value 'updated',
     CONTENTTYPE type string value 'contenttype',
     LANGUAGE type string value 'language',
     PARENTID type string value 'parentid',
     REPLY type string value 'reply',
     FORWARD type string value 'forward',
     CODE type string value 'code',
     SUB_CODE type string value 'sub_code',
     ERROR type string value 'error',
     HELP type string value 'help',
  end of C_ABAPNAME_DICTIONARY .


  methods GET_APPNAME
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
  methods GET_SDK_VERSION_DATE
    redefinition .


    "! <p class="shorttext synchronized" lang="en">Get profile</p>
    "!   Generates a personality profile for the author of the input text. The service
    "!    accepts a maximum of 20 MB of input content, but it requires much less text to
    "!    produce an accurate profile. The service can analyze text in Arabic, English,
    "!    Japanese, Korean, or Spanish. It can return its results in a variety of
    "!    languages. <br/>
    "!   <br/>
    "!   **See also:**<br/>
    "!   * [Requesting a
    "!    profile](https://cloud.ibm.com/docs/personality-insights?topic=personality-insi
    "!   ghts-input#input)<br/>
    "!   * [Providing sufficient
    "!    input](https://cloud.ibm.com/docs/personality-insights?topic=personality-insigh
    "!   ts-input#sufficient) <br/>
    "!   <br/>
    "!   ### Content types<br/>
    "!   <br/>
    "!    You can provide input content as plain text (`text/plain`), HTML (`text/html`),
    "!    or JSON (`application/json`) by specifying the **Content-Type** parameter. The
    "!    default is `text/plain`.<br/>
    "!   * Per the JSON specification, the default character encoding for JSON content is
    "!    effectively always UTF-8.<br/>
    "!   * Per the HTTP specification, the default encoding for plain text and HTML is
    "!    ISO-8859-1 (effectively, the ASCII character set). <br/>
    "!   <br/>
    "!   When specifying a content type of plain text or HTML, include the `charset`
    "!    parameter to indicate the character encoding of the input text; for example,
    "!    `Content-Type: text/plain;charset=utf-8`. <br/>
    "!   <br/>
    "!   **See also:** [Specifying request and response
    "!    formats](https://cloud.ibm.com/docs/personality-insights?topic=personality-insi
    "!   ghts-input#formats) <br/>
    "!   <br/>
    "!   ### Accept types<br/>
    "!   <br/>
    "!    You must request a response as JSON (`application/json`) or comma-separated
    "!    values (`text/csv`) by specifying the **Accept** parameter. CSV output includes
    "!    a fixed number of columns. Set the **csv_headers** parameter to `true` to
    "!    request optional column headers for CSV output. <br/>
    "!   <br/>
    "!   **See also:**<br/>
    "!   * [Understanding a JSON
    "!    profile](https://cloud.ibm.com/docs/personality-insights?topic=personality-insi
    "!   ghts-output#output)<br/>
    "!   * [Understanding a CSV
    "!    profile](https://cloud.ibm.com/docs/personality-insights?topic=personality-insi
    "!   ghts-outputCSV#outputCSV)
    "!
    "! @parameter I_CONTENT |
    "!   A maximum of 20 MB of content to analyze, though the service requires much less
    "!    text; for more information, see [Providing sufficient
    "!    input](https://cloud.ibm.com/docs/personality-insights?topic=personality-insigh
    "!   ts-input#sufficient). For JSON input, provide an object of type `Content`.
    "! @parameter I_CONTENT_TYPE |
    "!   The type of the input. For more information, see **Content types** in the method
    "!    description.
    "! @parameter I_CONTENT_LANGUAGE |
    "!   The language of the input text for the request: Arabic, English, Japanese,
    "!    Korean, or Spanish. Regional variants are treated as their parent language; for
    "!    example, `en-US` is interpreted as `en`. <br/>
    "!   <br/>
    "!   The effect of the **Content-Language** parameter depends on the **Content-Type**
    "!    parameter. When **Content-Type** is `text/plain` or `text/html`,
    "!    **Content-Language** is the only way to specify the language. When
    "!    **Content-Type** is `application/json`, **Content-Language** overrides a
    "!    language specified with the `language` parameter of a `ContentItem` object, and
    "!    content items that specify a different language are ignored; omit this
    "!    parameter to base the language on the specification of the content items. You
    "!    can specify any combination of languages for **Content-Language** and
    "!    **Accept-Language**.
    "! @parameter I_ACCEPT_LANGUAGE |
    "!   The desired language of the response. For two-character arguments, regional
    "!    variants are treated as their parent language; for example, `en-US` is
    "!    interpreted as `en`. You can specify any combination of languages for the input
    "!    and response content.
    "! @parameter I_RAW_SCORES |
    "!   Indicates whether a raw score in addition to a normalized percentile is returned
    "!    for each characteristic; raw scores are not compared with a sample population.
    "!    By default, only normalized percentiles are returned.
    "! @parameter I_CSV_HEADERS |
    "!   Indicates whether column labels are returned with a CSV response. By default, no
    "!    column labels are returned. Applies only when the response type is CSV
    "!    (`text/csv`).
    "! @parameter I_CONSUMPTION_PREFERENCES |
    "!   Indicates whether consumption preferences are returned with the results. By
    "!    default, no consumption preferences are returned.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_PROFILE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods PROFILE
    importing
      !I_CONTENT type T_CONTENT
      !I_CONTENT_TYPE type STRING default 'text/plain'
      !I_CONTENT_LANGUAGE type STRING default 'en'
      !I_ACCEPT_LANGUAGE type STRING default 'en'
      !I_RAW_SCORES type BOOLEAN default c_boolean_false
      !I_CSV_HEADERS type BOOLEAN default c_boolean_false
      !I_CONSUMPTION_PREFERENCES type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_PROFILE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get profile as csv</p>
    "!   Generates a personality profile for the author of the input text. The service
    "!    accepts a maximum of 20 MB of input content, but it requires much less text to
    "!    produce an accurate profile. The service can analyze text in Arabic, English,
    "!    Japanese, Korean, or Spanish. It can return its results in a variety of
    "!    languages. <br/>
    "!   <br/>
    "!   **See also:**<br/>
    "!   * [Requesting a
    "!    profile](https://cloud.ibm.com/docs/personality-insights?topic=personality-insi
    "!   ghts-input#input)<br/>
    "!   * [Providing sufficient
    "!    input](https://cloud.ibm.com/docs/personality-insights?topic=personality-insigh
    "!   ts-input#sufficient) <br/>
    "!   <br/>
    "!   ### Content types<br/>
    "!   <br/>
    "!    You can provide input content as plain text (`text/plain`), HTML (`text/html`),
    "!    or JSON (`application/json`) by specifying the **Content-Type** parameter. The
    "!    default is `text/plain`.<br/>
    "!   * Per the JSON specification, the default character encoding for JSON content is
    "!    effectively always UTF-8.<br/>
    "!   * Per the HTTP specification, the default encoding for plain text and HTML is
    "!    ISO-8859-1 (effectively, the ASCII character set). <br/>
    "!   <br/>
    "!   When specifying a content type of plain text or HTML, include the `charset`
    "!    parameter to indicate the character encoding of the input text; for example,
    "!    `Content-Type: text/plain;charset=utf-8`. <br/>
    "!   <br/>
    "!   **See also:** [Specifying request and response
    "!    formats](https://cloud.ibm.com/docs/personality-insights?topic=personality-insi
    "!   ghts-input#formats) <br/>
    "!   <br/>
    "!   ### Accept types<br/>
    "!   <br/>
    "!    You must request a response as JSON (`application/json`) or comma-separated
    "!    values (`text/csv`) by specifying the **Accept** parameter. CSV output includes
    "!    a fixed number of columns. Set the **csv_headers** parameter to `true` to
    "!    request optional column headers for CSV output. <br/>
    "!   <br/>
    "!   **See also:**<br/>
    "!   * [Understanding a JSON
    "!    profile](https://cloud.ibm.com/docs/personality-insights?topic=personality-insi
    "!   ghts-output#output)<br/>
    "!   * [Understanding a CSV
    "!    profile](https://cloud.ibm.com/docs/personality-insights?topic=personality-insi
    "!   ghts-outputCSV#outputCSV)
    "!
    "! @parameter I_CONTENT |
    "!   A maximum of 20 MB of content to analyze, though the service requires much less
    "!    text; for more information, see [Providing sufficient
    "!    input](https://cloud.ibm.com/docs/personality-insights?topic=personality-insigh
    "!   ts-input#sufficient). For JSON input, provide an object of type `Content`.
    "! @parameter I_CONTENT_TYPE |
    "!   The type of the input. For more information, see **Content types** in the method
    "!    description.
    "! @parameter I_CONTENT_LANGUAGE |
    "!   The language of the input text for the request: Arabic, English, Japanese,
    "!    Korean, or Spanish. Regional variants are treated as their parent language; for
    "!    example, `en-US` is interpreted as `en`. <br/>
    "!   <br/>
    "!   The effect of the **Content-Language** parameter depends on the **Content-Type**
    "!    parameter. When **Content-Type** is `text/plain` or `text/html`,
    "!    **Content-Language** is the only way to specify the language. When
    "!    **Content-Type** is `application/json`, **Content-Language** overrides a
    "!    language specified with the `language` parameter of a `ContentItem` object, and
    "!    content items that specify a different language are ignored; omit this
    "!    parameter to base the language on the specification of the content items. You
    "!    can specify any combination of languages for **Content-Language** and
    "!    **Accept-Language**.
    "! @parameter I_ACCEPT_LANGUAGE |
    "!   The desired language of the response. For two-character arguments, regional
    "!    variants are treated as their parent language; for example, `en-US` is
    "!    interpreted as `en`. You can specify any combination of languages for the input
    "!    and response content.
    "! @parameter I_RAW_SCORES |
    "!   Indicates whether a raw score in addition to a normalized percentile is returned
    "!    for each characteristic; raw scores are not compared with a sample population.
    "!    By default, only normalized percentiles are returned.
    "! @parameter I_CSV_HEADERS |
    "!   Indicates whether column labels are returned with a CSV response. By default, no
    "!    column labels are returned. Applies only when the response type is CSV
    "!    (`text/csv`).
    "! @parameter I_CONSUMPTION_PREFERENCES |
    "!   Indicates whether consumption preferences are returned with the results. By
    "!    default, no consumption preferences are returned.
    "! @parameter E_RESPONSE |
    "!   Service return value of type STRING
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods PROFILE_AS_CSV
    importing
      !I_CONTENT type T_CONTENT
      !I_CONTENT_TYPE type STRING default 'text/plain'
      !I_CONTENT_LANGUAGE type STRING default 'en'
      !I_ACCEPT_LANGUAGE type STRING default 'en'
      !I_RAW_SCORES type BOOLEAN default c_boolean_false
      !I_CSV_HEADERS type BOOLEAN default c_boolean_false
      !I_CONSUMPTION_PREFERENCES type BOOLEAN default c_boolean_false
      !I_accept      type string default 'text/csv'
    exporting
      !E_RESPONSE type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .


protected section.

private section.

  methods SET_DEFAULT_QUERY_PARAMETERS
    changing
      !C_URL type TS_URL .

ENDCLASS.

class ZCL_IBMC_PERSONAL_INSIGHTS_V3 IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_PERSONAL_INSIGHTS_V3->GET_APPNAME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_APPNAME                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method GET_APPNAME.

    e_appname = 'Personality Insights'.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method ZCL_IBMC_PERSONAL_INSIGHTS_V3->GET_REQUEST_PROP
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
  elseif lv_auth_method eq 'basicAuth'.
    e_request_prop-auth_name       = 'basicAuth'.
    e_request_prop-auth_type       = 'http'.
    e_request_prop-auth_basic      = c_boolean_true.
  else.
  endif.

  e_request_prop-url-protocol    = 'http'.
  e_request_prop-url-host        = 'localhost'.
  e_request_prop-url-path_base   = '/personality-insights/api'.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_PERSONAL_INSIGHTS_V3->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20200310173434'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_PERSONAL_INSIGHTS_V3->PROFILE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CONTENT        TYPE T_CONTENT
* | [--->] I_CONTENT_TYPE        TYPE STRING (default ='text/plain')
* | [--->] I_CONTENT_LANGUAGE        TYPE STRING (default ='en')
* | [--->] I_ACCEPT_LANGUAGE        TYPE STRING (default ='en')
* | [--->] I_RAW_SCORES        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_CSV_HEADERS        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_CONSUMPTION_PREFERENCES        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_PROFILE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method PROFILE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/profile'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_RAW_SCORES is supplied.
    lv_queryparam = i_RAW_SCORES.
    add_query_parameter(
      exporting
        i_parameter  = `raw_scores`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CSV_HEADERS is supplied.
    lv_queryparam = i_CSV_HEADERS.
    add_query_parameter(
      exporting
        i_parameter  = `csv_headers`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CONSUMPTION_PREFERENCES is supplied.
    lv_queryparam = i_CONSUMPTION_PREFERENCES.
    add_query_parameter(
      exporting
        i_parameter  = `consumption_preferences`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    " process header parameters
    data:
      lv_headerparam type string  ##NEEDED.

    if i_CONTENT_TYPE is supplied.
    ls_request_prop-header_content_type = I_CONTENT_TYPE.
    endif.

    if i_CONTENT_LANGUAGE is supplied.
    lv_headerparam = I_CONTENT_LANGUAGE.
    add_header_parameter(
      exporting
        i_parameter  = 'Content-Language'
        i_value      = lv_headerparam
      changing
        c_headers    = ls_request_prop-headers )  ##NO_TEXT.
    endif.

    if i_ACCEPT_LANGUAGE is supplied.
    lv_headerparam = I_ACCEPT_LANGUAGE.
    add_header_parameter(
      exporting
        i_parameter  = 'Accept-Language'
        i_value      = lv_headerparam
      changing
        c_headers    = ls_request_prop-headers )  ##NO_TEXT.
    endif.



    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_CONTENT ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_CONTENT i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'content' i_value = i_CONTENT ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_CONTENT to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_PERSONAL_INSIGHTS_V3->PROFILE_AS_CSV
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CONTENT        TYPE T_CONTENT
* | [--->] I_CONTENT_TYPE        TYPE STRING (default ='text/plain')
* | [--->] I_CONTENT_LANGUAGE        TYPE STRING (default ='en')
* | [--->] I_ACCEPT_LANGUAGE        TYPE STRING (default ='en')
* | [--->] I_RAW_SCORES        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_CSV_HEADERS        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_CONSUMPTION_PREFERENCES        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='text/csv')
* | [<---] E_RESPONSE                    TYPE        STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method PROFILE_AS_CSV.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/profile'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_RAW_SCORES is supplied.
    lv_queryparam = i_RAW_SCORES.
    add_query_parameter(
      exporting
        i_parameter  = `raw_scores`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CSV_HEADERS is supplied.
    lv_queryparam = i_CSV_HEADERS.
    add_query_parameter(
      exporting
        i_parameter  = `csv_headers`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CONSUMPTION_PREFERENCES is supplied.
    lv_queryparam = i_CONSUMPTION_PREFERENCES.
    add_query_parameter(
      exporting
        i_parameter  = `consumption_preferences`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    " process header parameters
    data:
      lv_headerparam type string  ##NEEDED.

    if i_CONTENT_TYPE is supplied.
    ls_request_prop-header_content_type = I_CONTENT_TYPE.
    endif.

    if i_CONTENT_LANGUAGE is supplied.
    lv_headerparam = I_CONTENT_LANGUAGE.
    add_header_parameter(
      exporting
        i_parameter  = 'Content-Language'
        i_value      = lv_headerparam
      changing
        c_headers    = ls_request_prop-headers )  ##NO_TEXT.
    endif.

    if i_ACCEPT_LANGUAGE is supplied.
    lv_headerparam = I_ACCEPT_LANGUAGE.
    add_header_parameter(
      exporting
        i_parameter  = 'Accept-Language'
        i_value      = lv_headerparam
      changing
        c_headers    = ls_request_prop-headers )  ##NO_TEXT.
    endif.



    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_CONTENT ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_CONTENT i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'content' i_value = i_CONTENT ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_CONTENT to <lv_text>.
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


    " retrieve file data
    e_response = get_response_string( lo_response ).

endmethod.




* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_IBMC_PERSONAL_INSIGHTS_V3->SET_DEFAULT_QUERY_PARAMETERS
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
