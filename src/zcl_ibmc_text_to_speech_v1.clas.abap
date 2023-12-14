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
"! <p class="shorttext synchronized" lang="en">Text to Speech</p>
"! The IBM Watson&trade; Text to Speech service provides APIs that use IBM&apos;s
"!  speech-synthesis capabilities to synthesize text into natural-sounding speech
"!  in a variety of languages, dialects, and voices. The service supports at least
"!  one male or female voice, sometimes both, for each language. The audio is
"!  streamed back to the client with minimal delay. <br/>
"! <br/>
"! For speech synthesis, the service supports a synchronous HTTP Representational
"!  State Transfer (REST) interface and a WebSocket interface. Both interfaces
"!  support plain text and SSML input. SSML is an XML-based markup language that
"!  provides text annotation for speech-synthesis applications. The WebSocket
"!  interface also supports the SSML &lt;code&gt;&lt;mark&gt;&lt;/code&gt; element
"!  and word timings. <br/>
"! <br/>
"! The service offers a customization interface that you can use to define
"!  sounds-like or phonetic translations for words. A sounds-like translation
"!  consists of one or more words that, when combined, sound like the word. A
"!  phonetic translation is based on the SSML phoneme format for representing a
"!  word. You can specify a phonetic translation in standard International Phonetic
"!  Alphabet (IPA) representation or in the proprietary IBM Symbolic Phonetic
"!  Representation (SPR). For phonetic translation, the Arabic, Chinese, Dutch,
"!  Australian English, Korean, and Swedish voices support only IPA, not SPR. <br/>
"! <br/>
"! The service also offers a Tune by Example feature that lets you define custom
"!  prompts. You can also define speaker models to improve the quality of your
"!  custom prompts. The service support custom prompts only for US English custom
"!  models and voices. <br/>
"! <br/>
"! Effective **31 March 2022**, all *neural voices* are deprecated. The deprecated
"!  voices remain available to existing users until 31 March 2023, when they will
"!  be removed from the service and the documentation. *No enhanced neural voices
"!  or expressive neural voices are deprecated.*&lt;br/&gt;&lt;br/&gt; For more
"!  information, see the [1 March 2023 service
"!  update](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-release-
"! notes#text-to-speech-1march2023) in the release notes for
"!  &#123;&#123;site.data.keyword.texttospeechshort&#125;&#125; for
"!  &#123;&#123;site.data.keyword.cloud_notm&#125;&#125;.&#123;: deprecated&#125; <br/>
class ZCL_IBMC_TEXT_TO_SPEECH_V1 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about a speaker model.</p>
    begin of T_SPEAKER,
      "!   The speaker ID (GUID) of the speaker.
      SPEAKER_ID type STRING,
      "!   The user-defined name of the speaker.
      NAME type STRING,
    end of T_SPEAKER.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about a custom prompt.</p>
    begin of T_PROMPT,
      "!   The user-specified text of the prompt.
      PROMPT type STRING,
      "!   The user-specified identifier (name) of the prompt.
      PROMPT_ID type STRING,
      "!   The status of the prompt:<br/>
      "!   * `processing`: The service received the request to add the prompt and is
      "!    analyzing the validity of the prompt.<br/>
      "!   * `available`: The service successfully validated the prompt, which is now ready
      "!    for use in a speech synthesis request.<br/>
      "!   * `failed`: The service&apos;s validation of the prompt failed. The status of
      "!    the prompt includes an `error` field that describes the reason for the failure.
      "!
      STATUS type STRING,
      "!   If the status of the prompt is `failed`, an error message that describes the
      "!    reason for the failure. The field is omitted if no error occurred.
      ERROR type STRING,
      "!   The speaker ID (GUID) of the speaker for which the prompt was defined. The field
      "!    is omitted if no speaker ID was specified.
      SPEAKER_ID type STRING,
    end of T_PROMPT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about a word for the custom model.</p>
    begin of T_WORD,
      "!   The word for the custom model. The maximum length of a word is 49 characters.
      WORD type STRING,
      "!   The phonetic or sounds-like translation for the word. A phonetic translation is
      "!    based on the SSML format for representing the phonetic string of a word either
      "!    as an IPA or IBM SPR translation. The Arabic, Chinese, Dutch, Australian
      "!    English, and Korean languages support only IPA. A sounds-like translation
      "!    consists of one or more words that, when combined, sound like the word. The
      "!    maximum length of a translation is 499 characters.
      TRANSLATION type STRING,
      "!   **Japanese only.** The part of speech for the word. The service uses the value
      "!    to produce the correct intonation for the word. You can create only a single
      "!    entry, with or without a single part of speech, for any word; you cannot create
      "!    multiple entries with different parts of speech for the same word. For more
      "!    information, see [Working with Japanese
      "!    entries](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-rules#j
      "!   aNotes).
      PART_OF_SPEECH type STRING,
    end of T_WORD.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about an existing custom model.</p>
    begin of T_CUSTOM_MODEL,
      "!   The customization ID (GUID) of the custom model. The [Create a custom
      "!    model](#createcustommodel) method returns only this field. It does not not
      "!    return the other fields of this object.
      CUSTOMIZATION_ID type STRING,
      "!   The name of the custom model.
      NAME type STRING,
      "!   The language identifier of the custom model (for example, `en-US`).
      LANGUAGE type STRING,
      "!   The GUID of the credentials for the instance of the service that owns the custom
      "!    model.
      OWNER type STRING,
      "!   The date and time in Coordinated Universal Time (UTC) at which the custom model
      "!    was created. The value is provided in full ISO 8601 format
      "!    (`YYYY-MM-DDThh:mm:ss.sTZD`).
      CREATED type STRING,
      "!   The date and time in Coordinated Universal Time (UTC) at which the custom model
      "!    was last modified. The `created` and `updated` fields are equal when a model is
      "!    first added but has yet to be updated. The value is provided in full ISO 8601
      "!    format (`YYYY-MM-DDThh:mm:ss.sTZD`).
      LAST_MODIFIED type STRING,
      "!   The description of the custom model.
      DESCRIPTION type STRING,
      "!   An array of `Word` objects that lists the words and their translations from the
      "!    custom model. The words are listed in alphabetical order, with uppercase
      "!    letters listed before lowercase letters. The array is empty if no words are
      "!    defined for the custom model. This field is returned only by the [Get a custom
      "!    model](#getcustommodel) method.
      WORDS type STANDARD TABLE OF T_WORD WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of `Prompt` objects that provides information about the prompts that
      "!    are defined for the specified custom model. The array is empty if no prompts
      "!    are defined for the custom model. This field is returned only by the [Get a
      "!    custom model](#getcustommodel) method.
      PROMPTS type STANDARD TABLE OF T_PROMPT WITH NON-UNIQUE DEFAULT KEY,
    end of T_CUSTOM_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Additional service features that are supported with the</p>
    "!     voice.
    begin of T_SUPPORTED_FEATURES,
      "!   If `true`, the voice can be customized; if `false`, the voice cannot be
      "!    customized. (Same as `customizable`.).
      CUSTOM_PRONUNCIATION type BOOLEAN,
      "!   If `true`, the voice can be transformed by using the SSML
      "!    &lt;voice-transformation&gt; element; if `false`, the voice cannot be
      "!    transformed. The feature was available only for the now-deprecated standard
      "!    voices. You cannot use the feature with neural voices.
      VOICE_TRANSFORMATION type BOOLEAN,
    end of T_SUPPORTED_FEATURES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about an available voice.</p>
    begin of T_VOICE,
      "!   The URI of the voice.
      URL type STRING,
      "!   The gender of the voice: `male` or `female`.
      GENDER type STRING,
      "!   The name of the voice. Use this as the voice identifier in all requests.
      NAME type STRING,
      "!   The language and region of the voice (for example, `en-US`).
      LANGUAGE type STRING,
      "!   A textual description of the voice.
      DESCRIPTION type STRING,
      "!   If `true`, the voice can be customized; if `false`, the voice cannot be
      "!    customized. (Same as `custom_pronunciation`; maintained for backward
      "!    compatibility.).
      CUSTOMIZABLE type BOOLEAN,
      "!   Additional service features that are supported with the voice.
      SUPPORTED_FEATURES type T_SUPPORTED_FEATURES,
      "!   Returns information about a specified custom model. This field is returned only
      "!    by the [Get a voice](#getvoice) method and only when you specify the
      "!    customization ID of a custom model.
      CUSTOMIZATION type T_CUSTOM_MODEL,
    end of T_VOICE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A prompt that a speaker has defined for a custom model.</p>
    begin of T_SPEAKER_PROMPT,
      "!   The user-specified text of the prompt.
      PROMPT type STRING,
      "!   The user-specified identifier (name) of the prompt.
      PROMPT_ID type STRING,
      "!   The status of the prompt:<br/>
      "!   * `processing`: The service received the request to add the prompt and is
      "!    analyzing the validity of the prompt.<br/>
      "!   * `available`: The service successfully validated the prompt, which is now ready
      "!    for use in a speech synthesis request.<br/>
      "!   * `failed`: The service&apos;s validation of the prompt failed. The status of
      "!    the prompt includes an `error` field that describes the reason for the failure.
      "!
      STATUS type STRING,
      "!   If the status of the prompt is `failed`, an error message that describes the
      "!    reason for the failure. The field is omitted if no error occurred.
      ERROR type STRING,
    end of T_SPEAKER_PROMPT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A custom models for which the speaker has defined prompts.</p>
    begin of T_SPEAKER_CUSTOM_MODEL,
      "!   The customization ID (GUID) of a custom model for which the speaker has defined
      "!    one or more prompts.
      CUSTOMIZATION_ID type STRING,
      "!   An array of `SpeakerPrompt` objects that provides information about each prompt
      "!    that the user has defined for the custom model.
      PROMPTS type STANDARD TABLE OF T_SPEAKER_PROMPT WITH NON-UNIQUE DEFAULT KEY,
    end of T_SPEAKER_CUSTOM_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Custom models for which the speaker has defined prompts.</p>
    begin of T_SPEAKER_CUSTOM_MODELS,
      "!   An array of `SpeakerCustomModel` objects. Each object provides information about
      "!    the prompts that are defined for a specified speaker in the custom models that
      "!    are owned by a specified service instance. The array is empty if no prompts are
      "!    defined for the speaker.
      CUSTOMIZATIONS type STANDARD TABLE OF T_SPEAKER_CUSTOM_MODEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_SPEAKER_CUSTOM_MODELS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The error response from a failed request.</p>
    begin of T_ERROR_MODEL,
      "!   Description of the problem.
      ERROR type STRING,
      "!   HTTP response code.
      CODE type INTEGER,
      "!   Response message.
      CODE_DESCRIPTION type STRING,
    end of T_ERROR_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    For the [Add custom words](#addwords) method, one or more</p>
    "!     words that are to be added or updated for the custom model and the translation
    "!     for each specified word. <br/>
    "!    <br/>
    "!    For the [List custom words](#listwords) method, the words and their translations
    "!     from the custom model.
    begin of T_WORDS,
      "!   The [Add custom words](#addwords) method accepts an array of `Word` objects.
      "!    Each object provides a word that is to be added or updated for the custom model
      "!    and the word&apos;s translation. <br/>
      "!   <br/>
      "!   The [List custom words](#listwords) method returns an array of `Word` objects.
      "!    Each object shows a word and its translation from the custom model. The words
      "!    are listed in alphabetical order, with uppercase letters listed before
      "!    lowercase letters. The array is empty if the custom model contains no words.
      WORDS type STANDARD TABLE OF T_WORD WITH NON-UNIQUE DEFAULT KEY,
    end of T_WORDS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The speaker ID of the speaker model.</p>
    begin of T_SPEAKER_MODEL,
      "!   The speaker ID (GUID) of the speaker model.
      SPEAKER_ID type STRING,
    end of T_SPEAKER_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about all available voices.</p>
    begin of T_VOICES,
      "!   A list of available voices.
      VOICES type STANDARD TABLE OF T_VOICE WITH NON-UNIQUE DEFAULT KEY,
    end of T_VOICES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about the prompt that is to be added to a custom</p>
    "!     model. The following example of a `PromptMetadata` object includes both the
    "!     required prompt text and an optional speaker model ID: <br/>
    "!    <br/>
    "!    `&#123; &quot;prompt_text&quot;: &quot;Thank you and good-bye!&quot;,
    "!     &quot;speaker_id&quot;: &quot;823068b2-ed4e-11ea-b6e0-7b6456aa95cc&quot;
    "!     &#125;`.
    begin of T_PROMPT_METADATA,
      "!   The required written text of the spoken prompt. The length of a prompt&apos;s
      "!    text is limited to a few sentences. Speaking one or two sentences of text is
      "!    the recommended limit. A prompt cannot contain more than 1000 characters of
      "!    text. Escape any XML control characters (double quotes, single quotes,
      "!    ampersands, angle brackets, and slashes) that appear in the text of the prompt.
      "!
      PROMPT_TEXT type STRING,
      "!   The optional speaker ID (GUID) of a previously defined speaker model that is to
      "!    be associated with the prompt.
      SPEAKER_ID type STRING,
    end of T_PROMPT_METADATA.
  types:
    "! No documentation available.
    begin of T_INLINE_OBJECT,
      "!   Information about the prompt that is to be added to a custom model. The
      "!    following example of a `PromptMetadata` object includes both the required
      "!    prompt text and an optional speaker model ID: <br/>
      "!   <br/>
      "!   `&#123; &quot;prompt_text&quot;: &quot;Thank you and good-bye!&quot;,
      "!    &quot;speaker_id&quot;: &quot;823068b2-ed4e-11ea-b6e0-7b6456aa95cc&quot;
      "!    &#125;`.
      METADATA type T_PROMPT_METADATA,
      "!   An audio file that speaks the text of the prompt with intonation and prosody
      "!    that matches how you would like the prompt to be spoken.<br/>
      "!   * The prompt audio must be in WAV format and must have a minimum sampling rate
      "!    of 16 kHz. The service accepts audio with higher sampling rates. The service
      "!    transcodes all audio to 16 kHz before processing it.<br/>
      "!   * The length of the prompt audio is limited to 30 seconds.
      FILE type FILE,
    end of T_INLINE_OBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about the updated custom model.</p>
    begin of T_UPDATE_CUSTOM_MODEL,
      "!   A new name for the custom model.
      NAME type STRING,
      "!   A new description for the custom model.
      DESCRIPTION type STRING,
      "!   An array of `Word` objects that provides the words and their translations that
      "!    are to be added or updated for the custom model. Pass an empty array to make no
      "!    additions or updates.
      WORDS type STANDARD TABLE OF T_WORD WITH NON-UNIQUE DEFAULT KEY,
    end of T_UPDATE_CUSTOM_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The empty response from a request.</p>
      T_EMPTY_RESPONSE_BODY type JSONOBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about the new custom model.</p>
    begin of T_CREATE_CUSTOM_MODEL,
      "!   The name of the new custom model. Use a localized name that matches the language
      "!    of the custom model. Use a name that describes the purpose of the custom model,
      "!    such as `Medical custom model` or `Legal custom model`. Use a name that is
      "!    unique among all custom models that you own. <br/>
      "!   <br/>
      "!   Include a maximum of 256 characters in the name. Do not use backslashes,
      "!    slashes, colons, equal signs, ampersands, or question marks in the name.
      NAME type STRING,
      "!   The language of the new custom model. You create a custom model for a specific
      "!    language, not for a specific voice. A custom model can be used with any voice
      "!    for its specified language. Omit the parameter to use the the default language,
      "!    `en-US`.
      LANGUAGE type STRING,
      "!   A recommended description of the new custom model. Use a localized description
      "!    that matches the language of the custom model. Include a maximum of 128
      "!    characters in the description.
      DESCRIPTION type STRING,
    end of T_CREATE_CUSTOM_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The text to synthesize. Specify either plain text or a</p>
    "!     subset of SSML. SSML is an XML-based markup language that provides text
    "!     annotation for speech-synthesis applications. Pass a maximum of 5 KB of input
    "!     text. For more information, see<br/>
    "!    * [Specifying input
    "!     text](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-usingHTTP#
    "!    input)<br/>
    "!    * [Understanding
    "!     SSML](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-ssml).
    begin of T_TEXT,
      "!   The text to synthesize.
      TEXT type STRING,
    end of T_TEXT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about all speaker models for the service</p>
    "!     instance.
    begin of T_SPEAKERS,
      "!   An array of `Speaker` objects that provides information about the speakers for
      "!    the service instance. The array is empty if the service instance has no
      "!    speakers.
      SPEAKERS type STANDARD TABLE OF T_SPEAKER WITH NON-UNIQUE DEFAULT KEY,
    end of T_SPEAKERS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The pronunciation of the specified text.</p>
    begin of T_PRONUNCIATION,
      "!   The pronunciation of the specified text in the requested voice and format. If a
      "!    custom model is specified, the pronunciation also reflects that custom model.
      PRONUNCIATION type STRING,
    end of T_PRONUNCIATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about the custom prompts that are defined for a</p>
    "!     custom model.
    begin of T_PROMPTS,
      "!   An array of `Prompt` objects that provides information about the prompts that
      "!    are defined for the specified custom model. The array is empty if no prompts
      "!    are defined for the custom model.
      PROMPTS type STANDARD TABLE OF T_PROMPT WITH NON-UNIQUE DEFAULT KEY,
    end of T_PROMPTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about existing custom models.</p>
    begin of T_CUSTOM_MODELS,
      "!   An array of `CustomModel` objects that provides information about each available
      "!    custom model. The array is empty if the requesting credentials own no custom
      "!    models (if no language is specified) or own no custom models for the specified
      "!    language.
      CUSTOMIZATIONS type STANDARD TABLE OF T_CUSTOM_MODEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_CUSTOM_MODELS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about the translation for the specified text.</p>
    begin of T_TRANSLATION,
      "!   The phonetic or sounds-like translation for the word. A phonetic translation is
      "!    based on the SSML format for representing the phonetic string of a word either
      "!    as an IPA translation or as an IBM SPR translation. The Arabic, Chinese, Dutch,
      "!    Australian English, and Korean languages support only IPA. A sounds-like is one
      "!    or more words that, when combined, sound like the word.
      TRANSLATION type STRING,
      "!   **Japanese only.** The part of speech for the word. The service uses the value
      "!    to produce the correct intonation for the word. You can create only a single
      "!    entry, with or without a single part of speech, for any word; you cannot create
      "!    multiple entries with different parts of speech for the same word. For more
      "!    information, see [Working with Japanese
      "!    entries](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-rules#j
      "!   aNotes).
      PART_OF_SPEECH type STRING,
    end of T_TRANSLATION.

constants:
  "! <p class="shorttext synchronized" lang="en">List of required fields per type.</p>
  begin of C_REQUIRED_FIELDS,
    T_SPEAKER type string value '|SPEAKER_ID|NAME|',
    T_PROMPT type string value '|PROMPT|PROMPT_ID|STATUS|',
    T_WORD type string value '|WORD|TRANSLATION|',
    T_CUSTOM_MODEL type string value '|CUSTOMIZATION_ID|',
    T_SUPPORTED_FEATURES type string value '|CUSTOM_PRONUNCIATION|VOICE_TRANSFORMATION|',
    T_VOICE type string value '|URL|GENDER|NAME|LANGUAGE|DESCRIPTION|CUSTOMIZABLE|SUPPORTED_FEATURES|',
    T_SPEAKER_PROMPT type string value '|PROMPT|PROMPT_ID|STATUS|',
    T_SPEAKER_CUSTOM_MODEL type string value '|CUSTOMIZATION_ID|PROMPTS|',
    T_SPEAKER_CUSTOM_MODELS type string value '|CUSTOMIZATIONS|',
    T_ERROR_MODEL type string value '|ERROR|CODE|',
    T_WORDS type string value '|WORDS|',
    T_SPEAKER_MODEL type string value '|SPEAKER_ID|',
    T_VOICES type string value '|VOICES|',
    T_PROMPT_METADATA type string value '|PROMPT_TEXT|',
    T_INLINE_OBJECT type string value '|METADATA|FILE|',
    T_UPDATE_CUSTOM_MODEL type string value '|',
    T_CREATE_CUSTOM_MODEL type string value '|NAME|',
    T_TEXT type string value '|TEXT|',
    T_SPEAKERS type string value '|SPEAKERS|',
    T_PRONUNCIATION type string value '|PRONUNCIATION|',
    T_PROMPTS type string value '|PROMPTS|',
    T_CUSTOM_MODELS type string value '|CUSTOMIZATIONS|',
    T_TRANSLATION type string value '|TRANSLATION|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  "! <p class="shorttext synchronized" lang="en">Map ABAP identifiers to service identifiers.</p>
  begin of C_ABAPNAME_DICTIONARY,
     VOICES type string value 'voices',
     URL type string value 'url',
     GENDER type string value 'gender',
     NAME type string value 'name',
     LANGUAGE type string value 'language',
     DESCRIPTION type string value 'description',
     CUSTOMIZABLE type string value 'customizable',
     SUPPORTED_FEATURES type string value 'supported_features',
     CUSTOMIZATION type string value 'customization',
     CUSTOM_PRONUNCIATION type string value 'custom_pronunciation',
     VOICE_TRANSFORMATION type string value 'voice_transformation',
     TEXT type string value 'text',
     CUSTOMIZATIONS type string value 'customizations',
     CUSTOMIZATION_ID type string value 'customization_id',
     OWNER type string value 'owner',
     CREATED type string value 'created',
     LAST_MODIFIED type string value 'last_modified',
     WORDS type string value 'words',
     PROMPTS type string value 'prompts',
     WORD type string value 'word',
     TRANSLATION type string value 'translation',
     PART_OF_SPEECH type string value 'part_of_speech',
     PRONUNCIATION type string value 'pronunciation',
     PROMPT type string value 'prompt',
     PROMPT_ID type string value 'prompt_id',
     STATUS type string value 'status',
     ERROR type string value 'error',
     SPEAKER_ID type string value 'speaker_id',
     SPEAKERS type string value 'speakers',
     PROMPT_TEXT type string value 'prompt_text',
     CODE type string value 'code',
     CODE_DESCRIPTION type string value 'code_description',
     METADATA type string value 'metadata',
     FILE type string value 'file',
  end of C_ABAPNAME_DICTIONARY .


  methods GET_APPNAME
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
  methods GET_SDK_VERSION_DATE
    redefinition .


    "! <p class="shorttext synchronized" lang="en">List voices</p>
    "!   Lists all voices available for use with the service. The information includes
    "!    the name, language, gender, and other details about the voice. The ordering of
    "!    the list of voices can change from call to call; do not rely on an alphabetized
    "!    or static list of voices. To see information about a specific voice, use the
    "!    [Get a voice](#getvoice). <br/>
    "!   <br/>
    "!   **Note:** Effective **31 March 2022**, all *neural voices* are deprecated. The
    "!    deprecated voices remain available to existing users until 31 March 2023, when
    "!    they will be removed from the service and the documentation. *No enhanced
    "!    neural voices or expressive neural voices are deprecated.* For more
    "!    information, see the [1 March 2023 service
    "!    update](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-release-
    "!   notes#text-to-speech-1march2023) in the release notes. <br/>
    "!   <br/>
    "!   **See also:** [Listing all
    "!    voices](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-voices-l
    "!   ist#list-all-voices)
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_VOICES
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_VOICES
    importing
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_VOICES
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get a voice</p>
    "!   Gets information about the specified voice. The information includes the name,
    "!    language, gender, and other details about the voice. Specify a customization ID
    "!    to obtain information for a custom model that is defined for the language of
    "!    the specified voice. To list information about all available voices, use the
    "!    [List voices](#listvoices) method. <br/>
    "!   <br/>
    "!   **See also:** [Listing a specific
    "!    voice](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-voices-li
    "!   st#list-specific-voice). <br/>
    "!   <br/>
    "!   **Note:** Effective **31 March 2022**, all *neural voices* are deprecated. The
    "!    deprecated voices remain available to existing users until 31 March 2023, when
    "!    they will be removed from the service and the documentation. *No enhanced
    "!    neural voices or expressive neural voices are deprecated.* For more
    "!    information, see the [1 March 2023 service
    "!    update](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-release-
    "!   notes#text-to-speech-1march2023) in the release notes.
    "!
    "! @parameter I_VOICE |
    "!   The voice for which information is to be returned.
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of a custom model for which information is to be
    "!    returned. You must make the request with credentials for the instance of the
    "!    service that owns the custom model. Omit the parameter to see information about
    "!    the specified voice with no customization.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_VOICE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_VOICE
    importing
      !I_VOICE type STRING
      !I_CUSTOMIZATION_ID type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_VOICE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Synthesize audio</p>
    "!   Synthesizes text to audio that is spoken in the specified voice. The service
    "!    bases its understanding of the language for the input text on the specified
    "!    voice. Use a voice that matches the language of the input text. <br/>
    "!   <br/>
    "!   The method accepts a maximum of 5 KB of input text in the body of the request,
    "!    and 8 KB for the URL and headers. The 5 KB limit includes any SSML tags that
    "!    you specify. The service returns the synthesized audio stream as an array of
    "!    bytes. <br/>
    "!   <br/>
    "!   **See also:** [The HTTP
    "!    interface](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-using
    "!   HTTP#usingHTTP). <br/>
    "!   <br/>
    "!   **Note:** Effective **31 March 2022**, all *neural voices* are deprecated. The
    "!    deprecated voices remain available to existing users until 31 March 2023, when
    "!    they will be removed from the service and the documentation. *No enhanced
    "!    neural voices or expressive neural voices are deprecated.* For more
    "!    information, see the [1 March 2023 service
    "!    update](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-release-
    "!   notes#text-to-speech-1march2023) in the release notes. <br/>
    "!   <br/>
    "!   ### Audio formats (accept types)<br/>
    "!   <br/>
    "!    The service can return audio in the following formats (MIME types).<br/>
    "!   * Where indicated, you can optionally specify the sampling rate (`rate`) of the
    "!    audio. You must specify a sampling rate for the `audio/alaw`, `audio/l16`,  and
    "!    `audio/mulaw` formats. A specified sampling rate must lie in the range of 8 kHz
    "!    to 192 kHz. Some formats restrict the sampling rate to certain values, as
    "!    noted.<br/>
    "!   * For the `audio/l16` format, you can optionally specify the endianness
    "!    (`endianness`) of the audio: `endianness=big-endian` or
    "!    `endianness=little-endian`. <br/>
    "!   <br/>
    "!   Use the `Accept` header or the `accept` parameter to specify the requested
    "!    format of the response audio. If you omit an audio format altogether, the
    "!    service returns the audio in Ogg format with the Opus codec
    "!    (`audio/ogg;codecs=opus`). The service always returns single-channel
    "!    audio.<br/>
    "!   * `audio/alaw` - You must specify the `rate` of the audio.<br/>
    "!   * `audio/basic` - The service returns audio with a sampling rate of 8000
    "!    Hz.<br/>
    "!   * `audio/flac` - You can optionally specify the `rate` of the audio. The default
    "!    sampling rate is 22,050 Hz.<br/>
    "!   * `audio/l16` - You must specify the `rate` of the audio. You can optionally
    "!    specify the `endianness` of the audio. The default endianness is
    "!    `little-endian`.<br/>
    "!   * `audio/mp3` - You can optionally specify the `rate` of the audio. The default
    "!    sampling rate is 22,050 Hz.<br/>
    "!   * `audio/mpeg` - You can optionally specify the `rate` of the audio. The default
    "!    sampling rate is 22,050 Hz.<br/>
    "!   * `audio/mulaw` - You must specify the `rate` of the audio.<br/>
    "!   * `audio/ogg` - The service returns the audio in the `vorbis` codec. You can
    "!    optionally specify the `rate` of the audio. The default sampling rate is 22,050
    "!    Hz.<br/>
    "!   * `audio/ogg;codecs=opus` - You can optionally specify the `rate` of the audio.
    "!    Only the following values are valid sampling rates: `48000`, `24000`, `16000`,
    "!    `12000`, or `8000`. If you specify a value other than one of these, the service
    "!    returns an error. The default sampling rate is 48,000 Hz.<br/>
    "!   * `audio/ogg;codecs=vorbis` - You can optionally specify the `rate` of the
    "!    audio. The default sampling rate is 22,050 Hz.<br/>
    "!   * `audio/wav` - You can optionally specify the `rate` of the audio. The default
    "!    sampling rate is 22,050 Hz.<br/>
    "!   * `audio/webm` - The service returns the audio in the `opus` codec. The service
    "!    returns audio with a sampling rate of 48,000 Hz.<br/>
    "!   * `audio/webm;codecs=opus` - The service returns audio with a sampling rate of
    "!    48,000 Hz.<br/>
    "!   * `audio/webm;codecs=vorbis` - You can optionally specify the `rate` of the
    "!    audio. The default sampling rate is 22,050 Hz. <br/>
    "!   <br/>
    "!   For more information about specifying an audio format, including additional
    "!    details about some of the formats, see [Using audio
    "!    formats](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-audio-f
    "!   ormats). <br/>
    "!   <br/>
    "!   **Note:** By default, the service returns audio in the Ogg audio format with the
    "!    Opus codec (`audio/ogg;codecs=opus`). However, the Ogg audio format is not
    "!    supported with the Safari browser. If you are using the service with the Safari
    "!    browser, you must use the `Accept` request header or the `accept` query
    "!    parameter specify a different format in which you want the service to return
    "!    the audio. <br/>
    "!   <br/>
    "!   ### Warning messages<br/>
    "!   <br/>
    "!    If a request includes invalid query parameters, the service returns a
    "!    `Warnings` response header that provides messages about the invalid parameters.
    "!    The warning includes a descriptive message and a list of invalid argument
    "!    strings. For example, a message such as `&quot;Unknown arguments:&quot;` or
    "!    `&quot;Unknown url query arguments:&quot;` followed by a list of the form
    "!    `&quot;&#123;invalid_arg_1&#125;, &#123;invalid_arg_2&#125;.&quot;` The request
    "!    succeeds despite the warnings.
    "!
    "! @parameter I_TEXT |
    "!   No documentation available.
    "! @parameter I_ACCEPT |
    "!   The requested format (MIME type) of the audio. You can use the `Accept` header
    "!    or the `accept` parameter to specify the audio format. For more information
    "!    about specifying an audio format, see **Audio formats (accept types)** in the
    "!    method description.
    "! @parameter I_VOICE |
    "!   The voice to use for speech synthesis. If you omit the `voice` parameter, the
    "!    service uses the US English `en-US_MichaelV3Voice` by default. <br/>
    "!   <br/>
    "!   _For IBM Cloud Pak for Data,_ if you do not install the `en-US_MichaelV3Voice`,
    "!    you must either specify a voice with the request or specify a new default voice
    "!    for your installation of the service. <br/>
    "!   <br/>
    "!   **See also:**<br/>
    "!   * [Languages and
    "!    voices](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-voices)<
    "!   br/>
    "!   * [Using the default
    "!    voice](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-voices-us
    "!   e#specify-voice-default).
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of a custom model to use for the synthesis. If a
    "!    custom model is specified, it works only if it matches the language of the
    "!    indicated voice. You must make the request with credentials for the instance of
    "!    the service that owns the custom model. Omit the parameter to use the specified
    "!    voice with no customization.
    "! @parameter I_SPELL_OUT_MODE |
    "!   *For German voices,* indicates how the service is to spell out strings of
    "!    individual letters. To indicate the pace of the spelling, specify one of the
    "!    following values:<br/>
    "!   * `default` - The service reads the characters at the rate at which it
    "!    synthesizes speech for the request. You can also omit the parameter entirely to
    "!    achieve the default behavior.<br/>
    "!   * `singles` - The service reads the characters one at a time, with a brief pause
    "!    between each character.<br/>
    "!   * `pairs` - The service reads the characters two at a time, with a brief pause
    "!    between each pair.<br/>
    "!   * `triples` - The service reads the characters three at a time, with a brief
    "!    pause between each triplet. <br/>
    "!   <br/>
    "!   For more information, see [Specifying how strings are spelled
    "!    out](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-synthesis-p
    "!   arams#params-spell-out-mode).
    "! @parameter I_RATE_PERCENTAGE |
    "!   The percentage change from the default speaking rate of the voice that is used
    "!    for speech synthesis. Each voice has a default speaking rate that is optimized
    "!    to represent a normal rate of speech. The parameter accepts an integer that
    "!    represents the percentage change from the voice&apos;s default rate:<br/>
    "!   * Specify a signed negative integer to reduce the speaking rate by that
    "!    percentage. For example, -10 reduces the rate by ten percent.<br/>
    "!   * Specify an unsigned or signed positive integer to increase the speaking rate
    "!    by that percentage. For example, 10 and +10 increase the rate by ten
    "!    percent.<br/>
    "!   * Specify 0 or omit the parameter to get the default speaking rate for the
    "!    voice. <br/>
    "!   <br/>
    "!   The parameter affects the rate for an entire request. <br/>
    "!   <br/>
    "!   For more information, see [Modifying the speaking
    "!    rate](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-synthesis-
    "!   params#params-rate-percentage).
    "! @parameter I_PITCH_PERCENTAGE |
    "!   The percentage change from the default speaking pitch of the voice that is used
    "!    for speech synthesis. Each voice has a default speaking pitch that is optimized
    "!    to represent a normal tone of voice. The parameter accepts an integer that
    "!    represents the percentage change from the voice&apos;s default tone:<br/>
    "!   * Specify a signed negative integer to lower the voice&apos;s pitch by that
    "!    percentage. For example, -5 reduces the tone by five percent.<br/>
    "!   * Specify an unsigned or signed positive integer to increase the voice&apos;s
    "!    pitch by that percentage. For example, 5 and +5 increase the tone by five
    "!    percent.<br/>
    "!   * Specify 0 or omit the parameter to get the default speaking pitch for the
    "!    voice. <br/>
    "!   <br/>
    "!   The parameter affects the pitch for an entire request. <br/>
    "!   <br/>
    "!   For more information, see [Modifying the speaking
    "!    pitch](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-synthesis
    "!   -params#params-pitch-percentage).
    "! @parameter E_RESPONSE |
    "!   Service return value of type FILE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods SYNTHESIZE
    importing
      !I_TEXT type T_TEXT
      !I_ACCEPT type STRING default 'audio/ogg;codecs=opus'
      !I_VOICE type STRING default 'en-US_MichaelV3Voice'
      !I_CUSTOMIZATION_ID type STRING optional
      !I_SPELL_OUT_MODE type STRING default 'default'
      !I_RATE_PERCENTAGE type INTEGER default 0
      !I_PITCH_PERCENTAGE type INTEGER default 0
      !I_contenttype type string default 'application/json'
    exporting
      !E_RESPONSE type FILE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Get pronunciation</p>
    "!   Gets the phonetic pronunciation for the specified word. You can request the
    "!    pronunciation for a specific format. You can also request the pronunciation for
    "!    a specific voice to see the default translation for the language of that voice
    "!    or for a specific custom model to see the translation for that model. <br/>
    "!   <br/>
    "!   **Note:** Effective **31 March 2022**, all *neural voices* are deprecated. The
    "!    deprecated voices remain available to existing users until 31 March 2023, when
    "!    they will be removed from the service and the documentation. *No enhanced
    "!    neural voices or expressive neural voices are deprecated.* For more
    "!    information, see the [1 March 2023 service
    "!    update](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-release-
    "!   notes#text-to-speech-1march2023) in the release notes. <br/>
    "!   <br/>
    "!   **See also:** [Querying a word from a
    "!    language](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-custom
    "!   Words#cuWordsQueryLanguage).
    "!
    "! @parameter I_TEXT |
    "!   The word for which the pronunciation is requested.
    "! @parameter I_VOICE |
    "!   A voice that specifies the language in which the pronunciation is to be
    "!    returned. If you omit the `voice` parameter, the service uses the US English
    "!    `en-US_MichaelV3Voice` by default. All voices for the same language (for
    "!    example, `en-US`) return the same translation. <br/>
    "!   <br/>
    "!   _For IBM Cloud Pak for Data,_ if you do not install the `en-US_MichaelV3Voice`,
    "!    you must either specify a voice with the request or specify a new default voice
    "!    for your installation of the service. <br/>
    "!   <br/>
    "!   **See also:** [Using the default
    "!    voice](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-voices-us
    "!   e#specify-voice-default).
    "! @parameter I_FORMAT |
    "!   The phoneme format in which to return the pronunciation. The Arabic, Chinese,
    "!    Dutch, Australian English, and Korean languages support only IPA. Omit the
    "!    parameter to obtain the pronunciation in the default format.
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of a custom model for which the pronunciation is to
    "!    be returned. The language of a specified custom model must match the language
    "!    of the specified voice. If the word is not defined in the specified custom
    "!    model, the service returns the default translation for the custom model&apos;s
    "!    language. You must make the request with credentials for the instance of the
    "!    service that owns the custom model. Omit the parameter to see the translation
    "!    for the specified voice with no customization.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_PRONUNCIATION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_PRONUNCIATION
    importing
      !I_TEXT type STRING
      !I_VOICE type STRING default 'en-US_MichaelV3Voice'
      !I_FORMAT type STRING default 'ipa'
      !I_CUSTOMIZATION_ID type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_PRONUNCIATION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Create a custom model</p>
    "!   Creates a new empty custom model. You must specify a name for the new custom
    "!    model. You can optionally specify the language and a description for the new
    "!    model. The model is owned by the instance of the service whose credentials are
    "!    used to create it. <br/>
    "!   <br/>
    "!   **See also:** [Creating a custom
    "!    model](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-customMod
    "!   els#cuModelsCreate). <br/>
    "!   <br/>
    "!   **Note:** Effective **31 March 2022**, all *neural voices* are deprecated. The
    "!    deprecated voices remain available to existing users until 31 March 2023, when
    "!    they will be removed from the service and the documentation. *No enhanced
    "!    neural voices or expressive neural voices are deprecated.* For more
    "!    information, see the [1 March 2023 service
    "!    update](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-release-
    "!   notes#text-to-speech-1march2023) in the release notes.
    "!
    "! @parameter I_CREATE_VOICE_MODEL |
    "!   A `CreateCustomModel` object that contains information about the new custom
    "!    model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CUSTOM_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_CUSTOM_MODEL
    importing
      !I_CREATE_VOICE_MODEL type T_CREATE_CUSTOM_MODEL
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CUSTOM_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List custom models</p>
    "!   Lists metadata such as the name and description for all custom models that are
    "!    owned by an instance of the service. Specify a language to list the custom
    "!    models for that language only. To see the words and prompts in addition to the
    "!    metadata for a specific custom model, use the [Get a custom
    "!    model](#getcustommodel) method. You must use credentials for the instance of
    "!    the service that owns a model to list information about it. <br/>
    "!   <br/>
    "!   **See also:** [Querying all custom
    "!    models](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-customMo
    "!   dels#cuModelsQueryAll).
    "!
    "! @parameter I_LANGUAGE |
    "!   The language for which custom models that are owned by the requesting
    "!    credentials are to be returned. Omit the parameter to see all custom models
    "!    that are owned by the requester.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CUSTOM_MODELS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_CUSTOM_MODELS
    importing
      !I_LANGUAGE type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CUSTOM_MODELS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update a custom model</p>
    "!   Updates information for the specified custom model. You can update metadata such
    "!    as the name and description of the model. You can also update the words in the
    "!    model and their translations. Adding a new translation for a word that already
    "!    exists in a custom model overwrites the word&apos;s existing translation. A
    "!    custom model can contain no more than 20,000 entries. You must use credentials
    "!    for the instance of the service that owns a model to update it. <br/>
    "!   <br/>
    "!   You can define sounds-like or phonetic translations for words. A sounds-like
    "!    translation consists of one or more words that, when combined, sound like the
    "!    word. Phonetic translations are based on the SSML phoneme format for
    "!    representing a word. You can specify them in standard International Phonetic
    "!    Alphabet (IPA) representation<br/>
    "!   <br/>
    "!     &lt;code&gt;&lt;phoneme alphabet=&quot;ipa&quot;
    "!    ph=&quot;t&#601;m&#712;&#593;to&quot;&gt;&lt;/phoneme&gt;&lt;/code&gt;<br/>
    "!   <br/>
    "!     or in the proprietary IBM Symbolic Phonetic Representation (SPR)<br/>
    "!   <br/>
    "!     &lt;code&gt;&lt;phoneme alphabet=&quot;ibm&quot;
    "!    ph=&quot;1gAstroEntxrYFXs&quot;&gt;&lt;/phoneme&gt;&lt;/code&gt; <br/>
    "!   <br/>
    "!   **See also:**<br/>
    "!   * [Updating a custom
    "!    model](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-customMod
    "!   els#cuModelsUpdate)<br/>
    "!   * [Adding words to a Japanese custom
    "!    model](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-customWor
    "!   ds#cuJapaneseAdd)<br/>
    "!   * [Understanding
    "!    customization](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-c
    "!   ustomIntro#customIntro)
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom model. You must make the request with
    "!    credentials for the instance of the service that owns the custom model.
    "! @parameter I_UPDATE_VOICE_MODEL |
    "!   An `UpdateCustomModel` object that contains information that is to be updated
    "!    for the custom model.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_CUSTOM_MODEL
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_UPDATE_VOICE_MODEL type T_UPDATE_CUSTOM_MODEL
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get a custom model</p>
    "!   Gets all information about a specified custom model. In addition to metadata
    "!    such as the name and description of the custom model, the output includes the
    "!    words and their translations that are defined for the model, as well as any
    "!    prompts that are defined for the model. To see just the metadata for a model,
    "!    use the [List custom models](#listcustommodels) method. <br/>
    "!   <br/>
    "!   **See also:** [Querying a custom
    "!    model](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-customMod
    "!   els#cuModelsQuery).
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom model. You must make the request with
    "!    credentials for the instance of the service that owns the custom model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CUSTOM_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_CUSTOM_MODEL
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CUSTOM_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a custom model</p>
    "!   Deletes the specified custom model. You must use credentials for the instance of
    "!    the service that owns a model to delete it. <br/>
    "!   <br/>
    "!   **See also:** [Deleting a custom
    "!    model](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-customMod
    "!   els#cuModelsDelete).
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom model. You must make the request with
    "!    credentials for the instance of the service that owns the custom model.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_CUSTOM_MODEL
    importing
      !I_CUSTOMIZATION_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Add custom words</p>
    "!   Adds one or more words and their translations to the specified custom model.
    "!    Adding a new translation for a word that already exists in a custom model
    "!    overwrites the word&apos;s existing translation. A custom model can contain no
    "!    more than 20,000 entries. You must use credentials for the instance of the
    "!    service that owns a model to add words to it. <br/>
    "!   <br/>
    "!   You can define sounds-like or phonetic translations for words. A sounds-like
    "!    translation consists of one or more words that, when combined, sound like the
    "!    word. Phonetic translations are based on the SSML phoneme format for
    "!    representing a word. You can specify them in standard International Phonetic
    "!    Alphabet (IPA) representation<br/>
    "!   <br/>
    "!     &lt;code&gt;&lt;phoneme alphabet=&quot;ipa&quot;
    "!    ph=&quot;t&#601;m&#712;&#593;to&quot;&gt;&lt;/phoneme&gt;&lt;/code&gt;<br/>
    "!   <br/>
    "!     or in the proprietary IBM Symbolic Phonetic Representation (SPR)<br/>
    "!   <br/>
    "!     &lt;code&gt;&lt;phoneme alphabet=&quot;ibm&quot;
    "!    ph=&quot;1gAstroEntxrYFXs&quot;&gt;&lt;/phoneme&gt;&lt;/code&gt; <br/>
    "!   <br/>
    "!   **See also:**<br/>
    "!   * [Adding multiple words to a custom
    "!    model](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-customWor
    "!   ds#cuWordsAdd)<br/>
    "!   * [Adding words to a Japanese custom
    "!    model](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-customWor
    "!   ds#cuJapaneseAdd)<br/>
    "!   * [Understanding
    "!    customization](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-c
    "!   ustomIntro#customIntro)
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom model. You must make the request with
    "!    credentials for the instance of the service that owns the custom model.
    "! @parameter I_CUSTOM_WORDS |
    "!   No documentation available.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods ADD_WORDS
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_CUSTOM_WORDS type T_WORDS
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List custom words</p>
    "!   Lists all of the words and their translations for the specified custom model.
    "!    The output shows the translations as they are defined in the model. You must
    "!    use credentials for the instance of the service that owns a model to list its
    "!    words. <br/>
    "!   <br/>
    "!   **See also:** [Querying all words from a custom
    "!    model](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-customWor
    "!   ds#cuWordsQueryModel).
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom model. You must make the request with
    "!    credentials for the instance of the service that owns the custom model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_WORDS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_WORDS
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_WORDS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Add a custom word</p>
    "!   Adds a single word and its translation to the specified custom model. Adding a
    "!    new translation for a word that already exists in a custom model overwrites the
    "!    word&apos;s existing translation. A custom model can contain no more than
    "!    20,000 entries. You must use credentials for the instance of the service that
    "!    owns a model to add a word to it. <br/>
    "!   <br/>
    "!   You can define sounds-like or phonetic translations for words. A sounds-like
    "!    translation consists of one or more words that, when combined, sound like the
    "!    word. Phonetic translations are based on the SSML phoneme format for
    "!    representing a word. You can specify them in standard International Phonetic
    "!    Alphabet (IPA) representation<br/>
    "!   <br/>
    "!     &lt;code&gt;&lt;phoneme alphabet=&quot;ipa&quot;
    "!    ph=&quot;t&#601;m&#712;&#593;to&quot;&gt;&lt;/phoneme&gt;&lt;/code&gt;<br/>
    "!   <br/>
    "!     or in the proprietary IBM Symbolic Phonetic Representation (SPR)<br/>
    "!   <br/>
    "!     &lt;code&gt;&lt;phoneme alphabet=&quot;ibm&quot;
    "!    ph=&quot;1gAstroEntxrYFXs&quot;&gt;&lt;/phoneme&gt;&lt;/code&gt; <br/>
    "!   <br/>
    "!   **See also:**<br/>
    "!   * [Adding a single word to a custom
    "!    model](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-customWor
    "!   ds#cuWordAdd)<br/>
    "!   * [Adding words to a Japanese custom
    "!    model](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-customWor
    "!   ds#cuJapaneseAdd)<br/>
    "!   * [Understanding
    "!    customization](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-c
    "!   ustomIntro#customIntro)
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom model. You must make the request with
    "!    credentials for the instance of the service that owns the custom model.
    "! @parameter I_WORD |
    "!   The word that is to be added or updated for the custom model.
    "! @parameter I_TRANSLATION |
    "!   The translation for the word that is to be added or updated.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods ADD_WORD
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_WORD type STRING
      !I_TRANSLATION type T_TRANSLATION
      !I_contenttype type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get a custom word</p>
    "!   Gets the translation for a single word from the specified custom model. The
    "!    output shows the translation as it is defined in the model. You must use
    "!    credentials for the instance of the service that owns a model to list its
    "!    words. <br/>
    "!   <br/>
    "!   **See also:** [Querying a single word from a custom
    "!    model](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-customWor
    "!   ds#cuWordQueryModel).
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom model. You must make the request with
    "!    credentials for the instance of the service that owns the custom model.
    "! @parameter I_WORD |
    "!   The word that is to be queried from the custom model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRANSLATION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_WORD
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_WORD type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRANSLATION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a custom word</p>
    "!   Deletes a single word from the specified custom model. You must use credentials
    "!    for the instance of the service that owns a model to delete its words. <br/>
    "!   <br/>
    "!   **See also:** [Deleting a word from a custom
    "!    model](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-customWor
    "!   ds#cuWordDelete).
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom model. You must make the request with
    "!    credentials for the instance of the service that owns the custom model.
    "! @parameter I_WORD |
    "!   The word that is to be deleted from the custom model.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_WORD
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_WORD type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List custom prompts</p>
    "!   Lists information about all custom prompts that are defined for a custom model.
    "!    The information includes the prompt ID, prompt text, status, and optional
    "!    speaker ID for each prompt of the custom model. You must use credentials for
    "!    the instance of the service that owns the custom model. The same information
    "!    about all of the prompts for a custom model is also provided by the [Get a
    "!    custom model](#getcustommodel) method. That method provides complete details
    "!    about a specified custom model, including its language, owner, custom words,
    "!    and more. Custom prompts are supported only for use with US English custom
    "!    models and voices. <br/>
    "!   <br/>
    "!   **See also:** [Listing custom
    "!    prompts](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-tbe-cus
    "!   tom-prompts#tbe-custom-prompts-list).
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom model. You must make the request with
    "!    credentials for the instance of the service that owns the custom model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_PROMPTS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_CUSTOM_PROMPTS
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_PROMPTS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Add a custom prompt</p>
    "!   Adds a custom prompt to a custom model. A prompt is defined by the text that is
    "!    to be spoken, the audio for that text, a unique user-specified ID for the
    "!    prompt, and an optional speaker ID. The information is used to generate
    "!    prosodic data that is not visible to the user. This data is used by the service
    "!    to produce the synthesized audio upon request. You must use credentials for the
    "!    instance of the service that owns a custom model to add a prompt to it. You can
    "!    add a maximum of 1000 custom prompts to a single custom model. <br/>
    "!   <br/>
    "!   You are recommended to assign meaningful values for prompt IDs. For example, use
    "!    `goodbye` to identify a prompt that speaks a farewell message. Prompt IDs must
    "!    be unique within a given custom model. You cannot define two prompts with the
    "!    same name for the same custom model. If you provide the ID of an existing
    "!    prompt, the previously uploaded prompt is replaced by the new information. The
    "!    existing prompt is reprocessed by using the new text and audio and, if
    "!    provided, new speaker model, and the prosody data associated with the prompt is
    "!    updated. <br/>
    "!   <br/>
    "!   The quality of a prompt is undefined if the language of a prompt does not match
    "!    the language of its custom model. This is consistent with any text or SSML that
    "!    is specified for a speech synthesis request. The service makes a best-effort
    "!    attempt to render the specified text for the prompt; it does not validate that
    "!    the language of the text matches the language of the model. <br/>
    "!   <br/>
    "!   Adding a prompt is an asynchronous operation. Although it accepts less audio
    "!    than speaker enrollment, the service must align the audio with the provided
    "!    text. The time that it takes to process a prompt depends on the prompt itself.
    "!    The processing time for a reasonably sized prompt generally matches the length
    "!    of the audio (for example, it takes 20 seconds to process a 20-second prompt).
    "!    <br/>
    "!   <br/>
    "!   For shorter prompts, you can wait for a reasonable amount of time and then check
    "!    the status of the prompt with the [Get a custom prompt](#getcustomprompt)
    "!    method. For longer prompts, consider using that method to poll the service
    "!    every few seconds to determine when the prompt becomes available. No prompt can
    "!    be used for speech synthesis if it is in the `processing` or `failed` state.
    "!    Only prompts that are in the `available` state can be used for speech
    "!    synthesis. <br/>
    "!   <br/>
    "!   When it processes a request, the service attempts to align the text and the
    "!    audio that are provided for the prompt. The text that is passed with a prompt
    "!    must match the spoken audio as closely as possible. Optimally, the text and
    "!    audio match exactly. The service does its best to align the specified text with
    "!    the audio, and it can often compensate for mismatches between the two. But if
    "!    the service cannot effectively align the text and the audio, possibly because
    "!    the magnitude of mismatches between the two is too great, processing of the
    "!    prompt fails. <br/>
    "!   <br/>
    "!   ### Evaluating a prompt<br/>
    "!   <br/>
    "!    Always listen to and evaluate a prompt to determine its quality before using it
    "!    in production. To evaluate a prompt, include only the single prompt in a speech
    "!    synthesis request by using the following SSML extension, in this case for a
    "!    prompt whose ID is `goodbye`: <br/>
    "!   <br/>
    "!   `&lt;ibm:prompt id=&quot;goodbye&quot;/&gt;` <br/>
    "!   <br/>
    "!   In some cases, you might need to rerecord and resubmit a prompt as many as five
    "!    times to address the following possible problems:<br/>
    "!   * The service might fail to detect a mismatch between the prompt’s text and
    "!    audio. The longer the prompt, the greater the chance for misalignment between
    "!    its text and audio. Therefore, multiple shorter prompts are preferable to a
    "!    single long prompt.<br/>
    "!   * The text of a prompt might include a word that the service does not recognize.
    "!    In this case, you can create a custom word and pronunciation pair to tell the
    "!    service how to pronounce the word. You must then re-create the prompt.<br/>
    "!   * The quality of the input audio might be insufficient or the service’s
    "!    processing of the audio might fail to detect the intended prosody. Submitting
    "!    new audio for the prompt can correct these issues. <br/>
    "!   <br/>
    "!   If a prompt that is created without a speaker ID does not adequately reflect the
    "!    intended prosody, enrolling the speaker and providing a speaker ID for the
    "!    prompt is one recommended means of potentially improving the quality of the
    "!    prompt. This is especially important for shorter prompts such as
    "!    &quot;good-bye&quot; or &quot;thank you,&quot; where less audio data makes it
    "!    more difficult to match the prosody of the speaker. Custom prompts are
    "!    supported only for use with US English custom models and voices. <br/>
    "!   <br/>
    "!   **See also:** <br/>
    "!   * [Add a custom
    "!    prompt](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-tbe-crea
    "!   te#tbe-create-add-prompt)<br/>
    "!   * [Evaluate a custom
    "!    prompt](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-tbe-crea
    "!   te#tbe-create-evaluate-prompt)<br/>
    "!   * [Rules for creating custom
    "!    prompts](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-tbe-rul
    "!   es#tbe-rules-prompts)
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom model. You must make the request with
    "!    credentials for the instance of the service that owns the custom model.
    "! @parameter I_PROMPT_ID |
    "!   The identifier of the prompt that is to be added to the custom model:<br/>
    "!   * Include a maximum of 49 characters in the ID.<br/>
    "!   * Include only alphanumeric characters and `_` (underscores) in the ID.<br/>
    "!   * Do not include XML sensitive characters (double quotes, single quotes,
    "!    ampersands, angle brackets, and slashes) in the ID.<br/>
    "!   * To add a new prompt, the ID must be unique for the specified custom model.
    "!    Otherwise, the new information for the prompt overwrites the existing prompt
    "!    that has that ID.
    "! @parameter I_METADATA |
    "!   Information about the prompt that is to be added to a custom model. The
    "!    following example of a `PromptMetadata` object includes both the required
    "!    prompt text and an optional speaker model ID: <br/>
    "!   <br/>
    "!   `&#123; &quot;prompt_text&quot;: &quot;Thank you and good-bye!&quot;,
    "!    &quot;speaker_id&quot;: &quot;823068b2-ed4e-11ea-b6e0-7b6456aa95cc&quot;
    "!    &#125;`.
    "! @parameter I_FILE |
    "!   An audio file that speaks the text of the prompt with intonation and prosody
    "!    that matches how you would like the prompt to be spoken.<br/>
    "!   * The prompt audio must be in WAV format and must have a minimum sampling rate
    "!    of 16 kHz. The service accepts audio with higher sampling rates. The service
    "!    transcodes all audio to 16 kHz before processing it.<br/>
    "!   * The length of the prompt audio is limited to 30 seconds.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_PROMPT
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods ADD_CUSTOM_PROMPT
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_PROMPT_ID type STRING
      !I_METADATA type T_PROMPT_METADATA
      !I_FILE type FILE
      !I_FILE_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_PROMPT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get a custom prompt</p>
    "!   Gets information about a specified custom prompt for a specified custom model.
    "!    The information includes the prompt ID, prompt text, status, and optional
    "!    speaker ID for each prompt of the custom model. You must use credentials for
    "!    the instance of the service that owns the custom model. Custom prompts are
    "!    supported only for use with US English custom models and voices. <br/>
    "!   <br/>
    "!   **See also:** [Listing custom
    "!    prompts](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-tbe-cus
    "!   tom-prompts#tbe-custom-prompts-list).
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom model. You must make the request with
    "!    credentials for the instance of the service that owns the custom model.
    "! @parameter I_PROMPT_ID |
    "!   The identifier (name) of the prompt.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_PROMPT
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_CUSTOM_PROMPT
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_PROMPT_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_PROMPT
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a custom prompt</p>
    "!   Deletes an existing custom prompt from a custom model. The service deletes the
    "!    prompt with the specified ID. You must use credentials for the instance of the
    "!    service that owns the custom model from which the prompt is to be deleted.
    "!    <br/>
    "!   <br/>
    "!   **Caution:** Deleting a custom prompt elicits a 400 response code from synthesis
    "!    requests that attempt to use the prompt. Make sure that you do not attempt to
    "!    use a deleted prompt in a production application. Custom prompts are supported
    "!    only for use with US English custom models and voices. <br/>
    "!   <br/>
    "!   **See also:** [Deleting a custom
    "!    prompt](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-tbe-cust
    "!   om-prompts#tbe-custom-prompts-delete).
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom model. You must make the request with
    "!    credentials for the instance of the service that owns the custom model.
    "! @parameter I_PROMPT_ID |
    "!   The identifier (name) of the prompt that is to be deleted.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_CUSTOM_PROMPT
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_PROMPT_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List speaker models</p>
    "!   Lists information about all speaker models that are defined for a service
    "!    instance. The information includes the speaker ID and speaker name of each
    "!    defined speaker. You must use credentials for the instance of a service to list
    "!    its speakers. Speaker models and the custom prompts with which they are used
    "!    are supported only for use with US English custom models and voices. <br/>
    "!   <br/>
    "!   **See also:** [Listing speaker
    "!    models](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-tbe-spea
    "!   ker-models#tbe-speaker-models-list).
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SPEAKERS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_SPEAKER_MODELS
    importing
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SPEAKERS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Create a speaker model</p>
    "!   Creates a new speaker model, which is an optional enrollment token for users who
    "!    are to add prompts to custom models. A speaker model contains information about
    "!    a user&apos;s voice. The service extracts this information from a WAV audio
    "!    sample that you pass as the body of the request. Associating a speaker model
    "!    with a prompt is optional, but the information that is extracted from the
    "!    speaker model helps the service learn about the speaker&apos;s voice. <br/>
    "!   <br/>
    "!   A speaker model can make an appreciable difference in the quality of prompts,
    "!    especially short prompts with relatively little audio, that are associated with
    "!    that speaker. A speaker model can help the service produce a prompt with more
    "!    confidence; the lack of a speaker model can potentially compromise the quality
    "!    of a prompt. <br/>
    "!   <br/>
    "!   The gender of the speaker who creates a speaker model does not need to match the
    "!    gender of a voice that is used with prompts that are associated with that
    "!    speaker model. For example, a speaker model that is created by a male speaker
    "!    can be associated with prompts that are spoken by female voices. <br/>
    "!   <br/>
    "!   You create a speaker model for a given instance of the service. The new speaker
    "!    model is owned by the service instance whose credentials are used to create it.
    "!    That same speaker can then be used to create prompts for all custom models
    "!    within that service instance. No language is associated with a speaker model,
    "!    but each custom model has a single specified language. You can add prompts only
    "!    to US English models. <br/>
    "!   <br/>
    "!   You specify a name for the speaker when you create it. The name must be unique
    "!    among all speaker names for the owning service instance. To re-create a speaker
    "!    model for an existing speaker name, you must first delete the existing speaker
    "!    model that has that name. <br/>
    "!   <br/>
    "!   Speaker enrollment is a synchronous operation. Although it accepts more audio
    "!    data than a prompt, the process of adding a speaker is very fast. The service
    "!    simply extracts information about the speaker’s voice from the audio. Unlike
    "!    prompts, speaker models neither need nor accept a transcription of the audio.
    "!    When the call returns, the audio is fully processed and the speaker enrollment
    "!    is complete. <br/>
    "!   <br/>
    "!   The service returns a speaker ID with the request. A speaker ID is globally
    "!    unique identifier (GUID) that you use to identify the speaker in subsequent
    "!    requests to the service. Speaker models and the custom prompts with which they
    "!    are used are supported only for use with US English custom models and voices.
    "!    <br/>
    "!   <br/>
    "!   **See also:** <br/>
    "!   * [Create a speaker
    "!    model](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-tbe-creat
    "!   e#tbe-create-speaker-model)<br/>
    "!   * [Rules for creating speaker
    "!    models](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-tbe-rule
    "!   s#tbe-rules-speakers)
    "!
    "! @parameter I_SPEAKER_NAME |
    "!   The name of the speaker that is to be added to the service instance.<br/>
    "!   * Include a maximum of 49 characters in the name.<br/>
    "!   * Include only alphanumeric characters and `_` (underscores) in the name.<br/>
    "!   * Do not include XML sensitive characters (double quotes, single quotes,
    "!    ampersands, angle brackets, and slashes) in the name.<br/>
    "!   * Do not use the name of an existing speaker that is already defined for the
    "!    service instance.
    "! @parameter I_AUDIO |
    "!   An enrollment audio file that contains a sample of the speaker’s voice.<br/>
    "!   * The enrollment audio must be in WAV format and must have a minimum sampling
    "!    rate of 16 kHz. The service accepts audio with higher sampling rates. It
    "!    transcodes all audio to 16 kHz before processing it.<br/>
    "!   * The length of the enrollment audio is limited to 1 minute. Speaking one or two
    "!    paragraphs of text that include five to ten sentences is recommended.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SPEAKER_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_SPEAKER_MODEL
    importing
      !I_SPEAKER_NAME type STRING
      !I_AUDIO type FILE
      !I_contenttype type string default 'audio/wav'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SPEAKER_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get a speaker model</p>
    "!   Gets information about all prompts that are defined by a specified speaker for
    "!    all custom models that are owned by a service instance. The information is
    "!    grouped by the customization IDs of the custom models. For each custom model,
    "!    the information lists information about each prompt that is defined for that
    "!    custom model by the speaker. You must use credentials for the instance of the
    "!    service that owns a speaker model to list its prompts. Speaker models and the
    "!    custom prompts with which they are used are supported only for use with US
    "!    English custom models and voices. <br/>
    "!   <br/>
    "!   **See also:** [Listing the custom prompts for a speaker
    "!    model](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-tbe-speak
    "!   er-models#tbe-speaker-models-list-prompts).
    "!
    "! @parameter I_SPEAKER_ID |
    "!   The speaker ID (GUID) of the speaker model. You must make the request with
    "!    service credentials for the instance of the service that owns the speaker
    "!    model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SPEAKER_CUSTOM_MODELS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_SPEAKER_MODEL
    importing
      !I_SPEAKER_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SPEAKER_CUSTOM_MODELS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a speaker model</p>
    "!   Deletes an existing speaker model from the service instance. The service deletes
    "!    the enrolled speaker with the specified speaker ID. You must use credentials
    "!    for the instance of the service that owns a speaker model to delete the
    "!    speaker. <br/>
    "!   <br/>
    "!   Any prompts that are associated with the deleted speaker are not affected by the
    "!    speaker&apos;s deletion. The prosodic data that defines the quality of a prompt
    "!    is established when the prompt is created. A prompt is static and remains
    "!    unaffected by deletion of its associated speaker. However, the prompt cannot be
    "!    resubmitted or updated with its original speaker once that speaker is deleted.
    "!    Speaker models and the custom prompts with which they are used are supported
    "!    only for use with US English custom models and voices. <br/>
    "!   <br/>
    "!   **See also:** [Deleting a speaker
    "!    model](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-tbe-speak
    "!   er-models#tbe-speaker-models-delete).
    "!
    "! @parameter I_SPEAKER_ID |
    "!   The speaker ID (GUID) of the speaker model. You must make the request with
    "!    service credentials for the instance of the service that owns the speaker
    "!    model.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_SPEAKER_MODEL
    importing
      !I_SPEAKER_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Delete labeled data</p>
    "!   Deletes all data that is associated with a specified customer ID. The method
    "!    deletes all data for the customer ID, regardless of the method by which the
    "!    information was added. The method has no effect if no data is associated with
    "!    the customer ID. You must issue the request with credentials for the same
    "!    instance of the service that was used to associate the customer ID with the
    "!    data. You associate a customer ID with data by passing the `X-Watson-Metadata`
    "!    header with a request that passes the data. <br/>
    "!   <br/>
    "!   **Note:** If you delete an instance of the service from the service console, all
    "!    data associated with that service instance is automatically deleted. This
    "!    includes all custom models and word/translation pairs, and all data related to
    "!    speech synthesis requests. <br/>
    "!   <br/>
    "!   **See also:** [Information
    "!    security](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-inform
    "!   ation-security#information-security).
    "!
    "! @parameter I_CUSTOMER_ID |
    "!   The customer ID for which all data is to be deleted.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_USER_DATA
    importing
      !I_CUSTOMER_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .


protected section.

private section.

ENDCLASS.

class ZCL_IBMC_TEXT_TO_SPEECH_V1 IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->GET_APPNAME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_APPNAME                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method GET_APPNAME.

    e_appname = 'Text to Speech'.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method ZCL_IBMC_TEXT_TO_SPEECH_V1->GET_REQUEST_PROP
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
  e_request_prop-url-host        = 'api.us-south.text-to-speech.watson.cloud.ibm.com'.
  e_request_prop-url-path_base   = ''.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20231212104240'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->LIST_VOICES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_VOICES
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_VOICES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/voices'.

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
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->GET_VOICE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_VOICE        TYPE STRING
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_VOICE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_VOICE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/voices/{voice}'.
    replace all occurrences of `{voice}` in ls_request_prop-url-path with i_VOICE ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_CUSTOMIZATION_ID is supplied.
    lv_queryparam = escape( val = i_CUSTOMIZATION_ID format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `customization_id`
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
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->SYNTHESIZE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_TEXT        TYPE T_TEXT
* | [--->] I_ACCEPT        TYPE STRING (default ='audio/ogg;codecs=opus')
* | [--->] I_VOICE        TYPE STRING (default ='en-US_MichaelV3Voice')
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING(optional)
* | [--->] I_SPELL_OUT_MODE        TYPE STRING (default ='default')
* | [--->] I_RATE_PERCENTAGE        TYPE INTEGER (default =0)
* | [--->] I_PITCH_PERCENTAGE        TYPE INTEGER (default =0)
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        FILE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method SYNTHESIZE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/synthesize'.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_VOICE is supplied.
    lv_queryparam = escape( val = i_VOICE format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `voice`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CUSTOMIZATION_ID is supplied.
    lv_queryparam = escape( val = i_CUSTOMIZATION_ID format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `customization_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SPELL_OUT_MODE is supplied.
    lv_queryparam = escape( val = i_SPELL_OUT_MODE format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `spell_out_mode`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_RATE_PERCENTAGE is supplied.
    lv_queryparam = i_RATE_PERCENTAGE.
    add_query_parameter(
      exporting
        i_parameter  = `rate_percentage`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_PITCH_PERCENTAGE is supplied.
    lv_queryparam = i_PITCH_PERCENTAGE.
    add_query_parameter(
      exporting
        i_parameter  = `pitch_percentage`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    " process header parameters
    data:
      lv_headerparam type string  ##NEEDED.

    if i_ACCEPT is supplied.
    lv_headerparam = I_ACCEPT.
    add_header_parameter(
      exporting
        i_parameter  = 'Accept'
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
    lv_datatype = get_datatype( i_TEXT ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_TEXT i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'text' i_value = i_TEXT ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_TEXT to <lv_text>.
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


    " retrieve file data
    e_response = get_response_binary( lo_response ).

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->GET_PRONUNCIATION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_TEXT        TYPE STRING
* | [--->] I_VOICE        TYPE STRING (default ='en-US_MichaelV3Voice')
* | [--->] I_FORMAT        TYPE STRING (default ='ipa')
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_PRONUNCIATION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_PRONUNCIATION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/pronunciation'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    lv_queryparam = escape( val = i_TEXT format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `text`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.

    if i_VOICE is supplied.
    lv_queryparam = escape( val = i_VOICE format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `voice`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_FORMAT is supplied.
    lv_queryparam = escape( val = i_FORMAT format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `format`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CUSTOMIZATION_ID is supplied.
    lv_queryparam = escape( val = i_CUSTOMIZATION_ID format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `customization_id`
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
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->CREATE_CUSTOM_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CREATE_VOICE_MODEL        TYPE T_CREATE_CUSTOM_MODEL
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CUSTOM_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_CUSTOM_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations'.

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
    lv_datatype = get_datatype( i_CREATE_VOICE_MODEL ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_CREATE_VOICE_MODEL i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'create_voice_model' i_value = i_CREATE_VOICE_MODEL ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_CREATE_VOICE_MODEL to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->LIST_CUSTOM_MODELS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_LANGUAGE        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CUSTOM_MODELS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_CUSTOM_MODELS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_LANGUAGE is supplied.
    lv_queryparam = escape( val = i_LANGUAGE format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `language`
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
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->UPDATE_CUSTOM_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_UPDATE_VOICE_MODEL        TYPE T_UPDATE_CUSTOM_MODEL
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_CUSTOM_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.

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
    lv_datatype = get_datatype( i_UPDATE_VOICE_MODEL ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_UPDATE_VOICE_MODEL i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'update_voice_model' i_value = i_UPDATE_VOICE_MODEL ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_UPDATE_VOICE_MODEL to <lv_text>.
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



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->GET_CUSTOM_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CUSTOM_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_CUSTOM_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->DELETE_CUSTOM_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_CUSTOM_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->ADD_WORDS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_CUSTOM_WORDS        TYPE T_WORDS
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method ADD_WORDS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/words'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.

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
    lv_datatype = get_datatype( i_CUSTOM_WORDS ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_CUSTOM_WORDS i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'custom_words' i_value = i_CUSTOM_WORDS ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_CUSTOM_WORDS to <lv_text>.
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



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->LIST_WORDS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_WORDS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_WORDS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/words'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->ADD_WORD
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_WORD        TYPE STRING
* | [--->] I_TRANSLATION        TYPE T_TRANSLATION
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method ADD_WORD.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/words/{word}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.
    replace all occurrences of `{word}` in ls_request_prop-url-path with i_WORD ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
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
    lv_datatype = get_datatype( i_TRANSLATION ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_TRANSLATION i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'translation' i_value = i_TRANSLATION ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_TRANSLATION to <lv_text>.
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


    " execute HTTP PUT request
    lo_response = HTTP_PUT( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->GET_WORD
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_WORD        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRANSLATION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_WORD.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/words/{word}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.
    replace all occurrences of `{word}` in ls_request_prop-url-path with i_WORD ignoring case.

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
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->DELETE_WORD
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_WORD        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_WORD.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/words/{word}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.
    replace all occurrences of `{word}` in ls_request_prop-url-path with i_WORD ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->LIST_CUSTOM_PROMPTS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_PROMPTS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_CUSTOM_PROMPTS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/prompts'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->ADD_CUSTOM_PROMPT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_PROMPT_ID        TYPE STRING
* | [--->] I_METADATA        TYPE T_PROMPT_METADATA
* | [--->] I_FILE        TYPE FILE
* | [--->] I_FILE_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_PROMPT
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method ADD_CUSTOM_PROMPT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/prompts/{prompt_id}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.
    replace all occurrences of `{prompt_id}` in ls_request_prop-url-path with i_PROMPT_ID ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).





    " process form parameters
    data:
      ls_form_part     type ts_form_part,
      lt_form_part     type tt_form_part,
      lv_formdata      type string value is initial ##NEEDED,
      lv_value         type string ##NEEDED,
      lv_index(3)      type n value '000' ##NEEDED,
      lv_keypattern    type string ##NEEDED,
      lv_base_name     type string ##NEEDED,
      lv_extension     type string ##NEEDED.


    if not i_METADATA is initial.
      clear ls_form_part.
      ls_form_part-content_disposition = 'form-data; name="metadata"'  ##NO_TEXT.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-APPL_JSON.
      lv_formdata = abap_to_json( i_value = i_METADATA i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_FILE is initial.
      lv_extension = get_file_extension( I_FILE_CT ).
      lv_value = `form-data; name="file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_FILE_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_FILE.
      append ls_form_part to lt_form_part.
    endif.


    " execute HTTP POST request
    lo_response = HTTP_POST_MULTIPART( i_request_prop = ls_request_prop it_form_part = lt_form_part ).




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
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->GET_CUSTOM_PROMPT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_PROMPT_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_PROMPT
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_CUSTOM_PROMPT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/prompts/{prompt_id}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.
    replace all occurrences of `{prompt_id}` in ls_request_prop-url-path with i_PROMPT_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->DELETE_CUSTOM_PROMPT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_PROMPT_ID        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_CUSTOM_PROMPT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/prompts/{prompt_id}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.
    replace all occurrences of `{prompt_id}` in ls_request_prop-url-path with i_PROMPT_ID ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->LIST_SPEAKER_MODELS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_SPEAKERS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_SPEAKER_MODELS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/speakers'.

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
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->CREATE_SPEAKER_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_SPEAKER_NAME        TYPE STRING
* | [--->] I_AUDIO        TYPE FILE
* | [--->] I_contenttype       TYPE string (default ='audio/wav')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_SPEAKER_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_SPEAKER_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/speakers'.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    lv_queryparam = escape( val = i_SPEAKER_NAME format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `speaker_name`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.




    " process body parameters
    ls_request_prop-body_bin = i_AUDIO.

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
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->GET_SPEAKER_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_SPEAKER_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_SPEAKER_CUSTOM_MODELS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_SPEAKER_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/speakers/{speaker_id}'.
    replace all occurrences of `{speaker_id}` in ls_request_prop-url-path with i_SPEAKER_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->DELETE_SPEAKER_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_SPEAKER_ID        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_SPEAKER_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/speakers/{speaker_id}'.
    replace all occurrences of `{speaker_id}` in ls_request_prop-url-path with i_SPEAKER_ID ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_TEXT_TO_SPEECH_V1->DELETE_USER_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMER_ID        TYPE STRING
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


ENDCLASS.
