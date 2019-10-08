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
"! <h1>Speech to Text</h1>
"! The IBM&reg; Speech to Text service provides APIs that use IBM's
"!  speech-recognition capabilities to produce transcripts of spoken audio. The
"!  service can transcribe speech from various languages and audio formats. In
"!  addition to basic transcription, the service can produce detailed information
"!  about many different aspects of the audio. For most languages, the service
"!  supports two sampling rates, broadband and narrowband. It returns all JSON
"!  response content in the UTF-8 character set.
"!
"! For speech recognition, the service supports synchronous and asynchronous HTTP
"!  Representational State Transfer (REST) interfaces. It also supports a WebSocket
"!  interface that provides a full-duplex, low-latency communication channel:
"!  Clients send requests and audio to the service and receive results over a
"!  single connection asynchronously.
"!
"! The service also offers two customization interfaces. Use language model
"!  customization to expand the vocabulary of a base model with domain-specific
"!  terminology. Use acoustic model customization to adapt a base model for the
"!  acoustic characteristics of your audio. For language model customization, the
"!  service also supports grammars. A grammar is a formal language specification
"!  that lets you restrict the phrases that the service can recognize.
"!
"! Language model customization is generally available for production use with most
"!  supported languages. Acoustic model customization is beta functionality that is
"!  available for all supported languages.  <br/>
class ZCL_IBMC_SPEECH_TO_TEXT_V1 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "!   A warning from training of a custom language or custom acoustic model.
    begin of T_TRAINING_WARNING,
      CODE type STRING,
      MESSAGE type STRING,
    end of T_TRAINING_WARNING.
  types:
    "!   The response from training of a custom language or custom acoustic model.
    begin of T_TRAINING_RESPONSE,
      WARNINGS type STANDARD TABLE OF T_TRAINING_WARNING WITH NON-UNIQUE DEFAULT KEY,
    end of T_TRAINING_RESPONSE.
  types:
    "!   An alternative hypothesis for a word from speech recognition results.
    begin of T_WORD_ALTERNATIVE_RESULT,
      CONFIDENCE type DOUBLE,
      WORD type STRING,
    end of T_WORD_ALTERNATIVE_RESULT.
  types:
    "!   Information about alternative hypotheses for words from speech recognition
    "!    results.
    begin of T_WORD_ALTERNATIVE_RESULTS,
      START_TIME type DOUBLE,
      END_TIME type DOUBLE,
      ALTERNATIVES type STANDARD TABLE OF T_WORD_ALTERNATIVE_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_WORD_ALTERNATIVE_RESULTS.
  types:
    "!   A bin with defined boundaries that indicates the number of values in a range of
    "!    signal characteristics for a histogram. The first and last bins of a histogram
    "!    are the boundary bins. They cover the intervals between negative infinity and
    "!    the first boundary, and between the last boundary and positive infinity,
    "!    respectively.
    begin of T_AUDIO_METRICS_HISTOGRAM_BIN,
      BEGIN type FLOAT,
      END type FLOAT,
      COUNT type INTEGER,
    end of T_AUDIO_METRICS_HISTOGRAM_BIN.
  types:
    "!   Information about the speakers from speech recognition results.
    begin of T_SPEAKER_LABELS_RESULT,
      FROM type FLOAT,
      TO type FLOAT,
      SPEAKER type INTEGER,
      CONFIDENCE type FLOAT,
      FINAL type BOOLEAN,
    end of T_SPEAKER_LABELS_RESULT.
  types:
    "!   An alternative transcript from speech recognition results.
    begin of T_SPCH_RECOGNITION_ALTERNATIVE,
      TRANSCRIPT type STRING,
      CONFIDENCE type DOUBLE,
      TIMESTAMPS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      WORD_CONFIDENCE type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_SPCH_RECOGNITION_ALTERNATIVE.
  types:
    "!   Detailed timing information about the service's processing of the input audio.
    begin of T_PROCESSED_AUDIO,
      RECEIVED type FLOAT,
      SEEN_BY_ENGINE type FLOAT,
      TRANSCRIPTION type FLOAT,
      SPEAKER_LABELS type FLOAT,
    end of T_PROCESSED_AUDIO.
  types:
    "!   If processing metrics are requested, information about the service's processing
    "!    of the input audio. Processing metrics are not available with the synchronous
    "!    **Recognize audio** method.
    begin of T_PROCESSING_METRICS,
      PROCESSED_AUDIO type T_PROCESSED_AUDIO,
      WLL_CLCK_SNC_FRST_BYT_RECEIVED type FLOAT,
      PERIODIC type BOOLEAN,
    end of T_PROCESSING_METRICS.
  types:
    "!   Detailed information about the signal characteristics of the input audio.
    begin of T_AUDIO_METRICS_DETAILS,
      FINAL type BOOLEAN,
      END_TIME type FLOAT,
      SIGNAL_TO_NOISE_RATIO type FLOAT,
      SPEECH_RATIO type FLOAT,
      HIGH_FREQUENCY_LOSS type FLOAT,
      DIRECT_CURRENT_OFFSET type STANDARD TABLE OF T_AUDIO_METRICS_HISTOGRAM_BIN WITH NON-UNIQUE DEFAULT KEY,
      CLIPPING_RATE type STANDARD TABLE OF T_AUDIO_METRICS_HISTOGRAM_BIN WITH NON-UNIQUE DEFAULT KEY,
      SPEECH_LEVEL type STANDARD TABLE OF T_AUDIO_METRICS_HISTOGRAM_BIN WITH NON-UNIQUE DEFAULT KEY,
      NON_SPEECH_LEVEL type STANDARD TABLE OF T_AUDIO_METRICS_HISTOGRAM_BIN WITH NON-UNIQUE DEFAULT KEY,
    end of T_AUDIO_METRICS_DETAILS.
  types:
    "!   If audio metrics are requested, information about the signal characteristics of
    "!    the input audio.
    begin of T_AUDIO_METRICS,
      SAMPLING_INTERVAL type FLOAT,
      ACCUMULATED type T_AUDIO_METRICS_DETAILS,
    end of T_AUDIO_METRICS.
  types:
    "!   Component results for a speech recognition request.
    begin of T_SPEECH_RECOGNITION_RESULT,
      FINAL type BOOLEAN,
      ALTERNATIVES type STANDARD TABLE OF T_SPCH_RECOGNITION_ALTERNATIVE WITH NON-UNIQUE DEFAULT KEY,
      KEYWORDS_RESULT type MAP,
      WORD_ALTERNATIVES type STANDARD TABLE OF T_WORD_ALTERNATIVE_RESULTS WITH NON-UNIQUE DEFAULT KEY,
    end of T_SPEECH_RECOGNITION_RESULT.
  types:
    "!   The complete results for a speech recognition request.
    begin of T_SPEECH_RECOGNITION_RESULTS,
      RESULTS type STANDARD TABLE OF T_SPEECH_RECOGNITION_RESULT WITH NON-UNIQUE DEFAULT KEY,
      RESULT_INDEX type INTEGER,
      SPEAKER_LABELS type STANDARD TABLE OF T_SPEAKER_LABELS_RESULT WITH NON-UNIQUE DEFAULT KEY,
      PROCESSING_METRICS type T_PROCESSING_METRICS,
      AUDIO_METRICS type T_AUDIO_METRICS,
      WARNINGS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_SPEECH_RECOGNITION_RESULTS.
  types:
    "!   Information about a grammar from a custom language model.
    begin of T_GRAMMAR,
      NAME type STRING,
      OUT_OF_VOCABULARY_WORDS type INTEGER,
      STATUS type STRING,
      ERROR type STRING,
    end of T_GRAMMAR.
  types:
    "!   Information about the grammars from a custom language model.
    begin of T_GRAMMARS,
      GRAMMARS type STANDARD TABLE OF T_GRAMMAR WITH NON-UNIQUE DEFAULT KEY,
    end of T_GRAMMARS.
  types:
    "!   Information about a current asynchronous speech recognition job.
    begin of T_RECOGNITION_JOB,
      ID type STRING,
      STATUS type STRING,
      CREATED type STRING,
      UPDATED type STRING,
      URL type STRING,
      USER_TOKEN type STRING,
      RESULTS type STANDARD TABLE OF T_SPEECH_RECOGNITION_RESULTS WITH NON-UNIQUE DEFAULT KEY,
      WARNINGS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_RECOGNITION_JOB.
  types:
    "!   Information about current asynchronous speech recognition jobs.
    begin of T_RECOGNITION_JOBS,
      RECOGNITIONS type STANDARD TABLE OF T_RECOGNITION_JOB WITH NON-UNIQUE DEFAULT KEY,
    end of T_RECOGNITION_JOBS.
  types:
    "!   Information about an audio resource from a custom acoustic model.
    begin of T_AUDIO_DETAILS,
      TYPE type STRING,
      CODEC type STRING,
      FREQUENCY type INTEGER,
      COMPRESSION type STRING,
    end of T_AUDIO_DETAILS.
  types:
    "!   The error response from a failed request.
    begin of T_ERROR_MODEL,
      ERROR type STRING,
      CODE type INTEGER,
      CODE_DESCRIPTION type STRING,
      WARNINGS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_ERROR_MODEL.
  types:
    "!   Information about an audio resource from a custom acoustic model.
    begin of T_AUDIO_RESOURCE,
      DURATION type INTEGER,
      NAME type STRING,
      DETAILS type T_AUDIO_DETAILS,
      STATUS type STRING,
    end of T_AUDIO_RESOURCE.
  types:
    "!   Information about an audio resource from a custom acoustic model.
    begin of T_AUDIO_LISTING,
      DURATION type INTEGER,
      NAME type STRING,
      DETAILS type T_AUDIO_DETAILS,
      STATUS type STRING,
      CONTAINER type T_AUDIO_RESOURCE,
      AUDIO type STANDARD TABLE OF T_AUDIO_RESOURCE WITH NON-UNIQUE DEFAULT KEY,
    end of T_AUDIO_LISTING.
  types:
    "!   An error associated with a word from a custom language model.
    begin of T_WORD_ERROR,
      ELEMENT type STRING,
    end of T_WORD_ERROR.
  types:
    "!   Information about a word from a custom language model.
    begin of T_WORD,
      WORD type STRING,
      SOUNDS_LIKE type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      DISPLAY_AS type STRING,
      COUNT type INTEGER,
      SOURCE type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      ERROR type STANDARD TABLE OF T_WORD_ERROR WITH NON-UNIQUE DEFAULT KEY,
    end of T_WORD.
  types:
    "!   Information about the words from a custom language model.
    begin of T_WORDS,
      WORDS type STANDARD TABLE OF T_WORD WITH NON-UNIQUE DEFAULT KEY,
    end of T_WORDS.
  types:
    "!   Information about a word that is to be added to a custom language model.
    begin of T_CUSTOM_WORD,
      WORD type STRING,
      SOUNDS_LIKE type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      DISPLAY_AS type STRING,
    end of T_CUSTOM_WORD.
  types:
    "!   Information about the audio resources from a custom acoustic model.
    begin of T_AUDIO_RESOURCES,
      TOTAL_MINUTES_OF_AUDIO type DOUBLE,
      AUDIO type STANDARD TABLE OF T_AUDIO_RESOURCE WITH NON-UNIQUE DEFAULT KEY,
    end of T_AUDIO_RESOURCES.
  types:
    "!   Information about a corpus from a custom language model.
    begin of T_CORPUS,
      NAME type STRING,
      TOTAL_WORDS type INTEGER,
      OUT_OF_VOCABULARY_WORDS type INTEGER,
      STATUS type STRING,
      ERROR type STRING,
    end of T_CORPUS.
  types:
    "!   Information about the corpora from a custom language model.
    begin of T_CORPORA,
      CORPORA type STANDARD TABLE OF T_CORPUS WITH NON-UNIQUE DEFAULT KEY,
    end of T_CORPORA.
  types:
    "!   Information about an existing custom language model.
    begin of T_LANGUAGE_MODEL,
      CUSTOMIZATION_ID type STRING,
      CREATED type STRING,
      UPDATED type STRING,
      LANGUAGE type STRING,
      DIALECT type STRING,
      VERSIONS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      OWNER type STRING,
      NAME type STRING,
      DESCRIPTION type STRING,
      BASE_MODEL_NAME type STRING,
      STATUS type STRING,
      PROGRESS type INTEGER,
      ERROR type STRING,
      WARNINGS type STRING,
    end of T_LANGUAGE_MODEL.
  types:
    "!   Information about existing custom language models.
    begin of T_LANGUAGE_MODELS,
      CUSTOMIZATIONS type STANDARD TABLE OF T_LANGUAGE_MODEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_LANGUAGE_MODELS.
  types:
    "!   Information about an existing custom acoustic model.
    begin of T_ACOUSTIC_MODEL,
      CUSTOMIZATION_ID type STRING,
      CREATED type STRING,
      UPDATED type STRING,
      LANGUAGE type STRING,
      VERSIONS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      OWNER type STRING,
      NAME type STRING,
      DESCRIPTION type STRING,
      BASE_MODEL_NAME type STRING,
      STATUS type STRING,
      PROGRESS type INTEGER,
      WARNINGS type STRING,
    end of T_ACOUSTIC_MODEL.
  types:
    "!   Information about existing custom acoustic models.
    begin of T_ACOUSTIC_MODELS,
      CUSTOMIZATIONS type STANDARD TABLE OF T_ACOUSTIC_MODEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_ACOUSTIC_MODELS.
  types:
    "!
    begin of T_INLINE_OBJECT,
      CORPUS_FILE type FILE,
    end of T_INLINE_OBJECT.
  types:
    "!   Additional service features that are supported with the model.
    begin of T_SUPPORTED_FEATURES,
      CUSTOM_LANGUAGE_MODEL type BOOLEAN,
      SPEAKER_LABELS type BOOLEAN,
    end of T_SUPPORTED_FEATURES.
  types:
    "!   Information about the new custom language model.
    begin of T_CREATE_LANGUAGE_MODEL,
      NAME type STRING,
      BASE_MODEL_NAME type STRING,
      DIALECT type STRING,
      DESCRIPTION type STRING,
    end of T_CREATE_LANGUAGE_MODEL.
  types:
    "!   Information about an available language model.
    begin of T_SPEECH_MODEL,
      NAME type STRING,
      LANGUAGE type STRING,
      RATE type INTEGER,
      URL type STRING,
      SUPPORTED_FEATURES type T_SUPPORTED_FEATURES,
      DESCRIPTION type STRING,
    end of T_SPEECH_MODEL.
  types:
    "!   Information about the available language models.
    begin of T_SPEECH_MODELS,
      MODELS type STANDARD TABLE OF T_SPEECH_MODEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_SPEECH_MODELS.
  types:
    "!   Information about the new custom acoustic model.
    begin of T_CREATE_ACOUSTIC_MODEL,
      NAME type STRING,
      BASE_MODEL_NAME type STRING,
      DESCRIPTION type STRING,
    end of T_CREATE_ACOUSTIC_MODEL.
  types:
    "!   Information about the words that are to be added to a custom language model.
    begin of T_CUSTOM_WORDS,
      WORDS type STANDARD TABLE OF T_CUSTOM_WORD WITH NON-UNIQUE DEFAULT KEY,
    end of T_CUSTOM_WORDS.
  types:
    "!   Information about a match for a keyword from speech recognition results.
    begin of T_KEYWORD_RESULT,
      NORMALIZED_TEXT type STRING,
      START_TIME type DOUBLE,
      END_TIME type DOUBLE,
      CONFIDENCE type DOUBLE,
    end of T_KEYWORD_RESULT.
  types:
    "!   The empty response from a request.
      T_EMPTY_RESPONSE_BODY type JSONOBJECT.
  types:
    "!   Information about a request to register a callback for asynchronous speech
    "!    recognition.
    begin of T_REGISTER_STATUS,
      STATUS type STRING,
      URL type STRING,
    end of T_REGISTER_STATUS.

