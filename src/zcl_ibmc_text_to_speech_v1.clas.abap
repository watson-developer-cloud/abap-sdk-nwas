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
"!  Representation (SPR). The Arabic, Chinese, Dutch, Australian English, and
"!  Korean languages support only IPA. <br/>
class ZCL_IBMC_TEXT_TO_SPEECH_V1 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
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
      "!   The customization ID (GUID) of the custom model. The **Create a custom model**
      "!    method returns only this field. It does not not return the other fields of this
      "!    object.
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
      "!    letters listed before lowercase letters. The array is empty if the custom model
      "!    contains no words. This field is returned only by the **Get a voice** method
      "!    and only when you specify the customization ID of a custom model.
      WORDS type STANDARD TABLE OF T_WORD WITH NON-UNIQUE DEFAULT KEY,
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
      "!    by the **Get a voice** method and only when you specify the customization ID of
      "!    a custom model.
      CUSTOMIZATION type T_CUSTOM_MODEL,
    end of T_VOICE.
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
    "!    For the **Add custom words** method, one or more words that</p>
    "!     are to be added or updated for the custom model and the translation for each
    "!     specified word. <br/>
    "!    <br/>
    "!    For the **List custom words** method, the words and their translations from the
    "!     custom model.
    begin of T_WORDS,
      "!   The **Add custom words** method accepts an array of `Word` objects. Each object
      "!    provides a word that is to be added or updated for the custom model and the
      "!    word&apos;s translation. <br/>
      "!   <br/>
      "!   The **List custom words** method returns an array of `Word` objects. Each object
      "!    shows a word and its translation from the custom model. The words are listed in
      "!    alphabetical order, with uppercase letters listed before lowercase letters. The
      "!    array is empty if the custom model contains no words.
      WORDS type STANDARD TABLE OF T_WORD WITH NON-UNIQUE DEFAULT KEY,
    end of T_WORDS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about all available voices.</p>
    begin of T_VOICES,
      "!   A list of available voices.
      VOICES type STANDARD TABLE OF T_VOICE WITH NON-UNIQUE DEFAULT KEY,
    end of T_VOICES.
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
      "!   The name of the new custom model.
      NAME type STRING,
      "!   The language of the new custom model. You create a custom model for a specific
      "!    language, not for a specific voice. A custom model can be used with any voice
      "!    for its specified language. Omit the parameter to use the the default language,
      "!    `en-US`. **Note:** The `ar-AR` language identifier cannot be used to create a
      "!    custom model. Use the `ar-MS` identifier instead.
      LANGUAGE type STRING,
      "!   A description of the new custom model. Specifying a description is recommended.
      DESCRIPTION type STRING,
    end of T_CREATE_CUSTOM_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The text to synthesize. Specify either plain text or a</p>
    "!     subset of SSML. SSML is an XML-based markup language that provides text
    "!     annotation for speech-synthesis applications. Pass a maximum of 5 KB of input
    "!     text.
    begin of T_TEXT,
      "!   The text to synthesize.
      TEXT type STRING,
    end of T_TEXT.
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
    T_WORD type string value '|WORD|TRANSLATION|',
    T_CUSTOM_MODEL type string value '|CUSTOMIZATION_ID|',
    T_SUPPORTED_FEATURES type string value '|CUSTOM_PRONUNCIATION|VOICE_TRANSFORMATION|',
    T_VOICE type string value '|URL|GENDER|NAME|LANGUAGE|DESCRIPTION|CUSTOMIZABLE|SUPPORTED_FEATURES|',
    T_ERROR_MODEL type string value '|ERROR|CODE|',
    T_WORDS type string value '|WORDS|',
    T_VOICES type string value '|VOICES|',
    T_UPDATE_CUSTOM_MODEL type string value '|',
    T_CREATE_CUSTOM_MODEL type string value '|NAME|',
    T_TEXT type string value '|TEXT|',
    T_PRONUNCIATION type string value '|PRONUNCIATION|',
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
     WORD type string value 'word',
     TRANSLATION type string value 'translation',
     PART_OF_SPEECH type string value 'part_of_speech',
     PRONUNCIATION type string value 'pronunciation',
     ERROR type string value 'error',
     CODE type string value 'code',
     CODE_DESCRIPTION type string value 'code_description',
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
    "!    **Get a voice** method. <br/>
    "!   <br/>
    "!   **See also:** [Listing all available
    "!    voices](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-voices#l
    "!   istVoices).
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
    "!    **List voices** method. <br/>
    "!   <br/>
    "!   **See also:** [Listing a specific
    "!    voice](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-voices#li
    "!   stVoice). <br/>
    "!   <br/>
    "!   ### Important voice updates<br/>
    "!   <br/>
    "!    The service&apos;s voices underwent significant change on 2 December 2020.<br/>
    "!   * The Arabic, Chinese, Dutch, Australian English, and Korean voices are now
    "!    neural instead of concatenative.<br/>
    "!   * The `ar-AR_OmarVoice` voice is deprecated. Use `ar-MS_OmarVoice` voice
    "!    instead. <br/>
    "!   * The `ar-AR` language identifier cannot be used to create a custom model. Use
    "!    the `ar-MS` identifier instead. <br/>
    "!   * The standard concatenative voices for the following languages are now
    "!    deprecated: Brazilian Portuguese, United Kingdom and United States English,
    "!    French, German, Italian, Japanese, and Spanish (all dialects).<br/>
    "!   * The features expressive SSML, voice transformation SSML, and use of the
    "!    `volume` attribute of the `&lt;prosody&gt;` element are deprecated and are not
    "!    supported with any of the service&apos;s neural voices.<br/>
    "!   * All of the service&apos;s voices are now customizable and generally available
    "!    (GA) for production use. <br/>
    "!   <br/>
    "!   The deprecated voices and features will continue to function for at least one
    "!    year but might be removed at a future date. You are encouraged to migrate to
    "!    the equivalent neural voices at your earliest convenience. For more information
    "!    about all voice updates, see the [2 December 2020 service
    "!    update](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-release-
    "!   notes#December2020) in the release notes.
    "!
    "! @parameter I_VOICE |
    "!   The voice for which information is to be returned. For more information about
    "!    specifying a voice, see **Important voice updates** in the method description.
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
    "!   ### Audio formats (accept types)<br/>
    "!   <br/>
    "!    The service can return audio in the following formats (MIME types).<br/>
    "!   * Where indicated, you can optionally specify the sampling rate (`rate`) of the
    "!    audio. You must specify a sampling rate for the `audio/l16` and `audio/mulaw`
    "!    formats. A specified sampling rate must lie in the range of 8 kHz to 192 kHz.
    "!    Some formats restrict the sampling rate to certain values, as noted.<br/>
    "!   * For the `audio/l16` format, you can optionally specify the endianness
    "!    (`endianness`) of the audio: `endianness=big-endian` or
    "!    `endianness=little-endian`. <br/>
    "!   <br/>
    "!   Use the `Accept` header or the `accept` parameter to specify the requested
    "!    format of the response audio. If you omit an audio format altogether, the
    "!    service returns the audio in Ogg format with the Opus codec
    "!    (`audio/ogg;codecs=opus`). The service always returns single-channel
    "!    audio.<br/>
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
    "!    details about some of the formats, see [Audio
    "!    formats](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-audioFo
    "!   rmats#audioFormats). <br/>
    "!   <br/>
    "!   ### Important voice updates<br/>
    "!   <br/>
    "!    The service&apos;s voices underwent significant change on 2 December 2020.<br/>
    "!   * The Arabic, Chinese, Dutch, Australian English, and Korean voices are now
    "!    neural instead of concatenative.<br/>
    "!   * The `ar-AR_OmarVoice` voice is deprecated. Use `ar-MS_OmarVoice` voice
    "!    instead.<br/>
    "!   * The `ar-AR` language identifier cannot be used to create a custom model. Use
    "!    the `ar-MS` identifier instead.<br/>
    "!   * The standard concatenative voices for the following languages are now
    "!    deprecated: Brazilian Portuguese, United Kingdom and United States English,
    "!    French, German, Italian, Japanese, and Spanish (all dialects).<br/>
    "!   * The features expressive SSML, voice transformation SSML, and use of the
    "!    `volume` attribute of the `&lt;prosody&gt;` element are deprecated and are not
    "!    supported with any of the service&apos;s neural voices.<br/>
    "!   * All of the service&apos;s voices are now customizable and generally available
    "!    (GA) for production use. <br/>
    "!   <br/>
    "!   The deprecated voices and features will continue to function for at least one
    "!    year but might be removed at a future date. You are encouraged to migrate to
    "!    the equivalent neural voices at your earliest convenience. For more information
    "!    about all voice updates, see the [2 December 2020 service
    "!    update](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-release-
    "!   notes#December2020) in the release notes. <br/>
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
    "!   The voice to use for synthesis. For more information about specifying a voice,
    "!    see **Important voice updates** in the method description.
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of a custom model to use for the synthesis. If a
    "!    custom model is specified, it works only if it matches the language of the
    "!    indicated voice. You must make the request with credentials for the instance of
    "!    the service that owns the custom model. Omit the parameter to use the specified
    "!    voice with no customization.
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
    "!   **See also:** [Querying a word from a
    "!    language](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-custom
    "!   Words#cuWordsQueryLanguage). <br/>
    "!   <br/>
    "!   ### Important voice updates<br/>
    "!   <br/>
    "!    The service&apos;s voices underwent significant change on 2 December 2020.<br/>
    "!   * The Arabic, Chinese, Dutch, Australian English, and Korean voices are now
    "!    neural instead of concatenative.<br/>
    "!   * The `ar-AR_OmarVoice` voice is deprecated. Use `ar-MS_OmarVoice` voice
    "!    instead.<br/>
    "!   * The `ar-AR` language identifier cannot be used to create a custom model. Use
    "!    the `ar-MS` identifier instead.<br/>
    "!   * The standard concatenative voices for the following languages are now
    "!    deprecated: Brazilian Portuguese, United Kingdom and United States English,
    "!    French, German, Italian, Japanese, and Spanish (all dialects).<br/>
    "!   * The features expressive SSML, voice transformation SSML, and use of the
    "!    `volume` attribute of the `&lt;prosody&gt;` element are deprecated and are not
    "!    supported with any of the service&apos;s neural voices.<br/>
    "!   * All of the service&apos;s voices are now customizable and generally available
    "!    (GA) for production use. <br/>
    "!   <br/>
    "!   The deprecated voices and features will continue to function for at least one
    "!    year but might be removed at a future date. You are encouraged to migrate to
    "!    the equivalent neural voices at your earliest convenience. For more information
    "!    about all voice updates, see the [2 December 2020 service
    "!    update](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-release-
    "!   notes#December2020) in the release notes.
    "!
    "! @parameter I_TEXT |
    "!   The word for which the pronunciation is requested.
    "! @parameter I_VOICE |
    "!   A voice that specifies the language in which the pronunciation is to be
    "!    returned. All voices for the same language (for example, `en-US`) return the
    "!    same translation. For more information about specifying a voice, see
    "!    **Important voice updates** in the method description.
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
    "!   ### Important voice updates<br/>
    "!   <br/>
    "!    The service&apos;s voices underwent significant change on 2 December 2020.<br/>
    "!   * The Arabic, Chinese, Dutch, Australian English, and Korean voices are now
    "!    neural instead of concatenative.<br/>
    "!   * The `ar-AR_OmarVoice` voice is deprecated. Use `ar-MS_OmarVoice` voice
    "!    instead.<br/>
    "!   * The `ar-AR` language identifier cannot be used to create a custom model. Use
    "!    the `ar-MS` identifier instead.<br/>
    "!   * The standard concatenative voices for the following languages are now
    "!    deprecated: Brazilian Portuguese, United Kingdom and United States English,
    "!    French, German, Italian, Japanese, and Spanish (all dialects).<br/>
    "!   * The features expressive SSML, voice transformation SSML, and use of the
    "!    `volume` attribute of the `&lt;prosody&gt;` element are deprecated and are not
    "!    supported with any of the service&apos;s neural voices.<br/>
    "!   * All of the service&apos;s voices are now customizable and generally available
    "!    (GA) for production use. <br/>
    "!   <br/>
    "!   The deprecated voices and features will continue to function for at least one
    "!    year but might be removed at a future date. You are encouraged to migrate to
    "!    the equivalent neural voices at your earliest convenience. For more information
    "!    about all voice updates, see the [2 December 2020 service
    "!    update](https://cloud.ibm.com/docs/text-to-speech?topic=text-to-speech-release-
    "!   notes#December2020) in the release notes.
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
    "!    models for that language only. To see the words in addition to the metadata for
    "!    a specific custom model, use the **List a custom model** method. You must use
    "!    credentials for the instance of the service that owns a model to list
    "!    information about it. <br/>
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
    "!    words and their translations as defined in the model. To see just the metadata
    "!    for a model, use the **List custom models** method. <br/>
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

    e_sdk_version_date = '20210312144443'.

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
    if ls_request_prop-header_content_type cp '*json*' and lv_body(1) ne '{'.
      lv_body = `{` && lv_body && `}`.
    endif.

    if ls_request_prop-header_content_type cp '*charset=utf-8*'.
      ls_request_prop-body_bin = convert_string_to_utf8( i_string = lv_body ).
      replace all occurrences of regex ';\s*charset=utf-8' in ls_request_prop-header_content_type with '' ignoring case.
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
