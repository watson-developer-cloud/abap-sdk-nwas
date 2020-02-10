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
"! <h1>Speech to Text</h1>
"! The IBM&reg; Speech to Text service provides APIs that use IBM's
"!  speech-recognition capabilities to produce transcripts of spoken audio. The
"!  service can transcribe speech from various languages and audio formats. In
"!  addition to basic transcription, the service can produce detailed information
"!  about many different aspects of the audio. For most languages, the service
"!  supports two sampling rates, broadband and narrowband. It returns all JSON
"!  response content in the UTF-8 character set. <br/>
"! <br/>
"! For speech recognition, the service supports synchronous and asynchronous HTTP
"!  Representational State Transfer (REST) interfaces. It also supports a WebSocket
"!  interface that provides a full-duplex, low-latency communication channel:
"!  Clients send requests and audio to the service and receive results over a
"!  single connection asynchronously. <br/>
"! <br/>
"! The service also offers two customization interfaces. Use language model
"!  customization to expand the vocabulary of a base model with domain-specific
"!  terminology. Use acoustic model customization to adapt a base model for the
"!  acoustic characteristics of your audio. For language model customization, the
"!  service also supports grammars. A grammar is a formal language specification
"!  that lets you restrict the phrases that the service can recognize. <br/>
"! <br/>
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
      "!   An identifier for the type of invalid resources listed in the `description`
      "!    field.
      CODE type STRING,
      "!   A warning message that lists the invalid resources that are excluded from the
      "!    custom model's training. The message has the following format: `Analysis of the
      "!    following &#123;resource_type&#125; has not completed successfully:
      "!    [&#123;resource_names&#125;]. They will be excluded from custom
      "!    &#123;model_type&#125; model training.`.
      MESSAGE type STRING,
    end of T_TRAINING_WARNING.
  types:
    "!   The response from training of a custom language or custom acoustic model.
    begin of T_TRAINING_RESPONSE,
      "!   An array of `TrainingWarning` objects that lists any invalid resources contained
      "!    in the custom model. For custom language models, invalid resources are grouped
      "!    and identified by type of resource. The method can return warnings only if the
      "!    `strict` parameter is set to `false`.
      WARNINGS type STANDARD TABLE OF T_TRAINING_WARNING WITH NON-UNIQUE DEFAULT KEY,
    end of T_TRAINING_RESPONSE.
  types:
    "!   An alternative hypothesis for a word from speech recognition results.
    begin of T_WORD_ALTERNATIVE_RESULT,
      "!   A confidence score for the word alternative hypothesis in the range of 0.0 to
      "!    1.0.
      CONFIDENCE type DOUBLE,
      "!   An alternative hypothesis for a word from the input audio.
      WORD type STRING,
    end of T_WORD_ALTERNATIVE_RESULT.
  types:
    "!   Information about alternative hypotheses for words from speech recognition
    "!    results.
    begin of T_WORD_ALTERNATIVE_RESULTS,
      "!   The start time in seconds of the word from the input audio that corresponds to
      "!    the word alternatives.
      START_TIME type DOUBLE,
      "!   The end time in seconds of the word from the input audio that corresponds to the
      "!    word alternatives.
      END_TIME type DOUBLE,
      "!   An array of alternative hypotheses for a word from the input audio.
      ALTERNATIVES type STANDARD TABLE OF T_WORD_ALTERNATIVE_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_WORD_ALTERNATIVE_RESULTS.
  types:
    "!   A bin with defined boundaries that indicates the number of values in a range of
    "!    signal characteristics for a histogram. The first and last bins of a histogram
    "!    are the boundary bins. They cover the intervals between negative infinity and
    "!    the first boundary, and between the last boundary and positive infinity,
    "!    respectively.
    begin of T_AUDIO_METRICS_HISTOGRAM_BIN,
      "!   The lower boundary of the bin in the histogram.
      BEGIN type FLOAT,
      "!   The upper boundary of the bin in the histogram.
      END type FLOAT,
      "!   The number of values in the bin of the histogram.
      COUNT type INTEGER,
    end of T_AUDIO_METRICS_HISTOGRAM_BIN.
  types:
    "!   Information about the speakers from speech recognition results.
    begin of T_SPEAKER_LABELS_RESULT,
      "!   The start time of a word from the transcript. The value matches the start time
      "!    of a word from the `timestamps` array.
      FROM type FLOAT,
      "!   The end time of a word from the transcript. The value matches the end time of a
      "!    word from the `timestamps` array.
      TO type FLOAT,
      "!   The numeric identifier that the service assigns to a speaker from the audio.
      "!    Speaker IDs begin at `0` initially but can evolve and change across interim
      "!    results (if supported by the method) and between interim and final results as
      "!    the service processes the audio. They are not guaranteed to be sequential,
      "!    contiguous, or ordered.
      SPEAKER type INTEGER,
      "!   A score that indicates the service's confidence in its identification of the
      "!    speaker in the range of 0.0 to 1.0.
      CONFIDENCE type FLOAT,
      "!   An indication of whether the service might further change word and speaker-label
      "!    results. A value of `true` means that the service guarantees not to send any
      "!    further updates for the current or any preceding results; `false` means that
      "!    the service might send further updates to the results.
      FINAL type BOOLEAN,
    end of T_SPEAKER_LABELS_RESULT.
  types:
    "!   An alternative transcript from speech recognition results.
    begin of T_SPCH_RECOGNITION_ALTERNATIVE,
      "!   A transcription of the audio.
      TRANSCRIPT type STRING,
      "!   A score that indicates the service's confidence in the transcript in the range
      "!    of 0.0 to 1.0. A confidence score is returned only for the best alternative and
      "!    only with results marked as final.
      CONFIDENCE type DOUBLE,
      "!   Time alignments for each word from the transcript as a list of lists. Each inner
      "!    list consists of three elements: the word followed by its start and end time in
      "!    seconds, for example: `[["hello",0.0,1.2],["world",1.2,2.5]]`. Timestamps are
      "!    returned only for the best alternative.
      TIMESTAMPS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   A confidence score for each word of the transcript as a list of lists. Each
      "!    inner list consists of two elements: the word and its confidence score in the
      "!    range of 0.0 to 1.0, for example: `[["hello",0.95],["world",0.866]]`.
      "!    Confidence scores are returned only for the best alternative and only with
      "!    results marked as final.
      WORD_CONFIDENCE type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_SPCH_RECOGNITION_ALTERNATIVE.
  types:
    "!   Detailed timing information about the service's processing of the input audio.
    begin of T_PROCESSED_AUDIO,
      "!   The seconds of audio that the service has received as of this response. The
      "!    value of the field is greater than the values of the `transcription` and
      "!    `speaker_labels` fields during speech recognition processing, since the service
      "!    first has to receive the audio before it can begin to process it. The final
      "!    value can also be greater than the value of the `transcription` and
      "!    `speaker_labels` fields by a fractional number of seconds.
      RECEIVED type FLOAT,
      "!   The seconds of audio that the service has passed to its speech-processing engine
      "!    as of this response. The value of the field is greater than the values of the
      "!    `transcription` and `speaker_labels` fields during speech recognition
      "!    processing. The `received` and `seen_by_engine` fields have identical values
      "!    when the service has finished processing all audio. This final value can be
      "!    greater than the value of the `transcription` and `speaker_labels` fields by a
      "!    fractional number of seconds.
      SEEN_BY_ENGINE type FLOAT,
      "!   The seconds of audio that the service has processed for speech recognition as of
      "!    this response.
      TRANSCRIPTION type FLOAT,
      "!   If speaker labels are requested, the seconds of audio that the service has
      "!    processed to determine speaker labels as of this response. This value often
      "!    trails the value of the `transcription` field during speech recognition
      "!    processing. The `transcription` and `speaker_labels` fields have identical
      "!    values when the service has finished processing all audio.
      SPEAKER_LABELS type FLOAT,
    end of T_PROCESSED_AUDIO.
  types:
    "!   If processing metrics are requested, information about the service's processing
    "!    of the input audio. Processing metrics are not available with the synchronous
    "!    **Recognize audio** method.
    begin of T_PROCESSING_METRICS,
      "!   Detailed timing information about the service's processing of the input audio.
      PROCESSED_AUDIO type T_PROCESSED_AUDIO,
      "!   The amount of real time in seconds that has passed since the service received
      "!    the first byte of input audio. Values in this field are generally multiples of
      "!    the specified metrics interval, with two differences:<br/>
      "!   * Values might not reflect exact intervals (for instance, 0.25, 0.5, and so on).
      "!    Actual values might be 0.27, 0.52, and so on, depending on when the service
      "!    receives and processes audio.<br/>
      "!   * The service also returns values for transcription events if you set the
      "!    `interim_results` parameter to `true`. The service returns both processing
      "!    metrics and transcription results when such events occur.
      WLL_CLCK_SNC_FRST_BYT_RECEIVED type FLOAT,
      "!   An indication of whether the metrics apply to a periodic interval or a
      "!    transcription event:<br/>
      "!   * `true` means that the response was triggered by a specified processing
      "!    interval. The information contains processing metrics only.<br/>
      "!   * `false` means that the response was triggered by a transcription event. The
      "!    information contains processing metrics plus transcription results. <br/>
      "!   <br/>
      "!   Use the field to identify why the service generated the response and to filter
      "!    different results if necessary.
      PERIODIC type BOOLEAN,
    end of T_PROCESSING_METRICS.
  types:
    "!   Detailed information about the signal characteristics of the input audio.
    begin of T_AUDIO_METRICS_DETAILS,
      "!   If `true`, indicates the end of the audio stream, meaning that transcription is
      "!    complete. Currently, the field is always `true`. The service returns metrics
      "!    just once per audio stream. The results provide aggregated audio metrics that
      "!    pertain to the complete audio stream.
      FINAL type BOOLEAN,
      "!   The end time in seconds of the block of audio to which the metrics apply.
      END_TIME type FLOAT,
      "!   The signal-to-noise ratio (SNR) for the audio signal. The value indicates the
      "!    ratio of speech to noise in the audio. A valid value lies in the range of 0 to
      "!    100 decibels (dB). The service omits the field if it cannot compute the SNR for
      "!    the audio.
      SIGNAL_TO_NOISE_RATIO type FLOAT,
      "!   The ratio of speech to non-speech segments in the audio signal. The value lies
      "!    in the range of 0.0 to 1.0.
      SPEECH_RATIO type FLOAT,
      "!   The probability that the audio signal is missing the upper half of its frequency
      "!    content.<br/>
      "!   * A value close to 1.0 typically indicates artificially up-sampled audio, which
      "!    negatively impacts the accuracy of the transcription results.<br/>
      "!   * A value at or near 0.0 indicates that the audio signal is good and has a full
      "!    spectrum.<br/>
      "!   * A value around 0.5 means that detection of the frequency content is unreliable
      "!    or not available.
      HIGH_FREQUENCY_LOSS type FLOAT,
      "!   An array of `AudioMetricsHistogramBin` objects that defines a histogram of the
      "!    cumulative direct current (DC) component of the audio signal.
      DIRECT_CURRENT_OFFSET type STANDARD TABLE OF T_AUDIO_METRICS_HISTOGRAM_BIN WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of `AudioMetricsHistogramBin` objects that defines a histogram of the
      "!    clipping rate for the audio segments. The clipping rate is defined as the
      "!    fraction of samples in the segment that reach the maximum or minimum value that
      "!    is offered by the audio quantization range. The service auto-detects either a
      "!    16-bit Pulse-Code Modulation(PCM) audio range (-32768 to +32767) or a unit
      "!    range (-1.0 to +1.0). The clipping rate is between 0.0 and 1.0, with higher
      "!    values indicating possible degradation of speech recognition.
      CLIPPING_RATE type STANDARD TABLE OF T_AUDIO_METRICS_HISTOGRAM_BIN WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of `AudioMetricsHistogramBin` objects that defines a histogram of the
      "!    signal level in segments of the audio that contain speech. The signal level is
      "!    computed as the Root-Mean-Square (RMS) value in a decibel (dB) scale normalized
      "!    to the range 0.0 (minimum level) to 1.0 (maximum level).
      SPEECH_LEVEL type STANDARD TABLE OF T_AUDIO_METRICS_HISTOGRAM_BIN WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of `AudioMetricsHistogramBin` objects that defines a histogram of the
      "!    signal level in segments of the audio that do not contain speech. The signal
      "!    level is computed as the Root-Mean-Square (RMS) value in a decibel (dB) scale
      "!    normalized to the range 0.0 (minimum level) to 1.0 (maximum level).
      NON_SPEECH_LEVEL type STANDARD TABLE OF T_AUDIO_METRICS_HISTOGRAM_BIN WITH NON-UNIQUE DEFAULT KEY,
    end of T_AUDIO_METRICS_DETAILS.
  types:
    "!   If audio metrics are requested, information about the signal characteristics of
    "!    the input audio.
    begin of T_AUDIO_METRICS,
      "!   The interval in seconds (typically 0.1 seconds) at which the service calculated
      "!    the audio metrics. In other words, how often the service calculated the
      "!    metrics. A single unit in each histogram (see the `AudioMetricsHistogramBin`
      "!    object) is calculated based on a `sampling_interval` length of audio.
      SAMPLING_INTERVAL type FLOAT,
      "!   Detailed information about the signal characteristics of the input audio.
      ACCUMULATED type T_AUDIO_METRICS_DETAILS,
    end of T_AUDIO_METRICS.
  types:
    "!   Component results for a speech recognition request.
    begin of T_SPEECH_RECOGNITION_RESULT,
      "!   An indication of whether the transcription results are final. If `true`, the
      "!    results for this utterance are not updated further; no additional results are
      "!    sent for a `result_index` once its results are indicated as final.
      FINAL type BOOLEAN,
      "!   An array of alternative transcripts. The `alternatives` array can include
      "!    additional requested output such as word confidence or timestamps.
      ALTERNATIVES type STANDARD TABLE OF T_SPCH_RECOGNITION_ALTERNATIVE WITH NON-UNIQUE DEFAULT KEY,
      "!   A dictionary (or associative array) whose keys are the strings specified for
      "!    `keywords` if both that parameter and `keywords_threshold` are specified. The
      "!    value for each key is an array of matches spotted in the audio for that
      "!    keyword. Each match is described by a `KeywordResult` object. A keyword for
      "!    which no matches are found is omitted from the dictionary. The dictionary is
      "!    omitted entirely if no matches are found for any keywords.
      KEYWORDS_RESULT type MAP,
      "!   An array of alternative hypotheses found for words of the input audio if a
      "!    `word_alternatives_threshold` is specified.
      WORD_ALTERNATIVES type STANDARD TABLE OF T_WORD_ALTERNATIVE_RESULTS WITH NON-UNIQUE DEFAULT KEY,
      "!   If the `split_transcript_at_phrase_end` parameter is `true`, describes the
      "!    reason for the split:<br/>
      "!   * `end_of_data` - The end of the input audio stream.<br/>
      "!   * `full_stop` - A full semantic stop, such as for the conclusion of a
      "!    grammatical sentence. The insertion of splits is influenced by the base
      "!    language model and biased by custom language models and grammars. <br/>
      "!   * `reset` - The amount of audio that is currently being processed exceeds the
      "!    two-minute maximum. The service splits the transcript to avoid excessive memory
      "!    use.<br/>
      "!   * `silence` - A pause or silence that is at least as long as the pause interval.
      "!
      END_OF_UTTERANCE type STRING,
    end of T_SPEECH_RECOGNITION_RESULT.
  types:
    "!   The complete results for a speech recognition request.
    begin of T_SPEECH_RECOGNITION_RESULTS,
      "!   An array of `SpeechRecognitionResult` objects that can include interim and final
      "!    results (interim results are returned only if supported by the method). Final
      "!    results are guaranteed not to change; interim results might be replaced by
      "!    further interim results and final results. The service periodically sends
      "!    updates to the results list; the `result_index` is set to the lowest index in
      "!    the array that has changed; it is incremented for new results.
      RESULTS type STANDARD TABLE OF T_SPEECH_RECOGNITION_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   An index that indicates a change point in the `results` array. The service
      "!    increments the index only for additional results that it sends for new audio
      "!    for the same request.
      RESULT_INDEX type INTEGER,
      "!   An array of `SpeakerLabelsResult` objects that identifies which words were
      "!    spoken by which speakers in a multi-person exchange. The array is returned only
      "!    if the `speaker_labels` parameter is `true`. When interim results are also
      "!    requested for methods that support them, it is possible for a
      "!    `SpeechRecognitionResults` object to include only the `speaker_labels` field.
      SPEAKER_LABELS type STANDARD TABLE OF T_SPEAKER_LABELS_RESULT WITH NON-UNIQUE DEFAULT KEY,
      "!   If processing metrics are requested, information about the service's processing
      "!    of the input audio. Processing metrics are not available with the synchronous
      "!    **Recognize audio** method.
      PROCESSING_METRICS type T_PROCESSING_METRICS,
      "!   If audio metrics are requested, information about the signal characteristics of
      "!    the input audio.
      AUDIO_METRICS type T_AUDIO_METRICS,
      "!   An array of warning messages associated with the request:<br/>
      "!   * Warnings for invalid parameters or fields can include a descriptive message
      "!    and a list of invalid argument strings, for example, `"Unknown arguments:"` or
      "!    `"Unknown url query arguments:"` followed by a list of the form
      "!    `"&#123;invalid_arg_1&#125;, &#123;invalid_arg_2&#125;."`<br/>
      "!   * The following warning is returned if the request passes a custom model that is
      "!    based on an older version of a base model for which an updated version is
      "!    available: `"Using previous version of base model, because your custom model
      "!    has been built with it. Please note that this version will be supported only
      "!    for a limited time. Consider updating your custom model to the new base model.
      "!    If you do not do that you will be automatically switched to base model when you
      "!    used the non-updated custom model."`<br/>
      "!   <br/>
      "!   In both cases, the request succeeds despite the warnings.
      WARNINGS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_SPEECH_RECOGNITION_RESULTS.
  types:
    "!   Information about a grammar from a custom language model.
    begin of T_GRAMMAR,
      "!   The name of the grammar.
      NAME type STRING,
      "!   The number of OOV words in the grammar. The value is `0` while the grammar is
      "!    being processed.
      OUT_OF_VOCABULARY_WORDS type INTEGER,
      "!   The status of the grammar:<br/>
      "!   * `analyzed`: The service successfully analyzed the grammar. The custom model
      "!    can be trained with data from the grammar.<br/>
      "!   * `being_processed`: The service is still analyzing the grammar. The service
      "!    cannot accept requests to add new resources or to train the custom model.<br/>
      "!   * `undetermined`: The service encountered an error while processing the grammar.
      "!    The `error` field describes the failure.
      STATUS type STRING,
      "!   If the status of the grammar is `undetermined`, the following message: `Analysis
      "!    of grammar '&#123;grammar_name&#125;' failed. Please try fixing the error or
      "!    adding the grammar again by setting the 'allow_overwrite' flag to 'true'.`.
      ERROR type STRING,
    end of T_GRAMMAR.
  types:
    "!   Information about the grammars from a custom language model.
    begin of T_GRAMMARS,
      "!   An array of `Grammar` objects that provides information about the grammars for
      "!    the custom model. The array is empty if the custom model has no grammars.
      GRAMMARS type STANDARD TABLE OF T_GRAMMAR WITH NON-UNIQUE DEFAULT KEY,
    end of T_GRAMMARS.
  types:
    "!   Information about a current asynchronous speech recognition job.
    begin of T_RECOGNITION_JOB,
      "!   The ID of the asynchronous job.
      ID type STRING,
      "!   The current status of the job:<br/>
      "!   * `waiting`: The service is preparing the job for processing. The service
      "!    returns this status when the job is initially created or when it is waiting for
      "!    capacity to process the job. The job remains in this state until the service
      "!    has the capacity to begin processing it.<br/>
      "!   * `processing`: The service is actively processing the job.<br/>
      "!   * `completed`: The service has finished processing the job. If the job specified
      "!    a callback URL and the event `recognitions.completed_with_results`, the service
      "!    sent the results with the callback notification. Otherwise, you must retrieve
      "!    the results by checking the individual job.<br/>
      "!   * `failed`: The job failed.
      STATUS type STRING,
      "!   The date and time in Coordinated Universal Time (UTC) at which the job was
      "!    created. The value is provided in full ISO 8601 format
      "!    (`YYYY-MM-DDThh:mm:ss.sTZD`).
      CREATED type STRING,
      "!   The date and time in Coordinated Universal Time (UTC) at which the job was last
      "!    updated by the service. The value is provided in full ISO 8601 format
      "!    (`YYYY-MM-DDThh:mm:ss.sTZD`). This field is returned only by the **Check jobs**
      "!    and **Check a job** methods.
      UPDATED type STRING,
      "!   The URL to use to request information about the job with the **Check a job**
      "!    method. This field is returned only by the **Create a job** method.
      URL type STRING,
      "!   The user token associated with a job that was created with a callback URL and a
      "!    user token. This field can be returned only by the **Check jobs** method.
      USER_TOKEN type STRING,
      "!   If the status is `completed`, the results of the recognition request as an array
      "!    that includes a single instance of a `SpeechRecognitionResults` object. This
      "!    field is returned only by the **Check a job** method.
      RESULTS type STANDARD TABLE OF T_SPEECH_RECOGNITION_RESULTS WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of warning messages about invalid parameters included with the request.
      "!    Each warning includes a descriptive message and a list of invalid argument
      "!    strings, for example, `"unexpected query parameter 'user_token', query
      "!    parameter 'callback_url' was not specified"`. The request succeeds despite the
      "!    warnings. This field can be returned only by the **Create a job** method.
      WARNINGS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_RECOGNITION_JOB.
  types:
    "!   Information about current asynchronous speech recognition jobs.
    begin of T_RECOGNITION_JOBS,
      "!   An array of `RecognitionJob` objects that provides the status for each of the
      "!    user's current jobs. The array is empty if the user has no current jobs.
      RECOGNITIONS type STANDARD TABLE OF T_RECOGNITION_JOB WITH NON-UNIQUE DEFAULT KEY,
    end of T_RECOGNITION_JOBS.
  types:
    "!   Information about an audio resource from a custom acoustic model.
    begin of T_AUDIO_DETAILS,
      "!   The type of the audio resource:<br/>
      "!   * `audio` for an individual audio file<br/>
      "!   * `archive` for an archive (**.zip** or **.tar.gz**) file that contains audio
      "!    files<br/>
      "!   * `undetermined` for a resource that the service cannot validate (for example,
      "!    if the user mistakenly passes a file that does not contain audio, such as a
      "!    JPEG file).
      TYPE type STRING,
      "!   **For an audio-type resource,** the codec in which the audio is encoded. Omitted
      "!   ** for an archive-type resource.
      CODEC type STRING,
      "!   **For an audio-type resource,** the sampling rate of the audio in Hertz (samples
      "!   ** per second). Omitted for an archive-type resource.
      FREQUENCY type INTEGER,
      "!   **For an archive-type resource,** the format of the compressed archive:<br/>
      "!   *** `zip` for a **.zip** file<br/>
      "!   *** `gzip` for a **.tar.gz** file <br/>
      "!   **<br/>
      "!   **Omitted for an audio-type resource.
      COMPRESSION type STRING,
    end of T_AUDIO_DETAILS.
  types:
    "!   The error response from a failed request.
    begin of T_ERROR_MODEL,
      "!   Description of the problem.
      ERROR type STRING,
      "!   HTTP response code.
      CODE type INTEGER,
      "!   Response message.
      CODE_DESCRIPTION type STRING,
      "!   Warnings associated with the error.
      WARNINGS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_ERROR_MODEL.
  types:
    "!   Information about an audio resource from a custom acoustic model.
    begin of T_AUDIO_RESOURCE,
      "!   The total seconds of audio in the audio resource.
      DURATION type INTEGER,
      "!   **For an archive-type resource,** the user-specified name of the resource. <br/>
      "!   **<br/>
      "!   ****For an audio-type resource,** the user-specified name of the resource or the
      "!   ** name of the audio file that the user added for the resource. The value depends
      "!   ** on the method that is called.
      NAME type STRING,
      "!   An `AudioDetails` object that provides detailed information about the audio
      "!    resource. The object is empty until the service finishes processing the audio.
      DETAILS type T_AUDIO_DETAILS,
      "!   The status of the audio resource:<br/>
      "!   * `ok`: The service successfully analyzed the audio data. The data can be used
      "!    to train the custom model.<br/>
      "!   * `being_processed`: The service is still analyzing the audio data. The service
      "!    cannot accept requests to add new audio resources or to train the custom model
      "!    until its analysis is complete.<br/>
      "!   * `invalid`: The audio data is not valid for training the custom model (possibly
      "!    because it has the wrong format or sampling rate, or because it is corrupted).
      "!    For an archive file, the entire archive is invalid if any of its audio files
      "!    are invalid.
      STATUS type STRING,
    end of T_AUDIO_RESOURCE.
  types:
    "!   Information about an audio resource from a custom acoustic model.
    begin of T_AUDIO_LISTING,
      "!   **For an audio-type resource,**  the total seconds of audio in the resource.
      "!   ** Omitted for an archive-type resource.
      DURATION type INTEGER,
      "!   **For an audio-type resource,** the user-specified name of the resource. Omitted
      "!   ** for an archive-type resource.
      NAME type STRING,
      "!   **For an audio-type resource,** an `AudioDetails` object that provides detailed
      "!   ** information about the resource. The object is empty until the service finishes
      "!   ** processing the audio. Omitted for an archive-type resource.
      DETAILS type T_AUDIO_DETAILS,
      "!   **For an audio-type resource,** the status of the resource:<br/>
      "!   *** `ok`: The service successfully analyzed the audio data. The data can be used
      "!   ** to train the custom model.<br/>
      "!   *** `being_processed`: The service is still analyzing the audio data. The service
      "!   ** cannot accept requests to add new audio resources or to train the custom model
      "!   ** until its analysis is complete.<br/>
      "!   *** `invalid`: The audio data is not valid for training the custom model (possibly
      "!   ** because it has the wrong format or sampling rate, or because it is corrupted).
      "!   ** <br/>
      "!   **<br/>
      "!   **Omitted for an archive-type resource.
      STATUS type STRING,
      "!   **For an archive-type resource,** an object of type `AudioResource` that provides
      "!   ** information about the resource. Omitted for an audio-type resource.
      CONTAINER type T_AUDIO_RESOURCE,
      "!   **For an archive-type resource,** an array of `AudioResource` objects that
      "!   ** provides information about the audio-type resources that are contained in the
      "!   ** resource. Omitted for an audio-type resource.
      AUDIO type STANDARD TABLE OF T_AUDIO_RESOURCE WITH NON-UNIQUE DEFAULT KEY,
    end of T_AUDIO_LISTING.
  types:
    "!   An error associated with a word from a custom language model.
    begin of T_WORD_ERROR,
      "!   A key-value pair that describes an error associated with the definition of a
      "!    word in the words resource. The pair has the format `"element": "message"`,
      "!    where `element` is the aspect of the definition that caused the problem and
      "!    `message` describes the problem. The following example describes a problem with
      "!    one of the word's sounds-like definitions: `"&#123;sounds_like_string&#125;":
      "!    "Numbers are not allowed in sounds-like. You can try for example
      "!    '&#123;suggested_string&#125;'."`.
      ELEMENT type STRING,
    end of T_WORD_ERROR.
  types:
    "!   Information about a word from a custom language model.
    begin of T_WORD,
      "!   A word from the custom model's words resource. The spelling of the word is used
      "!    to train the model.
      WORD type STRING,
      "!   An array of pronunciations for the word. The array can include the sounds-like
      "!    pronunciation automatically generated by the service if none is provided for
      "!    the word; the service adds this pronunciation when it finishes processing the
      "!    word.
      SOUNDS_LIKE type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The spelling of the word that the service uses to display the word in a
      "!    transcript. The field contains an empty string if no display-as value is
      "!    provided for the word, in which case the word is displayed as it is spelled.
      DISPLAY_AS type STRING,
      "!   A sum of the number of times the word is found across all corpora. For example,
      "!    if the word occurs five times in one corpus and seven times in another, its
      "!    count is `12`. If you add a custom word to a model before it is added by any
      "!    corpora, the count begins at `1`; if the word is added from a corpus first and
      "!    later modified, the count reflects only the number of times it is found in
      "!    corpora.
      COUNT type INTEGER,
      "!   An array of sources that describes how the word was added to the custom model's
      "!    words resource. For OOV words added from a corpus, includes the name of the
      "!    corpus; if the word was added by multiple corpora, the names of all corpora are
      "!    listed. If the word was modified or added by the user directly, the field
      "!    includes the string `user`.
      SOURCE type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   If the service discovered one or more problems that you need to correct for the
      "!    word's definition, an array that describes each of the errors.
      ERROR type STANDARD TABLE OF T_WORD_ERROR WITH NON-UNIQUE DEFAULT KEY,
    end of T_WORD.
  types:
    "!   Information about the words from a custom language model.
    begin of T_WORDS,
      "!   An array of `Word` objects that provides information about each word in the
      "!    custom model's words resource. The array is empty if the custom model has no
      "!    words.
      WORDS type STANDARD TABLE OF T_WORD WITH NON-UNIQUE DEFAULT KEY,
    end of T_WORDS.
  types:
    "!   Information about a word that is to be added to a custom language model.
    begin of T_CUSTOM_WORD,
      "!   For the **Add custom words** method, you must specify the custom word that is to
      "!    be added to or updated in the custom model. Do not include spaces in the word.
      "!    Use a `-` (dash) or `_` (underscore) to connect the tokens of compound words.
      "!    <br/>
      "!   <br/>
      "!   Omit this parameter for the **Add a custom word** method.
      WORD type STRING,
      "!   An array of sounds-like pronunciations for the custom word. Specify how words
      "!    that are difficult to pronounce, foreign words, acronyms, and so on can be
      "!    pronounced by users.<br/>
      "!   * For a word that is not in the service's base vocabulary, omit the parameter to
      "!    have the service automatically generate a sounds-like pronunciation for the
      "!    word.<br/>
      "!   * For a word that is in the service's base vocabulary, use the parameter to
      "!    specify additional pronunciations for the word. You cannot override the default
      "!    pronunciation of a word; pronunciations you add augment the pronunciation from
      "!    the base vocabulary. <br/>
      "!   <br/>
      "!   A word can have at most five sounds-like pronunciations. A pronunciation can
      "!    include at most 40 characters not including spaces.
      SOUNDS_LIKE type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   An alternative spelling for the custom word when it appears in a transcript. Use
      "!    the parameter when you want the word to have a spelling that is different from
      "!    its usual representation or from its spelling in corpora training data.
      DISPLAY_AS type STRING,
    end of T_CUSTOM_WORD.
  types:
    "!   Information about the audio resources from a custom acoustic model.
    begin of T_AUDIO_RESOURCES,
      "!   The total minutes of accumulated audio summed over all of the valid audio
      "!    resources for the custom acoustic model. You can use this value to determine
      "!    whether the custom model has too little or too much audio to begin training.
      TOTAL_MINUTES_OF_AUDIO type DOUBLE,
      "!   An array of `AudioResource` objects that provides information about the audio
      "!    resources of the custom acoustic model. The array is empty if the custom model
      "!    has no audio resources.
      AUDIO type STANDARD TABLE OF T_AUDIO_RESOURCE WITH NON-UNIQUE DEFAULT KEY,
    end of T_AUDIO_RESOURCES.
  types:
    "!   Information about a corpus from a custom language model.
    begin of T_CORPUS,
      "!   The name of the corpus.
      NAME type STRING,
      "!   The total number of words in the corpus. The value is `0` while the corpus is
      "!    being processed.
      TOTAL_WORDS type INTEGER,
      "!   The number of OOV words in the corpus. The value is `0` while the corpus is
      "!    being processed.
      OUT_OF_VOCABULARY_WORDS type INTEGER,
      "!   The status of the corpus:<br/>
      "!   * `analyzed`: The service successfully analyzed the corpus. The custom model can
      "!    be trained with data from the corpus.<br/>
      "!   * `being_processed`: The service is still analyzing the corpus. The service
      "!    cannot accept requests to add new resources or to train the custom model.<br/>
      "!   * `undetermined`: The service encountered an error while processing the corpus.
      "!    The `error` field describes the failure.
      STATUS type STRING,
      "!   If the status of the corpus is `undetermined`, the following message: `Analysis
      "!    of corpus 'name' failed. Please try adding the corpus again by setting the
      "!    'allow_overwrite' flag to 'true'`.
      ERROR type STRING,
    end of T_CORPUS.
  types:
    "!   Information about the corpora from a custom language model.
    begin of T_CORPORA,
      "!   An array of `Corpus` objects that provides information about the corpora for the
      "!    custom model. The array is empty if the custom model has no corpora.
      CORPORA type STANDARD TABLE OF T_CORPUS WITH NON-UNIQUE DEFAULT KEY,
    end of T_CORPORA.
  types:
    "!   Information about an existing custom language model.
    begin of T_LANGUAGE_MODEL,
      "!   The customization ID (GUID) of the custom language model. The **Create a custom
      "!    language model** method returns only this field of the object; it does not
      "!    return the other fields.
      CUSTOMIZATION_ID type STRING,
      "!   The date and time in Coordinated Universal Time (UTC) at which the custom
      "!    language model was created. The value is provided in full ISO 8601 format
      "!    (`YYYY-MM-DDThh:mm:ss.sTZD`).
      CREATED type STRING,
      "!   The date and time in Coordinated Universal Time (UTC) at which the custom
      "!    language model was last modified. The `created` and `updated` fields are equal
      "!    when a language model is first added but has yet to be updated. The value is
      "!    provided in full ISO 8601 format (YYYY-MM-DDThh:mm:ss.sTZD).
      UPDATED type STRING,
      "!   The language identifier of the custom language model (for example, `en-US`).
      LANGUAGE type STRING,
      "!   The dialect of the language for the custom language model. For non-Spanish
      "!    models, the field matches the language of the base model; for example, `en-US`
      "!    for either of the US English language models. For Spanish models, the field
      "!    indicates the dialect for which the model was created:<br/>
      "!   * `es-ES` for Castilian Spanish (`es-ES` models)<br/>
      "!   * `es-LA` for Latin American Spanish (`es-AR`, `es-CL`, `es-CO`, and `es-PE`
      "!    models)<br/>
      "!   * `es-US` for Mexican (North American) Spanish (`es-MX` models) <br/>
      "!   <br/>
      "!   Dialect values are case-insensitive.
      DIALECT type STRING,
      "!   A list of the available versions of the custom language model. Each element of
      "!    the array indicates a version of the base model with which the custom model can
      "!    be used. Multiple versions exist only if the custom model has been upgraded;
      "!    otherwise, only a single version is shown.
      VERSIONS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The GUID of the credentials for the instance of the service that owns the custom
      "!    language model.
      OWNER type STRING,
      "!   The name of the custom language model.
      NAME type STRING,
      "!   The description of the custom language model.
      DESCRIPTION type STRING,
      "!   The name of the language model for which the custom language model was created.
      BASE_MODEL_NAME type STRING,
      "!   The current status of the custom language model:<br/>
      "!   * `pending`: The model was created but is waiting either for valid training data
      "!    to be added or for the service to finish analyzing added data.<br/>
      "!   * `ready`: The model contains valid data and is ready to be trained. If the
      "!    model contains a mix of valid and invalid resources, you need to set the
      "!    `strict` parameter to `false` for the training to proceed. <br/>
      "!   * `training`: The model is currently being trained.<br/>
      "!   * `available`: The model is trained and ready to use.<br/>
      "!   * `upgrading`: The model is currently being upgraded.<br/>
      "!   * `failed`: Training of the model failed.
      STATUS type STRING,
      "!   A percentage that indicates the progress of the custom language model's current
      "!    training. A value of `100` means that the model is fully trained. **Note:** The
      "!    `progress` field does not currently reflect the progress of the training. The
      "!    field changes from `0` to `100` when training is complete.
      PROGRESS type INTEGER,
      "!   If an error occurred while adding a grammar file to the custom language model, a
      "!    message that describes an `Internal Server Error` and includes the string
      "!    `Cannot compile grammar`. The status of the custom model is not affected by the
      "!    error, but the grammar cannot be used with the model.
      ERROR type STRING,
      "!   If the request included unknown parameters, the following message: `Unexpected
      "!    query parameter(s) ['parameters'] detected`, where `parameters` is a list that
      "!    includes a quoted string for each unknown parameter.
      WARNINGS type STRING,
    end of T_LANGUAGE_MODEL.
  types:
    "!   Information about existing custom language models.
    begin of T_LANGUAGE_MODELS,
      "!   An array of `LanguageModel` objects that provides information about each
      "!    available custom language model. The array is empty if the requesting
      "!    credentials own no custom language models (if no language is specified) or own
      "!    no custom language models for the specified language.
      CUSTOMIZATIONS type STANDARD TABLE OF T_LANGUAGE_MODEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_LANGUAGE_MODELS.
  types:
    "!   Information about an existing custom acoustic model.
    begin of T_ACOUSTIC_MODEL,
      "!   The customization ID (GUID) of the custom acoustic model. The **Create a custom
      "!    acoustic model** method returns only this field of the object; it does not
      "!    return the other fields.
      CUSTOMIZATION_ID type STRING,
      "!   The date and time in Coordinated Universal Time (UTC) at which the custom
      "!    acoustic model was created. The value is provided in full ISO 8601 format
      "!    (`YYYY-MM-DDThh:mm:ss.sTZD`).
      CREATED type STRING,
      "!   The date and time in Coordinated Universal Time (UTC) at which the custom
      "!    acoustic model was last modified. The `created` and `updated` fields are equal
      "!    when an acoustic model is first added but has yet to be updated. The value is
      "!    provided in full ISO 8601 format (YYYY-MM-DDThh:mm:ss.sTZD).
      UPDATED type STRING,
      "!   The language identifier of the custom acoustic model (for example, `en-US`).
      LANGUAGE type STRING,
      "!   A list of the available versions of the custom acoustic model. Each element of
      "!    the array indicates a version of the base model with which the custom model can
      "!    be used. Multiple versions exist only if the custom model has been upgraded;
      "!    otherwise, only a single version is shown.
      VERSIONS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The GUID of the credentials for the instance of the service that owns the custom
      "!    acoustic model.
      OWNER type STRING,
      "!   The name of the custom acoustic model.
      NAME type STRING,
      "!   The description of the custom acoustic model.
      DESCRIPTION type STRING,
      "!   The name of the language model for which the custom acoustic model was created.
      BASE_MODEL_NAME type STRING,
      "!   The current status of the custom acoustic model:<br/>
      "!   * `pending`: The model was created but is waiting either for valid training data
      "!    to be added or for the service to finish analyzing added data.<br/>
      "!   * `ready`: The model contains valid data and is ready to be trained. If the
      "!    model contains a mix of valid and invalid resources, you need to set the
      "!    `strict` parameter to `false` for the training to proceed. <br/>
      "!   * `training`: The model is currently being trained.<br/>
      "!   * `available`: The model is trained and ready to use.<br/>
      "!   * `upgrading`: The model is currently being upgraded.<br/>
      "!   * `failed`: Training of the model failed.
      STATUS type STRING,
      "!   A percentage that indicates the progress of the custom acoustic model's current
      "!    training. A value of `100` means that the model is fully trained. **Note:** The
      "!    `progress` field does not currently reflect the progress of the training. The
      "!    field changes from `0` to `100` when training is complete.
      PROGRESS type INTEGER,
      "!   If the request included unknown parameters, the following message: `Unexpected
      "!    query parameter(s) ['parameters'] detected`, where `parameters` is a list that
      "!    includes a quoted string for each unknown parameter.
      WARNINGS type STRING,
    end of T_ACOUSTIC_MODEL.
  types:
    "!   Information about existing custom acoustic models.
    begin of T_ACOUSTIC_MODELS,
      "!   An array of `AcousticModel` objects that provides information about each
      "!    available custom acoustic model. The array is empty if the requesting
      "!    credentials own no custom acoustic models (if no language is specified) or own
      "!    no custom acoustic models for the specified language.
      CUSTOMIZATIONS type STANDARD TABLE OF T_ACOUSTIC_MODEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_ACOUSTIC_MODELS.
  types:
    "!   No documentation available.
    begin of T_INLINE_OBJECT,
      "!   A plain text file that contains the training data for the corpus. Encode the
      "!    file in UTF-8 if it contains non-ASCII characters; the service assumes UTF-8
      "!    encoding if it encounters non-ASCII characters. <br/>
      "!   <br/>
      "!   Make sure that you know the character encoding of the file. You must use that
      "!    encoding when working with the words in the custom language model. For more
      "!    information, see [Character
      "!    encoding](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-te
      "!   xt-corporaWords#charEncoding). <br/>
      "!   <br/>
      "!   With the `curl` command, use the `--data-binary` option to upload the file for
      "!    the request.
      CORPUS_FILE type FILE,
    end of T_INLINE_OBJECT.
  types:
    "!   Additional service features that are supported with the model.
    begin of T_SUPPORTED_FEATURES,
      "!   Indicates whether the customization interface can be used to create a custom
      "!    language model based on the language model.
      CUSTOM_LANGUAGE_MODEL type BOOLEAN,
      "!   Indicates whether the `speaker_labels` parameter can be used with the language
      "!    model.
      SPEAKER_LABELS type BOOLEAN,
    end of T_SUPPORTED_FEATURES.
  types:
    "!   Information about the new custom language model.
    begin of T_CREATE_LANGUAGE_MODEL,
      "!   A user-defined name for the new custom language model. Use a name that is unique
      "!    among all custom language models that you own. Use a localized name that
      "!    matches the language of the custom model. Use a name that describes the domain
      "!    of the custom model, such as `Medical custom model` or `Legal custom model`.
      NAME type STRING,
      "!   The name of the base language model that is to be customized by the new custom
      "!    language model. The new custom model can be used only with the base model that
      "!    it customizes. <br/>
      "!   <br/>
      "!   To determine whether a base model supports language model customization, use the
      "!    **Get a model** method and check that the attribute `custom_language_model` is
      "!    set to `true`. You can also refer to [Language support for
      "!    customization](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-
      "!   to-text-customization#languageSupport).
      BASE_MODEL_NAME type STRING,
      "!   The dialect of the specified language that is to be used with the custom
      "!    language model. For most languages, the dialect matches the language of the
      "!    base model by default. For example, `en-US` is used for either of the US
      "!    English language models. <br/>
      "!   <br/>
      "!   For a Spanish language, the service creates a custom language model that is
      "!    suited for speech in one of the following dialects:<br/>
      "!   * `es-ES` for Castilian Spanish (`es-ES` models)<br/>
      "!   * `es-LA` for Latin American Spanish (`es-AR`, `es-CL`, `es-CO`, and `es-PE`
      "!    models)<br/>
      "!   * `es-US` for Mexican (North American) Spanish (`es-MX` models) <br/>
      "!   <br/>
      "!   The parameter is meaningful only for Spanish models, for which you can always
      "!    safely omit the parameter to have the service create the correct mapping. <br/>
      "!   <br/>
      "!   If you specify the `dialect` parameter for non-Spanish language models, its
      "!    value must match the language of the base model. If you specify the `dialect`
      "!    for Spanish language models, its value must match one of the defined mappings
      "!    as indicated (`es-ES`, `es-LA`, or `es-MX`). All dialect values are
      "!    case-insensitive.
      DIALECT type STRING,
      "!   A description of the new custom language model. Use a localized description that
      "!    matches the language of the custom model.
      DESCRIPTION type STRING,
    end of T_CREATE_LANGUAGE_MODEL.
  types:
    "!   Information about an available language model.
    begin of T_SPEECH_MODEL,
      "!   The name of the model for use as an identifier in calls to the service (for
      "!    example, `en-US_BroadbandModel`).
      NAME type STRING,
      "!   The language identifier of the model (for example, `en-US`).
      LANGUAGE type STRING,
      "!   The sampling rate (minimum acceptable rate for audio) used by the model in
      "!    Hertz.
      RATE type INTEGER,
      "!   The URI for the model.
      URL type STRING,
      "!   Additional service features that are supported with the model.
      SUPPORTED_FEATURES type T_SUPPORTED_FEATURES,
      "!   A brief description of the model.
      DESCRIPTION type STRING,
    end of T_SPEECH_MODEL.
  types:
    "!   Information about the available language models.
    begin of T_SPEECH_MODELS,
      "!   An array of `SpeechModel` objects that provides information about each available
      "!    model.
      MODELS type STANDARD TABLE OF T_SPEECH_MODEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_SPEECH_MODELS.
  types:
    "!   Information about the new custom acoustic model.
    begin of T_CREATE_ACOUSTIC_MODEL,
      "!   A user-defined name for the new custom acoustic model. Use a name that is unique
      "!    among all custom acoustic models that you own. Use a localized name that
      "!    matches the language of the custom model. Use a name that describes the
      "!    acoustic environment of the custom model, such as `Mobile custom model` or
      "!    `Noisy car custom model`.
      NAME type STRING,
      "!   The name of the base language model that is to be customized by the new custom
      "!    acoustic model. The new custom model can be used only with the base model that
      "!    it customizes. <br/>
      "!   <br/>
      "!   To determine whether a base model supports acoustic model customization, refer
      "!    to [Language support for
      "!    customization](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-
      "!   to-text-customization#languageSupport).
      BASE_MODEL_NAME type STRING,
      "!   A description of the new custom acoustic model. Use a localized description that
      "!    matches the language of the custom model.
      DESCRIPTION type STRING,
    end of T_CREATE_ACOUSTIC_MODEL.
  types:
    "!   Information about the words that are to be added to a custom language model.
    begin of T_CUSTOM_WORDS,
      "!   An array of `CustomWord` objects that provides information about each custom
      "!    word that is to be added to or updated in the custom language model.
      WORDS type STANDARD TABLE OF T_CUSTOM_WORD WITH NON-UNIQUE DEFAULT KEY,
    end of T_CUSTOM_WORDS.
  types:
    "!   Information about a match for a keyword from speech recognition results.
    begin of T_KEYWORD_RESULT,
      "!   A specified keyword normalized to the spoken phrase that matched in the audio
      "!    input.
      NORMALIZED_TEXT type STRING,
      "!   The start time in seconds of the keyword match.
      START_TIME type DOUBLE,
      "!   The end time in seconds of the keyword match.
      END_TIME type DOUBLE,
      "!   A confidence score for the keyword match in the range of 0.0 to 1.0.
      CONFIDENCE type DOUBLE,
    end of T_KEYWORD_RESULT.
  types:
    "!   The empty response from a request.
      T_EMPTY_RESPONSE_BODY type JSONOBJECT.
  types:
    "!   Information about a request to register a callback for asynchronous speech
    "!    recognition.
    begin of T_REGISTER_STATUS,
      "!   The current status of the job:<br/>
      "!   * `created`: The service successfully white-listed the callback URL as a result
      "!    of the call.<br/>
      "!   * `already created`: The URL was already white-listed.
      STATUS type STRING,
      "!   The callback URL that is successfully registered.
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
     END_OF_UTTERANCE type string value 'end_of_utterance',
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
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
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
    "! @parameter I_MODEL_ID |
    "!   The identifier of the model in the form of its name from the output of the **Get
    "!    a model** method.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SPEECH_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_MODEL
    importing
      !I_MODEL_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SPEECH_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Recognize audio.
    "!
    "! @parameter I_AUDIO |
    "!   The audio to transcribe.
    "! @parameter I_CONTENT_TYPE |
    "!   The format (MIME type) of the audio. For more information about specifying an
    "!    audio format, see **Audio formats (content types)** in the method description.
    "! @parameter I_MODEL |
    "!   The identifier of the model that is to be used for the recognition request. See
    "!    [Languages and
    "!    models](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -models#models).
    "! @parameter I_LANGUAGE_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of a custom language model that is to be used with
    "!    the recognition request. The base model of the specified custom language model
    "!    must match the model specified with the `model` parameter. You must make the
    "!    request with credentials for the instance of the service that owns the custom
    "!    model. By default, no custom language model is used. See [Custom
    "!    models](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -input#custom-input). <br/>
    "!   <br/>
    "!   **Note:** Use this parameter instead of the deprecated `customization_id`
    "!    parameter.
    "! @parameter I_ACOUSTIC_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of a custom acoustic model that is to be used with
    "!    the recognition request. The base model of the specified custom acoustic model
    "!    must match the model specified with the `model` parameter. You must make the
    "!    request with credentials for the instance of the service that owns the custom
    "!    model. By default, no custom acoustic model is used. See [Custom
    "!    models](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -input#custom-input).
    "! @parameter I_BASE_MODEL_VERSION |
    "!   The version of the specified base model that is to be used with the recognition
    "!    request. Multiple versions of a base model can exist when a model is updated
    "!    for internal improvements. The parameter is intended primarily for use with
    "!    custom models that have been upgraded for a new base model. The default value
    "!    depends on whether the parameter is used with or without a custom model. See
    "!    [Base model
    "!    version](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-tex
    "!   t-input#version).
    "! @parameter I_CUSTOMIZATION_WEIGHT |
    "!   If you specify the customization ID (GUID) of a custom language model with the
    "!    recognition request, the customization weight tells the service how much weight
    "!    to give to words from the custom language model compared to those from the base
    "!    model for the current request. <br/>
    "!   <br/>
    "!   Specify a value between 0.0 and 1.0. Unless a different customization weight was
    "!    specified for the custom model when it was trained, the default value is 0.3. A
    "!    customization weight that you specify overrides a weight that was specified
    "!    when the custom model was trained. <br/>
    "!   <br/>
    "!   The default value yields the best performance in general. Assign a higher value
    "!    if your audio makes frequent use of OOV words from the custom model. Use
    "!    caution when setting the weight: a higher value can improve the accuracy of
    "!    phrases from the custom model's domain, but it can negatively affect
    "!    performance on non-domain phrases. <br/>
    "!   <br/>
    "!   See [Custom
    "!    models](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -input#custom-input).
    "! @parameter I_INACTIVITY_TIMEOUT |
    "!   The time in seconds after which, if only silence (no speech) is detected in
    "!    streaming audio, the connection is closed with a 400 error. The parameter is
    "!    useful for stopping audio submission from a live microphone when a user simply
    "!    walks away. Use `-1` for infinity. See [Inactivity
    "!    timeout](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-tex
    "!   t-input#timeouts-inactivity).
    "! @parameter I_KEYWORDS |
    "!   An array of keyword strings to spot in the audio. Each keyword string can
    "!    include one or more string tokens. Keywords are spotted only in the final
    "!    results, not in interim hypotheses. If you specify any keywords, you must also
    "!    specify a keywords threshold. You can spot a maximum of 1000 keywords. Omit the
    "!    parameter or specify an empty array if you do not need to spot keywords. See
    "!    [Keyword
    "!    spotting](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-te
    "!   xt-output#keyword_spotting).
    "! @parameter I_KEYWORDS_THRESHOLD |
    "!   A confidence value that is the lower bound for spotting a keyword. A word is
    "!    considered to match a keyword if its confidence is greater than or equal to the
    "!    threshold. Specify a probability between 0.0 and 1.0. If you specify a
    "!    threshold, you must also specify one or more keywords. The service performs no
    "!    keyword spotting if you omit either parameter. See [Keyword
    "!    spotting](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-te
    "!   xt-output#keyword_spotting).
    "! @parameter I_MAX_ALTERNATIVES |
    "!   The maximum number of alternative transcripts that the service is to return. By
    "!    default, the service returns a single transcript. If you specify a value of
    "!    `0`, the service uses the default value, `1`. See [Maximum
    "!    alternatives](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-t
    "!   o-text-output#max_alternatives).
    "! @parameter I_WORD_ALTERNATIVES_THRESHOLD |
    "!   A confidence value that is the lower bound for identifying a hypothesis as a
    "!    possible word alternative (also known as "Confusion Networks"). An alternative
    "!    word is considered if its confidence is greater than or equal to the threshold.
    "!    Specify a probability between 0.0 and 1.0. By default, the service computes no
    "!    alternative words. See [Word
    "!    alternatives](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-t
    "!   o-text-output#word_alternatives).
    "! @parameter I_WORD_CONFIDENCE |
    "!   If `true`, the service returns a confidence measure in the range of 0.0 to 1.0
    "!    for each word. By default, the service returns no word confidence scores. See
    "!    [Word
    "!    confidence](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-
    "!   text-output#word_confidence).
    "! @parameter I_TIMESTAMPS |
    "!   If `true`, the service returns time alignment for each word. By default, no
    "!    timestamps are returned. See [Word
    "!    timestamps](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-
    "!   text-output#word_timestamps).
    "! @parameter I_PROFANITY_FILTER |
    "!   If `true`, the service filters profanity from all output except for keyword
    "!    results by replacing inappropriate words with a series of asterisks. Set the
    "!    parameter to `false` to return results with no censoring. Applies to US English
    "!    transcription only. See [Profanity
    "!    filtering](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-t
    "!   ext-output#profanity_filter).
    "! @parameter I_SMART_FORMATTING |
    "!   If `true`, the service converts dates, times, series of digits and numbers,
    "!    phone numbers, currency values, and internet addresses into more readable,
    "!    conventional representations in the final transcript of a recognition request.
    "!    For US English, the service also converts certain keyword strings to
    "!    punctuation symbols. By default, the service performs no smart formatting.
    "!    <br/>
    "!   <br/>
    "!   **Note:** Applies to US English, Japanese, and Spanish transcription only. <br/>
    "!   <br/>
    "!   See [Smart
    "!    formatting](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-
    "!   text-output#smart_formatting).
    "! @parameter I_SPEAKER_LABELS |
    "!   If `true`, the response includes labels that identify which words were spoken by
    "!    which participants in a multi-person exchange. By default, the service returns
    "!    no speaker labels. Setting `speaker_labels` to `true` forces the `timestamps`
    "!    parameter to be `true`, regardless of whether you specify `false` for the
    "!    parameter. <br/>
    "!   <br/>
    "!   **Note:** Applies to US English, Japanese, and Spanish (both broadband and
    "!    narrowband models) and UK English (narrowband model) transcription only. To
    "!    determine whether a language model supports speaker labels, you can also use
    "!    the **Get a model** method and check that the attribute `speaker_labels` is set
    "!    to `true`. <br/>
    "!   <br/>
    "!   See [Speaker
    "!    labels](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -output#speaker_labels).
    "! @parameter I_CUSTOMIZATION_ID |
    "!   **Deprecated.** Use the `language_customization_id` parameter to specify the
    "!   ** customization ID (GUID) of a custom language model that is to be used with the
    "!   ** recognition request. Do not specify both parameters with a request.
    "! @parameter I_GRAMMAR_NAME |
    "!   The name of a grammar that is to be used with the recognition request. If you
    "!    specify a grammar, you must also use the `language_customization_id` parameter
    "!    to specify the name of the custom language model for which the grammar is
    "!    defined. The service recognizes only strings that are recognized by the
    "!    specified grammar; it does not recognize other custom words from the model's
    "!    words resource. See
    "!    [Grammars](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-t
    "!   ext-input#grammars-input).
    "! @parameter I_REDACTION |
    "!   If `true`, the service redacts, or masks, numeric data from final transcripts.
    "!    The feature redacts any number that has three or more consecutive digits by
    "!    replacing each digit with an `X` character. It is intended to redact sensitive
    "!    numeric data, such as credit card numbers. By default, the service performs no
    "!    redaction. <br/>
    "!   <br/>
    "!   When you enable redaction, the service automatically enables smart formatting,
    "!    regardless of whether you explicitly disable that feature. To ensure maximum
    "!    security, the service also disables keyword spotting (ignores the `keywords`
    "!    and `keywords_threshold` parameters) and returns only a single final transcript
    "!    (forces the `max_alternatives` parameter to be `1`). <br/>
    "!   <br/>
    "!   **Note:** Applies to US English, Japanese, and Korean transcription only. <br/>
    "!   <br/>
    "!   See [Numeric
    "!    redaction](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-t
    "!   ext-output#redaction).
    "! @parameter I_AUDIO_METRICS |
    "!   If `true`, requests detailed information about the signal characteristics of the
    "!    input audio. The service returns audio metrics with the final transcription
    "!    results. By default, the service returns no audio metrics. <br/>
    "!   <br/>
    "!   See [Audio
    "!    metrics](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-tex
    "!   t-metrics#audio_metrics).
    "! @parameter I_END_OF_PHRASE_SILENCE_TIME |
    "!   If `true`, specifies the duration of the pause interval at which the service
    "!    splits a transcript into multiple final results. If the service detects pauses
    "!    or extended silence before it reaches the end of the audio stream, its response
    "!    can include multiple final results. Silence indicates a point at which the
    "!    speaker pauses between spoken words or phrases. <br/>
    "!   <br/>
    "!   Specify a value for the pause interval in the range of 0.0 to 120.0.<br/>
    "!   * A value greater than 0 specifies the interval that the service is to use for
    "!    speech recognition.<br/>
    "!   * A value of 0 indicates that the service is to use the default interval. It is
    "!    equivalent to omitting the parameter. <br/>
    "!   <br/>
    "!   The default pause interval for most languages is 0.8 seconds; the default for
    "!    Chinese is 0.6 seconds. <br/>
    "!   <br/>
    "!   See [End of phrase silence
    "!    time](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text-o
    "!   utput#silence_time).
    "! @parameter I_SPLT_TRNSCRPT_AT_PHRASE_END |
    "!   If `true`, directs the service to split the transcript into multiple final
    "!    results based on semantic features of the input, for example, at the conclusion
    "!    of meaningful phrases such as sentences. The service bases its understanding of
    "!    semantic features on the base language model that you use with a request.
    "!    Custom language models and grammars can also influence how and where the
    "!    service splits a transcript. By default, the service splits transcripts based
    "!    solely on the pause interval. <br/>
    "!   <br/>
    "!   See [Split transcript at phrase
    "!    end](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text-ou
    "!   tput#split_transcript).
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_SPEECH_RECOGNITION_RESULTS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods RECOGNIZE
    importing
      !I_AUDIO type FILE
      !I_CONTENT_TYPE type STRING default 'application/octet-stream'
      !I_MODEL type STRING default 'en-US_BroadbandModel'
      !I_LANGUAGE_CUSTOMIZATION_ID type STRING optional
      !I_ACOUSTIC_CUSTOMIZATION_ID type STRING optional
      !I_BASE_MODEL_VERSION type STRING optional
      !I_CUSTOMIZATION_WEIGHT type DOUBLE optional
      !I_INACTIVITY_TIMEOUT type INTEGER optional
      !I_KEYWORDS type TT_STRING optional
      !I_KEYWORDS_THRESHOLD type FLOAT optional
      !I_MAX_ALTERNATIVES type INTEGER optional
      !I_WORD_ALTERNATIVES_THRESHOLD type FLOAT optional
      !I_WORD_CONFIDENCE type BOOLEAN default c_boolean_false
      !I_TIMESTAMPS type BOOLEAN default c_boolean_false
      !I_PROFANITY_FILTER type BOOLEAN default c_boolean_true
      !I_SMART_FORMATTING type BOOLEAN default c_boolean_false
      !I_SPEAKER_LABELS type BOOLEAN default c_boolean_false
      !I_CUSTOMIZATION_ID type STRING optional
      !I_GRAMMAR_NAME type STRING optional
      !I_REDACTION type BOOLEAN default c_boolean_false
      !I_AUDIO_METRICS type BOOLEAN default c_boolean_false
      !I_END_OF_PHRASE_SILENCE_TIME type DOUBLE optional
      !I_SPLT_TRNSCRPT_AT_PHRASE_END type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_SPEECH_RECOGNITION_RESULTS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Register a callback.
    "!
    "! @parameter I_CALLBACK_URL |
    "!   An HTTP or HTTPS URL to which callback notifications are to be sent. To be
    "!    white-listed, the URL must successfully echo the challenge string during URL
    "!    verification. During verification, the client can also check the signature that
    "!    the service sends in the `X-Callback-Signature` header to verify the origin of
    "!    the request.
    "! @parameter I_USER_SECRET |
    "!   A user-specified string that the service uses to generate the HMAC-SHA1
    "!    signature that it sends via the `X-Callback-Signature` header. The service
    "!    includes the header during URL verification and with every notification sent to
    "!    the callback URL. It calculates the signature over the payload of the
    "!    notification. If you omit the parameter, the service does not send the header.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_REGISTER_STATUS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods REGISTER_CALLBACK
    importing
      !I_CALLBACK_URL type STRING
      !I_USER_SECRET type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_REGISTER_STATUS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Unregister a callback.
    "!
    "! @parameter I_CALLBACK_URL |
    "!   The callback URL that is to be unregistered.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UNREGISTER_CALLBACK
    importing
      !I_CALLBACK_URL type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Create a job.
    "!
    "! @parameter I_AUDIO |
    "!   The audio to transcribe.
    "! @parameter I_CONTENT_TYPE |
    "!   The format (MIME type) of the audio. For more information about specifying an
    "!    audio format, see **Audio formats (content types)** in the method description.
    "! @parameter I_MODEL |
    "!   The identifier of the model that is to be used for the recognition request. See
    "!    [Languages and
    "!    models](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -models#models).
    "! @parameter I_CALLBACK_URL |
    "!   A URL to which callback notifications are to be sent. The URL must already be
    "!    successfully white-listed by using the **Register a callback** method. You can
    "!    include the same callback URL with any number of job creation requests. Omit
    "!    the parameter to poll the service for job completion and results. <br/>
    "!   <br/>
    "!   Use the `user_token` parameter to specify a unique user-specified string with
    "!    each job to differentiate the callback notifications for the jobs.
    "! @parameter I_EVENTS |
    "!   If the job includes a callback URL, a comma-separated list of notification
    "!    events to which to subscribe. Valid events are<br/>
    "!   * `recognitions.started` generates a callback notification when the service
    "!    begins to process the job.<br/>
    "!   * `recognitions.completed` generates a callback notification when the job is
    "!    complete. You must use the **Check a job** method to retrieve the results
    "!    before they time out or are deleted.<br/>
    "!   * `recognitions.completed_with_results` generates a callback notification when
    "!    the job is complete. The notification includes the results of the request.<br/>
    "!   * `recognitions.failed` generates a callback notification if the service
    "!    experiences an error while processing the job. <br/>
    "!   <br/>
    "!   The `recognitions.completed` and `recognitions.completed_with_results` events
    "!    are incompatible. You can specify only of the two events. <br/>
    "!   <br/>
    "!   If the job includes a callback URL, omit the parameter to subscribe to the
    "!    default events: `recognitions.started`, `recognitions.completed`, and
    "!    `recognitions.failed`. If the job does not include a callback URL, omit the
    "!    parameter.
    "! @parameter I_USER_TOKEN |
    "!   If the job includes a callback URL, a user-specified string that the service is
    "!    to include with each callback notification for the job; the token allows the
    "!    user to maintain an internal mapping between jobs and notification events. If
    "!    the job does not include a callback URL, omit the parameter.
    "! @parameter I_RESULTS_TTL |
    "!   The number of minutes for which the results are to be available after the job
    "!    has finished. If not delivered via a callback, the results must be retrieved
    "!    within this time. Omit the parameter to use a time to live of one week. The
    "!    parameter is valid with or without a callback URL.
    "! @parameter I_LANGUAGE_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of a custom language model that is to be used with
    "!    the recognition request. The base model of the specified custom language model
    "!    must match the model specified with the `model` parameter. You must make the
    "!    request with credentials for the instance of the service that owns the custom
    "!    model. By default, no custom language model is used. See [Custom
    "!    models](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -input#custom-input). <br/>
    "!   <br/>
    "!   **Note:** Use this parameter instead of the deprecated `customization_id`
    "!    parameter.
    "! @parameter I_ACOUSTIC_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of a custom acoustic model that is to be used with
    "!    the recognition request. The base model of the specified custom acoustic model
    "!    must match the model specified with the `model` parameter. You must make the
    "!    request with credentials for the instance of the service that owns the custom
    "!    model. By default, no custom acoustic model is used. See [Custom
    "!    models](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -input#custom-input).
    "! @parameter I_BASE_MODEL_VERSION |
    "!   The version of the specified base model that is to be used with the recognition
    "!    request. Multiple versions of a base model can exist when a model is updated
    "!    for internal improvements. The parameter is intended primarily for use with
    "!    custom models that have been upgraded for a new base model. The default value
    "!    depends on whether the parameter is used with or without a custom model. See
    "!    [Base model
    "!    version](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-tex
    "!   t-input#version).
    "! @parameter I_CUSTOMIZATION_WEIGHT |
    "!   If you specify the customization ID (GUID) of a custom language model with the
    "!    recognition request, the customization weight tells the service how much weight
    "!    to give to words from the custom language model compared to those from the base
    "!    model for the current request. <br/>
    "!   <br/>
    "!   Specify a value between 0.0 and 1.0. Unless a different customization weight was
    "!    specified for the custom model when it was trained, the default value is 0.3. A
    "!    customization weight that you specify overrides a weight that was specified
    "!    when the custom model was trained. <br/>
    "!   <br/>
    "!   The default value yields the best performance in general. Assign a higher value
    "!    if your audio makes frequent use of OOV words from the custom model. Use
    "!    caution when setting the weight: a higher value can improve the accuracy of
    "!    phrases from the custom model's domain, but it can negatively affect
    "!    performance on non-domain phrases. <br/>
    "!   <br/>
    "!   See [Custom
    "!    models](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -input#custom-input).
    "! @parameter I_INACTIVITY_TIMEOUT |
    "!   The time in seconds after which, if only silence (no speech) is detected in
    "!    streaming audio, the connection is closed with a 400 error. The parameter is
    "!    useful for stopping audio submission from a live microphone when a user simply
    "!    walks away. Use `-1` for infinity. See [Inactivity
    "!    timeout](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-tex
    "!   t-input#timeouts-inactivity).
    "! @parameter I_KEYWORDS |
    "!   An array of keyword strings to spot in the audio. Each keyword string can
    "!    include one or more string tokens. Keywords are spotted only in the final
    "!    results, not in interim hypotheses. If you specify any keywords, you must also
    "!    specify a keywords threshold. You can spot a maximum of 1000 keywords. Omit the
    "!    parameter or specify an empty array if you do not need to spot keywords. See
    "!    [Keyword
    "!    spotting](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-te
    "!   xt-output#keyword_spotting).
    "! @parameter I_KEYWORDS_THRESHOLD |
    "!   A confidence value that is the lower bound for spotting a keyword. A word is
    "!    considered to match a keyword if its confidence is greater than or equal to the
    "!    threshold. Specify a probability between 0.0 and 1.0. If you specify a
    "!    threshold, you must also specify one or more keywords. The service performs no
    "!    keyword spotting if you omit either parameter. See [Keyword
    "!    spotting](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-te
    "!   xt-output#keyword_spotting).
    "! @parameter I_MAX_ALTERNATIVES |
    "!   The maximum number of alternative transcripts that the service is to return. By
    "!    default, the service returns a single transcript. If you specify a value of
    "!    `0`, the service uses the default value, `1`. See [Maximum
    "!    alternatives](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-t
    "!   o-text-output#max_alternatives).
    "! @parameter I_WORD_ALTERNATIVES_THRESHOLD |
    "!   A confidence value that is the lower bound for identifying a hypothesis as a
    "!    possible word alternative (also known as "Confusion Networks"). An alternative
    "!    word is considered if its confidence is greater than or equal to the threshold.
    "!    Specify a probability between 0.0 and 1.0. By default, the service computes no
    "!    alternative words. See [Word
    "!    alternatives](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-t
    "!   o-text-output#word_alternatives).
    "! @parameter I_WORD_CONFIDENCE |
    "!   If `true`, the service returns a confidence measure in the range of 0.0 to 1.0
    "!    for each word. By default, the service returns no word confidence scores. See
    "!    [Word
    "!    confidence](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-
    "!   text-output#word_confidence).
    "! @parameter I_TIMESTAMPS |
    "!   If `true`, the service returns time alignment for each word. By default, no
    "!    timestamps are returned. See [Word
    "!    timestamps](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-
    "!   text-output#word_timestamps).
    "! @parameter I_PROFANITY_FILTER |
    "!   If `true`, the service filters profanity from all output except for keyword
    "!    results by replacing inappropriate words with a series of asterisks. Set the
    "!    parameter to `false` to return results with no censoring. Applies to US English
    "!    transcription only. See [Profanity
    "!    filtering](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-t
    "!   ext-output#profanity_filter).
    "! @parameter I_SMART_FORMATTING |
    "!   If `true`, the service converts dates, times, series of digits and numbers,
    "!    phone numbers, currency values, and internet addresses into more readable,
    "!    conventional representations in the final transcript of a recognition request.
    "!    For US English, the service also converts certain keyword strings to
    "!    punctuation symbols. By default, the service performs no smart formatting.
    "!    <br/>
    "!   <br/>
    "!   **Note:** Applies to US English, Japanese, and Spanish transcription only. <br/>
    "!   <br/>
    "!   See [Smart
    "!    formatting](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-
    "!   text-output#smart_formatting).
    "! @parameter I_SPEAKER_LABELS |
    "!   If `true`, the response includes labels that identify which words were spoken by
    "!    which participants in a multi-person exchange. By default, the service returns
    "!    no speaker labels. Setting `speaker_labels` to `true` forces the `timestamps`
    "!    parameter to be `true`, regardless of whether you specify `false` for the
    "!    parameter. <br/>
    "!   <br/>
    "!   **Note:** Applies to US English, Japanese, and Spanish (both broadband and
    "!    narrowband models) and UK English (narrowband model) transcription only. To
    "!    determine whether a language model supports speaker labels, you can also use
    "!    the **Get a model** method and check that the attribute `speaker_labels` is set
    "!    to `true`. <br/>
    "!   <br/>
    "!   See [Speaker
    "!    labels](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text
    "!   -output#speaker_labels).
    "! @parameter I_CUSTOMIZATION_ID |
    "!   **Deprecated.** Use the `language_customization_id` parameter to specify the
    "!   ** customization ID (GUID) of a custom language model that is to be used with the
    "!   ** recognition request. Do not specify both parameters with a request.
    "! @parameter I_GRAMMAR_NAME |
    "!   The name of a grammar that is to be used with the recognition request. If you
    "!    specify a grammar, you must also use the `language_customization_id` parameter
    "!    to specify the name of the custom language model for which the grammar is
    "!    defined. The service recognizes only strings that are recognized by the
    "!    specified grammar; it does not recognize other custom words from the model's
    "!    words resource. See
    "!    [Grammars](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-t
    "!   ext-input#grammars-input).
    "! @parameter I_REDACTION |
    "!   If `true`, the service redacts, or masks, numeric data from final transcripts.
    "!    The feature redacts any number that has three or more consecutive digits by
    "!    replacing each digit with an `X` character. It is intended to redact sensitive
    "!    numeric data, such as credit card numbers. By default, the service performs no
    "!    redaction. <br/>
    "!   <br/>
    "!   When you enable redaction, the service automatically enables smart formatting,
    "!    regardless of whether you explicitly disable that feature. To ensure maximum
    "!    security, the service also disables keyword spotting (ignores the `keywords`
    "!    and `keywords_threshold` parameters) and returns only a single final transcript
    "!    (forces the `max_alternatives` parameter to be `1`). <br/>
    "!   <br/>
    "!   **Note:** Applies to US English, Japanese, and Korean transcription only. <br/>
    "!   <br/>
    "!   See [Numeric
    "!    redaction](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-t
    "!   ext-output#redaction).
    "! @parameter I_PROCESSING_METRICS |
    "!   If `true`, requests processing metrics about the service's transcription of the
    "!    input audio. The service returns processing metrics at the interval specified
    "!    by the `processing_metrics_interval` parameter. It also returns processing
    "!    metrics for transcription events, for example, for final and interim results.
    "!    By default, the service returns no processing metrics. <br/>
    "!   <br/>
    "!   See [Processing
    "!    metrics](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-tex
    "!   t-metrics#processing_metrics).
    "! @parameter I_PROCESSING_METRICS_INTERVAL |
    "!   Specifies the interval in real wall-clock seconds at which the service is to
    "!    return processing metrics. The parameter is ignored unless the
    "!    `processing_metrics` parameter is set to `true`. <br/>
    "!   <br/>
    "!   The parameter accepts a minimum value of 0.1 seconds. The level of precision is
    "!    not restricted, so you can specify values such as 0.25 and 0.125. <br/>
    "!   <br/>
    "!   The service does not impose a maximum value. If you want to receive processing
    "!    metrics only for transcription events instead of at periodic intervals, set the
    "!    value to a large number. If the value is larger than the duration of the audio,
    "!    the service returns processing metrics only for transcription events. <br/>
    "!   <br/>
    "!   See [Processing
    "!    metrics](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-tex
    "!   t-metrics#processing_metrics).
    "! @parameter I_AUDIO_METRICS |
    "!   If `true`, requests detailed information about the signal characteristics of the
    "!    input audio. The service returns audio metrics with the final transcription
    "!    results. By default, the service returns no audio metrics. <br/>
    "!   <br/>
    "!   See [Audio
    "!    metrics](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-tex
    "!   t-metrics#audio_metrics).
    "! @parameter I_END_OF_PHRASE_SILENCE_TIME |
    "!   If `true`, specifies the duration of the pause interval at which the service
    "!    splits a transcript into multiple final results. If the service detects pauses
    "!    or extended silence before it reaches the end of the audio stream, its response
    "!    can include multiple final results. Silence indicates a point at which the
    "!    speaker pauses between spoken words or phrases. <br/>
    "!   <br/>
    "!   Specify a value for the pause interval in the range of 0.0 to 120.0.<br/>
    "!   * A value greater than 0 specifies the interval that the service is to use for
    "!    speech recognition.<br/>
    "!   * A value of 0 indicates that the service is to use the default interval. It is
    "!    equivalent to omitting the parameter. <br/>
    "!   <br/>
    "!   The default pause interval for most languages is 0.8 seconds; the default for
    "!    Chinese is 0.6 seconds. <br/>
    "!   <br/>
    "!   See [End of phrase silence
    "!    time](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text-o
    "!   utput#silence_time).
    "! @parameter I_SPLT_TRNSCRPT_AT_PHRASE_END |
    "!   If `true`, directs the service to split the transcript into multiple final
    "!    results based on semantic features of the input, for example, at the conclusion
    "!    of meaningful phrases such as sentences. The service bases its understanding of
    "!    semantic features on the base language model that you use with a request.
    "!    Custom language models and grammars can also influence how and where the
    "!    service splits a transcript. By default, the service splits transcripts based
    "!    solely on the pause interval. <br/>
    "!   <br/>
    "!   See [Split transcript at phrase
    "!    end](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text-ou
    "!   tput#split_transcript).
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_RECOGNITION_JOB
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_JOB
    importing
      !I_AUDIO type FILE
      !I_CONTENT_TYPE type STRING default 'application/octet-stream'
      !I_MODEL type STRING default 'en-US_BroadbandModel'
      !I_CALLBACK_URL type STRING optional
      !I_EVENTS type STRING optional
      !I_USER_TOKEN type STRING optional
      !I_RESULTS_TTL type INTEGER optional
      !I_LANGUAGE_CUSTOMIZATION_ID type STRING optional
      !I_ACOUSTIC_CUSTOMIZATION_ID type STRING optional
      !I_BASE_MODEL_VERSION type STRING optional
      !I_CUSTOMIZATION_WEIGHT type DOUBLE optional
      !I_INACTIVITY_TIMEOUT type INTEGER optional
      !I_KEYWORDS type TT_STRING optional
      !I_KEYWORDS_THRESHOLD type FLOAT optional
      !I_MAX_ALTERNATIVES type INTEGER optional
      !I_WORD_ALTERNATIVES_THRESHOLD type FLOAT optional
      !I_WORD_CONFIDENCE type BOOLEAN default c_boolean_false
      !I_TIMESTAMPS type BOOLEAN default c_boolean_false
      !I_PROFANITY_FILTER type BOOLEAN default c_boolean_true
      !I_SMART_FORMATTING type BOOLEAN default c_boolean_false
      !I_SPEAKER_LABELS type BOOLEAN default c_boolean_false
      !I_CUSTOMIZATION_ID type STRING optional
      !I_GRAMMAR_NAME type STRING optional
      !I_REDACTION type BOOLEAN default c_boolean_false
      !I_PROCESSING_METRICS type BOOLEAN default c_boolean_false
      !I_PROCESSING_METRICS_INTERVAL type FLOAT optional
      !I_AUDIO_METRICS type BOOLEAN default c_boolean_false
      !I_END_OF_PHRASE_SILENCE_TIME type DOUBLE optional
      !I_SPLT_TRNSCRPT_AT_PHRASE_END type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_RECOGNITION_JOB
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Check jobs.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_RECOGNITION_JOBS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
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
    "! @parameter I_ID |
    "!   The identifier of the asynchronous job that is to be used for the request. You
    "!    must make the request with credentials for the instance of the service that
    "!    owns the job.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_RECOGNITION_JOB
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CHECK_JOB
    importing
      !I_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_RECOGNITION_JOB
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a job.
    "!
    "! @parameter I_ID |
    "!   The identifier of the asynchronous job that is to be used for the request. You
    "!    must make the request with credentials for the instance of the service that
    "!    owns the job.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_JOB
    importing
      !I_ID type STRING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Create a custom language model.
    "!
    "! @parameter I_CREATE_LANGUAGE_MODEL |
    "!   A `CreateLanguageModel` object that provides basic information about the new
    "!    custom language model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LANGUAGE_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_LANGUAGE_MODEL
    importing
      !I_CREATE_LANGUAGE_MODEL type T_CREATE_LANGUAGE_MODEL
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LANGUAGE_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! List custom language models.
    "!
    "! @parameter I_LANGUAGE |
    "!   The identifier of the language for which custom language or custom acoustic
    "!    models are to be returned (for example, `en-US`). Omit the parameter to see all
    "!    custom language or custom acoustic models that are owned by the requesting
    "!    credentials.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LANGUAGE_MODELS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_LANGUAGE_MODELS
    importing
      !I_LANGUAGE type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LANGUAGE_MODELS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get a custom language model.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_LANGUAGE_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_LANGUAGE_MODEL
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_LANGUAGE_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a custom language model.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_LANGUAGE_MODEL
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Train a custom language model.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_WORD_TYPE_TO_ADD |
    "!   The type of words from the custom language model's words resource on which to
    "!    train the model:<br/>
    "!   * `all` (the default) trains the model on all new words, regardless of whether
    "!    they were extracted from corpora or grammars or were added or modified by the
    "!    user.<br/>
    "!   * `user` trains the model only on new words that were added or modified by the
    "!    user directly. The model is not trained on new words extracted from corpora or
    "!    grammars.
    "! @parameter I_CUSTOMIZATION_WEIGHT |
    "!   Specifies a customization weight for the custom language model. The
    "!    customization weight tells the service how much weight to give to words from
    "!    the custom language model compared to those from the base model for speech
    "!    recognition. Specify a value between 0.0 and 1.0; the default is 0.3. <br/>
    "!   <br/>
    "!   The default value yields the best performance in general. Assign a higher value
    "!    if your audio makes frequent use of OOV words from the custom model. Use
    "!    caution when setting the weight: a higher value can improve the accuracy of
    "!    phrases from the custom model's domain, but it can negatively affect
    "!    performance on non-domain phrases. <br/>
    "!   <br/>
    "!   The value that you assign is used for all recognition requests that use the
    "!    model. You can override it for any recognition request by specifying a
    "!    customization weight for that request.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods TRAIN_LANGUAGE_MODEL
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_WORD_TYPE_TO_ADD type STRING default 'all'
      !I_CUSTOMIZATION_WEIGHT type DOUBLE optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Reset a custom language model.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods RESET_LANGUAGE_MODEL
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Upgrade a custom language model.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPGRADE_LANGUAGE_MODEL
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List corpora.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CORPORA
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_CORPORA
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CORPORA
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Add a corpus.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_CORPUS_NAME |
    "!   The name of the new corpus for the custom language model. Use a localized name
    "!    that matches the language of the custom model and reflects the contents of the
    "!    corpus.<br/>
    "!   * Include a maximum of 128 characters in the name.<br/>
    "!   * Do not use characters that need to be URL-encoded. For example, do not use
    "!    spaces, slashes, backslashes, colons, ampersands, double quotes, plus signs,
    "!    equals signs, questions marks, and so on in the name. (The service does not
    "!    prevent the use of these characters. But because they must be URL-encoded
    "!    wherever used, their use is strongly discouraged.)<br/>
    "!   * Do not use the name of an existing corpus or grammar that is already defined
    "!    for the custom model.<br/>
    "!   * Do not use the name `user`, which is reserved by the service to denote custom
    "!    words that are added or modified by the user.<br/>
    "!   * Do not use the name `base_lm` or `default_lm`. Both names are reserved for
    "!    future use by the service.
    "! @parameter I_CORPUS_FILE |
    "!   A plain text file that contains the training data for the corpus. Encode the
    "!    file in UTF-8 if it contains non-ASCII characters; the service assumes UTF-8
    "!    encoding if it encounters non-ASCII characters. <br/>
    "!   <br/>
    "!   Make sure that you know the character encoding of the file. You must use that
    "!    encoding when working with the words in the custom language model. For more
    "!    information, see [Character
    "!    encoding](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-te
    "!   xt-corporaWords#charEncoding). <br/>
    "!   <br/>
    "!   With the `curl` command, use the `--data-binary` option to upload the file for
    "!    the request.
    "! @parameter I_ALLOW_OVERWRITE |
    "!   If `true`, the specified corpus overwrites an existing corpus with the same
    "!    name. If `false`, the request fails if a corpus with the same name already
    "!    exists. The parameter has no effect if a corpus with the same name does not
    "!    already exist.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods ADD_CORPUS
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_CORPUS_NAME type STRING
      !I_CORPUS_FILE type FILE
      !I_ALLOW_OVERWRITE type BOOLEAN default c_boolean_false
      !I_CORPUS_FILE_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get a corpus.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_CORPUS_NAME |
    "!   The name of the corpus for the custom language model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CORPUS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_CORPUS
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_CORPUS_NAME type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CORPUS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a corpus.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_CORPUS_NAME |
    "!   The name of the corpus for the custom language model.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_CORPUS
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_CORPUS_NAME type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List custom words.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_WORD_TYPE |
    "!   The type of words to be listed from the custom language model's words
    "!    resource:<br/>
    "!   * `all` (the default) shows all words.<br/>
    "!   * `user` shows only custom words that were added or modified by the user
    "!    directly.<br/>
    "!   * `corpora` shows only OOV that were extracted from corpora.<br/>
    "!   * `grammars` shows only OOV words that are recognized by grammars.
    "! @parameter I_SORT |
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
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_WORDS
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_WORD_TYPE type STRING default 'all'
      !I_SORT type STRING default 'alphabetical'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_WORDS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Add custom words.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_CUSTOM_WORDS |
    "!   A `CustomWords` object that provides information about one or more custom words
    "!    that are to be added to or updated in the custom language model.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods ADD_WORDS
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_CUSTOM_WORDS type T_CUSTOM_WORDS
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Add a custom word.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_WORD_NAME |
    "!   The custom word that is to be added to or updated in the custom language model.
    "!    Do not include spaces in the word. Use a `-` (dash) or `_` (underscore) to
    "!    connect the tokens of compound words. URL-encode the word if it includes
    "!    non-ASCII characters. For more information, see [Character
    "!    encoding](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-te
    "!   xt-corporaWords#charEncoding).
    "! @parameter I_CUSTOM_WORD |
    "!   A `CustomWord` object that provides information about the specified custom word.
    "!    Specify an empty object to add a word with no sounds-like or display-as
    "!    information.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods ADD_WORD
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_WORD_NAME type STRING
      !I_CUSTOM_WORD type T_CUSTOM_WORD
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get a custom word.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_WORD_NAME |
    "!   The custom word that is to be read from the custom language model. URL-encode
    "!    the word if it includes non-ASCII characters. For more information, see
    "!    [Character
    "!    encoding](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-te
    "!   xt-corporaWords#charEncoding).
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_WORD
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_WORD
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_WORD_NAME type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_WORD
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a custom word.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_WORD_NAME |
    "!   The custom word that is to be deleted from the custom language model. URL-encode
    "!    the word if it includes non-ASCII characters. For more information, see
    "!    [Character
    "!    encoding](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-te
    "!   xt-corporaWords#charEncoding).
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_WORD
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_WORD_NAME type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List grammars.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_GRAMMARS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_GRAMMARS
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_GRAMMARS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Add a grammar.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_GRAMMAR_NAME |
    "!   The name of the new grammar for the custom language model. Use a localized name
    "!    that matches the language of the custom model and reflects the contents of the
    "!    grammar.<br/>
    "!   * Include a maximum of 128 characters in the name.<br/>
    "!   * Do not use characters that need to be URL-encoded. For example, do not use
    "!    spaces, slashes, backslashes, colons, ampersands, double quotes, plus signs,
    "!    equals signs, questions marks, and so on in the name. (The service does not
    "!    prevent the use of these characters. But because they must be URL-encoded
    "!    wherever used, their use is strongly discouraged.)<br/>
    "!   * Do not use the name of an existing grammar or corpus that is already defined
    "!    for the custom model.<br/>
    "!   * Do not use the name `user`, which is reserved by the service to denote custom
    "!    words that are added or modified by the user.<br/>
    "!   * Do not use the name `base_lm` or `default_lm`. Both names are reserved for
    "!    future use by the service.
    "! @parameter I_GRAMMAR_FILE |
    "!   A plain text file that contains the grammar in the format specified by the
    "!    `Content-Type` header. Encode the file in UTF-8 (ASCII is a subset of UTF-8).
    "!    Using any other encoding can lead to issues when compiling the grammar or to
    "!    unexpected results in decoding. The service ignores an encoding that is
    "!    specified in the header of the grammar. <br/>
    "!   <br/>
    "!   With the `curl` command, use the `--data-binary` option to upload the file for
    "!    the request.
    "! @parameter I_CONTENT_TYPE |
    "!   The format (MIME type) of the grammar file:<br/>
    "!   * `application/srgs` for Augmented Backus-Naur Form (ABNF), which uses a
    "!    plain-text representation that is similar to traditional BNF grammars.<br/>
    "!   * `application/srgs+xml` for XML Form, which uses XML elements to represent the
    "!    grammar.
    "! @parameter I_ALLOW_OVERWRITE |
    "!   If `true`, the specified grammar overwrites an existing grammar with the same
    "!    name. If `false`, the request fails if a grammar with the same name already
    "!    exists. The parameter has no effect if a grammar with the same name does not
    "!    already exist.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods ADD_GRAMMAR
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_GRAMMAR_NAME type STRING
      !I_GRAMMAR_FILE type STRING
      !I_CONTENT_TYPE type STRING default 'application/srgs'
      !I_ALLOW_OVERWRITE type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get a grammar.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_GRAMMAR_NAME |
    "!   The name of the grammar for the custom language model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_GRAMMAR
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_GRAMMAR
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_GRAMMAR_NAME type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_GRAMMAR
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a grammar.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_GRAMMAR_NAME |
    "!   The name of the grammar for the custom language model.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_GRAMMAR
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_GRAMMAR_NAME type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Create a custom acoustic model.
    "!
    "! @parameter I_CREATE_ACOUSTIC_MODEL |
    "!   A `CreateAcousticModel` object that provides basic information about the new
    "!    custom acoustic model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ACOUSTIC_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_ACOUSTIC_MODEL
    importing
      !I_CREATE_ACOUSTIC_MODEL type T_CREATE_ACOUSTIC_MODEL
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ACOUSTIC_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! List custom acoustic models.
    "!
    "! @parameter I_LANGUAGE |
    "!   The identifier of the language for which custom language or custom acoustic
    "!    models are to be returned (for example, `en-US`). Omit the parameter to see all
    "!    custom language or custom acoustic models that are owned by the requesting
    "!    credentials.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ACOUSTIC_MODELS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_ACOUSTIC_MODELS
    importing
      !I_LANGUAGE type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ACOUSTIC_MODELS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get a custom acoustic model.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom acoustic model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ACOUSTIC_MODEL
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_ACOUSTIC_MODEL
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ACOUSTIC_MODEL
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a custom acoustic model.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom acoustic model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_ACOUSTIC_MODEL
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Train a custom acoustic model.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom acoustic model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_CUSTOM_LANGUAGE_MODEL_ID |
    "!   The customization ID (GUID) of a custom language model that is to be used during
    "!    training of the custom acoustic model. Specify a custom language model that has
    "!    been trained with verbatim transcriptions of the audio resources or that
    "!    contains words that are relevant to the contents of the audio resources. The
    "!    custom language model must be based on the same version of the same base model
    "!    as the custom acoustic model. The credentials specified with the request must
    "!    own both custom models.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods TRAIN_ACOUSTIC_MODEL
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_CUSTOM_LANGUAGE_MODEL_ID type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Reset a custom acoustic model.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom acoustic model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods RESET_ACOUSTIC_MODEL
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Upgrade a custom acoustic model.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom acoustic model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_CUSTOM_LANGUAGE_MODEL_ID |
    "!   If the custom acoustic model was trained with a custom language model, the
    "!    customization ID (GUID) of that custom language model. The custom language
    "!    model must be upgraded before the custom acoustic model can be upgraded. The
    "!    credentials specified with the request must own both custom models.
    "! @parameter I_FORCE |
    "!   If `true`, forces the upgrade of a custom acoustic model for which no input data
    "!    has been modified since it was last trained. Use this parameter only to force
    "!    the upgrade of a custom acoustic model that is trained with a custom language
    "!    model, and only if you receive a 400 response code and the message `No input
    "!    data modified since last training`. See [Upgrading a custom acoustic
    "!    model](https://cloud.ibm.com/docs/services/speech-to-text?topic=speech-to-text-
    "!   customUpgrade#upgradeAcoustic).
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPGRADE_ACOUSTIC_MODEL
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_CUSTOM_LANGUAGE_MODEL_ID type STRING optional
      !I_FORCE type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! List audio resources.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom acoustic model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_AUDIO_RESOURCES
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_AUDIO
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_AUDIO_RESOURCES
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Add an audio resource.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom acoustic model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_AUDIO_NAME |
    "!   The name of the new audio resource for the custom acoustic model. Use a
    "!    localized name that matches the language of the custom model and reflects the
    "!    contents of the resource.<br/>
    "!   * Include a maximum of 128 characters in the name.<br/>
    "!   * Do not use characters that need to be URL-encoded. For example, do not use
    "!    spaces, slashes, backslashes, colons, ampersands, double quotes, plus signs,
    "!    equals signs, questions marks, and so on in the name. (The service does not
    "!    prevent the use of these characters. But because they must be URL-encoded
    "!    wherever used, their use is strongly discouraged.)<br/>
    "!   * Do not use the name of an audio resource that has already been added to the
    "!    custom model.
    "! @parameter I_AUDIO_RESOURCE |
    "!   The audio resource that is to be added to the custom acoustic model, an
    "!    individual audio file or an archive file. <br/>
    "!   <br/>
    "!   With the `curl` command, use the `--data-binary` option to upload the file for
    "!    the request.
    "! @parameter I_CONTENT_TYPE |
    "!   For an audio-type resource, the format (MIME type) of the audio. For more
    "!    information, see **Content types for audio-type resources** in the method
    "!    description. <br/>
    "!   <br/>
    "!   For an archive-type resource, the media type of the archive file. For more
    "!    information, see **Content types for archive-type resources** in the method
    "!    description.
    "! @parameter I_CONTAINED_CONTENT_TYPE |
    "!   **For an archive-type resource,** specify the format of the audio files that are
    "!   ** contained in the archive file if they are of type `audio/alaw`, `audio/basic`,
    "!   ** `audio/l16`, or `audio/mulaw`. Include the `rate`, `channels`, and `endianness`
    "!   ** parameters where necessary. In this case, all audio files that are contained in
    "!   ** the archive file must be of the indicated type. <br/>
    "!   **<br/>
    "!   **For all other audio formats, you can omit the header. In this case, the audio
    "!   ** files can be of multiple types as long as they are not of the types listed in
    "!   ** the previous paragraph. <br/>
    "!   **<br/>
    "!   **The parameter accepts all of the audio formats that are supported for use with
    "!   ** speech recognition. For more information, see **Content types for audio-type
    "!   ** resources** in the method description. <br/>
    "!   **<br/>
    "!   ****For an audio-type resource,** omit the header.
    "! @parameter I_ALLOW_OVERWRITE |
    "!   If `true`, the specified audio resource overwrites an existing audio resource
    "!    with the same name. If `false`, the request fails if an audio resource with the
    "!    same name already exists. The parameter has no effect if an audio resource with
    "!    the same name does not already exist.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods ADD_AUDIO
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_AUDIO_NAME type STRING
      !I_AUDIO_RESOURCE type FILE
      !I_CONTENT_TYPE type STRING default 'application/zip'
      !I_CONTAINED_CONTENT_TYPE type STRING optional
      !I_ALLOW_OVERWRITE type BOOLEAN default c_boolean_false
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get an audio resource.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom acoustic model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_AUDIO_NAME |
    "!   The name of the audio resource for the custom acoustic model.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_AUDIO_LISTING
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_AUDIO
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_AUDIO_NAME type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_AUDIO_LISTING
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete an audio resource.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom acoustic model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_AUDIO_NAME |
    "!   The name of the audio resource for the custom acoustic model.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_AUDIO
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_AUDIO_NAME type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Delete labeled data.
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
  e_request_prop-url-path_base   = '/speech-to-text/api'.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20200210092825'.

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
* | [--->] I_MODEL_ID        TYPE STRING
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
    replace all occurrences of `{model_id}` in ls_request_prop-url-path with i_MODEL_ID ignoring case.

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
* | [--->] I_AUDIO        TYPE FILE
* | [--->] I_CONTENT_TYPE        TYPE STRING (default ='application/octet-stream')
* | [--->] I_MODEL        TYPE STRING (default ='en-US_BroadbandModel')
* | [--->] I_LANGUAGE_CUSTOMIZATION_ID        TYPE STRING(optional)
* | [--->] I_ACOUSTIC_CUSTOMIZATION_ID        TYPE STRING(optional)
* | [--->] I_BASE_MODEL_VERSION        TYPE STRING(optional)
* | [--->] I_CUSTOMIZATION_WEIGHT        TYPE DOUBLE(optional)
* | [--->] I_INACTIVITY_TIMEOUT        TYPE INTEGER(optional)
* | [--->] I_KEYWORDS        TYPE TT_STRING(optional)
* | [--->] I_KEYWORDS_THRESHOLD        TYPE FLOAT(optional)
* | [--->] I_MAX_ALTERNATIVES        TYPE INTEGER(optional)
* | [--->] I_WORD_ALTERNATIVES_THRESHOLD        TYPE FLOAT(optional)
* | [--->] I_WORD_CONFIDENCE        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_TIMESTAMPS        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_PROFANITY_FILTER        TYPE BOOLEAN (default =c_boolean_true)
* | [--->] I_SMART_FORMATTING        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_SPEAKER_LABELS        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING(optional)
* | [--->] I_GRAMMAR_NAME        TYPE STRING(optional)
* | [--->] I_REDACTION        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_AUDIO_METRICS        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_END_OF_PHRASE_SILENCE_TIME        TYPE DOUBLE(optional)
* | [--->] I_SPLT_TRNSCRPT_AT_PHRASE_END        TYPE BOOLEAN (default =c_boolean_false)
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

    if i_MODEL is supplied.
    lv_queryparam = escape( val = i_MODEL format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `model`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_LANGUAGE_CUSTOMIZATION_ID is supplied.
    lv_queryparam = escape( val = i_LANGUAGE_CUSTOMIZATION_ID format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `language_customization_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_ACOUSTIC_CUSTOMIZATION_ID is supplied.
    lv_queryparam = escape( val = i_ACOUSTIC_CUSTOMIZATION_ID format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `acoustic_customization_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_BASE_MODEL_VERSION is supplied.
    lv_queryparam = escape( val = i_BASE_MODEL_VERSION format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `base_model_version`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CUSTOMIZATION_WEIGHT is supplied.
    lv_queryparam = i_CUSTOMIZATION_WEIGHT.
    add_query_parameter(
      exporting
        i_parameter  = `customization_weight`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INACTIVITY_TIMEOUT is supplied.
    lv_queryparam = i_INACTIVITY_TIMEOUT.
    add_query_parameter(
      exporting
        i_parameter  = `inactivity_timeout`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_KEYWORDS is supplied.
    data:
      lv_item_KEYWORDS type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_KEYWORDS into lv_item_KEYWORDS.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_KEYWORDS.
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

    if i_KEYWORDS_THRESHOLD is supplied.
    lv_queryparam = i_KEYWORDS_THRESHOLD.
    add_query_parameter(
      exporting
        i_parameter  = `keywords_threshold`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_MAX_ALTERNATIVES is supplied.
    lv_queryparam = i_MAX_ALTERNATIVES.
    add_query_parameter(
      exporting
        i_parameter  = `max_alternatives`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_WORD_ALTERNATIVES_THRESHOLD is supplied.
    lv_queryparam = i_WORD_ALTERNATIVES_THRESHOLD.
    add_query_parameter(
      exporting
        i_parameter  = `word_alternatives_threshold`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_WORD_CONFIDENCE is supplied.
    lv_queryparam = i_WORD_CONFIDENCE.
    add_query_parameter(
      exporting
        i_parameter  = `word_confidence`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_TIMESTAMPS is supplied.
    lv_queryparam = i_TIMESTAMPS.
    add_query_parameter(
      exporting
        i_parameter  = `timestamps`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_PROFANITY_FILTER is supplied.
    lv_queryparam = i_PROFANITY_FILTER.
    add_query_parameter(
      exporting
        i_parameter  = `profanity_filter`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SMART_FORMATTING is supplied.
    lv_queryparam = i_SMART_FORMATTING.
    add_query_parameter(
      exporting
        i_parameter  = `smart_formatting`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SPEAKER_LABELS is supplied.
    lv_queryparam = i_SPEAKER_LABELS.
    add_query_parameter(
      exporting
        i_parameter  = `speaker_labels`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
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

    if i_GRAMMAR_NAME is supplied.
    lv_queryparam = escape( val = i_GRAMMAR_NAME format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `grammar_name`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_REDACTION is supplied.
    lv_queryparam = i_REDACTION.
    add_query_parameter(
      exporting
        i_parameter  = `redaction`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_AUDIO_METRICS is supplied.
    lv_queryparam = i_AUDIO_METRICS.
    add_query_parameter(
      exporting
        i_parameter  = `audio_metrics`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_END_OF_PHRASE_SILENCE_TIME is supplied.
    lv_queryparam = i_END_OF_PHRASE_SILENCE_TIME.
    add_query_parameter(
      exporting
        i_parameter  = `end_of_phrase_silence_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SPLT_TRNSCRPT_AT_PHRASE_END is supplied.
    lv_queryparam = i_SPLT_TRNSCRPT_AT_PHRASE_END.
    add_query_parameter(
      exporting
        i_parameter  = `split_transcript_at_phrase_end`
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->REGISTER_CALLBACK
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CALLBACK_URL        TYPE STRING
* | [--->] I_USER_SECRET        TYPE STRING(optional)
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

    lv_queryparam = escape( val = i_CALLBACK_URL format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `callback_url`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.

    if i_USER_SECRET is supplied.
    lv_queryparam = escape( val = i_USER_SECRET format = cl_abap_format=>e_uri_full ).
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
* | [--->] I_CALLBACK_URL        TYPE STRING
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

    lv_queryparam = escape( val = i_CALLBACK_URL format = cl_abap_format=>e_uri_full ).
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
* | [--->] I_AUDIO        TYPE FILE
* | [--->] I_CONTENT_TYPE        TYPE STRING (default ='application/octet-stream')
* | [--->] I_MODEL        TYPE STRING (default ='en-US_BroadbandModel')
* | [--->] I_CALLBACK_URL        TYPE STRING(optional)
* | [--->] I_EVENTS        TYPE STRING(optional)
* | [--->] I_USER_TOKEN        TYPE STRING(optional)
* | [--->] I_RESULTS_TTL        TYPE INTEGER(optional)
* | [--->] I_LANGUAGE_CUSTOMIZATION_ID        TYPE STRING(optional)
* | [--->] I_ACOUSTIC_CUSTOMIZATION_ID        TYPE STRING(optional)
* | [--->] I_BASE_MODEL_VERSION        TYPE STRING(optional)
* | [--->] I_CUSTOMIZATION_WEIGHT        TYPE DOUBLE(optional)
* | [--->] I_INACTIVITY_TIMEOUT        TYPE INTEGER(optional)
* | [--->] I_KEYWORDS        TYPE TT_STRING(optional)
* | [--->] I_KEYWORDS_THRESHOLD        TYPE FLOAT(optional)
* | [--->] I_MAX_ALTERNATIVES        TYPE INTEGER(optional)
* | [--->] I_WORD_ALTERNATIVES_THRESHOLD        TYPE FLOAT(optional)
* | [--->] I_WORD_CONFIDENCE        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_TIMESTAMPS        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_PROFANITY_FILTER        TYPE BOOLEAN (default =c_boolean_true)
* | [--->] I_SMART_FORMATTING        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_SPEAKER_LABELS        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING(optional)
* | [--->] I_GRAMMAR_NAME        TYPE STRING(optional)
* | [--->] I_REDACTION        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_PROCESSING_METRICS        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_PROCESSING_METRICS_INTERVAL        TYPE FLOAT(optional)
* | [--->] I_AUDIO_METRICS        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_END_OF_PHRASE_SILENCE_TIME        TYPE DOUBLE(optional)
* | [--->] I_SPLT_TRNSCRPT_AT_PHRASE_END        TYPE BOOLEAN (default =c_boolean_false)
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

    if i_MODEL is supplied.
    lv_queryparam = escape( val = i_MODEL format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `model`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CALLBACK_URL is supplied.
    lv_queryparam = escape( val = i_CALLBACK_URL format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `callback_url`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_EVENTS is supplied.
    lv_queryparam = escape( val = i_EVENTS format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `events`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_USER_TOKEN is supplied.
    lv_queryparam = escape( val = i_USER_TOKEN format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `user_token`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_RESULTS_TTL is supplied.
    lv_queryparam = i_RESULTS_TTL.
    add_query_parameter(
      exporting
        i_parameter  = `results_ttl`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_LANGUAGE_CUSTOMIZATION_ID is supplied.
    lv_queryparam = escape( val = i_LANGUAGE_CUSTOMIZATION_ID format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `language_customization_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_ACOUSTIC_CUSTOMIZATION_ID is supplied.
    lv_queryparam = escape( val = i_ACOUSTIC_CUSTOMIZATION_ID format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `acoustic_customization_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_BASE_MODEL_VERSION is supplied.
    lv_queryparam = escape( val = i_BASE_MODEL_VERSION format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `base_model_version`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CUSTOMIZATION_WEIGHT is supplied.
    lv_queryparam = i_CUSTOMIZATION_WEIGHT.
    add_query_parameter(
      exporting
        i_parameter  = `customization_weight`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_INACTIVITY_TIMEOUT is supplied.
    lv_queryparam = i_INACTIVITY_TIMEOUT.
    add_query_parameter(
      exporting
        i_parameter  = `inactivity_timeout`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_KEYWORDS is supplied.
    data:
      lv_item_KEYWORDS type STRING.
    clear: lv_queryparam, lv_sep.
    loop at i_KEYWORDS into lv_item_KEYWORDS.
      lv_queryparam = lv_queryparam && lv_sep && lv_item_KEYWORDS.
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

    if i_KEYWORDS_THRESHOLD is supplied.
    lv_queryparam = i_KEYWORDS_THRESHOLD.
    add_query_parameter(
      exporting
        i_parameter  = `keywords_threshold`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_MAX_ALTERNATIVES is supplied.
    lv_queryparam = i_MAX_ALTERNATIVES.
    add_query_parameter(
      exporting
        i_parameter  = `max_alternatives`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_WORD_ALTERNATIVES_THRESHOLD is supplied.
    lv_queryparam = i_WORD_ALTERNATIVES_THRESHOLD.
    add_query_parameter(
      exporting
        i_parameter  = `word_alternatives_threshold`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_WORD_CONFIDENCE is supplied.
    lv_queryparam = i_WORD_CONFIDENCE.
    add_query_parameter(
      exporting
        i_parameter  = `word_confidence`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_TIMESTAMPS is supplied.
    lv_queryparam = i_TIMESTAMPS.
    add_query_parameter(
      exporting
        i_parameter  = `timestamps`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_PROFANITY_FILTER is supplied.
    lv_queryparam = i_PROFANITY_FILTER.
    add_query_parameter(
      exporting
        i_parameter  = `profanity_filter`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SMART_FORMATTING is supplied.
    lv_queryparam = i_SMART_FORMATTING.
    add_query_parameter(
      exporting
        i_parameter  = `smart_formatting`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SPEAKER_LABELS is supplied.
    lv_queryparam = i_SPEAKER_LABELS.
    add_query_parameter(
      exporting
        i_parameter  = `speaker_labels`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
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

    if i_GRAMMAR_NAME is supplied.
    lv_queryparam = escape( val = i_GRAMMAR_NAME format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `grammar_name`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_REDACTION is supplied.
    lv_queryparam = i_REDACTION.
    add_query_parameter(
      exporting
        i_parameter  = `redaction`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_PROCESSING_METRICS is supplied.
    lv_queryparam = i_PROCESSING_METRICS.
    add_query_parameter(
      exporting
        i_parameter  = `processing_metrics`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_PROCESSING_METRICS_INTERVAL is supplied.
    lv_queryparam = i_PROCESSING_METRICS_INTERVAL.
    add_query_parameter(
      exporting
        i_parameter  = `processing_metrics_interval`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_AUDIO_METRICS is supplied.
    lv_queryparam = i_AUDIO_METRICS.
    add_query_parameter(
      exporting
        i_parameter  = `audio_metrics`
        i_value      = lv_queryparam
        i_is_boolean = c_boolean_true
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_END_OF_PHRASE_SILENCE_TIME is supplied.
    lv_queryparam = i_END_OF_PHRASE_SILENCE_TIME.
    add_query_parameter(
      exporting
        i_parameter  = `end_of_phrase_silence_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_SPLT_TRNSCRPT_AT_PHRASE_END is supplied.
    lv_queryparam = i_SPLT_TRNSCRPT_AT_PHRASE_END.
    add_query_parameter(
      exporting
        i_parameter  = `split_transcript_at_phrase_end`
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
* | [--->] I_ID        TYPE STRING
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
    replace all occurrences of `{id}` in ls_request_prop-url-path with i_ID ignoring case.

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
* | [--->] I_ID        TYPE STRING
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
    replace all occurrences of `{id}` in ls_request_prop-url-path with i_ID ignoring case.

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
* | [--->] I_CREATE_LANGUAGE_MODEL        TYPE T_CREATE_LANGUAGE_MODEL
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
    lv_datatype = get_datatype( i_CREATE_LANGUAGE_MODEL ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_CREATE_LANGUAGE_MODEL i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'create_language_model' i_value = i_CREATE_LANGUAGE_MODEL ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_CREATE_LANGUAGE_MODEL to <lv_text>.
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
* | [--->] I_LANGUAGE        TYPE STRING(optional)
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->GET_LANGUAGE_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->DELETE_LANGUAGE_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.

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
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_WORD_TYPE_TO_ADD        TYPE STRING (default ='all')
* | [--->] I_CUSTOMIZATION_WEIGHT        TYPE DOUBLE(optional)
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_WORD_TYPE_TO_ADD is supplied.
    lv_queryparam = escape( val = i_WORD_TYPE_TO_ADD format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `word_type_to_add`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_CUSTOMIZATION_WEIGHT is supplied.
    lv_queryparam = i_CUSTOMIZATION_WEIGHT.
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
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.

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
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.

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
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->ADD_CORPUS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_CORPUS_NAME        TYPE STRING
* | [--->] I_CORPUS_FILE        TYPE FILE
* | [--->] I_ALLOW_OVERWRITE        TYPE BOOLEAN (default =c_boolean_false)
* | [--->] I_CORPUS_FILE_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.
    replace all occurrences of `{corpus_name}` in ls_request_prop-url-path with i_CORPUS_NAME ignoring case.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_ALLOW_OVERWRITE is supplied.
    lv_queryparam = i_ALLOW_OVERWRITE.
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




    if not i_CORPUS_FILE is initial.
      lv_extension = get_file_extension( I_CORPUS_FILE_CT ).
      lv_value = `form-data; name="corpus_file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_CORPUS_FILE_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_CORPUS_FILE.
      append ls_form_part to lt_form_part.
    endif.


    " execute HTTP POST request
    lo_response = HTTP_POST_MULTIPART( i_request_prop = ls_request_prop it_form_part = lt_form_part ).





endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->GET_CORPUS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_CORPUS_NAME        TYPE STRING
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.
    replace all occurrences of `{corpus_name}` in ls_request_prop-url-path with i_CORPUS_NAME ignoring case.

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
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_CORPUS_NAME        TYPE STRING
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.
    replace all occurrences of `{corpus_name}` in ls_request_prop-url-path with i_CORPUS_NAME ignoring case.

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
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_WORD_TYPE        TYPE STRING (default ='all')
* | [--->] I_SORT        TYPE STRING (default ='alphabetical')
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

    " process query parameters
    data:
      lv_queryparam type string.

    if i_WORD_TYPE is supplied.
    lv_queryparam = escape( val = i_WORD_TYPE format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `word_type`
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
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_CUSTOM_WORDS        TYPE T_CUSTOM_WORDS
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->ADD_WORD
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_WORD_NAME        TYPE STRING
* | [--->] I_CUSTOM_WORD        TYPE T_CUSTOM_WORD
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.
    replace all occurrences of `{word_name}` in ls_request_prop-url-path with i_WORD_NAME ignoring case.

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
    lv_datatype = get_datatype( i_CUSTOM_WORD ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_CUSTOM_WORD i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'custom_word' i_value = i_CUSTOM_WORD ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_CUSTOM_WORD to <lv_text>.
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
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_WORD_NAME        TYPE STRING
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.
    replace all occurrences of `{word_name}` in ls_request_prop-url-path with i_WORD_NAME ignoring case.

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
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_WORD_NAME        TYPE STRING
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.
    replace all occurrences of `{word_name}` in ls_request_prop-url-path with i_WORD_NAME ignoring case.

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
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->ADD_GRAMMAR
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_GRAMMAR_NAME        TYPE STRING
* | [--->] I_GRAMMAR_FILE        TYPE STRING
* | [--->] I_CONTENT_TYPE        TYPE STRING (default ='application/srgs')
* | [--->] I_ALLOW_OVERWRITE        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.
    replace all occurrences of `{grammar_name}` in ls_request_prop-url-path with i_GRAMMAR_NAME ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_ALLOW_OVERWRITE is supplied.
    lv_queryparam = i_ALLOW_OVERWRITE.
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

    ls_request_prop-header_content_type = I_CONTENT_TYPE.



    " process body parameters
    data:
      lv_body      type string,
      lv_bodyparam type string,
      lv_datatype  type char.
    field-symbols:
      <lv_text> type any.
    lv_separator = ''.
    lv_datatype = get_datatype( i_GRAMMAR_FILE ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_GRAMMAR_FILE i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'grammar_file' i_value = i_GRAMMAR_FILE ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_GRAMMAR_FILE to <lv_text>.
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
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_GRAMMAR_NAME        TYPE STRING
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.
    replace all occurrences of `{grammar_name}` in ls_request_prop-url-path with i_GRAMMAR_NAME ignoring case.

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
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_GRAMMAR_NAME        TYPE STRING
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.
    replace all occurrences of `{grammar_name}` in ls_request_prop-url-path with i_GRAMMAR_NAME ignoring case.

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
* | [--->] I_CREATE_ACOUSTIC_MODEL        TYPE T_CREATE_ACOUSTIC_MODEL
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
    lv_datatype = get_datatype( i_CREATE_ACOUSTIC_MODEL ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_CREATE_ACOUSTIC_MODEL i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'create_acoustic_model' i_value = i_CREATE_ACOUSTIC_MODEL ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_CREATE_ACOUSTIC_MODEL to <lv_text>.
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
* | [--->] I_LANGUAGE        TYPE STRING(optional)
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->GET_ACOUSTIC_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->DELETE_ACOUSTIC_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.

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
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_CUSTOM_LANGUAGE_MODEL_ID        TYPE STRING(optional)
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_CUSTOM_LANGUAGE_MODEL_ID is supplied.
    lv_queryparam = escape( val = i_CUSTOM_LANGUAGE_MODEL_ID format = cl_abap_format=>e_uri_full ).
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
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.

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
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_CUSTOM_LANGUAGE_MODEL_ID        TYPE STRING(optional)
* | [--->] I_FORCE        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_CUSTOM_LANGUAGE_MODEL_ID is supplied.
    lv_queryparam = escape( val = i_CUSTOM_LANGUAGE_MODEL_ID format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `custom_language_model_id`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_FORCE is supplied.
    lv_queryparam = i_FORCE.
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
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
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
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->ADD_AUDIO
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_AUDIO_NAME        TYPE STRING
* | [--->] I_AUDIO_RESOURCE        TYPE FILE
* | [--->] I_CONTENT_TYPE        TYPE STRING (default ='application/zip')
* | [--->] I_CONTAINED_CONTENT_TYPE        TYPE STRING(optional)
* | [--->] I_ALLOW_OVERWRITE        TYPE BOOLEAN (default =c_boolean_false)
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.
    replace all occurrences of `{audio_name}` in ls_request_prop-url-path with i_AUDIO_NAME ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_ALLOW_OVERWRITE is supplied.
    lv_queryparam = i_ALLOW_OVERWRITE.
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

    if i_CONTENT_TYPE is supplied.
    ls_request_prop-header_content_type = I_CONTENT_TYPE.
    endif.

    if i_CONTAINED_CONTENT_TYPE is supplied.
    lv_headerparam = I_CONTAINED_CONTENT_TYPE.
    add_header_parameter(
      exporting
        i_parameter  = 'Contained-Content-Type'
        i_value      = lv_headerparam
      changing
        c_headers    = ls_request_prop-headers )  ##NO_TEXT.
    endif.



    " process body parameters
    ls_request_prop-body_bin = i_AUDIO_RESOURCE.

    " execute HTTP POST request
    lo_response = HTTP_POST( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_SPEECH_TO_TEXT_V1->GET_AUDIO
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_AUDIO_NAME        TYPE STRING
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.
    replace all occurrences of `{audio_name}` in ls_request_prop-url-path with i_AUDIO_NAME ignoring case.

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
* | [--->] I_CUSTOMIZATION_ID        TYPE STRING
* | [--->] I_AUDIO_NAME        TYPE STRING
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
    replace all occurrences of `{customization_id}` in ls_request_prop-url-path with i_CUSTOMIZATION_ID ignoring case.
    replace all occurrences of `{audio_name}` in ls_request_prop-url-path with i_AUDIO_NAME ignoring case.

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




* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Private Method ZCL_IBMC_SPEECH_TO_TEXT_V1->SET_DEFAULT_QUERY_PARAMETERS
* +-------------------------------------------------------------------------------------------------+
* | [<-->] C_URL                          TYPE        TS_URL
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method set_default_query_parameters.
  endmethod.

ENDCLASS.