constants:
  begin of C_REQUIRED_FIELDS,
    T_TRAINING_WARNING type string value '|CODE|MESSAGE|',
    T_TRAINING_RESPONSE type string value '|',
    T_WORD_ALTERNATIVE_RESULT type string value '|CONFIDENCE|WORD|',
    T_WORD_ALTERNATIVE_RESULTS type string value '|START_TIME|END_TIME|ALTERNATIVES|',
    T_AUDIO_METRICS_HISTOGRAM_BIN type string value '|BEGIN|END|COUNT|',
    T_SPEAKER_LABELS_RESULT type string value '|FROM|TO|SPEAKER|CONFIDENCE|FINAL|',
    T_SPCH_RECOGNITION_ALTERNATIVE type string value '|TRANSCRIPT|',
    T_PROCESSED_AUDIO type string value '|RECEIVED|SEEN_BY_ENGINE|TRANSCRIPTION|',
    T_PROCESSING_METRICS type string value '|PROCESSED_AUDIO|WLL_CLCK_SNC_FRST_BYT_RECEIVED|PERIODIC|',
    T_AUDIO_METRICS_DETAILS type string value '|FINAL|END_TIME|SPEECH_RATIO|HIGH_FREQUENCY_LOSS|DIRECT_CURRENT_OFFSET|CLIPPING_RATE|SPEECH_LEVEL|NON_SPEECH_LEVEL|',
    T_AUDIO_METRICS type string value '|SAMPLING_INTERVAL|ACCUMULATED|',
    T_SPEECH_RECOGNITION_RESULT type string value '|FINAL|ALTERNATIVES|',
    T_SPEECH_RECOGNITION_RESULTS type string value '|',
    T_GRAMMAR type string value '|NAME|OUT_OF_VOCABULARY_WORDS|STATUS|',
    T_GRAMMARS type string value '|GRAMMARS|',
    T_RECOGNITION_JOB type string value '|ID|STATUS|CREATED|',
    T_RECOGNITION_JOBS type string value '|RECOGNITIONS|',
    T_AUDIO_DETAILS type string value '|',
    T_ERROR_MODEL type string value '|ERROR|CODE|CODE_DESCRIPTION|',
    T_AUDIO_RESOURCE type string value '|DURATION|NAME|DETAILS|STATUS|',
    T_AUDIO_LISTING type string value '|',
    T_WORD_ERROR type string value '|ELEMENT|',
    T_WORD type string value '|WORD|SOUNDS_LIKE|DISPLAY_AS|COUNT|SOURCE|',
    T_WORDS type string value '|WORDS|',
    T_CUSTOM_WORD type string value '|',
    T_AUDIO_RESOURCES type string value '|TOTAL_MINUTES_OF_AUDIO|AUDIO|',
    T_CORPUS type string value '|NAME|TOTAL_WORDS|OUT_OF_VOCABULARY_WORDS|STATUS|',
    T_CORPORA type string value '|CORPORA|',
    T_LANGUAGE_MODEL type string value '|CUSTOMIZATION_ID|',
    T_LANGUAGE_MODELS type string value '|CUSTOMIZATIONS|',
    T_ACOUSTIC_MODEL type string value '|CUSTOMIZATION_ID|',
    T_ACOUSTIC_MODELS type string value '|CUSTOMIZATIONS|',
    T_INLINE_OBJECT type string value '|CORPUS_FILE|',
    T_SUPPORTED_FEATURES type string value '|CUSTOM_LANGUAGE_MODEL|SPEAKER_LABELS|',
    T_CREATE_LANGUAGE_MODEL type string value '|NAME|BASE_MODEL_NAME|',
    T_SPEECH_MODEL type string value '|NAME|LANGUAGE|RATE|URL|SUPPORTED_FEATURES|DESCRIPTION|',
    T_SPEECH_MODELS type string value '|MODELS|',
    T_CREATE_ACOUSTIC_MODEL type string value '|NAME|BASE_MODEL_NAME|',
    T_CUSTOM_WORDS type string value '|WORDS|',
    T_KEYWORD_RESULT type string value '|NORMALIZED_TEXT|START_TIME|END_TIME|CONFIDENCE|',
    T_REGISTER_STATUS type string value '|STATUS|URL|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  begin of C_ABAPNAME_DICTIONARY,
     RECOGNITIONS type string value 'recognitions',
     ID type string value 'id',
     STATUS type string value 'status',
     CREATED type string value 'created',
     UPDATED type string value 'updated',
     URL type string value 'url',
     USER_TOKEN type string value 'user_token',
     RESULTS type string value 'results',
     WARNINGS type string value 'warnings',
     RESULT_INDEX type string value 'result_index',
     SPEAKER_LABELS type string value 'speaker_labels',
     SPEAKERLABELS type string value 'speakerLabels',
     PROCESSING_METRICS type string value 'processing_metrics',
     AUDIO_METRICS type string value 'audio_metrics',
     FINAL type string value 'final',
     ALTERNATIVES type string value 'alternatives',
     KEYWORDS_RESULT type string value 'keywords_result',
     INNER type string value 'inner',
     WORD_ALTERNATIVES type string value 'word_alternatives',
     WORDALTERNATIVES type string value 'wordAlternatives',
     NORMALIZED_TEXT type string value 'normalized_text',
     START_TIME type string value 'start_time',
     END_TIME type string value 'end_time',
     CONFIDENCE type string value 'confidence',
     WORD type string value 'word',
     TRANSCRIPT type string value 'transcript',
     TIMESTAMPS type string value 'timestamps',
     WORD_CONFIDENCE type string value 'word_confidence',
     WORDCONFIDENCE type string value 'wordConfidence',
     FROM type string value 'from',
     TO type string value 'to',
     SPEAKER type string value 'speaker',
     PROCESSED_AUDIO type string value 'processed_audio',
     WLL_CLCK_SNC_FRST_BYT_RECEIVED type string value 'wall_clock_since_first_byte_received',
     PERIODIC type string value 'periodic',
     RECEIVED type string value 'received',
     SEEN_BY_ENGINE type string value 'seen_by_engine',
     TRANSCRIPTION type string value 'transcription',
     SAMPLING_INTERVAL type string value 'sampling_interval',
     ACCUMULATED type string value 'accumulated',
     SIGNAL_TO_NOISE_RATIO type string value 'signal_to_noise_ratio',
     SPEECH_RATIO type string value 'speech_ratio',
     HIGH_FREQUENCY_LOSS type string value 'high_frequency_loss',
     DIRECT_CURRENT_OFFSET type string value 'direct_current_offset',
     DIRECTCURRENTOFFSET type string value 'directCurrentOffset',
     CLIPPING_RATE type string value 'clipping_rate',
     CLIPPINGRATE type string value 'clippingRate',
     SPEECH_LEVEL type string value 'speech_level',
     SPEECHLEVEL type string value 'speechLevel',
     NON_SPEECH_LEVEL type string value 'non_speech_level',
     NONSPEECHLEVEL type string value 'nonSpeechLevel',
     BEGIN type string value 'begin',
     END type string value 'end',
     COUNT type string value 'count',
     MODELS type string value 'models',
     NAME type string value 'name',
     LANGUAGE type string value 'language',
     RATE type string value 'rate',
     SUPPORTED_FEATURES type string value 'supported_features',
     DESCRIPTION type string value 'description',
     CUSTOM_LANGUAGE_MODEL type string value 'custom_language_model',
     BASE_MODEL_NAME type string value 'base_model_name',
     DIALECT type string value 'dialect',
     CUSTOMIZATIONS type string value 'customizations',
     CUSTOMIZATION_ID type string value 'customization_id',
     VERSIONS type string value 'versions',
     OWNER type string value 'owner',
     PROGRESS type string value 'progress',
     ERROR type string value 'error',
     CORPORA type string value 'corpora',
     TOTAL_WORDS type string value 'total_words',
     OUT_OF_VOCABULARY_WORDS type string value 'out_of_vocabulary_words',
     WORDS type string value 'words',
     SOUNDS_LIKE type string value 'sounds_like',
     SOUNDSLIKE type string value 'soundsLike',
     DISPLAY_AS type string value 'display_as',
     SOURCE type string value 'source',
     ELEMENT type string value 'element',
     GRAMMARS type string value 'grammars',
     TOTAL_MINUTES_OF_AUDIO type string value 'total_minutes_of_audio',
     AUDIO type string value 'audio',
     DURATION type string value 'duration',
     DETAILS type string value 'details',
     TYPE type string value 'type',
     CODEC type string value 'codec',
     FREQUENCY type string value 'frequency',
     COMPRESSION type string value 'compression',
     CONTAINER type string value 'container',
     CODE type string value 'code',
     MESSAGE type string value 'message',
     CODE_DESCRIPTION type string value 'code_description',
     CORPUS_FILE type string value 'corpus_file',
  end of C_ABAPNAME_DICTIONARY .


  methods GET_APPNAME
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
  methods GET_SDK_VERSION_DATE
    redefinition .


    "! List models.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SPEECH_MODELS
    "!
  methods LIST_MODELS
    importing
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SPEECH_MODELS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get a model.
    "!
    "! @parameter I_model_id |
    "!   The identifier of the model in the form of its name from the output of the **Get
    "!    a model** method.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SPEECH_MODEL
    "!
  methods GET_MODEL
    importing
      !I_model_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SPEECH_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Recognize audio.
    "!
    "! @parameter I_audio |
    "!   The audio to transcribe.
    "! @parameter I_Content_Type |
    "!   The format (MIME type) of the audio. For more information about specifying an
    "!    audio format, see **Audio formats (content types)** in the method description.
    "! @parameter I_model |
    "!   The identifier of the model that is to be used for the recognition request. See
    "!    [Languages and
    "!    models](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -models#models).
    "! @parameter I_language_customization_id |
    "!   The customization ID (GUID) of a custom language model that is to be used with
    "!    the recognition request. The base model of the specified custom language model
    "!    must match the model specified with the `model` parameter. You must make the
    "!    request with credentials for the instance of the service that owns the custom
    "!    model. By default, no custom language model is used. See [Custom
    "!    models](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -input#custom-input).
    "!
    "!   **Note:** Use this parameter instead of the deprecated `customization_id`
    "!    parameter.
    "! @parameter I_acoustic_customization_id |
    "!   The customization ID (GUID) of a custom acoustic model that is to be used with
    "!    the recognition request. The base model of the specified custom acoustic model
    "!    must match the model specified with the `model` parameter. You must make the
    "!    request with credentials for the instance of the service that owns the custom
    "!    model. By default, no custom acoustic model is used. See [Custom
    "!    models](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -input#custom-input).
    "! @parameter I_base_model_version |
    "!   The version of the specified base model that is to be used with the recognition
    "!    request. Multiple versions of a base model can exist when a model is updated
    "!    for internal improvements. The parameter is intended primarily for use with
    "!    custom models that have been upgraded for a new base model. The default value
    "!    depends on whether the parameter is used with or without a custom model. See
    "!    [Base model
    "!    version](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-tex
    "!   t-input#version).
    "! @parameter I_customization_weight |
    "!   If you specify the customization ID (GUID) of a custom language model with the
    "!    recognition request, the customization weight tells the service how much weight
    "!    to give to words from the custom language model compared to those from the base
    "!    model for the current request.
    "!
    "!   Specify a value between 0.0 and 1.0. Unless a different customization weight was
    "!    specified for the custom model when it was trained, the default value is 0.3. A
    "!    customization weight that you specify overrides a weight that was specified
    "!    when the custom model was trained.
    "!
    "!   The default value yields the best performance in general. Assign a higher value
    "!    if your audio makes frequent use of OOV words from the custom model. Use
    "!    caution when setting the weight: a higher value can improve the accuracy of
    "!    phrases from the custom model's domain, but it can negatively affect
    "!    performance on non-domain phrases.
    "!
    "!   See [Custom
    "!    models](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -input#custom-input).
    "! @parameter I_inactivity_timeout |
    "!   The time in seconds after which, if only silence (no speech) is detected in
    "!    streaming audio, the connection is closed with a 400 error. The parameter is
    "!    useful for stopping audio submission from a live microphone when a user simply
    "!    walks away. Use `-1` for infinity. See [Inactivity
    "!    timeout](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-tex
    "!   t-input#timeouts-inactivity).
    "! @parameter I_keywords |
    "!   An array of keyword strings to spot in the audio. Each keyword string can
    "!    include one or more string tokens. Keywords are spotted only in the final
    "!    results, not in interim hypotheses. If you specify any keywords, you must also
    "!    specify a keywords threshold. You can spot a maximum of 1000 keywords. Omit the
    "!    parameter or specify an empty array if you do not need to spot keywords. See
    "!    [Keyword
    "!    spotting](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-te
    "!   xt-output#keyword_spotting).
    "! @parameter I_keywords_threshold |
    "!   A confidence value that is the lower bound for spotting a keyword. A word is
    "!    considered to match a keyword if its confidence is greater than or equal to the
    "!    threshold. Specify a probability between 0.0 and 1.0. If you specify a
    "!    threshold, you must also specify one or more keywords. The service performs no
    "!    keyword spotting if you omit either parameter. See [Keyword
    "!    spotting](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-te
    "!   xt-output#keyword_spotting).
    "! @parameter I_max_alternatives |
    "!   The maximum number of alternative transcripts that the service is to return. By
    "!    default, the service returns a single transcript. If you specify a value of
    "!    `0`, the service uses the default value, `1`. See [Maximum
    "!    alternatives](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-t
    "!   o-text-output#max_alternatives).
    "! @parameter I_word_alternatives_threshold |
    "!   A confidence value that is the lower bound for identifying a hypothesis as a
    "!    possible word alternative (also known as "Confusion Networks"). An alternative
    "!    word is considered if its confidence is greater than or equal to the threshold.
    "!    Specify a probability between 0.0 and 1.0. By default, the service computes no
    "!    alternative words. See [Word
    "!    alternatives](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-t
    "!   o-text-output#word_alternatives).
    "! @parameter I_word_confidence |
    "!   If `true`, the service returns a confidence measure in the range of 0.0 to 1.0
    "!    for each word. By default, the service returns no word confidence scores. See
    "!    [Word
    "!    confidence](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-
    "!   text-output#word_confidence).
    "! @parameter I_timestamps |
    "!   If `true`, the service returns time alignment for each word. By default, no
    "!    timestamps are returned. See [Word
    "!    timestamps](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-
    "!   text-output#word_timestamps).
    "! @parameter I_profanity_filter |
    "!   If `true`, the service filters profanity from all output except for keyword
    "!    results by replacing inappropriate words with a series of asterisks. Set the
    "!    parameter to `false` to return results with no censoring. Applies to US English
    "!    transcription only. See [Profanity
    "!    filtering](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-t
    "!   ext-output#profanity_filter).
    "! @parameter I_smart_formatting |
    "!   If `true`, the service converts dates, times, series of digits and numbers,
    "!    phone numbers, currency values, and internet addresses into more readable,
    "!    conventional representations in the final transcript of a recognition request.
    "!    For US English, the service also converts certain keyword strings to
    "!    punctuation symbols. By default, the service performs no smart formatting.
    "!
    "!   **Note:** Applies to US English, Japanese, and Spanish transcription only.
    "!
    "!   See [Smart
    "!    formatting](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-
    "!   text-output#smart_formatting).
    "! @parameter I_speaker_labels |
    "!   If `true`, the response includes labels that identify which words were spoken by
    "!    which participants in a multi-person exchange. By default, the service returns
    "!    no speaker labels. Setting `speaker_labels` to `true` forces the `timestamps`
    "!    parameter to be `true`, regardless of whether you specify `false` for the
    "!    parameter.
    "!
    "!   **Note:** Applies to US English, Japanese, and Spanish (both broadband and
    "!    narrowband models) and UK English (narrowband model) transcription only. To
    "!    determine whether a language model supports speaker labels, you can also use
    "!    the **Get a model** method and check that the attribute `speaker_labels` is set
    "!    to `true`.
    "!
    "!   See [Speaker
    "!    labels](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -output#speaker_labels).
    "! @parameter I_customization_id |
    "!   **Deprecated.** Use the `language_customization_id` parameter to specify the
    "!   ** customization ID (GUID) of a custom language model that is to be used with the
    "!   ** recognition request. Do not specify both parameters with a request.
    "! @parameter I_grammar_name |
    "!   The name of a grammar that is to be used with the recognition request. If you
    "!    specify a grammar, you must also use the `language_customization_id` parameter
    "!    to specify the name of the custom language model for which the grammar is
    "!    defined. The service recognizes only strings that are recognized by the
    "!    specified grammar; it does not recognize other custom words from the model's
    "!    words resource. See
    "!    [Grammars](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-t
    "!   ext-input#grammars-input).
    "! @parameter I_redaction |
    "!   If `true`, the service redacts, or masks, numeric data from final transcripts.
    "!    The feature redacts any number that has three or more consecutive digits by
    "!    replacing each digit with an `X` character. It is intended to redact sensitive
    "!    numeric data, such as credit card numbers. By default, the service performs no
    "!    redaction.
    "!
    "!   When you enable redaction, the service automatically enables smart formatting,
    "!    regardless of whether you explicitly disable that feature. To ensure maximum
    "!    security, the service also disables keyword spotting (ignores the `keywords`
    "!    and `keywords_threshold` parameters) and returns only a single final transcript
    "!    (forces the `max_alternatives` parameter to be `1`).
    "!
    "!   **Note:** Applies to US English, Japanese, and Korean transcription only.
    "!
    "!   See [Numeric
    "!    redaction](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-t
    "!   ext-output#redaction).
    "! @parameter I_audio_metrics |
    "!   If `true`, requests detailed information about the signal characteristics of the
    "!    input audio. The service returns audio metrics with the final transcription
    "!    results. By default, the service returns no audio metrics.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SPEECH_RECOGNITION_RESULTS
    "!
  methods RECOGNIZE
    importing
      !I_audio type FILE
      !I_Content_Type type STRING default 'application/octet-stream'
      !I_model type STRING default 'en-US_BroadbandModel'
      !I_language_customization_id type STRING optional
      !I_acoustic_customization_id type STRING optional
      !I_base_model_version type STRING optional
      !I_customization_weight type DOUBLE optional
      !I_inactivity_timeout type INTEGER optional
      !I_keywords type TT_STRING optional
      !I_keywords_threshold type FLOAT optional
      !I_max_alternatives type INTEGER optional
      !I_word_alternatives_threshold type FLOAT optional
      !I_word_confidence type BOOLEAN default c_boolean_false
      !I_timestamps type BOOLEAN default c_boolean_false
      !I_profanity_filter type BOOLEAN default c_boolean_true
      !I_smart_formatting type BOOLEAN default c_boolean_false
      !I_speaker_labels type BOOLEAN default c_boolean_false
      !I_customization_id type STRING optional
      !I_grammar_name type STRING optional
      !I_redaction type BOOLEAN default c_boolean_false
      !I_audio_metrics type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SPEECH_RECOGNITION_RESULTS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Register a callback.
    "!
    "! @parameter I_callback_url |
    "!   An HTTP or HTTPS URL to which callback notifications are to be sent. To be
    "!    white-listed, the URL must successfully echo the challenge string during URL
    "!    verification. During verification, the client can also check the signature that
    "!    the service sends in the `X-Callback-Signature` header to verify the origin of
    "!    the request.
    "! @parameter I_user_secret |
    "!   A user-specified string that the service uses to generate the HMAC-SHA1
    "!    signature that it sends via the `X-Callback-Signature` header. The service
    "!    includes the header during URL verification and with every notification sent to
    "!    the callback URL. It calculates the signature over the payload of the
    "!    notification. If you omit the parameter, the service does not send the header.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_REGISTER_STATUS
    "!
  methods REGISTER_CALLBACK
    importing
      !I_callback_url type STRING
      !I_user_secret type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_REGISTER_STATUS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Unregister a callback.
    "!
    "! @parameter I_callback_url |
    "!   The callback URL that is to be unregistered.
    "!
  methods UNREGISTER_CALLBACK
    importing
      !I_callback_url type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Create a job.
    "!
    "! @parameter I_audio |
    "!   The audio to transcribe.
    "! @parameter I_Content_Type |
    "!   The format (MIME type) of the audio. For more information about specifying an
    "!    audio format, see **Audio formats (content types)** in the method description.
    "! @parameter I_model |
    "!   The identifier of the model that is to be used for the recognition request. See
    "!    [Languages and
    "!    models](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -models#models).
    "! @parameter I_callback_url |
    "!   A URL to which callback notifications are to be sent. The URL must already be
    "!    successfully white-listed by using the **Register a callback** method. You can
    "!    include the same callback URL with any number of job creation requests. Omit
    "!    the parameter to poll the service for job completion and results.
    "!
    "!   Use the `user_token` parameter to specify a unique user-specified string with
    "!    each job to differentiate the callback notifications for the jobs.
    "! @parameter I_events |
    "!   If the job includes a callback URL, a comma-separated list of notification
    "!    events to which to subscribe. Valid events are
    "!   * `recognitions.started` generates a callback notification when the service
    "!    begins to process the job.
    "!   * `recognitions.completed` generates a callback notification when the job is
    "!    complete. You must use the **Check a job** method to retrieve the results
    "!    before they time out or are deleted.
    "!   * `recognitions.completed_with_results` generates a callback notification when
    "!    the job is complete. The notification includes the results of the request.
    "!   * `recognitions.failed` generates a callback notification if the service
    "!    experiences an error while processing the job.
    "!
    "!   The `recognitions.completed` and `recognitions.completed_with_results` events
    "!    are incompatible. You can specify only of the two events.
    "!
    "!   If the job includes a callback URL, omit the parameter to subscribe to the
    "!    default events: `recognitions.started`, `recognitions.completed`, and
    "!    `recognitions.failed`. If the job does not include a callback URL, omit the
    "!    parameter.
    "! @parameter I_user_token |
    "!   If the job includes a callback URL, a user-specified string that the service is
    "!    to include with each callback notification for the job; the token allows the
    "!    user to maintain an internal mapping between jobs and notification events. If
    "!    the job does not include a callback URL, omit the parameter.
    "! @parameter I_results_ttl |
    "!   The number of minutes for which the results are to be available after the job
    "!    has finished. If not delivered via a callback, the results must be retrieved
    "!    within this time. Omit the parameter to use a time to live of one week. The
    "!    parameter is valid with or without a callback URL.
    "! @parameter I_language_customization_id |
    "!   The customization ID (GUID) of a custom language model that is to be used with
    "!    the recognition request. The base model of the specified custom language model
    "!    must match the model specified with the `model` parameter. You must make the
    "!    request with credentials for the instance of the service that owns the custom
    "!    model. By default, no custom language model is used. See [Custom
    "!    models](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -input#custom-input).
    "!
    "!   **Note:** Use this parameter instead of the deprecated `customization_id`
    "!    parameter.
    "! @parameter I_acoustic_customization_id |
    "!   The customization ID (GUID) of a custom acoustic model that is to be used with
    "!    the recognition request. The base model of the specified custom acoustic model
    "!    must match the model specified with the `model` parameter. You must make the
    "!    request with credentials for the instance of the service that owns the custom
    "!    model. By default, no custom acoustic model is used. See [Custom
    "!    models](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -input#custom-input).
    "! @parameter I_base_model_version |
    "!   The version of the specified base model that is to be used with the recognition
    "!    request. Multiple versions of a base model can exist when a model is updated
    "!    for internal improvements. The parameter is intended primarily for use with
    "!    custom models that have been upgraded for a new base model. The default value
    "!    depends on whether the parameter is used with or without a custom model. See
    "!    [Base model
    "!    version](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-tex
    "!   t-input#version).
    "! @parameter I_customization_weight |
    "!   If you specify the customization ID (GUID) of a custom language model with the
    "!    recognition request, the customization weight tells the service how much weight
    "!    to give to words from the custom language model compared to those from the base
    "!    model for the current request.
    "!
    "!   Specify a value between 0.0 and 1.0. Unless a different customization weight was
    "!    specified for the custom model when it was trained, the default value is 0.3. A
    "!    customization weight that you specify overrides a weight that was specified
    "!    when the custom model was trained.
    "!
    "!   The default value yields the best performance in general. Assign a higher value
    "!    if your audio makes frequent use of OOV words from the custom model. Use
    "!    caution when setting the weight: a higher value can improve the accuracy of
    "!    phrases from the custom model's domain, but it can negatively affect
    "!    performance on non-domain phrases.
    "!
    "!   See [Custom
    "!    models](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -input#custom-input).
    "! @parameter I_inactivity_timeout |
    "!   The time in seconds after which, if only silence (no speech) is detected in
    "!    streaming audio, the connection is closed with a 400 error. The parameter is
    "!    useful for stopping audio submission from a live microphone when a user simply
    "!    walks away. Use `-1` for infinity. See [Inactivity
    "!    timeout](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-tex
    "!   t-input#timeouts-inactivity).
    "! @parameter I_keywords |
    "!   An array of keyword strings to spot in the audio. Each keyword string can
    "!    include one or more string tokens. Keywords are spotted only in the final
    "!    results, not in interim hypotheses. If you specify any keywords, you must also
    "!    specify a keywords threshold. You can spot a maximum of 1000 keywords. Omit the
    "!    parameter or specify an empty array if you do not need to spot keywords. See
    "!    [Keyword
    "!    spotting](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-te
    "!   xt-output#keyword_spotting).
    "! @parameter I_keywords_threshold |
    "!   A confidence value that is the lower bound for spotting a keyword. A word is
    "!    considered to match a keyword if its confidence is greater than or equal to the
    "!    threshold. Specify a probability between 0.0 and 1.0. If you specify a
    "!    threshold, you must also specify one or more keywords. The service performs no
    "!    keyword spotting if you omit either parameter. See [Keyword
    "!    spotting](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-te
    "!   xt-output#keyword_spotting).
    "! @parameter I_max_alternatives |
    "!   The maximum number of alternative transcripts that the service is to return. By
    "!    default, the service returns a single transcript. If you specify a value of
    "!    `0`, the service uses the default value, `1`. See [Maximum
    "!    alternatives](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-t
    "!   o-text-output#max_alternatives).
    "! @parameter I_word_alternatives_threshold |
    "!   A confidence value that is the lower bound for identifying a hypothesis as a
    "!    possible word alternative (also known as "Confusion Networks"). An alternative
    "!    word is considered if its confidence is greater than or equal to the threshold.
    "!    Specify a probability between 0.0 and 1.0. By default, the service computes no
    "!    alternative words. See [Word
    "!    alternatives](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-t
    "!   o-text-output#word_alternatives).
    "! @parameter I_word_confidence |
    "!   If `true`, the service returns a confidence measure in the range of 0.0 to 1.0
    "!    for each word. By default, the service returns no word confidence scores. See
    "!    [Word
    "!    confidence](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-
    "!   text-output#word_confidence).
    "! @parameter I_timestamps |
    "!   If `true`, the service returns time alignment for each word. By default, no
    "!    timestamps are returned. See [Word
    "!    timestamps](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-
    "!   text-output#word_timestamps).
    "! @parameter I_profanity_filter |
    "!   If `true`, the service filters profanity from all output except for keyword
    "!    results by replacing inappropriate words with a series of asterisks. Set the
    "!    parameter to `false` to return results with no censoring. Applies to US English
    "!    transcription only. See [Profanity
    "!    filtering](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-t
    "!   ext-output#profanity_filter).
    "! @parameter I_smart_formatting |
    "!   If `true`, the service converts dates, times, series of digits and numbers,
    "!    phone numbers, currency values, and internet addresses into more readable,
    "!    conventional representations in the final transcript of a recognition request.
    "!    For US English, the service also converts certain keyword strings to
    "!    punctuation symbols. By default, the service performs no smart formatting.
    "!
    "!   **Note:** Applies to US English, Japanese, and Spanish transcription only.
    "!
    "!   See [Smart
    "!    formatting](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-
    "!   text-output#smart_formatting).
    "! @parameter I_speaker_labels |
    "!   If `true`, the response includes labels that identify which words were spoken by
    "!    which participants in a multi-person exchange. By default, the service returns
    "!    no speaker labels. Setting `speaker_labels` to `true` forces the `timestamps`
    "!    parameter to be `true`, regardless of whether you specify `false` for the
    "!    parameter.
    "!
    "!   **Note:** Applies to US English, Japanese, and Spanish (both broadband and
    "!    narrowband models) and UK English (narrowband model) transcription only. To
    "!    determine whether a language model supports speaker labels, you can also use
    "!    the **Get a model** method and check that the attribute `speaker_labels` is set
    "!    to `true`.
    "!
    "!   See [Speaker
    "!    labels](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -output#speaker_labels).
    "! @parameter I_customization_id |
    "!   **Deprecated.** Use the `language_customization_id` parameter to specify the
    "!   ** customization ID (GUID) of a custom language model that is to be used with the
    "!   ** recognition request. Do not specify both parameters with a request.
    "! @parameter I_grammar_name |
    "!   The name of a grammar that is to be used with the recognition request. If you
    "!    specify a grammar, you must also use the `language_customization_id` parameter
    "!    to specify the name of the custom language model for which the grammar is
    "!    defined. The service recognizes only strings that are recognized by the
    "!    specified grammar; it does not recognize other custom words from the model's
    "!    words resource. See
    "!    [Grammars](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-t
    "!   ext-input#grammars-input).
    "! @parameter I_redaction |
    "!   If `true`, the service redacts, or masks, numeric data from final transcripts.
    "!    The feature redacts any number that has three or more consecutive digits by
    "!    replacing each digit with an `X` character. It is intended to redact sensitive
    "!    numeric data, such as credit card numbers. By default, the service performs no
    "!    redaction.
    "!
    "!   When you enable redaction, the service automatically enables smart formatting,
    "!    regardless of whether you explicitly disable that feature. To ensure maximum
    "!    security, the service also disables keyword spotting (ignores the `keywords`
    "!    and `keywords_threshold` parameters) and returns only a single final transcript
    "!    (forces the `max_alternatives` parameter to be `1`).
    "!
    "!   **Note:** Applies to US English, Japanese, and Korean transcription only.
    "!
    "!   See [Numeric
    "!    redaction](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-t
    "!   ext-output#redaction).
    "! @parameter I_processing_metrics |
    "!   If `true`, requests processing metrics about the service's transcription of the
    "!    input audio. The service returns processing metrics at the interval specified
    "!    by the `processing_metrics_interval` parameter. It also returns processing
    "!    metrics for transcription events, for example, for final and interim results.
    "!    By default, the service returns no processing metrics.
    "! @parameter I_processing_metrics_interval |
    "!   Specifies the interval in real wall-clock seconds at which the service is to
    "!    return processing metrics. The parameter is ignored unless the
    "!    `processing_metrics` parameter is set to `true`.
    "!
    "!   The parameter accepts a minimum value of 0.1 seconds. The level of precision is
    "!    not restricted, so you can specify values such as 0.25 and 0.125.
    "!
    "!   The service does not impose a maximum value. If you want to receive processing
    "!    metrics only for transcription events instead of at periodic intervals, set the
    "!    value to a large number. If the value is larger than the duration of the audio,
    "!    the service returns processing metrics only for transcription events.
    "! @parameter I_audio_metrics |
    "!   If `true`, requests detailed information about the signal characteristics of the
    "!    input audio. The service returns audio metrics with the final transcription
    "!    results. By default, the service returns no audio metrics.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_RECOGNITION_JOB
    "!
  methods CREATE_JOB
    importing
      !I_audio type FILE
      !I_Content_Type type STRING default 'application/octet-stream'
      !I_model type STRING default 'en-US_BroadbandModel'
      !I_callback_url type STRING optional
      !I_events type STRING optional
      !I_user_token type STRING optional
      !I_results_ttl type INTEGER optional
      !I_language_customization_id type STRING optional
      !I_acoustic_customization_id type STRING optional
      !I_base_model_version type STRING optional
      !I_customization_weight type DOUBLE optional
      !I_inactivity_timeout type INTEGER optional
      !I_keywords type TT_STRING optional
      !I_keywords_threshold type FLOAT optional
      !I_max_alternatives type INTEGER optional
      !I_word_alternatives_threshold type FLOAT optional
      !I_word_confidence type BOOLEAN default c_boolean_false
      !I_timestamps type BOOLEAN default c_boolean_false
      !I_profanity_filter type BOOLEAN default c_boolean_true
      !I_smart_formatting type BOOLEAN default c_boolean_false
      !I_speaker_labels type BOOLEAN default c_boolean_false
      !I_customization_id type STRING optional
      !I_grammar_name type STRING optional
      !I_redaction type BOOLEAN default c_boolean_false
      !I_processing_metrics type BOOLEAN default c_boolean_false
      !I_processing_metrics_interval type FLOAT optional
      !I_audio_metrics type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_RECOGNITION_JOB
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Check jobs.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_RECOGNITION_JOBS
    "!
  methods CHECK_JOBS
    importing
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_RECOGNITION_JOBS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Check a job.
    "!
    "! @parameter I_id |
    "!   The identifier of the asynchronous job that is to be used for the request. You
    "!    must make the request with credentials for the instance of the service that
    "!    owns the job.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_RECOGNITION_JOB
    "!
  methods CHECK_JOB
    importing
      !I_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_RECOGNITION_JOB
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a job.
    "!
    "! @parameter I_id |
    "!   The identifier of the asynchronous job that is to be used for the request. You
    "!    must make the request with credentials for the instance of the service that
    "!    owns the job.
    "!
  methods DELETE_JOB
    importing
      !I_id type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Create a custom language model.
    "!
    "! @parameter I_create_language_model |
    "!   A `CreateLanguageModel` object that provides basic information about the new
    "!    custom language model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LANGUAGE_MODEL
    "!
  methods CREATE_LANGUAGE_MODEL
    importing
      !I_create_language_model type T_CREATE_LANGUAGE_MODEL
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LANGUAGE_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! List custom language models.
    "!
    "! @parameter I_language |
    "!   The identifier of the language for which custom language or custom acoustic
    "!    models are to be returned (for example, `en-US`). Omit the parameter to see all
    "!    custom language or custom acoustic models that are owned by the requesting
    "!    credentials.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LANGUAGE_MODELS
    "!
  methods LIST_LANGUAGE_MODELS
    importing
      !I_language type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LANGUAGE_MODELS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get a custom language model.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LANGUAGE_MODEL
    "!
  methods GET_LANGUAGE_MODEL
    importing
      !I_customization_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LANGUAGE_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a custom language model.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "!
  methods DELETE_LANGUAGE_MODEL
    importing
      !I_customization_id type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Train a custom language model.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_word_type_to_add |
    "!   The type of words from the custom language model's words resource on which to
    "!    train the model:
    "!   * `all` (the default) trains the model on all new words, regardless of whether
    "!    they were extracted from corpora or grammars or were added or modified by the
    "!    user.
    "!   * `user` trains the model only on new words that were added or modified by the
    "!    user directly. The model is not trained on new words extracted from corpora or
    "!    grammars.
    "! @parameter I_customization_weight |
    "!   Specifies a customization weight for the custom language model. The
    "!    customization weight tells the service how much weight to give to words from
    "!    the custom language model compared to those from the base model for speech
    "!    recognition. Specify a value between 0.0 and 1.0; the default is 0.3.
    "!
    "!   The default value yields the best performance in general. Assign a higher value
    "!    if your audio makes frequent use of OOV words from the custom model. Use
    "!    caution when setting the weight: a higher value can improve the accuracy of
    "!    phrases from the custom model's domain, but it can negatively affect
    "!    performance on non-domain phrases.
    "!
    "!   The value that you assign is used for all recognition requests that use the
    "!    model. You can override it for any recognition request by specifying a
    "!    customization weight for that request.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_RESPONSE
    "!
  methods TRAIN_LANGUAGE_MODEL
    importing
      !I_customization_id type STRING
      !I_word_type_to_add type STRING default 'all'
      !I_customization_weight type DOUBLE optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Reset a custom language model.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "!
  methods RESET_LANGUAGE_MODEL
    importing
      !I_customization_id type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Upgrade a custom language model.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "!
  methods UPGRADE_LANGUAGE_MODEL
    importing
      !I_customization_id type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List corpora.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CORPORA
    "!
  methods LIST_CORPORA
    importing
      !I_customization_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CORPORA
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Add a corpus.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_corpus_name |
    "!   The name of the new corpus for the custom language model. Use a localized name
    "!    that matches the language of the custom model and reflects the contents of the
    "!    corpus.
    "!   * Include a maximum of 128 characters in the name.
    "!   * Do not use characters that need to be URL-encoded. For example, do not use
    "!    spaces, slashes, backslashes, colons, ampersands, double quotes, plus signs,
    "!    equals signs, questions marks, and so on in the name. (The service does not
    "!    prevent the use of these characters. But because they must be URL-encoded
    "!    wherever used, their use is strongly discouraged.)
    "!   * Do not use the name of an existing corpus or grammar that is already defined
    "!    for the custom model.
    "!   * Do not use the name `user`, which is reserved by the service to denote custom
    "!    words that are added or modified by the user.
    "!   * Do not use the name `base_lm` or `default_lm`. Both names are reserved for
    "!    future use by the service.
    "! @parameter I_corpus_file |
    "!   A plain text file that contains the training data for the corpus. Encode the
    "!    file in UTF-8 if it contains non-ASCII characters; the service assumes UTF-8
    "!    encoding if it encounters non-ASCII characters.
    "!
    "!   Make sure that you know the character encoding of the file. You must use that
    "!    encoding when working with the words in the custom language model. For more
    "!    information, see [Character
    "!    encoding](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-te
    "!   xt-corporaWords#charEncoding).
    "!
    "!   With the `curl` command, use the `--data-binary` option to upload the file for
    "!    the request.
    "! @parameter I_allow_overwrite |
    "!   If `true`, the specified corpus overwrites an existing corpus with the same
    "!    name. If `false`, the request fails if a corpus with the same name already
    "!    exists. The parameter has no effect if a corpus with the same name does not
    "!    already exist.
    "!
  methods ADD_CORPUS
    importing
      !I_customization_id type STRING
      !I_corpus_name type STRING
      !I_corpus_file type FILE
      !I_allow_overwrite type BOOLEAN default c_boolean_false
      !I_corpus_file_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get a corpus.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_corpus_name |
    "!   The name of the corpus for the custom language model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CORPUS
    "!
  methods GET_CORPUS
    importing
      !I_customization_id type STRING
      !I_corpus_name type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CORPUS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a corpus.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_corpus_name |
    "!   The name of the corpus for the custom language model.
    "!
  methods DELETE_CORPUS
    importing
      !I_customization_id type STRING
      !I_corpus_name type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List custom words.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_word_type |
    "!   The type of words to be listed from the custom language model's words resource:
    "!   * `all` (the default) shows all words.
    "!   * `user` shows only custom words that were added or modified by the user
    "!    directly.
    "!   * `corpora` shows only OOV that were extracted from corpora.
    "!   * `grammars` shows only OOV words that are recognized by grammars.
    "! @parameter I_sort |
    "!   Indicates the order in which the words are to be listed, `alphabetical` or by
    "!    `count`. You can prepend an optional `+` or `-` to an argument to indicate
    "!    whether the results are to be sorted in ascending or descending order. By
    "!    default, words are sorted in ascending alphabetical order. For alphabetical
    "!    ordering, the lexicographical precedence is numeric values, uppercase letters,
    "!    and lowercase letters. For count ordering, values with the same count are
    "!    ordered alphabetically. With the `curl` command, URL-encode the `+` symbol as
    "!    `%2B`.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_WORDS
    "!
  methods LIST_WORDS
    importing
      !I_customization_id type STRING
      !I_word_type type STRING default 'all'
      !I_sort type STRING default 'alphabetical'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_WORDS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Add custom words.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_custom_words |
    "!   A `CustomWords` object that provides information about one or more custom words
    "!    that are to be added to or updated in the custom language model.
    "!
  methods ADD_WORDS
    importing
      !I_customization_id type STRING
      !I_custom_words type T_CUSTOM_WORDS
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Add a custom word.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_word_name |
    "!   The custom word that is to be added to or updated in the custom language model.
    "!    Do not include spaces in the word. Use a `-` (dash) or `_` (underscore) to
    "!    connect the tokens of compound words. URL-encode the word if it includes
    "!    non-ASCII characters. For more information, see [Character
    "!    encoding](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-te
    "!   xt-corporaWords#charEncoding).
    "! @parameter I_custom_word |
    "!   A `CustomWord` object that provides information about the specified custom word.
    "!    Specify an empty object to add a word with no sounds-like or display-as
    "!    information.
    "!
  methods ADD_WORD
    importing
      !I_customization_id type STRING
      !I_word_name type STRING
      !I_custom_word type T_CUSTOM_WORD
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get a custom word.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_word_name |
    "!   The custom word that is to be read from the custom language model. URL-encode
    "!    the word if it includes non-ASCII characters. For more information, see
    "!    [Character
    "!    encoding](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-te
    "!   xt-corporaWords#charEncoding).
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_WORD
    "!
  methods GET_WORD
    importing
      !I_customization_id type STRING
      !I_word_name type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_WORD
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a custom word.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_word_name |
    "!   The custom word that is to be deleted from the custom language model. URL-encode
    "!    the word if it includes non-ASCII characters. For more information, see
    "!    [Character
    "!    encoding](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-te
    "!   xt-corporaWords#charEncoding).
    "!
  methods DELETE_WORD
    importing
      !I_customization_id type STRING
      !I_word_name type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List grammars.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_GRAMMARS
    "!
  methods LIST_GRAMMARS
    importing
      !I_customization_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_GRAMMARS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Add a grammar.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_grammar_name |
    "!   The name of the new grammar for the custom language model. Use a localized name
    "!    that matches the language of the custom model and reflects the contents of the
    "!    grammar.
    "!   * Include a maximum of 128 characters in the name.
    "!   * Do not use characters that need to be URL-encoded. For example, do not use
    "!    spaces, slashes, backslashes, colons, ampersands, double quotes, plus signs,
    "!    equals signs, questions marks, and so on in the name. (The service does not
    "!    prevent the use of these characters. But because they must be URL-encoded
    "!    wherever used, their use is strongly discouraged.)
    "!   * Do not use the name of an existing grammar or corpus that is already defined
    "!    for the custom model.
    "!   * Do not use the name `user`, which is reserved by the service to denote custom
    "!    words that are added or modified by the user.
    "!   * Do not use the name `base_lm` or `default_lm`. Both names are reserved for
    "!    future use by the service.
    "! @parameter I_grammar_file |
    "!   A plain text file that contains the grammar in the format specified by the
    "!    `Content-Type` header. Encode the file in UTF-8 (ASCII is a subset of UTF-8).
    "!    Using any other encoding can lead to issues when compiling the grammar or to
    "!    unexpected results in decoding. The service ignores an encoding that is
    "!    specified in the header of the grammar.
    "!
    "!   With the `curl` command, use the `--data-binary` option to upload the file for
    "!    the request.
    "! @parameter I_Content_Type |
    "!   The format (MIME type) of the grammar file:
    "!   * `application/srgs` for Augmented Backus-Naur Form (ABNF), which uses a
    "!    plain-text representation that is similar to traditional BNF grammars.
    "!   * `application/srgs+xml` for XML Form, which uses XML elements to represent the
    "!    grammar.
    "! @parameter I_allow_overwrite |
    "!   If `true`, the specified grammar overwrites an existing grammar with the same
    "!    name. If `false`, the request fails if a grammar with the same name already
    "!    exists. The parameter has no effect if a grammar with the same name does not
    "!    already exist.
    "!
  methods ADD_GRAMMAR
    importing
      !I_customization_id type STRING
      !I_grammar_name type STRING
      !I_grammar_file type STRING
      !I_Content_Type type STRING default 'application/srgs'
      !I_allow_overwrite type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get a grammar.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_grammar_name |
    "!   The name of the grammar for the custom language model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_GRAMMAR
    "!
  methods GET_GRAMMAR
    importing
      !I_customization_id type STRING
      !I_grammar_name type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_GRAMMAR
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a grammar.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_grammar_name |
    "!   The name of the grammar for the custom language model.
    "!
  methods DELETE_GRAMMAR
    importing
      !I_customization_id type STRING
      !I_grammar_name type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Create a custom acoustic model.
    "!
    "! @parameter I_create_acoustic_model |
    "!   A `CreateAcousticModel` object that provides basic information about the new
    "!    custom acoustic model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ACOUSTIC_MODEL
    "!
  methods CREATE_ACOUSTIC_MODEL
    importing
      !I_create_acoustic_model type T_CREATE_ACOUSTIC_MODEL
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ACOUSTIC_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! List custom acoustic models.
    "!
    "! @parameter I_language |
    "!   The identifier of the language for which custom language or custom acoustic
    "!    models are to be returned (for example, `en-US`). Omit the parameter to see all
    "!    custom language or custom acoustic models that are owned by the requesting
    "!    credentials.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ACOUSTIC_MODELS
    "!
  methods LIST_ACOUSTIC_MODELS
    importing
      !I_language type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ACOUSTIC_MODELS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get a custom acoustic model.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom acoustic model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ACOUSTIC_MODEL
    "!
  methods GET_ACOUSTIC_MODEL
    importing
      !I_customization_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ACOUSTIC_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a custom acoustic model.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom acoustic model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "!
  methods DELETE_ACOUSTIC_MODEL
    importing
      !I_customization_id type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Train a custom acoustic model.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom acoustic model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_custom_language_model_id |
    "!   The customization ID (GUID) of a custom language model that is to be used during
    "!    training of the custom acoustic model. Specify a custom language model that has
    "!    been trained with verbatim transcriptions of the audio resources or that
    "!    contains words that are relevant to the contents of the audio resources. The
    "!    custom language model must be based on the same version of the same base model
    "!    as the custom acoustic model. The credentials specified with the request must
    "!    own both custom models.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_RESPONSE
    "!
  methods TRAIN_ACOUSTIC_MODEL
    importing
      !I_customization_id type STRING
      !I_custom_language_model_id type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Reset a custom acoustic model.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom acoustic model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "!
  methods RESET_ACOUSTIC_MODEL
    importing
      !I_customization_id type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Upgrade a custom acoustic model.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom acoustic model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_custom_language_model_id |
    "!   If the custom acoustic model was trained with a custom language model, the
    "!    customization ID (GUID) of that custom language model. The custom language
    "!    model must be upgraded before the custom acoustic model can be upgraded. The
    "!    credentials specified with the request must own both custom models.
    "! @parameter I_force |
    "!   If `true`, forces the upgrade of a custom acoustic model for which no input data
    "!    has been modified since it was last trained. Use this parameter only to force
    "!    the upgrade of a custom acoustic model that is trained with a custom language
    "!    model, and only if you receive a 400 response code and the message `No input
    "!    data modified since last training`. See [Upgrading a custom acoustic
    "!    model](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text-
    "!   customUpgrade#upgradeAcoustic).
    "!
  methods UPGRADE_ACOUSTIC_MODEL
    importing
      !I_customization_id type STRING
      !I_custom_language_model_id type STRING optional
      !I_force type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List audio resources.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom acoustic model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_AUDIO_RESOURCES
    "!
  methods LIST_AUDIO
    importing
      !I_customization_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_AUDIO_RESOURCES
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Add an audio resource.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom acoustic model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_audio_name |
    "!   The name of the new audio resource for the custom acoustic model. Use a
    "!    localized name that matches the language of the custom model and reflects the
    "!    contents of the resource.
    "!   * Include a maximum of 128 characters in the name.
    "!   * Do not use characters that need to be URL-encoded. For example, do not use
    "!    spaces, slashes, backslashes, colons, ampersands, double quotes, plus signs,
    "!    equals signs, questions marks, and so on in the name. (The service does not
    "!    prevent the use of these characters. But because they must be URL-encoded
    "!    wherever used, their use is strongly discouraged.)
    "!   * Do not use the name of an audio resource that has already been added to the
    "!    custom model.
    "! @parameter I_audio_resource |
    "!   The audio resource that is to be added to the custom acoustic model, an
    "!    individual audio file or an archive file.
    "!
    "!   With the `curl` command, use the `--data-binary` option to upload the file for
    "!    the request.
    "! @parameter I_Content_Type |
    "!   For an audio-type resource, the format (MIME type) of the audio. For more
    "!    information, see **Content types for audio-type resources** in the method
    "!    description.
    "!
    "!   For an archive-type resource, the media type of the archive file. For more
    "!    information, see **Content types for archive-type resources** in the method
    "!    description.
    "! @parameter I_Contained_Content_Type |
    "!   **For an archive-type resource,** specify the format of the audio files that are
    "!   ** contained in the archive file if they are of type `audio/alaw`, `audio/basic`,
    "!   ** `audio/l16`, or `audio/mulaw`. Include the `rate`, `channels`, and `endianness`
    "!   ** parameters where necessary. In this case, all audio files that are contained in
    "!   ** the archive file must be of the indicated type.
    "!   **
    "!   **For all other audio formats, you can omit the header. In this case, the audio
    "!   ** files can be of multiple types as long as they are not of the types listed in
    "!   ** the previous paragraph.
    "!   **
    "!   **The parameter accepts all of the audio formats that are supported for use with
    "!   ** speech recognition. For more information, see **Content types for audio-type
    "!   ** resources** in the method description.
    "!   **
    "!   ****For an audio-type resource,** omit the header.
    "! @parameter I_allow_overwrite |
    "!   If `true`, the specified audio resource overwrites an existing audio resource
    "!    with the same name. If `false`, the request fails if an audio resource with the
    "!    same name already exists. The parameter has no effect if an audio resource with
    "!    the same name does not already exist.
    "!
  methods ADD_AUDIO
    importing
      !I_customization_id type STRING
      !I_audio_name type STRING
      !I_audio_resource type FILE
      !I_Content_Type type STRING default 'application/zip'
      !I_Contained_Content_Type type STRING optional
      !I_allow_overwrite type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get an audio resource.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom acoustic model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_audio_name |
    "!   The name of the audio resource for the custom acoustic model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_AUDIO_LISTING
    "!
  methods GET_AUDIO
    importing
      !I_customization_id type STRING
      !I_audio_name type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_AUDIO_LISTING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete an audio resource.
    "!
    "! @parameter I_customization_id |
    "!   The customization ID (GUID) of the custom acoustic model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_audio_name |
    "!   The name of the audio resource for the custom acoustic model.
    "!
  methods DELETE_AUDIO
    importing
      !I_customization_id type STRING
      !I_audio_name type STRING
      !I_accept      type string default 'application/json'
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
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .


