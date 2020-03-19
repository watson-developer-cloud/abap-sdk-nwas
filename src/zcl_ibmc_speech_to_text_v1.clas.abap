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
"! <p class="shorttext synchronized" lang="en">Speech to Text</p>
"! The IBM&reg; Speech to Text service provides APIs that use IBM&apos;s
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
    "! <p class="shorttext synchronized" lang="en">
    "!    A warning from training of a custom language or custom</p>
    "!     acoustic model.
    begin of T_TRAINING_WARNING,
      "!   An identifier for the type of invalid resources listed in the `description`
      "!    field.
      CODE type STRING,
      "!   A warning message that lists the invalid resources that are excluded from the
      "!    custom model&apos;s training. The message has the following format: `Analysis
      "!    of the following &#123;resource_type&#125; has not completed successfully:
      "!    [&#123;resource_names&#125;]. They will be excluded from custom
      "!    &#123;model_type&#125; model training.`.
      MESSAGE type STRING,
    end of T_TRAINING_WARNING.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The response from training of a custom language or custom</p>
    "!     acoustic model.
    begin of T_TRAINING_RESPONSE,
      "!   An array of `TrainingWarning` objects that lists any invalid resources contained
      "!    in the custom model. For custom language models, invalid resources are grouped
      "!    and identified by type of resource. The method can return warnings only if the
      "!    `strict` parameter is set to `false`.
      WARNINGS type STANDARD TABLE OF T_TRAINING_WARNING WITH NON-UNIQUE DEFAULT KEY,
    end of T_TRAINING_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An alternative hypothesis for a word from speech recognition</p>
    "!     results.
    begin of T_WORD_ALTERNATIVE_RESULT,
      "!   A confidence score for the word alternative hypothesis in the range of 0.0 to
      "!    1.0.
      CONFIDENCE type DOUBLE,
      "!   An alternative hypothesis for a word from the input audio.
      WORD type STRING,
    end of T_WORD_ALTERNATIVE_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about alternative hypotheses for words from</p>
    "!     speech recognition results.
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
    "! <p class="shorttext synchronized" lang="en">
    "!    A bin with defined boundaries that indicates the number of</p>
    "!     values in a range of signal characteristics for a histogram. The first and last
    "!     bins of a histogram are the boundary bins. They cover the intervals between
    "!     negative infinity and the first boundary, and between the last boundary and
    "!     positive infinity, respectively.
    begin of T_AUDIO_METRICS_HISTOGRAM_BIN,
      "!   The lower boundary of the bin in the histogram.
      BEGIN type FLOAT,
      "!   The upper boundary of the bin in the histogram.
      END type FLOAT,
      "!   The number of values in the bin of the histogram.
      COUNT type INTEGER,
    end of T_AUDIO_METRICS_HISTOGRAM_BIN.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about the speakers from speech recognition</p>
    "!     results.
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
      "!   A score that indicates the service&apos;s confidence in its identification of
      "!    the speaker in the range of 0.0 to 1.0.
      CONFIDENCE type FLOAT,
      "!   An indication of whether the service might further change word and speaker-label
      "!    results. A value of `true` means that the service guarantees not to send any
      "!    further updates for the current or any preceding results; `false` means that
      "!    the service might send further updates to the results.
      FINAL type BOOLEAN,
    end of T_SPEAKER_LABELS_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An alternative transcript from speech recognition results.</p>
    begin of T_SPCH_RECOGNITION_ALTERNATIVE,
      "!   A transcription of the audio.
      TRANSCRIPT type STRING,
      "!   A score that indicates the service&apos;s confidence in the transcript in the
      "!    range of 0.0 to 1.0. A confidence score is returned only for the best
      "!    alternative and only with results marked as final.
      CONFIDENCE type DOUBLE,
      "!   Time alignments for each word from the transcript as a list of lists. Each inner
      "!    list consists of three elements: the word followed by its start and end time in
      "!    seconds, for example:
      "!    `[[&quot;hello&quot;,0.0,1.2],[&quot;world&quot;,1.2,2.5]]`. Timestamps are
      "!    returned only for the best alternative.
      TIMESTAMPS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   A confidence score for each word of the transcript as a list of lists. Each
      "!    inner list consists of two elements: the word and its confidence score in the
      "!    range of 0.0 to 1.0, for example:
      "!    `[[&quot;hello&quot;,0.95],[&quot;world&quot;,0.866]]`. Confidence scores are
      "!    returned only for the best alternative and only with results marked as final.
      WORD_CONFIDENCE type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_SPCH_RECOGNITION_ALTERNATIVE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Detailed timing information about the service&apos;s</p>
    "!     processing of the input audio.
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
    "! <p class="shorttext synchronized" lang="en">
    "!    If processing metrics are requested, information about the</p>
    "!     service&apos;s processing of the input audio. Processing metrics are not
    "!     available with the synchronous **Recognize audio** method.
    begin of T_PROCESSING_METRICS,
      "!   Detailed timing information about the service&apos;s processing of the input
      "!    audio.
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
    "! <p class="shorttext synchronized" lang="en">
    "!    Detailed information about the signal characteristics of the</p>
    "!     input audio.
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
    "! <p class="shorttext synchronized" lang="en">
    "!    If audio metrics are requested, information about the signal</p>
    "!     characteristics of the input audio.
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
    "! <p class="shorttext synchronized" lang="en">
    "!    Component results for a speech recognition request.</p>
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
    "! <p class="shorttext synchronized" lang="en">
    "!    The complete results for a speech recognition request.</p>
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
      "!   If processing metrics are requested, information about the service&apos;s
      "!    processing of the input audio. Processing metrics are not available with the
      "!    synchronous **Recognize audio** method.
      PROCESSING_METRICS type T_PROCESSING_METRICS,
      "!   If audio metrics are requested, information about the signal characteristics of
      "!    the input audio.
      AUDIO_METRICS type T_AUDIO_METRICS,
      "!   An array of warning messages associated with the request:<br/>
      "!   * Warnings for invalid parameters or fields can include a descriptive message
      "!    and a list of invalid argument strings, for example, `&quot;Unknown
      "!    arguments:&quot;` or `&quot;Unknown url query arguments:&quot;` followed by a
      "!    list of the form `&quot;&#123;invalid_arg_1&#125;,
      "!    &#123;invalid_arg_2&#125;.&quot;`<br/>
      "!   * The following warning is returned if the request passes a custom model that is
      "!    based on an older version of a base model for which an updated version is
      "!    available: `&quot;Using previous version of base model, because your custom
      "!    model has been built with it. Please note that this version will be supported
      "!    only for a limited time. Consider updating your custom model to the new base
      "!    model. If you do not do that you will be automatically switched to base model
      "!    when you used the non-updated custom model.&quot;`<br/>
      "!   <br/>
      "!   In both cases, the request succeeds despite the warnings.
      WARNINGS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_SPEECH_RECOGNITION_RESULTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about a grammar from a custom language model.</p>
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
      "!    of grammar &apos;&#123;grammar_name&#125;&apos; failed. Please try fixing the
      "!    error or adding the grammar again by setting the &apos;allow_overwrite&apos;
      "!    flag to &apos;true&apos;.`.
      ERROR type STRING,
    end of T_GRAMMAR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about the grammars from a custom language model.</p>
    begin of T_GRAMMARS,
      "!   An array of `Grammar` objects that provides information about the grammars for
      "!    the custom model. The array is empty if the custom model has no grammars.
      GRAMMARS type STANDARD TABLE OF T_GRAMMAR WITH NON-UNIQUE DEFAULT KEY,
    end of T_GRAMMARS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about a current asynchronous speech recognition</p>
    "!     job.
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
      "!    strings, for example, `&quot;unexpected query parameter &apos;user_token&apos;,
      "!    query parameter &apos;callback_url&apos; was not specified&quot;`. The request
      "!    succeeds despite the warnings. This field can be returned only by the **Create
      "!    a job** method.
      WARNINGS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_RECOGNITION_JOB.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about current asynchronous speech recognition</p>
    "!     jobs.
    begin of T_RECOGNITION_JOBS,
      "!   An array of `RecognitionJob` objects that provides the status for each of the
      "!    user&apos;s current jobs. The array is empty if the user has no current jobs.
      RECOGNITIONS type STANDARD TABLE OF T_RECOGNITION_JOB WITH NON-UNIQUE DEFAULT KEY,
    end of T_RECOGNITION_JOBS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about an audio resource from a custom acoustic</p>
    "!     model.
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
      "!    for an archive-type resource.
      CODEC type STRING,
      "!   **For an audio-type resource,** the sampling rate of the audio in Hertz (samples
      "!    per second). Omitted for an archive-type resource.
      FREQUENCY type INTEGER,
      "!   **For an archive-type resource,** the format of the compressed archive:<br/>
      "!   * `zip` for a **.zip** file<br/>
      "!   * `gzip` for a **.tar.gz** file <br/>
      "!   <br/>
      "!   Omitted for an audio-type resource.
      COMPRESSION type STRING,
    end of T_AUDIO_DETAILS.
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
      "!   Warnings associated with the error.
      WARNINGS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_ERROR_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about an audio resource from a custom acoustic</p>
    "!     model.
    begin of T_AUDIO_RESOURCE,
      "!   The total seconds of audio in the audio resource.
      DURATION type INTEGER,
      "!   **For an archive-type resource,** the user-specified name of the resource. <br/>
      "!   <br/>
      "!   **For an audio-type resource,** the user-specified name of the resource or the
      "!    name of the audio file that the user added for the resource. The value depends
      "!    on the method that is called.
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
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about an audio resource from a custom acoustic</p>
    "!     model.
    begin of T_AUDIO_LISTING,
      "!   **For an audio-type resource,**  the total seconds of audio in the resource.
      "!    Omitted for an archive-type resource.
      DURATION type INTEGER,
      "!   **For an audio-type resource,** the user-specified name of the resource. Omitted
      "!    for an archive-type resource.
      NAME type STRING,
      "!   **For an audio-type resource,** an `AudioDetails` object that provides detailed
      "!    information about the resource. The object is empty until the service finishes
      "!    processing the audio. Omitted for an archive-type resource.
      DETAILS type T_AUDIO_DETAILS,
      "!   **For an audio-type resource,** the status of the resource:<br/>
      "!   * `ok`: The service successfully analyzed the audio data. The data can be used
      "!    to train the custom model.<br/>
      "!   * `being_processed`: The service is still analyzing the audio data. The service
      "!    cannot accept requests to add new audio resources or to train the custom model
      "!    until its analysis is complete.<br/>
      "!   * `invalid`: The audio data is not valid for training the custom model (possibly
      "!    because it has the wrong format or sampling rate, or because it is corrupted).
      "!    <br/>
      "!   <br/>
      "!   Omitted for an archive-type resource.
      STATUS type STRING,
      "!   **For an archive-type resource,** an object of type `AudioResource` that
      "!    provides information about the resource. Omitted for an audio-type resource.
      CONTAINER type T_AUDIO_RESOURCE,
      "!   **For an archive-type resource,** an array of `AudioResource` objects that
      "!    provides information about the audio-type resources that are contained in the
      "!    resource. Omitted for an audio-type resource.
      AUDIO type STANDARD TABLE OF T_AUDIO_RESOURCE WITH NON-UNIQUE DEFAULT KEY,
    end of T_AUDIO_LISTING.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    An error associated with a word from a custom language</p>
    "!     model.
    begin of T_WORD_ERROR,
      "!   A key-value pair that describes an error associated with the definition of a
      "!    word in the words resource. The pair has the format `&quot;element&quot;:
      "!    &quot;message&quot;`, where `element` is the aspect of the definition that
      "!    caused the problem and `message` describes the problem. The following example
      "!    describes a problem with one of the word&apos;s sounds-like definitions:
      "!    `&quot;&#123;sounds_like_string&#125;&quot;: &quot;Numbers are not allowed in
      "!    sounds-like. You can try for example
      "!    &apos;&#123;suggested_string&#125;&apos;.&quot;`.
      ELEMENT type STRING,
    end of T_WORD_ERROR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about a word from a custom language model.</p>
    begin of T_WORD,
      "!   A word from the custom model&apos;s words resource. The spelling of the word is
      "!    used to train the model.
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
      "!   An array of sources that describes how the word was added to the custom
      "!    model&apos;s words resource. For OOV words added from a corpus, includes the
      "!    name of the corpus; if the word was added by multiple corpora, the names of all
      "!    corpora are listed. If the word was modified or added by the user directly, the
      "!    field includes the string `user`.
      SOURCE type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   If the service discovered one or more problems that you need to correct for the
      "!    word&apos;s definition, an array that describes each of the errors.
      ERROR type STANDARD TABLE OF T_WORD_ERROR WITH NON-UNIQUE DEFAULT KEY,
    end of T_WORD.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about the words from a custom language model.</p>
    begin of T_WORDS,
      "!   An array of `Word` objects that provides information about each word in the
      "!    custom model&apos;s words resource. The array is empty if the custom model has
      "!    no words.
      WORDS type STANDARD TABLE OF T_WORD WITH NON-UNIQUE DEFAULT KEY,
    end of T_WORDS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about a word that is to be added to a custom</p>
    "!     language model.
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
      "!   * For a word that is not in the service&apos;s base vocabulary, omit the
      "!    parameter to have the service automatically generate a sounds-like
      "!    pronunciation for the word.<br/>
      "!   * For a word that is in the service&apos;s base vocabulary, use the parameter to
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
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about the audio resources from a custom acoustic</p>
    "!     model.
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
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about a corpus from a custom language model.</p>
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
      "!    of corpus &apos;name&apos; failed. Please try adding the corpus again by
      "!    setting the &apos;allow_overwrite&apos; flag to &apos;true&apos;`.
      ERROR type STRING,
    end of T_CORPUS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about the corpora from a custom language model.</p>
    begin of T_CORPORA,
      "!   An array of `Corpus` objects that provides information about the corpora for the
      "!    custom model. The array is empty if the custom model has no corpora.
      CORPORA type STANDARD TABLE OF T_CORPUS WITH NON-UNIQUE DEFAULT KEY,
    end of T_CORPORA.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about an existing custom language model.</p>
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
      "!   A percentage that indicates the progress of the custom language model&apos;s
      "!    current training. A value of `100` means that the model is fully trained.
      "!    **Note:** The `progress` field does not currently reflect the progress of the
      "!    training. The field changes from `0` to `100` when training is complete.
      PROGRESS type INTEGER,
      "!   If an error occurred while adding a grammar file to the custom language model, a
      "!    message that describes an `Internal Server Error` and includes the string
      "!    `Cannot compile grammar`. The status of the custom model is not affected by the
      "!    error, but the grammar cannot be used with the model.
      ERROR type STRING,
      "!   If the request included unknown parameters, the following message: `Unexpected
      "!    query parameter(s) [&apos;parameters&apos;] detected`, where `parameters` is a
      "!    list that includes a quoted string for each unknown parameter.
      WARNINGS type STRING,
    end of T_LANGUAGE_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about existing custom language models.</p>
    begin of T_LANGUAGE_MODELS,
      "!   An array of `LanguageModel` objects that provides information about each
      "!    available custom language model. The array is empty if the requesting
      "!    credentials own no custom language models (if no language is specified) or own
      "!    no custom language models for the specified language.
      CUSTOMIZATIONS type STANDARD TABLE OF T_LANGUAGE_MODEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_LANGUAGE_MODELS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about an existing custom acoustic model.</p>
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
      "!   A percentage that indicates the progress of the custom acoustic model&apos;s
      "!    current training. A value of `100` means that the model is fully trained.
      "!    **Note:** The `progress` field does not currently reflect the progress of the
      "!    training. The field changes from `0` to `100` when training is complete.
      PROGRESS type INTEGER,
      "!   If the request included unknown parameters, the following message: `Unexpected
      "!    query parameter(s) [&apos;parameters&apos;] detected`, where `parameters` is a
      "!    list that includes a quoted string for each unknown parameter.
      WARNINGS type STRING,
    end of T_ACOUSTIC_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about existing custom acoustic models.</p>
    begin of T_ACOUSTIC_MODELS,
      "!   An array of `AcousticModel` objects that provides information about each
      "!    available custom acoustic model. The array is empty if the requesting
      "!    credentials own no custom acoustic models (if no language is specified) or own
      "!    no custom acoustic models for the specified language.
      CUSTOMIZATIONS type STANDARD TABLE OF T_ACOUSTIC_MODEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_ACOUSTIC_MODELS.
  types:
    "! No documentation available.
    begin of T_INLINE_OBJECT,
      "!   A plain text file that contains the training data for the corpus. Encode the
      "!    file in UTF-8 if it contains non-ASCII characters; the service assumes UTF-8
      "!    encoding if it encounters non-ASCII characters. <br/>
      "!   <br/>
      "!   Make sure that you know the character encoding of the file. You must use that
      "!    encoding when working with the words in the custom language model. For more
      "!    information, see [Character
      "!    encoding](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-corpor
      "!   aWords#charEncoding). <br/>
      "!   <br/>
      "!   With the `curl` command, use the `--data-binary` option to upload the file for
      "!    the request.
      CORPUS_FILE type FILE,
    end of T_INLINE_OBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Additional service features that are supported with the</p>
    "!     model.
    begin of T_SUPPORTED_FEATURES,
      "!   Indicates whether the customization interface can be used to create a custom
      "!    language model based on the language model.
      CUSTOM_LANGUAGE_MODEL type BOOLEAN,
      "!   Indicates whether the `speaker_labels` parameter can be used with the language
      "!    model.
      SPEAKER_LABELS type BOOLEAN,
    end of T_SUPPORTED_FEATURES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about the new custom language model.</p>
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
      "!    customization](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-c
      "!   ustomization#languageSupport).
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
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about an available language model.</p>
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
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about the available language models.</p>
    begin of T_SPEECH_MODELS,
      "!   An array of `SpeechModel` objects that provides information about each available
      "!    model.
      MODELS type STANDARD TABLE OF T_SPEECH_MODEL WITH NON-UNIQUE DEFAULT KEY,
    end of T_SPEECH_MODELS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about the new custom acoustic model.</p>
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
      "!    customization](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-c
      "!   ustomization#languageSupport).
      BASE_MODEL_NAME type STRING,
      "!   A description of the new custom acoustic model. Use a localized description that
      "!    matches the language of the custom model.
      DESCRIPTION type STRING,
    end of T_CREATE_ACOUSTIC_MODEL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about the words that are to be added to a custom</p>
    "!     language model.
    begin of T_CUSTOM_WORDS,
      "!   An array of `CustomWord` objects that provides information about each custom
      "!    word that is to be added to or updated in the custom language model.
      WORDS type STANDARD TABLE OF T_CUSTOM_WORD WITH NON-UNIQUE DEFAULT KEY,
    end of T_CUSTOM_WORDS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about a match for a keyword from speech</p>
    "!     recognition results.
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
    "! <p class="shorttext synchronized" lang="en">
    "!    The empty response from a request.</p>
      T_EMPTY_RESPONSE_BODY type JSONOBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about a request to register a callback for</p>
    "!     asynchronous speech recognition.
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
  "! <p class="shorttext synchronized" lang="en">List of required fields per type.</p>
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
  "! <p class="shorttext synchronized" lang="en">Map ABAP identifiers to service identifiers.</p>
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


    "! <p class="shorttext synchronized" lang="en">List models</p>
    "!   Lists all language models that are available for use with the service. The
    "!    information includes the name of the model and its minimum sampling rate in
    "!    Hertz, among other things. <br/>
    "!   <br/>
    "!   **See also:** [Languages and
    "!    models](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-models#m
    "!   odels).
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
    "! <p class="shorttext synchronized" lang="en">Get a model</p>
    "!   Gets information for a single specified language model that is available for use
    "!    with the service. The information includes the name of the model and its
    "!    minimum sampling rate in Hertz, among other things. <br/>
    "!   <br/>
    "!   **See also:** [Languages and
    "!    models](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-models#m
    "!   odels).
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

    "! <p class="shorttext synchronized" lang="en">Recognize audio</p>
    "!   Sends audio and returns transcription results for a recognition request. You can
    "!    pass a maximum of 100 MB and a minimum of 100 bytes of audio with a request.
    "!    The service automatically detects the endianness of the incoming audio and, for
    "!    audio that includes multiple channels, downmixes the audio to one-channel mono
    "!    during transcoding. The method returns only final results; to enable interim
    "!    results, use the WebSocket API. (With the `curl` command, use the
    "!    `--data-binary` option to upload the file for the request.) <br/>
    "!   <br/>
    "!   **See also:** [Making a basic HTTP
    "!    request](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-http#HT
    "!   TP-basic). <br/>
    "!   <br/>
    "!   ### Streaming mode<br/>
    "!   <br/>
    "!    For requests to transcribe live audio as it becomes available, you must set the
    "!    `Transfer-Encoding` header to `chunked` to use streaming mode. In streaming
    "!    mode, the service closes the connection (status code 408) if it does not
    "!    receive at least 15 seconds of audio (including silence) in any 30-second
    "!    period. The service also closes the connection (status code 400) if it detects
    "!    no speech for `inactivity_timeout` seconds of streaming audio; use the
    "!    `inactivity_timeout` parameter to change the default of 30 seconds. <br/>
    "!   <br/>
    "!   **See also:**<br/>
    "!   * [Audio
    "!    transmission](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-in
    "!   put#transmission)<br/>
    "!   *
    "!    [Timeouts](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-input
    "!   #timeouts) <br/>
    "!   <br/>
    "!   ### Audio formats (content types)<br/>
    "!   <br/>
    "!    The service accepts audio in the following formats (MIME types).<br/>
    "!   * For formats that are labeled **Required**, you must use the `Content-Type`
    "!    header with the request to specify the format of the audio.<br/>
    "!   * For all other formats, you can omit the `Content-Type` header or specify
    "!    `application/octet-stream` with the header to have the service automatically
    "!    detect the format of the audio. (With the `curl` command, you can specify
    "!    either `&quot;Content-Type:&quot;` or `&quot;Content-Type:
    "!    application/octet-stream&quot;`.) <br/>
    "!   <br/>
    "!   Where indicated, the format that you specify must include the sampling rate and
    "!    can optionally include the number of channels and the endianness of the
    "!    audio.<br/>
    "!   * `audio/alaw` (**Required.** Specify the sampling rate (`rate`) of the
    "!    audio.)<br/>
    "!   * `audio/basic` (**Required.** Use only with narrowband models.)<br/>
    "!   * `audio/flac`<br/>
    "!   * `audio/g729` (Use only with narrowband models.)<br/>
    "!   * `audio/l16` (**Required.** Specify the sampling rate (`rate`) and optionally
    "!    the number of channels (`channels`) and endianness (`endianness`) of the
    "!    audio.)<br/>
    "!   * `audio/mp3`<br/>
    "!   * `audio/mpeg`<br/>
    "!   * `audio/mulaw` (**Required.** Specify the sampling rate (`rate`) of the
    "!    audio.)<br/>
    "!   * `audio/ogg` (The service automatically detects the codec of the input
    "!    audio.)<br/>
    "!   * `audio/ogg;codecs=opus`<br/>
    "!   * `audio/ogg;codecs=vorbis`<br/>
    "!   * `audio/wav` (Provide audio with a maximum of nine channels.)<br/>
    "!   * `audio/webm` (The service automatically detects the codec of the input
    "!    audio.)<br/>
    "!   * `audio/webm;codecs=opus`<br/>
    "!   * `audio/webm;codecs=vorbis` <br/>
    "!   <br/>
    "!   The sampling rate of the audio must match the sampling rate of the model for the
    "!    recognition request: for broadband models, at least 16 kHz; for narrowband
    "!    models, at least 8 kHz. If the sampling rate of the audio is higher than the
    "!    minimum required rate, the service down-samples the audio to the appropriate
    "!    rate. If the sampling rate of the audio is lower than the minimum required
    "!    rate, the request fails.<br/>
    "!   <br/>
    "!    **See also:** [Audio
    "!    formats](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-audio-f
    "!   ormats#audio-formats). <br/>
    "!   <br/>
    "!   ### Multipart speech recognition<br/>
    "!   <br/>
    "!    **Note:** The Watson SDKs do not support multipart speech recognition. <br/>
    "!   <br/>
    "!   The HTTP `POST` method of the service also supports multipart speech
    "!    recognition. With multipart requests, you pass all audio data as multipart form
    "!    data. You specify some parameters as request headers and query parameters, but
    "!    you pass JSON metadata as form data to control most aspects of the
    "!    transcription. You can use multipart recognition to pass multiple audio files
    "!    with a single request. <br/>
    "!   <br/>
    "!   Use the multipart approach with browsers for which JavaScript is disabled or
    "!    when the parameters used with the request are greater than the 8 KB limit
    "!    imposed by most HTTP servers and proxies. You can encounter this limit, for
    "!    example, if you want to spot a very large number of keywords. <br/>
    "!   <br/>
    "!   **See also:** [Making a multipart HTTP
    "!    request](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-http#HT
    "!   TP-multi).
    "!
    "! @parameter I_AUDIO |
    "!   The audio to transcribe.
    "! @parameter I_CONTENT_TYPE |
    "!   The format (MIME type) of the audio. For more information about specifying an
    "!    audio format, see **Audio formats (content types)** in the method description.
    "! @parameter I_MODEL |
    "!   The identifier of the model that is to be used for the recognition request. See
    "!    [Languages and
    "!    models](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-models#m
    "!   odels).
    "! @parameter I_LANGUAGE_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of a custom language model that is to be used with
    "!    the recognition request. The base model of the specified custom language model
    "!    must match the model specified with the `model` parameter. You must make the
    "!    request with credentials for the instance of the service that owns the custom
    "!    model. By default, no custom language model is used. See [Custom
    "!    models](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-input#cu
    "!   stom-input). <br/>
    "!   <br/>
    "!   **Note:** Use this parameter instead of the deprecated `customization_id`
    "!    parameter.
    "! @parameter I_ACOUSTIC_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of a custom acoustic model that is to be used with
    "!    the recognition request. The base model of the specified custom acoustic model
    "!    must match the model specified with the `model` parameter. You must make the
    "!    request with credentials for the instance of the service that owns the custom
    "!    model. By default, no custom acoustic model is used. See [Custom
    "!    models](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-input#cu
    "!   stom-input).
    "! @parameter I_BASE_MODEL_VERSION |
    "!   The version of the specified base model that is to be used with the recognition
    "!    request. Multiple versions of a base model can exist when a model is updated
    "!    for internal improvements. The parameter is intended primarily for use with
    "!    custom models that have been upgraded for a new base model. The default value
    "!    depends on whether the parameter is used with or without a custom model. See
    "!    [Base model
    "!    version](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-input#v
    "!   ersion).
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
    "!    phrases from the custom model&apos;s domain, but it can negatively affect
    "!    performance on non-domain phrases. <br/>
    "!   <br/>
    "!   See [Custom
    "!    models](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-input#cu
    "!   stom-input).
    "! @parameter I_INACTIVITY_TIMEOUT |
    "!   The time in seconds after which, if only silence (no speech) is detected in
    "!    streaming audio, the connection is closed with a 400 error. The parameter is
    "!    useful for stopping audio submission from a live microphone when a user simply
    "!    walks away. Use `-1` for infinity. See [Inactivity
    "!    timeout](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-input#t
    "!   imeouts-inactivity).
    "! @parameter I_KEYWORDS |
    "!   An array of keyword strings to spot in the audio. Each keyword string can
    "!    include one or more string tokens. Keywords are spotted only in the final
    "!    results, not in interim hypotheses. If you specify any keywords, you must also
    "!    specify a keywords threshold. You can spot a maximum of 1000 keywords. Omit the
    "!    parameter or specify an empty array if you do not need to spot keywords. See
    "!    [Keyword
    "!    spotting](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-output
    "!   #keyword_spotting).
    "! @parameter I_KEYWORDS_THRESHOLD |
    "!   A confidence value that is the lower bound for spotting a keyword. A word is
    "!    considered to match a keyword if its confidence is greater than or equal to the
    "!    threshold. Specify a probability between 0.0 and 1.0. If you specify a
    "!    threshold, you must also specify one or more keywords. The service performs no
    "!    keyword spotting if you omit either parameter. See [Keyword
    "!    spotting](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-output
    "!   #keyword_spotting).
    "! @parameter I_MAX_ALTERNATIVES |
    "!   The maximum number of alternative transcripts that the service is to return. By
    "!    default, the service returns a single transcript. If you specify a value of
    "!    `0`, the service uses the default value, `1`. See [Maximum
    "!    alternatives](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-ou
    "!   tput#max_alternatives).
    "! @parameter I_WORD_ALTERNATIVES_THRESHOLD |
    "!   A confidence value that is the lower bound for identifying a hypothesis as a
    "!    possible word alternative (also known as &quot;Confusion Networks&quot;). An
    "!    alternative word is considered if its confidence is greater than or equal to
    "!    the threshold. Specify a probability between 0.0 and 1.0. By default, the
    "!    service computes no alternative words. See [Word
    "!    alternatives](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-ou
    "!   tput#word_alternatives).
    "! @parameter I_WORD_CONFIDENCE |
    "!   If `true`, the service returns a confidence measure in the range of 0.0 to 1.0
    "!    for each word. By default, the service returns no word confidence scores. See
    "!    [Word
    "!    confidence](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-outp
    "!   ut#word_confidence).
    "! @parameter I_TIMESTAMPS |
    "!   If `true`, the service returns time alignment for each word. By default, no
    "!    timestamps are returned. See [Word
    "!    timestamps](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-outp
    "!   ut#word_timestamps).
    "! @parameter I_PROFANITY_FILTER |
    "!   If `true`, the service filters profanity from all output except for keyword
    "!    results by replacing inappropriate words with a series of asterisks. Set the
    "!    parameter to `false` to return results with no censoring. Applies to US English
    "!    transcription only. See [Profanity
    "!    filtering](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-outpu
    "!   t#profanity_filter).
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
    "!    formatting](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-outp
    "!   ut#smart_formatting).
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
    "!    labels](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-output#s
    "!   peaker_labels).
    "! @parameter I_CUSTOMIZATION_ID |
    "!   **Deprecated.** Use the `language_customization_id` parameter to specify the
    "!    customization ID (GUID) of a custom language model that is to be used with the
    "!    recognition request. Do not specify both parameters with a request.
    "! @parameter I_GRAMMAR_NAME |
    "!   The name of a grammar that is to be used with the recognition request. If you
    "!    specify a grammar, you must also use the `language_customization_id` parameter
    "!    to specify the name of the custom language model for which the grammar is
    "!    defined. The service recognizes only strings that are recognized by the
    "!    specified grammar; it does not recognize other custom words from the
    "!    model&apos;s words resource. See
    "!    [Grammars](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-input
    "!   #grammars-input).
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
    "!    redaction](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-outpu
    "!   t#redaction).
    "! @parameter I_AUDIO_METRICS |
    "!   If `true`, requests detailed information about the signal characteristics of the
    "!    input audio. The service returns audio metrics with the final transcription
    "!    results. By default, the service returns no audio metrics. <br/>
    "!   <br/>
    "!   See [Audio
    "!    metrics](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-metrics
    "!   #audio_metrics).
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
    "!    time](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-output#sil
    "!   ence_time).
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
    "!    end](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-output#spli
    "!   t_transcript).
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

    "! <p class="shorttext synchronized" lang="en">Register a callback</p>
    "!   Registers a callback URL with the service for use with subsequent asynchronous
    "!    recognition requests. The service attempts to register, or white-list, the
    "!    callback URL if it is not already registered by sending a `GET` request to the
    "!    callback URL. The service passes a random alphanumeric challenge string via the
    "!    `challenge_string` parameter of the request. The request includes an `Accept`
    "!    header that specifies `text/plain` as the required response type. <br/>
    "!   <br/>
    "!   To be registered successfully, the callback URL must respond to the `GET`
    "!    request from the service. The response must send status code 200 and must
    "!    include the challenge string in its body. Set the `Content-Type` response
    "!    header to `text/plain`. Upon receiving this response, the service responds to
    "!    the original registration request with response code 201. <br/>
    "!   <br/>
    "!   The service sends only a single `GET` request to the callback URL. If the
    "!    service does not receive a reply with a response code of 200 and a body that
    "!    echoes the challenge string sent by the service within five seconds, it does
    "!    not white-list the URL; it instead sends status code 400 in response to the
    "!    **Register a callback** request. If the requested callback URL is already
    "!    white-listed, the service responds to the initial registration request with
    "!    response code 200. <br/>
    "!   <br/>
    "!   If you specify a user secret with the request, the service uses it as a key to
    "!    calculate an HMAC-SHA1 signature of the challenge string in its response to the
    "!    `POST` request. It sends this signature in the `X-Callback-Signature` header of
    "!    its `GET` request to the URL during registration. It also uses the secret to
    "!    calculate a signature over the payload of every callback notification that uses
    "!    the URL. The signature provides authentication and data integrity for HTTP
    "!    communications. <br/>
    "!   <br/>
    "!   After you successfully register a callback URL, you can use it with an
    "!    indefinite number of recognition requests. You can register a maximum of 20
    "!    callback URLS in a one-hour span of time. <br/>
    "!   <br/>
    "!   **See also:** [Registering a callback
    "!    URL](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-async#regis
    "!   ter).
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
    "! <p class="shorttext synchronized" lang="en">Unregister a callback</p>
    "!   Unregisters a callback URL that was previously white-listed with a **Register a
    "!    callback** request for use with the asynchronous interface. Once unregistered,
    "!    the URL can no longer be used with asynchronous recognition requests. <br/>
    "!   <br/>
    "!   **See also:** [Unregistering a callback
    "!    URL](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-async#unreg
    "!   ister).
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
    "! <p class="shorttext synchronized" lang="en">Create a job</p>
    "!   Creates a job for a new asynchronous recognition request. The job is owned by
    "!    the instance of the service whose credentials are used to create it. How you
    "!    learn the status and results of a job depends on the parameters you include
    "!    with the job creation request:<br/>
    "!   * By callback notification: Include the `callback_url` parameter to specify a
    "!    URL to which the service is to send callback notifications when the status of
    "!    the job changes. Optionally, you can also include the `events` and `user_token`
    "!    parameters to subscribe to specific events and to specify a string that is to
    "!    be included with each notification for the job.<br/>
    "!   * By polling the service: Omit the `callback_url`, `events`, and `user_token`
    "!    parameters. You must then use the **Check jobs** or **Check a job** methods to
    "!    check the status of the job, using the latter to retrieve the results when the
    "!    job is complete. <br/>
    "!   <br/>
    "!   The two approaches are not mutually exclusive. You can poll the service for job
    "!    status or obtain results from the service manually even if you include a
    "!    callback URL. In both cases, you can include the `results_ttl` parameter to
    "!    specify how long the results are to remain available after the job is complete.
    "!    Using the HTTPS **Check a job** method to retrieve results is more secure than
    "!    receiving them via callback notification over HTTP because it provides
    "!    confidentiality in addition to authentication and data integrity. <br/>
    "!   <br/>
    "!   The method supports the same basic parameters as other HTTP and WebSocket
    "!    recognition requests. It also supports the following parameters specific to the
    "!    asynchronous interface:<br/>
    "!   * `callback_url`<br/>
    "!   * `events`<br/>
    "!   * `user_token`<br/>
    "!   * `results_ttl` <br/>
    "!   <br/>
    "!   You can pass a maximum of 1 GB and a minimum of 100 bytes of audio with a
    "!    request. The service automatically detects the endianness of the incoming audio
    "!    and, for audio that includes multiple channels, downmixes the audio to
    "!    one-channel mono during transcoding. The method returns only final results; to
    "!    enable interim results, use the WebSocket API. (With the `curl` command, use
    "!    the `--data-binary` option to upload the file for the request.) <br/>
    "!   <br/>
    "!   **See also:** [Creating a
    "!    job](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-async#creat
    "!   e). <br/>
    "!   <br/>
    "!   ### Streaming mode<br/>
    "!   <br/>
    "!    For requests to transcribe live audio as it becomes available, you must set the
    "!    `Transfer-Encoding` header to `chunked` to use streaming mode. In streaming
    "!    mode, the service closes the connection (status code 408) if it does not
    "!    receive at least 15 seconds of audio (including silence) in any 30-second
    "!    period. The service also closes the connection (status code 400) if it detects
    "!    no speech for `inactivity_timeout` seconds of streaming audio; use the
    "!    `inactivity_timeout` parameter to change the default of 30 seconds. <br/>
    "!   <br/>
    "!   **See also:**<br/>
    "!   * [Audio
    "!    transmission](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-in
    "!   put#transmission)<br/>
    "!   *
    "!    [Timeouts](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-input
    "!   #timeouts) <br/>
    "!   <br/>
    "!   ### Audio formats (content types)<br/>
    "!   <br/>
    "!    The service accepts audio in the following formats (MIME types).<br/>
    "!   * For formats that are labeled **Required**, you must use the `Content-Type`
    "!    header with the request to specify the format of the audio.<br/>
    "!   * For all other formats, you can omit the `Content-Type` header or specify
    "!    `application/octet-stream` with the header to have the service automatically
    "!    detect the format of the audio. (With the `curl` command, you can specify
    "!    either `&quot;Content-Type:&quot;` or `&quot;Content-Type:
    "!    application/octet-stream&quot;`.) <br/>
    "!   <br/>
    "!   Where indicated, the format that you specify must include the sampling rate and
    "!    can optionally include the number of channels and the endianness of the
    "!    audio.<br/>
    "!   * `audio/alaw` (**Required.** Specify the sampling rate (`rate`) of the
    "!    audio.)<br/>
    "!   * `audio/basic` (**Required.** Use only with narrowband models.)<br/>
    "!   * `audio/flac`<br/>
    "!   * `audio/g729` (Use only with narrowband models.)<br/>
    "!   * `audio/l16` (**Required.** Specify the sampling rate (`rate`) and optionally
    "!    the number of channels (`channels`) and endianness (`endianness`) of the
    "!    audio.)<br/>
    "!   * `audio/mp3`<br/>
    "!   * `audio/mpeg`<br/>
    "!   * `audio/mulaw` (**Required.** Specify the sampling rate (`rate`) of the
    "!    audio.)<br/>
    "!   * `audio/ogg` (The service automatically detects the codec of the input
    "!    audio.)<br/>
    "!   * `audio/ogg;codecs=opus`<br/>
    "!   * `audio/ogg;codecs=vorbis`<br/>
    "!   * `audio/wav` (Provide audio with a maximum of nine channels.)<br/>
    "!   * `audio/webm` (The service automatically detects the codec of the input
    "!    audio.)<br/>
    "!   * `audio/webm;codecs=opus`<br/>
    "!   * `audio/webm;codecs=vorbis` <br/>
    "!   <br/>
    "!   The sampling rate of the audio must match the sampling rate of the model for the
    "!    recognition request: for broadband models, at least 16 kHz; for narrowband
    "!    models, at least 8 kHz. If the sampling rate of the audio is higher than the
    "!    minimum required rate, the service down-samples the audio to the appropriate
    "!    rate. If the sampling rate of the audio is lower than the minimum required
    "!    rate, the request fails.<br/>
    "!   <br/>
    "!    **See also:** [Audio
    "!    formats](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-audio-f
    "!   ormats#audio-formats).
    "!
    "! @parameter I_AUDIO |
    "!   The audio to transcribe.
    "! @parameter I_CONTENT_TYPE |
    "!   The format (MIME type) of the audio. For more information about specifying an
    "!    audio format, see **Audio formats (content types)** in the method description.
    "! @parameter I_MODEL |
    "!   The identifier of the model that is to be used for the recognition request. See
    "!    [Languages and
    "!    models](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-models#m
    "!   odels).
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
    "!    models](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-input#cu
    "!   stom-input). <br/>
    "!   <br/>
    "!   **Note:** Use this parameter instead of the deprecated `customization_id`
    "!    parameter.
    "! @parameter I_ACOUSTIC_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of a custom acoustic model that is to be used with
    "!    the recognition request. The base model of the specified custom acoustic model
    "!    must match the model specified with the `model` parameter. You must make the
    "!    request with credentials for the instance of the service that owns the custom
    "!    model. By default, no custom acoustic model is used. See [Custom
    "!    models](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-input#cu
    "!   stom-input).
    "! @parameter I_BASE_MODEL_VERSION |
    "!   The version of the specified base model that is to be used with the recognition
    "!    request. Multiple versions of a base model can exist when a model is updated
    "!    for internal improvements. The parameter is intended primarily for use with
    "!    custom models that have been upgraded for a new base model. The default value
    "!    depends on whether the parameter is used with or without a custom model. See
    "!    [Base model
    "!    version](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-input#v
    "!   ersion).
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
    "!    phrases from the custom model&apos;s domain, but it can negatively affect
    "!    performance on non-domain phrases. <br/>
    "!   <br/>
    "!   See [Custom
    "!    models](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-input#cu
    "!   stom-input).
    "! @parameter I_INACTIVITY_TIMEOUT |
    "!   The time in seconds after which, if only silence (no speech) is detected in
    "!    streaming audio, the connection is closed with a 400 error. The parameter is
    "!    useful for stopping audio submission from a live microphone when a user simply
    "!    walks away. Use `-1` for infinity. See [Inactivity
    "!    timeout](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-input#t
    "!   imeouts-inactivity).
    "! @parameter I_KEYWORDS |
    "!   An array of keyword strings to spot in the audio. Each keyword string can
    "!    include one or more string tokens. Keywords are spotted only in the final
    "!    results, not in interim hypotheses. If you specify any keywords, you must also
    "!    specify a keywords threshold. You can spot a maximum of 1000 keywords. Omit the
    "!    parameter or specify an empty array if you do not need to spot keywords. See
    "!    [Keyword
    "!    spotting](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-output
    "!   #keyword_spotting).
    "! @parameter I_KEYWORDS_THRESHOLD |
    "!   A confidence value that is the lower bound for spotting a keyword. A word is
    "!    considered to match a keyword if its confidence is greater than or equal to the
    "!    threshold. Specify a probability between 0.0 and 1.0. If you specify a
    "!    threshold, you must also specify one or more keywords. The service performs no
    "!    keyword spotting if you omit either parameter. See [Keyword
    "!    spotting](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-output
    "!   #keyword_spotting).
    "! @parameter I_MAX_ALTERNATIVES |
    "!   The maximum number of alternative transcripts that the service is to return. By
    "!    default, the service returns a single transcript. If you specify a value of
    "!    `0`, the service uses the default value, `1`. See [Maximum
    "!    alternatives](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-ou
    "!   tput#max_alternatives).
    "! @parameter I_WORD_ALTERNATIVES_THRESHOLD |
    "!   A confidence value that is the lower bound for identifying a hypothesis as a
    "!    possible word alternative (also known as &quot;Confusion Networks&quot;). An
    "!    alternative word is considered if its confidence is greater than or equal to
    "!    the threshold. Specify a probability between 0.0 and 1.0. By default, the
    "!    service computes no alternative words. See [Word
    "!    alternatives](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-ou
    "!   tput#word_alternatives).
    "! @parameter I_WORD_CONFIDENCE |
    "!   If `true`, the service returns a confidence measure in the range of 0.0 to 1.0
    "!    for each word. By default, the service returns no word confidence scores. See
    "!    [Word
    "!    confidence](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-outp
    "!   ut#word_confidence).
    "! @parameter I_TIMESTAMPS |
    "!   If `true`, the service returns time alignment for each word. By default, no
    "!    timestamps are returned. See [Word
    "!    timestamps](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-outp
    "!   ut#word_timestamps).
    "! @parameter I_PROFANITY_FILTER |
    "!   If `true`, the service filters profanity from all output except for keyword
    "!    results by replacing inappropriate words with a series of asterisks. Set the
    "!    parameter to `false` to return results with no censoring. Applies to US English
    "!    transcription only. See [Profanity
    "!    filtering](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-outpu
    "!   t#profanity_filter).
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
    "!    formatting](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-outp
    "!   ut#smart_formatting).
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
    "!    labels](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-output#s
    "!   peaker_labels).
    "! @parameter I_CUSTOMIZATION_ID |
    "!   **Deprecated.** Use the `language_customization_id` parameter to specify the
    "!    customization ID (GUID) of a custom language model that is to be used with the
    "!    recognition request. Do not specify both parameters with a request.
    "! @parameter I_GRAMMAR_NAME |
    "!   The name of a grammar that is to be used with the recognition request. If you
    "!    specify a grammar, you must also use the `language_customization_id` parameter
    "!    to specify the name of the custom language model for which the grammar is
    "!    defined. The service recognizes only strings that are recognized by the
    "!    specified grammar; it does not recognize other custom words from the
    "!    model&apos;s words resource. See
    "!    [Grammars](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-input
    "!   #grammars-input).
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
    "!    redaction](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-outpu
    "!   t#redaction).
    "! @parameter I_PROCESSING_METRICS |
    "!   If `true`, requests processing metrics about the service&apos;s transcription of
    "!    the input audio. The service returns processing metrics at the interval
    "!    specified by the `processing_metrics_interval` parameter. It also returns
    "!    processing metrics for transcription events, for example, for final and interim
    "!    results. By default, the service returns no processing metrics. <br/>
    "!   <br/>
    "!   See [Processing
    "!    metrics](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-metrics
    "!   #processing_metrics).
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
    "!    metrics](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-metrics
    "!   #processing_metrics).
    "! @parameter I_AUDIO_METRICS |
    "!   If `true`, requests detailed information about the signal characteristics of the
    "!    input audio. The service returns audio metrics with the final transcription
    "!    results. By default, the service returns no audio metrics. <br/>
    "!   <br/>
    "!   See [Audio
    "!    metrics](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-metrics
    "!   #audio_metrics).
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
    "!    time](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-output#sil
    "!   ence_time).
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
    "!    end](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-output#spli
    "!   t_transcript).
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
    "! <p class="shorttext synchronized" lang="en">Check jobs</p>
    "!   Returns the ID and status of the latest 100 outstanding jobs associated with the
    "!    credentials with which it is called. The method also returns the creation and
    "!    update times of each job, and, if a job was created with a callback URL and a
    "!    user token, the user token for the job. To obtain the results for a job whose
    "!    status is `completed` or not one of the latest 100 outstanding jobs, use the
    "!    **Check a job** method. A job and its results remain available until you delete
    "!    them with the **Delete a job** method or until the job&apos;s time to live
    "!    expires, whichever comes first. <br/>
    "!   <br/>
    "!   **See also:** [Checking the status of the latest
    "!    jobs](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-async#jobs
    "!   ).
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
    "! <p class="shorttext synchronized" lang="en">Check a job</p>
    "!   Returns information about the specified job. The response always includes the
    "!    status of the job and its creation and update times. If the status is
    "!    `completed`, the response includes the results of the recognition request. You
    "!    must use credentials for the instance of the service that owns a job to list
    "!    information about it. <br/>
    "!   <br/>
    "!   You can use the method to retrieve the results of any job, regardless of whether
    "!    it was submitted with a callback URL and the
    "!    `recognitions.completed_with_results` event, and you can retrieve the results
    "!    multiple times for as long as they remain available. Use the **Check jobs**
    "!    method to request information about the most recent jobs associated with the
    "!    calling credentials. <br/>
    "!   <br/>
    "!   **See also:** [Checking the status and retrieving the results of a
    "!    job](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-async#job).
    "!
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
    "! <p class="shorttext synchronized" lang="en">Delete a job</p>
    "!   Deletes the specified job. You cannot delete a job that the service is actively
    "!    processing. Once you delete a job, its results are no longer available. The
    "!    service automatically deletes a job and its results when the time to live for
    "!    the results expires. You must use credentials for the instance of the service
    "!    that owns a job to delete it. <br/>
    "!   <br/>
    "!   **See also:** [Deleting a
    "!    job](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-async#delet
    "!   e-async).
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

    "! <p class="shorttext synchronized" lang="en">Create a custom language model</p>
    "!   Creates a new custom language model for a specified base model. The custom
    "!    language model can be used only with the base model for which it is created.
    "!    The model is owned by the instance of the service whose credentials are used to
    "!    create it. <br/>
    "!   <br/>
    "!   You can create a maximum of 1024 custom language models per owning credentials.
    "!    The service returns an error if you attempt to create more than 1024 models.
    "!    You do not lose any models, but you cannot create any more until your model
    "!    count is below the limit. <br/>
    "!   <br/>
    "!   **See also:** [Create a custom language
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-languageC
    "!   reate#createModel-language).
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
    "! <p class="shorttext synchronized" lang="en">List custom language models</p>
    "!   Lists information about all custom language models that are owned by an instance
    "!    of the service. Use the `language` parameter to see all custom language models
    "!    for the specified language. Omit the parameter to see all custom language
    "!    models for all languages. You must use credentials for the instance of the
    "!    service that owns a model to list information about it. <br/>
    "!   <br/>
    "!   **See also:** [Listing custom language
    "!    models](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageLa
    "!   nguageModels#listModels-language).
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
    "! <p class="shorttext synchronized" lang="en">Get a custom language model</p>
    "!   Gets information about a specified custom language model. You must use
    "!    credentials for the instance of the service that owns a model to list
    "!    information about it. <br/>
    "!   <br/>
    "!   **See also:** [Listing custom language
    "!    models](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageLa
    "!   nguageModels#listModels-language).
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
    "! <p class="shorttext synchronized" lang="en">Delete a custom language model</p>
    "!   Deletes an existing custom language model. The custom model cannot be deleted if
    "!    another request, such as adding a corpus or grammar to the model, is currently
    "!    being processed. You must use credentials for the instance of the service that
    "!    owns a model to delete it. <br/>
    "!   <br/>
    "!   **See also:** [Deleting a custom language
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageLan
    "!   guageModels#deleteModel-language).
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
    "! <p class="shorttext synchronized" lang="en">Train a custom language model</p>
    "!   Initiates the training of a custom language model with new resources such as
    "!    corpora, grammars, and custom words. After adding, modifying, or deleting
    "!    resources for a custom language model, use this method to begin the actual
    "!    training of the model on the latest data. You can specify whether the custom
    "!    language model is to be trained with all words from its words resource or only
    "!    with words that were added or modified by the user directly. You must use
    "!    credentials for the instance of the service that owns a model to train it.
    "!    <br/>
    "!   <br/>
    "!   The training method is asynchronous. It can take on the order of minutes to
    "!    complete depending on the amount of data on which the service is being trained
    "!    and the current load on the service. The method returns an HTTP 200 response
    "!    code to indicate that the training process has begun. <br/>
    "!   <br/>
    "!   You can monitor the status of the training by using the **Get a custom language
    "!    model** method to poll the model&apos;s status. Use a loop to check the status
    "!    every 10 seconds. The method returns a `LanguageModel` object that includes
    "!    `status` and `progress` fields. A status of `available` means that the custom
    "!    model is trained and ready to use. The service cannot accept subsequent
    "!    training requests or requests to add new resources until the existing request
    "!    completes. <br/>
    "!   <br/>
    "!   **See also:** [Train the custom language
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-languageC
    "!   reate#trainModel-language). <br/>
    "!   <br/>
    "!   ### Training failures<br/>
    "!   <br/>
    "!    Training can fail to start for the following reasons:<br/>
    "!   * The service is currently handling another request for the custom model, such
    "!    as another training request or a request to add a corpus or grammar to the
    "!    model.<br/>
    "!   * No training data have been added to the custom model.<br/>
    "!   * The custom model contains one or more invalid corpora, grammars, or words (for
    "!    example, a custom word has an invalid sounds-like pronunciation). You can
    "!    correct the invalid resources or set the `strict` parameter to `false` to
    "!    exclude the invalid resources from the training. The model must contain at
    "!    least one valid resource for training to succeed.
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_WORD_TYPE_TO_ADD |
    "!   The type of words from the custom language model&apos;s words resource on which
    "!    to train the model:<br/>
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
    "!    phrases from the custom model&apos;s domain, but it can negatively affect
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
    "! <p class="shorttext synchronized" lang="en">Reset a custom language model</p>
    "!   Resets a custom language model by removing all corpora, grammars, and words from
    "!    the model. Resetting a custom language model initializes the model to its state
    "!    when it was first created. Metadata such as the name and language of the model
    "!    are preserved, but the model&apos;s words resource is removed and must be
    "!    re-created. You must use credentials for the instance of the service that owns
    "!    a model to reset it. <br/>
    "!   <br/>
    "!   **See also:** [Resetting a custom language
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageLan
    "!   guageModels#resetModel-language).
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
    "! <p class="shorttext synchronized" lang="en">Upgrade a custom language model</p>
    "!   Initiates the upgrade of a custom language model to the latest version of its
    "!    base language model. The upgrade method is asynchronous. It can take on the
    "!    order of minutes to complete depending on the amount of data in the custom
    "!    model and the current load on the service. A custom model must be in the
    "!    `ready` or `available` state to be upgraded. You must use credentials for the
    "!    instance of the service that owns a model to upgrade it. <br/>
    "!   <br/>
    "!   The method returns an HTTP 200 response code to indicate that the upgrade
    "!    process has begun successfully. You can monitor the status of the upgrade by
    "!    using the **Get a custom language model** method to poll the model&apos;s
    "!    status. The method returns a `LanguageModel` object that includes `status` and
    "!    `progress` fields. Use a loop to check the status every 10 seconds. While it is
    "!    being upgraded, the custom model has the status `upgrading`. When the upgrade
    "!    is complete, the model resumes the status that it had prior to upgrade. The
    "!    service cannot accept subsequent requests for the model until the upgrade
    "!    completes. <br/>
    "!   <br/>
    "!   **See also:** [Upgrading a custom language
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-customUpg
    "!   rade#upgradeLanguage).
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

    "! <p class="shorttext synchronized" lang="en">List corpora</p>
    "!   Lists information about all corpora from a custom language model. The
    "!    information includes the total number of words and out-of-vocabulary (OOV)
    "!    words, name, and status of each corpus. You must use credentials for the
    "!    instance of the service that owns a model to list its corpora. <br/>
    "!   <br/>
    "!   **See also:** [Listing corpora for a custom language
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageCor
    "!   pora#listCorpora).
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
    "! <p class="shorttext synchronized" lang="en">Add a corpus</p>
    "!   Adds a single corpus text file of new training data to a custom language model.
    "!    Use multiple requests to submit multiple corpus text files. You must use
    "!    credentials for the instance of the service that owns a model to add a corpus
    "!    to it. Adding a corpus does not affect the custom language model until you
    "!    train the model for the new data by using the **Train a custom language model**
    "!    method. <br/>
    "!   <br/>
    "!   Submit a plain text file that contains sample sentences from the domain of
    "!    interest to enable the service to extract words in context. The more sentences
    "!    you add that represent the context in which speakers use words from the domain,
    "!    the better the service&apos;s recognition accuracy. <br/>
    "!   <br/>
    "!   The call returns an HTTP 201 response code if the corpus is valid. The service
    "!    then asynchronously processes the contents of the corpus and automatically
    "!    extracts new words that it finds. This can take on the order of a minute or two
    "!    to complete depending on the total number of words and the number of new words
    "!    in the corpus, as well as the current load on the service. You cannot submit
    "!    requests to add additional resources to the custom model or to train the model
    "!    until the service&apos;s analysis of the corpus for the current request
    "!    completes. Use the **List a corpus** method to check the status of the
    "!    analysis. <br/>
    "!   <br/>
    "!   The service auto-populates the model&apos;s words resource with words from the
    "!    corpus that are not found in its base vocabulary. These are referred to as
    "!    out-of-vocabulary (OOV) words. You can use the **List custom words** method to
    "!    examine the words resource. You can use other words method to eliminate typos
    "!    and modify how words are pronounced as needed. <br/>
    "!   <br/>
    "!   To add a corpus file that has the same name as an existing corpus, set the
    "!    `allow_overwrite` parameter to `true`; otherwise, the request fails.
    "!    Overwriting an existing corpus causes the service to process the corpus text
    "!    file and extract OOV words anew. Before doing so, it removes any OOV words
    "!    associated with the existing corpus from the model&apos;s words resource unless
    "!    they were also added by another corpus or grammar, or they have been modified
    "!    in some way with the **Add custom words** or **Add a custom word** method.
    "!    <br/>
    "!   <br/>
    "!   The service limits the overall amount of data that you can add to a custom model
    "!    to a maximum of 10 million total words from all sources combined. Also, you can
    "!    add no more than 90 thousand custom (OOV) words to a model. This includes words
    "!    that the service extracts from corpora and grammars, and words that you add
    "!    directly. <br/>
    "!   <br/>
    "!   **See also:**<br/>
    "!   * [Working with
    "!    corpora](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-corpora
    "!   Words#workingCorpora)<br/>
    "!   * [Add a corpus to the custom language
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-languageC
    "!   reate#addCorpus)
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
    "!    encoding](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-corpor
    "!   aWords#charEncoding). <br/>
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
    "! <p class="shorttext synchronized" lang="en">Get a corpus</p>
    "!   Gets information about a corpus from a custom language model. The information
    "!    includes the total number of words and out-of-vocabulary (OOV) words, name, and
    "!    status of the corpus. You must use credentials for the instance of the service
    "!    that owns a model to list its corpora. <br/>
    "!   <br/>
    "!   **See also:** [Listing corpora for a custom language
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageCor
    "!   pora#listCorpora).
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
    "! <p class="shorttext synchronized" lang="en">Delete a corpus</p>
    "!   Deletes an existing corpus from a custom language model. The service removes any
    "!    out-of-vocabulary (OOV) words that are associated with the corpus from the
    "!    custom model&apos;s words resource unless they were also added by another
    "!    corpus or grammar, or they were modified in some way with the **Add custom
    "!    words** or **Add a custom word** method. Removing a corpus does not affect the
    "!    custom model until you train the model with the **Train a custom language
    "!    model** method. You must use credentials for the instance of the service that
    "!    owns a model to delete its corpora. <br/>
    "!   <br/>
    "!   **See also:** [Deleting a corpus from a custom language
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageCor
    "!   pora#deleteCorpus).
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

    "! <p class="shorttext synchronized" lang="en">List custom words</p>
    "!   Lists information about custom words from a custom language model. You can list
    "!    all words from the custom model&apos;s words resource, only custom words that
    "!    were added or modified by the user, or only out-of-vocabulary (OOV) words that
    "!    were extracted from corpora or are recognized by grammars. You can also
    "!    indicate the order in which the service is to return words; by default, the
    "!    service lists words in ascending alphabetical order. You must use credentials
    "!    for the instance of the service that owns a model to list information about its
    "!    words. <br/>
    "!   <br/>
    "!   **See also:** [Listing words from a custom language
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageWor
    "!   ds#listWords).
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_WORD_TYPE |
    "!   The type of words to be listed from the custom language model&apos;s words
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
    "! <p class="shorttext synchronized" lang="en">Add custom words</p>
    "!   Adds one or more custom words to a custom language model. The service populates
    "!    the words resource for a custom model with out-of-vocabulary (OOV) words from
    "!    each corpus or grammar that is added to the model. You can use this method to
    "!    add additional words or to modify existing words in the words resource. The
    "!    words resource for a model can contain a maximum of 90 thousand custom (OOV)
    "!    words. This includes words that the service extracts from corpora and grammars
    "!    and words that you add directly. <br/>
    "!   <br/>
    "!   You must use credentials for the instance of the service that owns a model to
    "!    add or modify custom words for the model. Adding or modifying custom words does
    "!    not affect the custom model until you train the model for the new data by using
    "!    the **Train a custom language model** method. <br/>
    "!   <br/>
    "!   You add custom words by providing a `CustomWords` object, which is an array of
    "!    `CustomWord` objects, one per word. You must use the object&apos;s `word`
    "!    parameter to identify the word that is to be added. You can also provide one or
    "!    both of the optional `sounds_like` and `display_as` fields for each word.<br/>
    "!   * The `sounds_like` field provides an array of one or more pronunciations for
    "!    the word. Use the parameter to specify how the word can be pronounced by users.
    "!    Use the parameter for words that are difficult to pronounce, foreign words,
    "!    acronyms, and so on. For example, you might specify that the word `IEEE` can
    "!    sound like `i triple e`. You can specify a maximum of five sounds-like
    "!    pronunciations for a word.<br/>
    "!   * The `display_as` field provides a different way of spelling the word in a
    "!    transcript. Use the parameter when you want the word to appear different from
    "!    its usual representation or from its spelling in training data. For example,
    "!    you might indicate that the word `IBM(trademark)` is to be displayed as
    "!    `IBM&trade;`. <br/>
    "!   <br/>
    "!   If you add a custom word that already exists in the words resource for the
    "!    custom model, the new definition overwrites the existing data for the word. If
    "!    the service encounters an error with the input data, it returns a failure code
    "!    and does not add any of the words to the words resource. <br/>
    "!   <br/>
    "!   The call returns an HTTP 201 response code if the input data is valid. It then
    "!    asynchronously processes the words to add them to the model&apos;s words
    "!    resource. The time that it takes for the analysis to complete depends on the
    "!    number of new words that you add but is generally faster than adding a corpus
    "!    or grammar. <br/>
    "!   <br/>
    "!   You can monitor the status of the request by using the **List a custom language
    "!    model** method to poll the model&apos;s status. Use a loop to check the status
    "!    every 10 seconds. The method returns a `Customization` object that includes a
    "!    `status` field. A status of `ready` means that the words have been added to the
    "!    custom model. The service cannot accept requests to add new data or to train
    "!    the model until the existing request completes. <br/>
    "!   <br/>
    "!   You can use the **List custom words** or **List a custom word** method to review
    "!    the words that you add. Words with an invalid `sounds_like` field include an
    "!    `error` field that describes the problem. You can use other words-related
    "!    methods to correct errors, eliminate typos, and modify how words are pronounced
    "!    as needed. <br/>
    "!   <br/>
    "!   **See also:**<br/>
    "!   * [Working with custom
    "!    words](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-corporaWo
    "!   rds#workingWords)<br/>
    "!   * [Add words to the custom language
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-languageC
    "!   reate#addWords)
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
    "! <p class="shorttext synchronized" lang="en">Add a custom word</p>
    "!   Adds a custom word to a custom language model. The service populates the words
    "!    resource for a custom model with out-of-vocabulary (OOV) words from each corpus
    "!    or grammar that is added to the model. You can use this method to add a word or
    "!    to modify an existing word in the words resource. The words resource for a
    "!    model can contain a maximum of 90 thousand custom (OOV) words. This includes
    "!    words that the service extracts from corpora and grammars and words that you
    "!    add directly. <br/>
    "!   <br/>
    "!   You must use credentials for the instance of the service that owns a model to
    "!    add or modify a custom word for the model. Adding or modifying a custom word
    "!    does not affect the custom model until you train the model for the new data by
    "!    using the **Train a custom language model** method. <br/>
    "!   <br/>
    "!   Use the `word_name` parameter to specify the custom word that is to be added or
    "!    modified. Use the `CustomWord` object to provide one or both of the optional
    "!    `sounds_like` and `display_as` fields for the word.<br/>
    "!   * The `sounds_like` field provides an array of one or more pronunciations for
    "!    the word. Use the parameter to specify how the word can be pronounced by users.
    "!    Use the parameter for words that are difficult to pronounce, foreign words,
    "!    acronyms, and so on. For example, you might specify that the word `IEEE` can
    "!    sound like `i triple e`. You can specify a maximum of five sounds-like
    "!    pronunciations for a word.<br/>
    "!   * The `display_as` field provides a different way of spelling the word in a
    "!    transcript. Use the parameter when you want the word to appear different from
    "!    its usual representation or from its spelling in training data. For example,
    "!    you might indicate that the word `IBM(trademark)` is to be displayed as
    "!    `IBM&trade;`. <br/>
    "!   <br/>
    "!   If you add a custom word that already exists in the words resource for the
    "!    custom model, the new definition overwrites the existing data for the word. If
    "!    the service encounters an error, it does not add the word to the words
    "!    resource. Use the **List a custom word** method to review the word that you
    "!    add. <br/>
    "!   <br/>
    "!   **See also:**<br/>
    "!   * [Working with custom
    "!    words](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-corporaWo
    "!   rds#workingWords)<br/>
    "!   * [Add words to the custom language
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-languageC
    "!   reate#addWords)
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
    "!    encoding](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-corpor
    "!   aWords#charEncoding).
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
    "! <p class="shorttext synchronized" lang="en">Get a custom word</p>
    "!   Gets information about a custom word from a custom language model. You must use
    "!    credentials for the instance of the service that owns a model to list
    "!    information about its words. <br/>
    "!   <br/>
    "!   **See also:** [Listing words from a custom language
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageWor
    "!   ds#listWords).
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_WORD_NAME |
    "!   The custom word that is to be read from the custom language model. URL-encode
    "!    the word if it includes non-ASCII characters. For more information, see
    "!    [Character
    "!    encoding](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-corpor
    "!   aWords#charEncoding).
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
    "! <p class="shorttext synchronized" lang="en">Delete a custom word</p>
    "!   Deletes a custom word from a custom language model. You can remove any word that
    "!    you added to the custom model&apos;s words resource via any means. However, if
    "!    the word also exists in the service&apos;s base vocabulary, the service removes
    "!    only the custom pronunciation for the word; the word remains in the base
    "!    vocabulary. Removing a custom word does not affect the custom model until you
    "!    train the model with the **Train a custom language model** method. You must use
    "!    credentials for the instance of the service that owns a model to delete its
    "!    words. <br/>
    "!   <br/>
    "!   **See also:** [Deleting a word from a custom language
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageWor
    "!   ds#deleteWord).
    "!
    "! @parameter I_CUSTOMIZATION_ID |
    "!   The customization ID (GUID) of the custom language model that is to be used for
    "!    the request. You must make the request with credentials for the instance of the
    "!    service that owns the custom model.
    "! @parameter I_WORD_NAME |
    "!   The custom word that is to be deleted from the custom language model. URL-encode
    "!    the word if it includes non-ASCII characters. For more information, see
    "!    [Character
    "!    encoding](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-corpor
    "!   aWords#charEncoding).
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_WORD
    importing
      !I_CUSTOMIZATION_ID type STRING
      !I_WORD_NAME type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List grammars</p>
    "!   Lists information about all grammars from a custom language model. The
    "!    information includes the total number of out-of-vocabulary (OOV) words, name,
    "!    and status of each grammar. You must use credentials for the instance of the
    "!    service that owns a model to list its grammars. <br/>
    "!   <br/>
    "!   **See also:** [Listing grammars from a custom language
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageGra
    "!   mmars#listGrammars).
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
    "! <p class="shorttext synchronized" lang="en">Add a grammar</p>
    "!   Adds a single grammar file to a custom language model. Submit a plain text file
    "!    in UTF-8 format that defines the grammar. Use multiple requests to submit
    "!    multiple grammar files. You must use credentials for the instance of the
    "!    service that owns a model to add a grammar to it. Adding a grammar does not
    "!    affect the custom language model until you train the model for the new data by
    "!    using the **Train a custom language model** method. <br/>
    "!   <br/>
    "!   The call returns an HTTP 201 response code if the grammar is valid. The service
    "!    then asynchronously processes the contents of the grammar and automatically
    "!    extracts new words that it finds. This can take a few seconds to complete
    "!    depending on the size and complexity of the grammar, as well as the current
    "!    load on the service. You cannot submit requests to add additional resources to
    "!    the custom model or to train the model until the service&apos;s analysis of the
    "!    grammar for the current request completes. Use the **Get a grammar** method to
    "!    check the status of the analysis. <br/>
    "!   <br/>
    "!   The service populates the model&apos;s words resource with any word that is
    "!    recognized by the grammar that is not found in the model&apos;s base
    "!    vocabulary. These are referred to as out-of-vocabulary (OOV) words. You can use
    "!    the **List custom words** method to examine the words resource and use other
    "!    words-related methods to eliminate typos and modify how words are pronounced as
    "!    needed. <br/>
    "!   <br/>
    "!   To add a grammar that has the same name as an existing grammar, set the
    "!    `allow_overwrite` parameter to `true`; otherwise, the request fails.
    "!    Overwriting an existing grammar causes the service to process the grammar file
    "!    and extract OOV words anew. Before doing so, it removes any OOV words
    "!    associated with the existing grammar from the model&apos;s words resource
    "!    unless they were also added by another resource or they have been modified in
    "!    some way with the **Add custom words** or **Add a custom word** method. <br/>
    "!   <br/>
    "!   The service limits the overall amount of data that you can add to a custom model
    "!    to a maximum of 10 million total words from all sources combined. Also, you can
    "!    add no more than 90 thousand OOV words to a model. This includes words that the
    "!    service extracts from corpora and grammars and words that you add directly.
    "!    <br/>
    "!   <br/>
    "!   **See also:**<br/>
    "!   * [Understanding
    "!    grammars](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-gramma
    "!   rUnderstand#grammarUnderstand)<br/>
    "!   * [Add a grammar to the custom language
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-grammarAd
    "!   d#addGrammar)
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
    "! <p class="shorttext synchronized" lang="en">Get a grammar</p>
    "!   Gets information about a grammar from a custom language model. The information
    "!    includes the total number of out-of-vocabulary (OOV) words, name, and status of
    "!    the grammar. You must use credentials for the instance of the service that owns
    "!    a model to list its grammars. <br/>
    "!   <br/>
    "!   **See also:** [Listing grammars from a custom language
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageGra
    "!   mmars#listGrammars).
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
    "! <p class="shorttext synchronized" lang="en">Delete a grammar</p>
    "!   Deletes an existing grammar from a custom language model. The service removes
    "!    any out-of-vocabulary (OOV) words associated with the grammar from the custom
    "!    model&apos;s words resource unless they were also added by another resource or
    "!    they were modified in some way with the **Add custom words** or **Add a custom
    "!    word** method. Removing a grammar does not affect the custom model until you
    "!    train the model with the **Train a custom language model** method. You must use
    "!    credentials for the instance of the service that owns a model to delete its
    "!    grammar. <br/>
    "!   <br/>
    "!   **See also:** [Deleting a grammar from a custom language
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageGra
    "!   mmars#deleteGrammar).
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

    "! <p class="shorttext synchronized" lang="en">Create a custom acoustic model</p>
    "!   Creates a new custom acoustic model for a specified base model. The custom
    "!    acoustic model can be used only with the base model for which it is created.
    "!    The model is owned by the instance of the service whose credentials are used to
    "!    create it. <br/>
    "!   <br/>
    "!   You can create a maximum of 1024 custom acoustic models per owning credentials.
    "!    The service returns an error if you attempt to create more than 1024 models.
    "!    You do not lose any models, but you cannot create any more until your model
    "!    count is below the limit. <br/>
    "!   <br/>
    "!   **See also:** [Create a custom acoustic
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-acoustic#
    "!   createModel-acoustic).
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
    "! <p class="shorttext synchronized" lang="en">List custom acoustic models</p>
    "!   Lists information about all custom acoustic models that are owned by an instance
    "!    of the service. Use the `language` parameter to see all custom acoustic models
    "!    for the specified language. Omit the parameter to see all custom acoustic
    "!    models for all languages. You must use credentials for the instance of the
    "!    service that owns a model to list information about it. <br/>
    "!   <br/>
    "!   **See also:** [Listing custom acoustic
    "!    models](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageAc
    "!   ousticModels#listModels-acoustic).
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
    "! <p class="shorttext synchronized" lang="en">Get a custom acoustic model</p>
    "!   Gets information about a specified custom acoustic model. You must use
    "!    credentials for the instance of the service that owns a model to list
    "!    information about it. <br/>
    "!   <br/>
    "!   **See also:** [Listing custom acoustic
    "!    models](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageAc
    "!   ousticModels#listModels-acoustic).
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
    "! <p class="shorttext synchronized" lang="en">Delete a custom acoustic model</p>
    "!   Deletes an existing custom acoustic model. The custom model cannot be deleted if
    "!    another request, such as adding an audio resource to the model, is currently
    "!    being processed. You must use credentials for the instance of the service that
    "!    owns a model to delete it. <br/>
    "!   <br/>
    "!   **See also:** [Deleting a custom acoustic
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageAco
    "!   usticModels#deleteModel-acoustic).
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
    "! <p class="shorttext synchronized" lang="en">Train a custom acoustic model</p>
    "!   Initiates the training of a custom acoustic model with new or changed audio
    "!    resources. After adding or deleting audio resources for a custom acoustic
    "!    model, use this method to begin the actual training of the model on the latest
    "!    audio data. The custom acoustic model does not reflect its changed data until
    "!    you train it. You must use credentials for the instance of the service that
    "!    owns a model to train it. <br/>
    "!   <br/>
    "!   The training method is asynchronous. It can take on the order of minutes or
    "!    hours to complete depending on the total amount of audio data on which the
    "!    custom acoustic model is being trained and the current load on the service.
    "!    Typically, training a custom acoustic model takes approximately two to four
    "!    times the length of its audio data. The range of time depends on the model
    "!    being trained and the nature of the audio, such as whether the audio is clean
    "!    or noisy. The method returns an HTTP 200 response code to indicate that the
    "!    training process has begun. <br/>
    "!   <br/>
    "!   You can monitor the status of the training by using the **Get a custom acoustic
    "!    model** method to poll the model&apos;s status. Use a loop to check the status
    "!    once a minute. The method returns an `AcousticModel` object that includes
    "!    `status` and `progress` fields. A status of `available` indicates that the
    "!    custom model is trained and ready to use. The service cannot train a model
    "!    while it is handling another request for the model. The service cannot accept
    "!    subsequent training requests, or requests to add new audio resources, until the
    "!    existing training request completes. <br/>
    "!   <br/>
    "!   You can use the optional `custom_language_model_id` parameter to specify the
    "!    GUID of a separately created custom language model that is to be used during
    "!    training. Train with a custom language model if you have verbatim
    "!    transcriptions of the audio files that you have added to the custom model or
    "!    you have either corpora (text files) or a list of words that are relevant to
    "!    the contents of the audio files. Both of the custom models must be based on the
    "!    same version of the same base model for training to succeed. <br/>
    "!   <br/>
    "!   **See also:**<br/>
    "!   * [Train the custom acoustic
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-acoustic#
    "!   trainModel-acoustic)<br/>
    "!   * [Using custom acoustic and custom language models
    "!    together](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-useBot
    "!   h#useBoth) <br/>
    "!   <br/>
    "!   ### Training failures<br/>
    "!   <br/>
    "!    Training can fail to start for the following reasons:<br/>
    "!   * The service is currently handling another request for the custom model, such
    "!    as another training request or a request to add audio resources to the
    "!    model.<br/>
    "!   * The custom model contains less than 10 minutes or more than 200 hours of audio
    "!    data.<br/>
    "!   * You passed an incompatible custom language model with the
    "!    `custom_language_model_id` query parameter. Both custom models must be based on
    "!    the same version of the same base model.<br/>
    "!   * The custom model contains one or more invalid audio resources. You can correct
    "!    the invalid audio resources or set the `strict` parameter to `false` to exclude
    "!    the invalid resources from the training. The model must contain at least one
    "!    valid resource for training to succeed.
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
    "! <p class="shorttext synchronized" lang="en">Reset a custom acoustic model</p>
    "!   Resets a custom acoustic model by removing all audio resources from the model.
    "!    Resetting a custom acoustic model initializes the model to its state when it
    "!    was first created. Metadata such as the name and language of the model are
    "!    preserved, but the model&apos;s audio resources are removed and must be
    "!    re-created. The service cannot reset a model while it is handling another
    "!    request for the model. The service cannot accept subsequent requests for the
    "!    model until the existing reset request completes. You must use credentials for
    "!    the instance of the service that owns a model to reset it. <br/>
    "!   <br/>
    "!   **See also:** [Resetting a custom acoustic
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageAco
    "!   usticModels#resetModel-acoustic).
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
    "! <p class="shorttext synchronized" lang="en">Upgrade a custom acoustic model</p>
    "!   Initiates the upgrade of a custom acoustic model to the latest version of its
    "!    base language model. The upgrade method is asynchronous. It can take on the
    "!    order of minutes or hours to complete depending on the amount of data in the
    "!    custom model and the current load on the service; typically, upgrade takes
    "!    approximately twice the length of the total audio contained in the custom
    "!    model. A custom model must be in the `ready` or `available` state to be
    "!    upgraded. You must use credentials for the instance of the service that owns a
    "!    model to upgrade it. <br/>
    "!   <br/>
    "!   The method returns an HTTP 200 response code to indicate that the upgrade
    "!    process has begun successfully. You can monitor the status of the upgrade by
    "!    using the **Get a custom acoustic model** method to poll the model&apos;s
    "!    status. The method returns an `AcousticModel` object that includes `status` and
    "!    `progress` fields. Use a loop to check the status once a minute. While it is
    "!    being upgraded, the custom model has the status `upgrading`. When the upgrade
    "!    is complete, the model resumes the status that it had prior to upgrade. The
    "!    service cannot upgrade a model while it is handling another request for the
    "!    model. The service cannot accept subsequent requests for the model until the
    "!    existing upgrade request completes. <br/>
    "!   <br/>
    "!   If the custom acoustic model was trained with a separately created custom
    "!    language model, you must use the `custom_language_model_id` parameter to
    "!    specify the GUID of that custom language model. The custom language model must
    "!    be upgraded before the custom acoustic model can be upgraded. Omit the
    "!    parameter if the custom acoustic model was not trained with a custom language
    "!    model. <br/>
    "!   <br/>
    "!   **See also:** [Upgrading a custom acoustic
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-customUpg
    "!   rade#upgradeAcoustic).
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
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-customUpg
    "!   rade#upgradeAcoustic).
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

    "! <p class="shorttext synchronized" lang="en">List audio resources</p>
    "!   Lists information about all audio resources from a custom acoustic model. The
    "!    information includes the name of the resource and information about its audio
    "!    data, such as its duration. It also includes the status of the audio resource,
    "!    which is important for checking the service&apos;s analysis of the resource in
    "!    response to a request to add it to the custom acoustic model. You must use
    "!    credentials for the instance of the service that owns a model to list its audio
    "!    resources. <br/>
    "!   <br/>
    "!   **See also:** [Listing audio resources for a custom acoustic
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageAud
    "!   io#listAudio).
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
    "! <p class="shorttext synchronized" lang="en">Add an audio resource</p>
    "!   Adds an audio resource to a custom acoustic model. Add audio content that
    "!    reflects the acoustic characteristics of the audio that you plan to transcribe.
    "!    You must use credentials for the instance of the service that owns a model to
    "!    add an audio resource to it. Adding audio data does not affect the custom
    "!    acoustic model until you train the model for the new data by using the **Train
    "!    a custom acoustic model** method. <br/>
    "!   <br/>
    "!   You can add individual audio files or an archive file that contains multiple
    "!    audio files. Adding multiple audio files via a single archive file is
    "!    significantly more efficient than adding each file individually. You can add
    "!    audio resources in any format that the service supports for speech recognition.
    "!    <br/>
    "!   <br/>
    "!   You can use this method to add any number of audio resources to a custom model
    "!    by calling the method once for each audio or archive file. You can add multiple
    "!    different audio resources at the same time. You must add a minimum of 10
    "!    minutes and a maximum of 200 hours of audio that includes speech, not just
    "!    silence, to a custom acoustic model before you can train it. No audio resource,
    "!    audio- or archive-type, can be larger than 100 MB. To add an audio resource
    "!    that has the same name as an existing audio resource, set the `allow_overwrite`
    "!    parameter to `true`; otherwise, the request fails. <br/>
    "!   <br/>
    "!   The method is asynchronous. It can take several seconds to complete depending on
    "!    the duration of the audio and, in the case of an archive file, the total number
    "!    of audio files being processed. The service returns a 201 response code if the
    "!    audio is valid. It then asynchronously analyzes the contents of the audio file
    "!    or files and automatically extracts information about the audio such as its
    "!    length, sampling rate, and encoding. You cannot submit requests to train or
    "!    upgrade the model until the service&apos;s analysis of all audio resources for
    "!    current requests completes. <br/>
    "!   <br/>
    "!   To determine the status of the service&apos;s analysis of the audio, use the
    "!    **Get an audio resource** method to poll the status of the audio. The method
    "!    accepts the customization ID of the custom model and the name of the audio
    "!    resource, and it returns the status of the resource. Use a loop to check the
    "!    status of the audio every few seconds until it becomes `ok`. <br/>
    "!   <br/>
    "!   **See also:** [Add audio to the custom acoustic
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-acoustic#
    "!   addAudio). <br/>
    "!   <br/>
    "!   ### Content types for audio-type resources<br/>
    "!   <br/>
    "!    You can add an individual audio file in any format that the service supports
    "!    for speech recognition. For an audio-type resource, use the `Content-Type`
    "!    parameter to specify the audio format (MIME type) of the audio file, including
    "!    specifying the sampling rate, channels, and endianness where indicated.<br/>
    "!   * `audio/alaw` (Specify the sampling rate (`rate`) of the audio.)<br/>
    "!   * `audio/basic` (Use only with narrowband models.)<br/>
    "!   * `audio/flac`<br/>
    "!   * `audio/g729` (Use only with narrowband models.)<br/>
    "!   * `audio/l16` (Specify the sampling rate (`rate`) and optionally the number of
    "!    channels (`channels`) and endianness (`endianness`) of the audio.)<br/>
    "!   * `audio/mp3`<br/>
    "!   * `audio/mpeg`<br/>
    "!   * `audio/mulaw` (Specify the sampling rate (`rate`) of the audio.)<br/>
    "!   * `audio/ogg` (The service automatically detects the codec of the input
    "!    audio.)<br/>
    "!   * `audio/ogg;codecs=opus`<br/>
    "!   * `audio/ogg;codecs=vorbis`<br/>
    "!   * `audio/wav` (Provide audio with a maximum of nine channels.)<br/>
    "!   * `audio/webm` (The service automatically detects the codec of the input
    "!    audio.)<br/>
    "!   * `audio/webm;codecs=opus`<br/>
    "!   * `audio/webm;codecs=vorbis` <br/>
    "!   <br/>
    "!   The sampling rate of an audio file must match the sampling rate of the base
    "!    model for the custom model: for broadband models, at least 16 kHz; for
    "!    narrowband models, at least 8 kHz. If the sampling rate of the audio is higher
    "!    than the minimum required rate, the service down-samples the audio to the
    "!    appropriate rate. If the sampling rate of the audio is lower than the minimum
    "!    required rate, the service labels the audio file as `invalid`.<br/>
    "!   <br/>
    "!    **See also:** [Audio
    "!    formats](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-audio-f
    "!   ormats#audio-formats). <br/>
    "!   <br/>
    "!   ### Content types for archive-type resources<br/>
    "!   <br/>
    "!    You can add an archive file (**.zip** or **.tar.gz** file) that contains audio
    "!    files in any format that the service supports for speech recognition. For an
    "!    archive-type resource, use the `Content-Type` parameter to specify the media
    "!    type of the archive file:<br/>
    "!   * `application/zip` for a **.zip** file<br/>
    "!   * `application/gzip` for a **.tar.gz** file. <br/>
    "!   <br/>
    "!   When you add an archive-type resource, the `Contained-Content-Type` header is
    "!    optional depending on the format of the files that you are adding: <br/>
    "!   * For audio files of type `audio/alaw`, `audio/basic`, `audio/l16`, or
    "!    `audio/mulaw`, you must use the `Contained-Content-Type` header to specify the
    "!    format of the contained audio files. Include the `rate`, `channels`, and
    "!    `endianness` parameters where necessary. In this case, all audio files
    "!    contained in the archive file must have the same audio format. <br/>
    "!   * For audio files of all other types, you can omit the `Contained-Content-Type`
    "!    header. In this case, the audio files contained in the archive file can have
    "!    any of the formats not listed in the previous bullet. The audio files do not
    "!    need to have the same format. <br/>
    "!   <br/>
    "!   Do not use the `Contained-Content-Type` header when adding an audio-type
    "!    resource. <br/>
    "!   <br/>
    "!   ### Naming restrictions for embedded audio files<br/>
    "!   <br/>
    "!    The name of an audio file that is contained in an archive-type resource can
    "!    include a maximum of 128 characters. This includes the file extension and all
    "!    elements of the name (for example, slashes).
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
    "!    contained in the archive file if they are of type `audio/alaw`, `audio/basic`,
    "!    `audio/l16`, or `audio/mulaw`. Include the `rate`, `channels`, and `endianness`
    "!    parameters where necessary. In this case, all audio files that are contained in
    "!    the archive file must be of the indicated type. <br/>
    "!   <br/>
    "!   For all other audio formats, you can omit the header. In this case, the audio
    "!    files can be of multiple types as long as they are not of the types listed in
    "!    the previous paragraph. <br/>
    "!   <br/>
    "!   The parameter accepts all of the audio formats that are supported for use with
    "!    speech recognition. For more information, see **Content types for audio-type
    "!    resources** in the method description. <br/>
    "!   <br/>
    "!   **For an audio-type resource,** omit the header.
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
    "! <p class="shorttext synchronized" lang="en">Get an audio resource</p>
    "!   Gets information about an audio resource from a custom acoustic model. The
    "!    method returns an `AudioListing` object whose fields depend on the type of
    "!    audio resource that you specify with the method&apos;s `audio_name`
    "!    parameter:<br/>
    "!   * **For an audio-type resource,** the object&apos;s fields match those of an
    "!    `AudioResource` object: `duration`, `name`, `details`, and `status`.<br/>
    "!   * **For an archive-type resource,** the object includes a `container` field
    "!    whose fields match those of an `AudioResource` object. It also includes an
    "!    `audio` field, which contains an array of `AudioResource` objects that provides
    "!    information about the audio files that are contained in the archive. <br/>
    "!   <br/>
    "!   The information includes the status of the specified audio resource. The status
    "!    is important for checking the service&apos;s analysis of a resource that you
    "!    add to the custom model.<br/>
    "!   * For an audio-type resource, the `status` field is located in the
    "!    `AudioListing` object.<br/>
    "!   * For an archive-type resource, the `status` field is located in the
    "!    `AudioResource` object that is returned in the `container` field. <br/>
    "!   <br/>
    "!   You must use credentials for the instance of the service that owns a model to
    "!    list its audio resources. <br/>
    "!   <br/>
    "!   **See also:** [Listing audio resources for a custom acoustic
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageAud
    "!   io#listAudio).
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
    "! <p class="shorttext synchronized" lang="en">Delete an audio resource</p>
    "!   Deletes an existing audio resource from a custom acoustic model. Deleting an
    "!    archive-type audio resource removes the entire archive of files. The service
    "!    does not allow deletion of individual files from an archive resource. <br/>
    "!   <br/>
    "!   Removing an audio resource does not affect the custom model until you train the
    "!    model on its updated data by using the **Train a custom acoustic model**
    "!    method. You can delete an existing audio resource from a model while a
    "!    different resource is being added to the model. You must use credentials for
    "!    the instance of the service that owns a model to delete its audio resources.
    "!    <br/>
    "!   <br/>
    "!   **See also:** [Deleting an audio resource from a custom acoustic
    "!    model](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-manageAud
    "!   io#deleteAudio).
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

    "! <p class="shorttext synchronized" lang="en">Delete labeled data</p>
    "!   Deletes all data that is associated with a specified customer ID. The method
    "!    deletes all data for the customer ID, regardless of the method by which the
    "!    information was added. The method has no effect if no data is associated with
    "!    the customer ID. You must issue the request with credentials for the same
    "!    instance of the service that was used to associate the customer ID with the
    "!    data. <br/>
    "!   <br/>
    "!   You associate a customer ID with data by passing the `X-Watson-Metadata` header
    "!    with a request that passes the data. <br/>
    "!   <br/>
    "!   **See also:** [Information
    "!    security](https://cloud.ibm.com/docs/speech-to-text?topic=speech-to-text-inform
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

    e_sdk_version_date = '20200310173436'.

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