protected section.

private section.

  methods SET_DEFAULT_QUERY_PARAMETERS
    changing
      !C_URL type TS_URL .

ENDCLASS.

class ZCL_IBMC_SPEECH_TO_TEXT_V1 IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->GET_APPNAME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_APPNAME                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method GET_APPNAME.

    e_appname = 'Speech to Text'.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method ZCL_IBMC_SPEECH_TO_TEXT_V1->GET_REQUEST_PROP
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
  e_request_prop-url-path_base   = '/speech-to-text/api'.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20191002122849'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->LIST_MODELS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_SPEECH_MODELS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_MODELS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/models'.

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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->GET_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_model_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_SPEECH_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/models/{model_id}'.
    replace all occurrences of `{model_id}` in ls_request_prop-url-path with i_model_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->RECOGNIZE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_audio        TYPE FILE
* | [--->] I_Content_Type        TYPE STRING (default ='application/octet-stream')
* | [--->] I_model        TYPE STRING (default ='en-US_BroadbandModel')
* | [--->] I_language_customization_id        TYPE STRING(optional)
* | [--->] I_acoustic_customization_id        TYPE STRING(optional)
* | [--->] I_base_model_version        TYPE STRING(optional)
* | [--->] I_customization_weight        TYPE DOUBLE(optional)
* | [--->] I_inactivity_timeout        TYPE INTEGER(optional)
* | [--->] I_keywords        TYPE TT_STRING(optional)
* | [--->] I_keywords_threshold        TYPE FLOAT(optional)
* | [--->] I_max_alternatives        TYPE INTEGER(optional)
* | [--->] I_word_alternatives_threshold        TYPE FLOAT(optional)
* | [--->] I_word_confidence        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_timestamps        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_profanity_filter        TYPE BOOLEAN (default =c_boolean_true)
* | [--->] I_smart_formatting        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_speaker_labels        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_customization_id        TYPE STRING(optional)
* | [--->] I_grammar_name        TYPE STRING(optional)
* | [--->] I_redaction        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_audio_metrics        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_SPEECH_RECOGNITION_RESULTS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method RECOGNIZE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/recognize'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_model is supplied.
    lv_queryparam = escape( val = i_model format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `model`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_language_customization_id is supplied.
    lv_queryparam = escape( val = i_language_customization_id format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `language_customization_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_acoustic_customization_id is supplied.
    lv_queryparam = escape( val = i_acoustic_customization_id format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `acoustic_customization_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_base_model_version is supplied.
    lv_queryparam = escape( val = i_base_model_version format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `base_model_version`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_customization_weight is supplied.
    lv_queryparam = i_customization_weight.
    add_query_parameter(
      exporting
        i_parameter  = `customization_weight`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_inactivity_timeout is supplied.
    lv_queryparam = i_inactivity_timeout.
    add_query_parameter(
      exporting
        i_parameter  = `inactivity_timeout`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_keywords is supplied.
    data:
      lv_item_keywords type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_keywords into lv_item_keywords.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_keywords.
      lv_sep = ','.
    endloop.
    lv_queryparam = escape( val = lv_queryparam format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `keywords`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_keywords_threshold is supplied.
    lv_queryparam = i_keywords_threshold.
    add_query_parameter(
      exporting
        i_parameter  = `keywords_threshold`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_max_alternatives is supplied.
    lv_queryparam = i_max_alternatives.
    add_query_parameter(
      exporting
        i_parameter  = `max_alternatives`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_word_alternatives_threshold is supplied.
    lv_queryparam = i_word_alternatives_threshold.
    add_query_parameter(
      exporting
        i_parameter  = `word_alternatives_threshold`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_word_confidence is supplied.
    lv_queryparam = i_word_confidence.
    add_query_parameter(
      exporting
        i_parameter  = `word_confidence`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_timestamps is supplied.
    lv_queryparam = i_timestamps.
    add_query_parameter(
      exporting
        i_parameter  = `timestamps`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_profanity_filter is supplied.
    lv_queryparam = i_profanity_filter.
    add_query_parameter(
      exporting
        i_parameter  = `profanity_filter`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_smart_formatting is supplied.
    lv_queryparam = i_smart_formatting.
    add_query_parameter(
      exporting
        i_parameter  = `smart_formatting`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_speaker_labels is supplied.
    lv_queryparam = i_speaker_labels.
    add_query_parameter(
      exporting
        i_parameter  = `speaker_labels`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_customization_id is supplied.
    lv_queryparam = escape( val = i_customization_id format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `customization_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_grammar_name is supplied.
    lv_queryparam = escape( val = i_grammar_name format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `grammar_name`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_redaction is supplied.
    lv_queryparam = i_redaction.
    add_query_parameter(
      exporting
        i_parameter  = `redaction`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_audio_metrics is supplied.
    lv_queryparam = i_audio_metrics.
    add_query_parameter(
      exporting
        i_parameter  = `audio_metrics`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    " process header parameters
    data:
      lv_headerparam type string  ##NEEDED.

    if i_Content_Type is supplied.
    ls_request_prop-header_content_type = I_Content_Type.
    endif.



    " process body parameters
    ls_request_prop-body_bin = i_audio.

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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->REGISTER_CALLBACK
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_callback_url        TYPE STRING
* | [--->] I_user_secret        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_REGISTER_STATUS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method REGISTER_CALLBACK.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/register_callback'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    lv_queryparam = escape( val = i_callback_url format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `callback_url`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.

    if i_user_secret is supplied.
    lv_queryparam = escape( val = i_user_secret format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `user_secret`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->UNREGISTER_CALLBACK
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_callback_url        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UNREGISTER_CALLBACK.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/unregister_callback'.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    lv_queryparam = escape( val = i_callback_url format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `callback_url`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.






    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->CREATE_JOB
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_audio        TYPE FILE
* | [--->] I_Content_Type        TYPE STRING (default ='application/octet-stream')
* | [--->] I_model        TYPE STRING (default ='en-US_BroadbandModel')
* | [--->] I_callback_url        TYPE STRING(optional)
* | [--->] I_events        TYPE STRING(optional)
* | [--->] I_user_token        TYPE STRING(optional)
* | [--->] I_results_ttl        TYPE INTEGER(optional)
* | [--->] I_language_customization_id        TYPE STRING(optional)
* | [--->] I_acoustic_customization_id        TYPE STRING(optional)
* | [--->] I_base_model_version        TYPE STRING(optional)
* | [--->] I_customization_weight        TYPE DOUBLE(optional)
* | [--->] I_inactivity_timeout        TYPE INTEGER(optional)
* | [--->] I_keywords        TYPE TT_STRING(optional)
* | [--->] I_keywords_threshold        TYPE FLOAT(optional)
* | [--->] I_max_alternatives        TYPE INTEGER(optional)
* | [--->] I_word_alternatives_threshold        TYPE FLOAT(optional)
* | [--->] I_word_confidence        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_timestamps        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_profanity_filter        TYPE BOOLEAN (default =c_boolean_true)
* | [--->] I_smart_formatting        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_speaker_labels        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_customization_id        TYPE STRING(optional)
* | [--->] I_grammar_name        TYPE STRING(optional)
* | [--->] I_redaction        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_processing_metrics        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_processing_metrics_interval        TYPE FLOAT(optional)
* | [--->] I_audio_metrics        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_RECOGNITION_JOB
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_JOB.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/recognitions'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_model is supplied.
    lv_queryparam = escape( val = i_model format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `model`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_callback_url is supplied.
    lv_queryparam = escape( val = i_callback_url format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `callback_url`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_events is supplied.
    lv_queryparam = escape( val = i_events format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `events`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_user_token is supplied.
    lv_queryparam = escape( val = i_user_token format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `user_token`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_results_ttl is supplied.
    lv_queryparam = i_results_ttl.
    add_query_parameter(
      exporting
        i_parameter  = `results_ttl`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_language_customization_id is supplied.
    lv_queryparam = escape( val = i_language_customization_id format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `language_customization_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_acoustic_customization_id is supplied.
    lv_queryparam = escape( val = i_acoustic_customization_id format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `acoustic_customization_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_base_model_version is supplied.
    lv_queryparam = escape( val = i_base_model_version format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `base_model_version`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_customization_weight is supplied.
    lv_queryparam = i_customization_weight.
    add_query_parameter(
      exporting
        i_parameter  = `customization_weight`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_inactivity_timeout is supplied.
    lv_queryparam = i_inactivity_timeout.
    add_query_parameter(
      exporting
        i_parameter  = `inactivity_timeout`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_keywords is supplied.
    data:
      lv_item_keywords type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_keywords into lv_item_keywords.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_keywords.
      lv_sep = ','.
    endloop.
    lv_queryparam = escape( val = lv_queryparam format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `keywords`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_keywords_threshold is supplied.
    lv_queryparam = i_keywords_threshold.
    add_query_parameter(
      exporting
        i_parameter  = `keywords_threshold`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_max_alternatives is supplied.
    lv_queryparam = i_max_alternatives.
    add_query_parameter(
      exporting
        i_parameter  = `max_alternatives`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_word_alternatives_threshold is supplied.
    lv_queryparam = i_word_alternatives_threshold.
    add_query_parameter(
      exporting
        i_parameter  = `word_alternatives_threshold`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_word_confidence is supplied.
    lv_queryparam = i_word_confidence.
    add_query_parameter(
      exporting
        i_parameter  = `word_confidence`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_timestamps is supplied.
    lv_queryparam = i_timestamps.
    add_query_parameter(
      exporting
        i_parameter  = `timestamps`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_profanity_filter is supplied.
    lv_queryparam = i_profanity_filter.
    add_query_parameter(
      exporting
        i_parameter  = `profanity_filter`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_smart_formatting is supplied.
    lv_queryparam = i_smart_formatting.
    add_query_parameter(
      exporting
        i_parameter  = `smart_formatting`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_speaker_labels is supplied.
    lv_queryparam = i_speaker_labels.
    add_query_parameter(
      exporting
        i_parameter  = `speaker_labels`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_customization_id is supplied.
    lv_queryparam = escape( val = i_customization_id format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `customization_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_grammar_name is supplied.
    lv_queryparam = escape( val = i_grammar_name format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `grammar_name`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_redaction is supplied.
    lv_queryparam = i_redaction.
    add_query_parameter(
      exporting
        i_parameter  = `redaction`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_processing_metrics is supplied.
    lv_queryparam = i_processing_metrics.
    add_query_parameter(
      exporting
        i_parameter  = `processing_metrics`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_processing_metrics_interval is supplied.
    lv_queryparam = i_processing_metrics_interval.
    add_query_parameter(
      exporting
        i_parameter  = `processing_metrics_interval`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_audio_metrics is supplied.
    lv_queryparam = i_audio_metrics.
    add_query_parameter(
      exporting
        i_parameter  = `audio_metrics`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    " process header parameters
    data:
      lv_headerparam type string  ##NEEDED.

    if i_Content_Type is supplied.
    ls_request_prop-header_content_type = I_Content_Type.
    endif.



    " process body parameters
    ls_request_prop-body_bin = i_audio.

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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->CHECK_JOBS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_RECOGNITION_JOBS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CHECK_JOBS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/recognitions'.

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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->CHECK_JOB
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_RECOGNITION_JOB
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CHECK_JOB.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/recognitions/{id}'.
    replace all occurrences of `{id}` in ls_request_prop-url-path with i_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->DELETE_JOB
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_id        TYPE STRING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_JOB.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/recognitions/{id}'.
    replace all occurrences of `{id}` in ls_request_prop-url-path with i_id ignoring case.

    " standard headers
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->CREATE_LANGUAGE_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_create_language_model        TYPE T_CREATE_LANGUAGE_MODEL
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_LANGUAGE_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_LANGUAGE_MODEL.

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
    lv_datatype = get_datatype( i_create_language_model ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_create_language_model i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'create_language_model' i_value = i_create_language_model ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_create_language_model to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->LIST_LANGUAGE_MODELS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_language        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_LANGUAGE_MODELS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_LANGUAGE_MODELS.

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

    if i_language is supplied.
    lv_queryparam = escape( val = i_language format = cl_abap_format=>e_uri_full ).
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->GET_LANGUAGE_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_LANGUAGE_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_LANGUAGE_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->DELETE_LANGUAGE_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_LANGUAGE_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->TRAIN_LANGUAGE_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_word_type_to_add        TYPE STRING (default ='all')
* | [--->] I_customization_weight        TYPE DOUBLE(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRAINING_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method TRAIN_LANGUAGE_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/train'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_word_type_to_add is supplied.
    lv_queryparam = escape( val = i_word_type_to_add format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `word_type_to_add`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_customization_weight is supplied.
    lv_queryparam = i_customization_weight.
    add_query_parameter(
      exporting
        i_parameter  = `customization_weight`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->RESET_LANGUAGE_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method RESET_LANGUAGE_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/reset'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->UPGRADE_LANGUAGE_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPGRADE_LANGUAGE_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/upgrade_model'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->LIST_CORPORA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CORPORA
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_CORPORA.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/corpora'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->ADD_CORPUS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_corpus_name        TYPE STRING
* | [--->] I_corpus_file        TYPE FILE
* | [--->] I_allow_overwrite        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_corpus_file_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method ADD_CORPUS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/corpora/{corpus_name}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.
    replace all occurrences of `{corpus_name}` in ls_request_prop-url-path with i_corpus_name ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_allow_overwrite is supplied.
    lv_queryparam = i_allow_overwrite.
    add_query_parameter(
      exporting
        i_parameter  = `allow_overwrite`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.



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




    if not i_corpus_file is initial.
      lv_extension = get_file_extension( I_corpus_file_CT ).
      lv_value = `form-data; name="corpus_file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_corpus_file_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_corpus_file.
      append ls_form_part to lt_form_part.
    endif.


    " execute HTTP POST request
    lo_response = HTTP_POST_MULTIPART( i_request_prop = ls_request_prop it_form_part = lt_form_part ).





endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->GET_CORPUS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_corpus_name        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CORPUS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_CORPUS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/corpora/{corpus_name}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.
    replace all occurrences of `{corpus_name}` in ls_request_prop-url-path with i_corpus_name ignoring case.

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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->DELETE_CORPUS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_corpus_name        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_CORPUS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/corpora/{corpus_name}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.
    replace all occurrences of `{corpus_name}` in ls_request_prop-url-path with i_corpus_name ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->LIST_WORDS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_word_type        TYPE STRING (default ='all')
* | [--->] I_sort        TYPE STRING (default ='alphabetical')
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_word_type is supplied.
    lv_queryparam = escape( val = i_word_type format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `word_type`
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->ADD_WORDS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_custom_words        TYPE T_CUSTOM_WORDS
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.

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
    lv_datatype = get_datatype( i_custom_words ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_custom_words i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'custom_words' i_value = i_custom_words ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_custom_words to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->ADD_WORD
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_word_name        TYPE STRING
* | [--->] I_custom_word        TYPE T_CUSTOM_WORD
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method ADD_WORD.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/words/{word_name}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.
    replace all occurrences of `{word_name}` in ls_request_prop-url-path with i_word_name ignoring case.

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
    lv_datatype = get_datatype( i_custom_word ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_custom_word i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'custom_word' i_value = i_custom_word ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_custom_word to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->GET_WORD
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_word_name        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_WORD
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_WORD.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/words/{word_name}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.
    replace all occurrences of `{word_name}` in ls_request_prop-url-path with i_word_name ignoring case.

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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->DELETE_WORD
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_word_name        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_WORD.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/words/{word_name}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.
    replace all occurrences of `{word_name}` in ls_request_prop-url-path with i_word_name ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->LIST_GRAMMARS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_GRAMMARS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_GRAMMARS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/grammars'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->ADD_GRAMMAR
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_grammar_name        TYPE STRING
* | [--->] I_grammar_file        TYPE STRING
* | [--->] I_Content_Type        TYPE STRING (default ='application/srgs')
* | [--->] I_allow_overwrite        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method ADD_GRAMMAR.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/grammars/{grammar_name}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.
    replace all occurrences of `{grammar_name}` in ls_request_prop-url-path with i_grammar_name ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_allow_overwrite is supplied.
    lv_queryparam = i_allow_overwrite.
    add_query_parameter(
      exporting
        i_parameter  = `allow_overwrite`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    " process header parameters
    data:
      lv_headerparam type string  ##NEEDED.

    ls_request_prop-header_content_type = I_Content_Type.



    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_grammar_file ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_grammar_file i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'grammar_file' i_value = i_grammar_file ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_grammar_file to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->GET_GRAMMAR
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_grammar_name        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_GRAMMAR
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_GRAMMAR.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/grammars/{grammar_name}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.
    replace all occurrences of `{grammar_name}` in ls_request_prop-url-path with i_grammar_name ignoring case.

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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->DELETE_GRAMMAR
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_grammar_name        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_GRAMMAR.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/customizations/{customization_id}/grammars/{grammar_name}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.
    replace all occurrences of `{grammar_name}` in ls_request_prop-url-path with i_grammar_name ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->CREATE_ACOUSTIC_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_create_acoustic_model        TYPE T_CREATE_ACOUSTIC_MODEL
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ACOUSTIC_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_ACOUSTIC_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/acoustic_customizations'.

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
    lv_datatype = get_datatype( i_create_acoustic_model ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_create_acoustic_model i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'create_acoustic_model' i_value = i_create_acoustic_model ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_create_acoustic_model to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->LIST_ACOUSTIC_MODELS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_language        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ACOUSTIC_MODELS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_ACOUSTIC_MODELS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/acoustic_customizations'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_language is supplied.
    lv_queryparam = escape( val = i_language format = cl_abap_format=>e_uri_full ).
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->GET_ACOUSTIC_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ACOUSTIC_MODEL
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_ACOUSTIC_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/acoustic_customizations/{customization_id}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->DELETE_ACOUSTIC_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_ACOUSTIC_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/acoustic_customizations/{customization_id}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->TRAIN_ACOUSTIC_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_custom_language_model_id        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRAINING_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method TRAIN_ACOUSTIC_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/acoustic_customizations/{customization_id}/train'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_custom_language_model_id is supplied.
    lv_queryparam = escape( val = i_custom_language_model_id format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `custom_language_model_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->RESET_ACOUSTIC_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method RESET_ACOUSTIC_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/acoustic_customizations/{customization_id}/reset'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->UPGRADE_ACOUSTIC_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_custom_language_model_id        TYPE STRING(optional)
* | [--->] I_force        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPGRADE_ACOUSTIC_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/acoustic_customizations/{customization_id}/upgrade_model'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_custom_language_model_id is supplied.
    lv_queryparam = escape( val = i_custom_language_model_id format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `custom_language_model_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_force is supplied.
    lv_queryparam = i_force.
    add_query_parameter(
      exporting
        i_parameter  = `force`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->LIST_AUDIO
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_AUDIO_RESOURCES
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_AUDIO.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/acoustic_customizations/{customization_id}/audio'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.

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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->ADD_AUDIO
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_audio_name        TYPE STRING
* | [--->] I_audio_resource        TYPE FILE
* | [--->] I_Content_Type        TYPE STRING (default ='application/zip')
* | [--->] I_Contained_Content_Type        TYPE STRING(optional)
* | [--->] I_allow_overwrite        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method ADD_AUDIO.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/acoustic_customizations/{customization_id}/audio/{audio_name}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.
    replace all occurrences of `{audio_name}` in ls_request_prop-url-path with i_audio_name ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_allow_overwrite is supplied.
    lv_queryparam = i_allow_overwrite.
    add_query_parameter(
      exporting
        i_parameter  = `allow_overwrite`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    " process header parameters
    data:
      lv_headerparam type string  ##NEEDED.

    if i_Content_Type is supplied.
    ls_request_prop-header_content_type = I_Content_Type.
    endif.

    if i_Contained_Content_Type is supplied.
    lv_headerparam = I_Contained_Content_Type.
    add_header_parameter(
      exporting
        i_parameter  = 'Contained-Content-Type'
        i_value      = lv_headerparam
      changing
        c_headers    = ls_request_prop-headers )  ##NO_TEXT.
    endif.



    " process body parameters
    ls_request_prop-body_bin = i_audio_resource.

    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->GET_AUDIO
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_audio_name        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_AUDIO_LISTING
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_AUDIO.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/acoustic_customizations/{customization_id}/audio/{audio_name}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.
    replace all occurrences of `{audio_name}` in ls_request_prop-url-path with i_audio_name ignoring case.

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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->DELETE_AUDIO
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customization_id        TYPE STRING
* | [--->] I_audio_name        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_AUDIO.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v1/acoustic_customizations/{customization_id}/audio/{audio_name}'.
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_customization_id ignoring case.
    replace all occurrences of `{audio_name}` in ls_request_prop-url-path with i_audio_name ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->DELETE_USER_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customer_id        TYPE STRING
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
* | Instance Private Method ZCL_IBMC_SPEECH_TO_TEXT_V1->SET_DEFAULT_QUERY_PARAMETERS
* +-------------------------------------------------------------------------------------------------+
* | [<-->] C_URL                          TYPE        TS_URL
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method set_default_query_parameters.
  endmethod.

ENDCLASS.
