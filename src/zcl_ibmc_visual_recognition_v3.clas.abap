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
"! <p class="shorttext synchronized" lang="en">Visual Recognition</p>
"! The IBM Watson&trade; Visual Recognition service uses deep learning algorithms
"!  to identify scenes and objects in images that you upload to the service. You
"!  can create and train a custom classifier to identify subjects that suit your
"!  needs. <br/>
class ZCL_IBMC_VISUAL_RECOGNITION_V3 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Number of images processed for the API call.</p>
      T_IMAGES_PROCESSED type Integer.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Result of a class within a classifier.</p>
    begin of T_CLASS_RESULT,
      "!   Name of the class. <br/>
      "!   <br/>
      "!   Class names are translated in the language defined by the **Accept-Language**
      "!    request header for the build-in classifier IDs (`default`, `food`, and
      "!    `explicit`). Class names of custom classifiers are not translated. The response
      "!    might not be in the specified language when the requested language is not
      "!    supported or when there is no translation for the class name.
      CLASS type STRING,
      "!   Confidence score for the property in the range of 0 to 1. A higher score
      "!    indicates greater likelihood that the class is depicted in the image. The
      "!    default threshold for returning scores from a classifier is 0.5.
      SCORE type FLOAT,
      "!   Knowledge graph of the property. For example, `/fruit/pome/apple/eating
      "!    apple/Granny Smith`. Included only if identified.
      TYPE_HIERARCHY type STRING,
    end of T_CLASS_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Classifier and score combination.</p>
    begin of T_CLASSIFIER_RESULT,
      "!   Name of the classifier.
      NAME type STRING,
      "!   ID of a classifier identified in the image.
      CLASSIFIER_ID type STRING,
      "!   Classes within the classifier.
      CLASSES type STANDARD TABLE OF T_CLASS_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_CLASSIFIER_RESULT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about what might have caused a failure, such as</p>
    "!     an image that is too large. Not returned when there is no error.
    begin of T_ERROR_INFO,
      "!   HTTP status code.
      CODE type INTEGER,
      "!   Human-readable error description. For example, `File size limit exceeded`.
      DESCRIPTION type STRING,
      "!   Codified error string. For example, `limit_exceeded`.
      ERROR_ID type STRING,
    end of T_ERROR_INFO.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Results for one image.</p>
    begin of T_CLASSIFIED_IMAGE,
      "!   Source of the image before any redirects. Not returned when the image is
      "!    uploaded.
      SOURCE_URL type STRING,
      "!   Fully resolved URL of the image after redirects are followed. Not returned when
      "!    the image is uploaded.
      RESOLVED_URL type STRING,
      "!   Relative path of the image file if uploaded directly. Not returned when the
      "!    image is passed by URL.
      IMAGE type STRING,
      "!   Information about what might have caused a failure, such as an image that is too
      "!    large. Not returned when there is no error.
      ERROR type T_ERROR_INFO,
      "!   The classifiers.
      CLASSIFIERS type STANDARD TABLE OF T_CLASSIFIER_RESULT WITH NON-UNIQUE DEFAULT KEY,
    end of T_CLASSIFIED_IMAGE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about something that went wrong.</p>
    begin of T_WARNING_INFO,
      "!   Codified warning string, such as `limit_reached`.
      WARNING_ID type STRING,
      "!   Information about the error.
      DESCRIPTION type STRING,
    end of T_WARNING_INFO.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Results for all images.</p>
    begin of T_CLASSIFIED_IMAGES,
      "!   Number of custom classes identified in the images.
      CUSTOM_CLASSES type INTEGER,
      "!   Number of images processed for the API call.
      IMAGES_PROCESSED type INTEGER,
      "!   Classified images.
      IMAGES type STANDARD TABLE OF T_CLASSIFIED_IMAGE WITH NON-UNIQUE DEFAULT KEY,
      "!   Information about what might cause less than optimal output. For example, a
      "!    request sent with a corrupt .zip file and a list of image URLs will still
      "!    complete, but does not return the expected output. Not returned when there is
      "!    no warning.
      WARNINGS type STANDARD TABLE OF T_WARNING_INFO WITH NON-UNIQUE DEFAULT KEY,
    end of T_CLASSIFIED_IMAGES.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Knowledge graph of the property. For example,</p>
    "!     `/fruit/pome/apple/eating apple/Granny Smith`. Included only if identified.
      T_TYPE_HIERARCHY type String.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A category within a classifier.</p>
    begin of T_CLASS,
      "!   The name of the class.
      CLASS type STRING,
    end of T_CLASS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Empty object.</p>
      T_EMPTY type JSONOBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Error information.</p>
    begin of T_ERROR_RESPONSE,
      "!   HTTP error code.
      CODE type INTEGER,
      "!   Human-readable error string, like &apos;Invalid image file&apos;.
      ERROR type STRING,
    end of T_ERROR_RESPONSE.
  types:
    "! No documentation available.
    begin of T_INLINE_OBJECT1,
      "!   The name of the new classifier. Encode special characters in UTF-8.
      NAME type STRING,
      "!   A .zip file of images that depict the visual subject of a class in the new
      "!    classifier. You can include more than one positive example file in a call.<br/>
      "!   <br/>
      "!   Specify the parameter name by appending `_positive_examples` to the class name.
      "!    For example, `goldenretriever_positive_examples` creates the class
      "!    **goldenretriever**. The string cannot contain the following characters: ``$ *
      "!    - &#123; &#125; \ | / &apos; &quot; ` [ ]``.<br/>
      "!   <br/>
      "!   Include at least 10 images in .jpg or .png format. The minimum recommended image
      "!    resolution is 32X32 pixels. The maximum number of images is 10,000 images or
      "!    100 MB per .zip file.<br/>
      "!   <br/>
      "!   Encode special characters in the file name in UTF-8.
      POSITIVE_EXAMPLES type FILE,
      "!   A .zip file of images that do not depict the visual subject of any of the
      "!    classes of the new classifier. Must contain a minimum of 10 images.<br/>
      "!   <br/>
      "!   Encode special characters in the file name in UTF-8.
      NEGATIVE_EXAMPLES type FILE,
    end of T_INLINE_OBJECT1.
  types:
    "! No documentation available.
    begin of T_INLINE_OBJECT,
      "!   An image file (.gif, .jpg, .png, .tif) or .zip file with images. Maximum image
      "!    size is 10 MB. Include no more than 20 images and limit the .zip file to 100
      "!    MB. Encode the image and .zip file names in UTF-8 if they contain non-ASCII
      "!    characters. The service assumes UTF-8 encoding if it encounters non-ASCII
      "!    characters.<br/>
      "!   <br/>
      "!   You can also include an image with the **url** parameter.
      IMAGES_FILE type FILE,
      "!   The URL of an image (.gif, .jpg, .png, .tif) to analyze. The minimum recommended
      "!    pixel density is 32X32 pixels, but the service tends to perform better with
      "!    images that are at least 224 x 224 pixels. The maximum image size is 10
      "!    MB.<br/>
      "!   <br/>
      "!   You can also include images with the **images_file** parameter.
      URL type STRING,
      "!   The minimum score a class must have to be displayed in the response. Set the
      "!    threshold to `0.0` to return all identified classes.
      THRESHOLD type FLOAT,
      "!   The categories of classifiers to apply. The **classifier_ids** parameter
      "!    overrides **owners**, so make sure that **classifier_ids** is empty. <br/>
      "!   - Use `IBM` to classify against the `default` general classifier. You get the
      "!    same result if both **classifier_ids** and **owners** parameters are
      "!    empty.<br/>
      "!   - Use `me` to classify against all your custom classifiers. However, for better
      "!    performance use **classifier_ids** to specify the specific custom classifiers
      "!    to apply.<br/>
      "!   - Use both `IBM` and `me` to analyze the image against both classifier
      "!    categories.
      OWNERS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   Which classifiers to apply. Overrides the **owners** parameter. You can specify
      "!    both custom and built-in classifier IDs. The built-in `default` classifier is
      "!    used if both **classifier_ids** and **owners** parameters are empty.<br/>
      "!   <br/>
      "!   The following built-in classifier IDs require no training:<br/>
      "!   - `default`: Returns classes from thousands of general tags.<br/>
      "!   - `food`: Enhances specificity and accuracy for images of food items.<br/>
      "!   - `explicit`: Evaluates whether the image might be pornographic.
      CLASSIFIER_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
    end of T_INLINE_OBJECT.
  types:
    "! No documentation available.
    begin of T_INLINE_OBJECT2,
      "!   A .zip file of images that depict the visual subject of a class in the
      "!    classifier. The positive examples create or update classes in the classifier.
      "!    You can include more than one positive example file in a call.<br/>
      "!   <br/>
      "!   Specify the parameter name by appending `_positive_examples` to the class name.
      "!    For example, `goldenretriever_positive_examples` creates the class
      "!    `goldenretriever`. The string cannot contain the following characters: ``$ * -
      "!    &#123; &#125; \ | / &apos; &quot; ` [ ]``.<br/>
      "!   <br/>
      "!   Include at least 10 images in .jpg or .png format. The minimum recommended image
      "!    resolution is 32X32 pixels. The maximum number of images is 10,000 images or
      "!    100 MB per .zip file.<br/>
      "!   <br/>
      "!   Encode special characters in the file name in UTF-8.
      POSITIVE_EXAMPLES type FILE,
      "!   A .zip file of images that do not depict the visual subject of any of the
      "!    classes of the new classifier. Must contain a minimum of 10 images.<br/>
      "!   <br/>
      "!   Encode special characters in the file name in UTF-8.
      NEGATIVE_EXAMPLES type FILE,
    end of T_INLINE_OBJECT2.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Information about a classifier.</p>
    begin of T_CLASSIFIER,
      "!   ID of a classifier identified in the image.
      CLASSIFIER_ID type STRING,
      "!   Name of the classifier.
      NAME type STRING,
      "!   Unique ID of the account who owns the classifier. Might not be returned by some
      "!    requests.
      OWNER type STRING,
      "!   Training status of classifier.
      STATUS type STRING,
      "!   Whether the classifier can be downloaded as a Core ML model after the training
      "!    status is `ready`.
      CORE_ML_ENABLED type BOOLEAN,
      "!   If classifier training has failed, this field might explain why.
      EXPLANATION type STRING,
      "!   Date and time in Coordinated Universal Time (UTC) that the classifier was
      "!    created.
      CREATED type DATETIME,
      "!   Classes that define a classifier.
      CLASSES type STANDARD TABLE OF T_CLASS WITH NON-UNIQUE DEFAULT KEY,
      "!   Date and time in Coordinated Universal Time (UTC) that the classifier was
      "!    updated. Might not be returned by some requests. Identical to `updated` and
      "!    retained for backward compatibility.
      RETRAINED type DATETIME,
      "!   Date and time in Coordinated Universal Time (UTC) that the classifier was most
      "!    recently updated. The field matches either `retrained` or `created`. Might not
      "!    be returned by some requests.
      UPDATED type DATETIME,
    end of T_CLASSIFIER.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Number of custom classes identified in the images.</p>
      T_CUSTOM_CLASSES_PROCESSED type Integer.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Confidence score for the property in the range of 0 to 1. A</p>
    "!     higher score indicates greater likelihood that the class is depicted in the
    "!     image. The default threshold for returning scores from a classifier is 0.5.
      T_CONFIDENCE_SCORE type Float.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Relative path of the image file if uploaded directly. Not</p>
    "!     returned when the image is passed by URL.
      T_IMAGE_FILE type String.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Error information.</p>
    begin of T_ERROR_HTML,
      "!   HTML description of the error.
      ERROR1 type STRING,
    end of T_ERROR_HTML.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Source of the image before any redirects. Not returned when</p>
    "!     the image is uploaded.
      T_SOURCE_URL type String.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Fully resolved URL of the image after redirects are</p>
    "!     followed. Not returned when the image is uploaded.
      T_RESOLVED_URL type String.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A container for the list of classifiers.</p>
    begin of T_CLASSIFIERS,
      "!   List of classifiers.
      CLASSIFIERS type STANDARD TABLE OF T_CLASSIFIER WITH NON-UNIQUE DEFAULT KEY,
    end of T_CLASSIFIERS.

constants:
  "! <p class="shorttext synchronized" lang="en">List of required fields per type.</p>
  begin of C_REQUIRED_FIELDS,
    T_CLASS_RESULT type string value '|CLASS|SCORE|',
    T_CLASSIFIER_RESULT type string value '|NAME|CLASSIFIER_ID|CLASSES|',
    T_ERROR_INFO type string value '|CODE|DESCRIPTION|ERROR_ID|',
    T_CLASSIFIED_IMAGE type string value '|CLASSIFIERS|',
    T_WARNING_INFO type string value '|WARNING_ID|DESCRIPTION|',
    T_CLASSIFIED_IMAGES type string value '|IMAGES|',
    T_CLASS type string value '|CLASS|',
    T_ERROR_RESPONSE type string value '|CODE|ERROR|',
    T_INLINE_OBJECT1 type string value '|NAME|POSITIVE_EXAMPLES|',
    T_INLINE_OBJECT type string value '|',
    T_INLINE_OBJECT2 type string value '|',
    T_CLASSIFIER type string value '|CLASSIFIER_ID|NAME|',
    T_ERROR_HTML type string value '|',
    T_CLASSIFIERS type string value '|CLASSIFIERS|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  "! <p class="shorttext synchronized" lang="en">Map ABAP identifiers to service identifiers.</p>
  begin of C_ABAPNAME_DICTIONARY,
     WARNING_ID type string value 'warning_id',
     DESCRIPTION type string value 'description',
     CODE type string value 'code',
     ERROR_ID type string value 'error_id',
     CLASSIFIERS type string value 'classifiers',
     CLASSIFIER_ID type string value 'classifier_id',
     NAME type string value 'name',
     OWNER type string value 'owner',
     STATUS type string value 'status',
     CORE_ML_ENABLED type string value 'core_ml_enabled',
     EXPLANATION type string value 'explanation',
     CREATED type string value 'created',
     CLASSES type string value 'classes',
     RETRAINED type string value 'retrained',
     UPDATED type string value 'updated',
     CLASS type string value 'class',
     SOURCE_URL type string value 'source_url',
     RESOLVED_URL type string value 'resolved_url',
     IMAGE type string value 'image',
     ERROR type string value 'error',
     ERROR1 type string value 'Error',
     SCORE type string value 'score',
     TYPE_HIERARCHY type string value 'type_hierarchy',
     CUSTOM_CLASSES type string value 'custom_classes',
     IMAGES_PROCESSED type string value 'images_processed',
     IMAGES type string value 'images',
     WARNINGS type string value 'warnings',
     IMAGES_FILE type string value 'images_file',
     URL type string value 'url',
     THRESHOLD type string value 'threshold',
     OWNERS type string value 'owners',
     CLASSIFIER_IDS type string value 'classifier_ids',
     CLASSIFIERID type string value 'classifierId',
     POSITIVE_EXAMPLES type string value 'positive_examples',
     NEGATIVE_EXAMPLES type string value 'negative_examples',
  end of C_ABAPNAME_DICTIONARY .


  methods GET_APPNAME
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
  methods GET_SDK_VERSION_DATE
    redefinition .


    "! <p class="shorttext synchronized" lang="en">Classify images</p>
    "!   Classify images with built-in or custom classifiers.
    "!
    "! @parameter I_IMAGES_FILE |
    "!   An image file (.gif, .jpg, .png, .tif) or .zip file with images. Maximum image
    "!    size is 10 MB. Include no more than 20 images and limit the .zip file to 100
    "!    MB. Encode the image and .zip file names in UTF-8 if they contain non-ASCII
    "!    characters. The service assumes UTF-8 encoding if it encounters non-ASCII
    "!    characters.<br/>
    "!   <br/>
    "!   You can also include an image with the **url** parameter.
    "! @parameter I_IMAGES_FILENAME |
    "!   The filename for imagesFile.
    "! @parameter I_IMAGES_FILE_CONTENT_TYPE |
    "!   The content type of imagesFile.
    "! @parameter I_URL |
    "!   The URL of an image (.gif, .jpg, .png, .tif) to analyze. The minimum recommended
    "!    pixel density is 32X32 pixels, but the service tends to perform better with
    "!    images that are at least 224 x 224 pixels. The maximum image size is 10
    "!    MB.<br/>
    "!   <br/>
    "!   You can also include images with the **images_file** parameter.
    "! @parameter I_THRESHOLD |
    "!   The minimum score a class must have to be displayed in the response. Set the
    "!    threshold to `0.0` to return all identified classes.
    "! @parameter I_OWNERS |
    "!   The categories of classifiers to apply. The **classifier_ids** parameter
    "!    overrides **owners**, so make sure that **classifier_ids** is empty. <br/>
    "!   - Use `IBM` to classify against the `default` general classifier. You get the
    "!    same result if both **classifier_ids** and **owners** parameters are
    "!    empty.<br/>
    "!   - Use `me` to classify against all your custom classifiers. However, for better
    "!    performance use **classifier_ids** to specify the specific custom classifiers
    "!    to apply.<br/>
    "!   - Use both `IBM` and `me` to analyze the image against both classifier
    "!    categories.
    "! @parameter I_CLASSIFIER_IDS |
    "!   Which classifiers to apply. Overrides the **owners** parameter. You can specify
    "!    both custom and built-in classifier IDs. The built-in `default` classifier is
    "!    used if both **classifier_ids** and **owners** parameters are empty.<br/>
    "!   <br/>
    "!   The following built-in classifier IDs require no training:<br/>
    "!   - `default`: Returns classes from thousands of general tags.<br/>
    "!   - `food`: Enhances specificity and accuracy for images of food items.<br/>
    "!   - `explicit`: Evaluates whether the image might be pornographic.
    "! @parameter I_ACCEPT_LANGUAGE |
    "!   The desired language of parts of the response. See the response for details.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CLASSIFIED_IMAGES
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CLASSIFY
    importing
      !I_IMAGES_FILE type FILE optional
      !I_IMAGES_FILENAME type STRING optional
      !I_IMAGES_FILE_CONTENT_TYPE type STRING optional
      !I_URL type STRING optional
      !I_THRESHOLD type FLOAT optional
      !I_OWNERS type TT_STRING optional
      !I_CLASSIFIER_IDS type TT_STRING optional
      !I_ACCEPT_LANGUAGE type STRING default 'en'
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CLASSIFIED_IMAGES
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Create a classifier</p>
    "!   Train a new multi-faceted classifier on the uploaded image data. Create your
    "!    custom classifier with positive or negative example training images. Include at
    "!    least two sets of examples, either two positive example files or one positive
    "!    and one negative file. You can upload a maximum of 256 MB per call.<br/>
    "!   <br/>
    "!   **Tips when creating:**<br/>
    "!   <br/>
    "!   - If you set the **X-Watson-Learning-Opt-Out** header parameter to `true` when
    "!    you create a classifier, the example training images are not stored. Save your
    "!    training images locally. For more information, see [Data
    "!    collection](#data-collection).<br/>
    "!   <br/>
    "!   - Encode all names in UTF-8 if they contain non-ASCII characters (.zip and image
    "!    file names, and classifier and class names). The service assumes UTF-8 encoding
    "!    if it encounters non-ASCII characters.
    "!
    "! @parameter I_NAME |
    "!   The name of the new classifier. Encode special characters in UTF-8.
    "! @parameter I_POSITIVE_EXAMPLES |
    "!   A .zip file of images that depict the visual subject of a class in the new
    "!    classifier. You can include more than one positive example file in a call.<br/>
    "!   <br/>
    "!   Specify the parameter name by appending `_positive_examples` to the class name.
    "!    For example, `goldenretriever_positive_examples` creates the class
    "!    **goldenretriever**. The string cannot contain the following characters: ``$ *
    "!    - &#123; &#125; \ | / &apos; &quot; ` [ ]``.<br/>
    "!   <br/>
    "!   Include at least 10 images in .jpg or .png format. The minimum recommended image
    "!    resolution is 32X32 pixels. The maximum number of images is 10,000 images or
    "!    100 MB per .zip file.<br/>
    "!   <br/>
    "!   Encode special characters in the file name in UTF-8.
    "! @parameter I_NEGATIVE_EXAMPLES |
    "!   A .zip file of images that do not depict the visual subject of any of the
    "!    classes of the new classifier. Must contain a minimum of 10 images.<br/>
    "!   <br/>
    "!   Encode special characters in the file name in UTF-8.
    "! @parameter I_NEGATIVE_EXAMPLES_FILENAME |
    "!   The filename for negativeExamples.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CLASSIFIER
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_CLASSIFIER
    importing
      !I_NAME type STRING
      !I_POSITIVE_EXAMPLES type TT_MAP_FILE
      !I_NEGATIVE_EXAMPLES type FILE optional
      !I_NEGATIVE_EXAMPLES_FILENAME type STRING optional
      !I_POSITIVE_EXAMPLES_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_NEGATIVE_EXAMPLES_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CLASSIFIER
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Retrieve a list of classifiers</p>
    "!
    "! @parameter I_VERBOSE |
    "!   Specify `true` to return details about the classifiers. Omit this parameter to
    "!    return a brief list of classifiers.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CLASSIFIERS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_CLASSIFIERS
    importing
      !I_VERBOSE type BOOLEAN optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CLASSIFIERS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Retrieve classifier details</p>
    "!   Retrieve information about a custom classifier.
    "!
    "! @parameter I_CLASSIFIER_ID |
    "!   The ID of the classifier.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CLASSIFIER
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_CLASSIFIER
    importing
      !I_CLASSIFIER_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CLASSIFIER
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update a classifier</p>
    "!   Update a custom classifier by adding new positive or negative classes or by
    "!    adding new images to existing classes. You must supply at least one set of
    "!    positive or negative examples. For details, see [Updating custom
    "!    classifiers](https://cloud.ibm.com/docs/visual-recognition?topic=visual-recogni
    "!   tion-customizing#updating-custom-classifiers).<br/>
    "!   <br/>
    "!   Encode all names in UTF-8 if they contain non-ASCII characters (.zip and image
    "!    file names, and classifier and class names). The service assumes UTF-8 encoding
    "!    if it encounters non-ASCII characters.<br/>
    "!   <br/>
    "!   **Tips about retraining:**<br/>
    "!   <br/>
    "!   - You can&apos;t update the classifier if the **X-Watson-Learning-Opt-Out**
    "!    header parameter was set to `true` when the classifier was created. Training
    "!    images are not stored in that case. Instead, create another classifier. For
    "!    more information, see [Data collection](#data-collection).<br/>
    "!   <br/>
    "!   - Don&apos;t make retraining calls on a classifier until the status is ready.
    "!    When you submit retraining requests in parallel, the last request overwrites
    "!    the previous requests. The `retrained` property shows the last time the
    "!    classifier retraining finished.
    "!
    "! @parameter I_CLASSIFIER_ID |
    "!   The ID of the classifier.
    "! @parameter I_POSITIVE_EXAMPLES |
    "!   A .zip file of images that depict the visual subject of a class in the
    "!    classifier. The positive examples create or update classes in the classifier.
    "!    You can include more than one positive example file in a call.<br/>
    "!   <br/>
    "!   Specify the parameter name by appending `_positive_examples` to the class name.
    "!    For example, `goldenretriever_positive_examples` creates the class
    "!    `goldenretriever`. The string cannot contain the following characters: ``$ * -
    "!    &#123; &#125; \ | / &apos; &quot; ` [ ]``.<br/>
    "!   <br/>
    "!   Include at least 10 images in .jpg or .png format. The minimum recommended image
    "!    resolution is 32X32 pixels. The maximum number of images is 10,000 images or
    "!    100 MB per .zip file.<br/>
    "!   <br/>
    "!   Encode special characters in the file name in UTF-8.
    "! @parameter I_NEGATIVE_EXAMPLES |
    "!   A .zip file of images that do not depict the visual subject of any of the
    "!    classes of the new classifier. Must contain a minimum of 10 images.<br/>
    "!   <br/>
    "!   Encode special characters in the file name in UTF-8.
    "! @parameter I_NEGATIVE_EXAMPLES_FILENAME |
    "!   The filename for negativeExamples.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_CLASSIFIER
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_CLASSIFIER
    importing
      !I_CLASSIFIER_ID type STRING
      !I_POSITIVE_EXAMPLES type TT_MAP_FILE optional
      !I_NEGATIVE_EXAMPLES type FILE optional
      !I_NEGATIVE_EXAMPLES_FILENAME type STRING optional
      !I_POSITIVE_EXAMPLES_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_NEGATIVE_EXAMPLES_CT type STRING default ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-ALL
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_CLASSIFIER
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a classifier</p>
    "!
    "! @parameter I_CLASSIFIER_ID |
    "!   The ID of the classifier.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_CLASSIFIER
    importing
      !I_CLASSIFIER_ID type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Retrieve a Core ML model of a classifier</p>
    "!   Download a Core ML model file (.mlmodel) of a custom classifier that returns
    "!    &lt;tt&gt;&quot;core_ml_enabled&quot;: true&lt;/tt&gt; in the classifier
    "!    details.
    "!
    "! @parameter I_CLASSIFIER_ID |
    "!   The ID of the classifier.
    "! @parameter E_RESPONSE |
    "!   Service return value of type FILE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_CORE_ML_MODEL
    importing
      !I_CLASSIFIER_ID type STRING
      !I_accept      type string default 'application/octet-stream'
    exporting
      !E_RESPONSE type FILE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Delete labeled data</p>
    "!   Deletes all data associated with a specified customer ID. The method has no
    "!    effect if no data is associated with the customer ID. <br/>
    "!   <br/>
    "!   You associate a customer ID with data by passing the `X-Watson-Metadata` header
    "!    with a request that passes data. For more information about personal data and
    "!    customer IDs, see [Information
    "!    security](https://cloud.ibm.com/docs/visual-recognition?topic=visual-recognitio
    "!   n-information-security).
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

class ZCL_IBMC_VISUAL_RECOGNITION_V3 IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V3->GET_APPNAME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_APPNAME                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method GET_APPNAME.

    e_appname = 'Visual Recognition'.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method ZCL_IBMC_VISUAL_RECOGNITION_V3->GET_REQUEST_PROP
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
  else.
  endif.

  e_request_prop-url-protocol    = 'http'.
  e_request_prop-url-host        = 'localhost'.
  e_request_prop-url-path_base   = '/visual-recognition/api'.

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V3->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20200310173442'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V3->CLASSIFY
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_IMAGES_FILE        TYPE FILE(optional)
* | [--->] I_IMAGES_FILENAME        TYPE STRING(optional)
* | [--->] I_IMAGES_FILE_CONTENT_TYPE        TYPE STRING(optional)
* | [--->] I_URL        TYPE STRING(optional)
* | [--->] I_THRESHOLD        TYPE FLOAT(optional)
* | [--->] I_OWNERS        TYPE TT_STRING(optional)
* | [--->] I_CLASSIFIER_IDS        TYPE TT_STRING(optional)
* | [--->] I_ACCEPT_LANGUAGE        TYPE STRING (default ='en')
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CLASSIFIED_IMAGES
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CLASSIFY.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/classify'.

    " standard headers
    ls_request_prop-header_content_type = I_contenttype.
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).



    " process header parameters
    data:
      lv_headerparam type string  ##NEEDED.

    if i_ACCEPT_LANGUAGE is supplied.
    lv_headerparam = I_ACCEPT_LANGUAGE.
    add_header_parameter(
      exporting
        i_parameter  = 'Accept-Language'
        i_value      = lv_headerparam
      changing
        c_headers    = ls_request_prop-headers )  ##NO_TEXT.
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


    if not i_URL is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="url"'  ##NO_TEXT.
      lv_formdata = i_URL.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_THRESHOLD is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="threshold"'  ##NO_TEXT.
      lv_formdata = i_THRESHOLD.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.

    if not i_OWNERS is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="owners"'  ##NO_TEXT.
      field-symbols:
        <l_OWNERS> like line of i_OWNERS.
      loop at i_OWNERS assigning <l_OWNERS>.
*        ls_form_part-cdata = <l_OWNERS>.
*        append ls_form_part to lt_form_part.
        if ls_form_part-cdata is initial.
        ls_form_part-cdata = <l_OWNERS>.
        else.
          ls_form_part-cdata = ls_form_part-cdata && `,` && <l_OWNERS>.
        endif.
      endloop.
      append ls_form_part to lt_form_part.
    endif.

    if not i_CLASSIFIER_IDS is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="classifier_ids"'  ##NO_TEXT.
      field-symbols:
        <l_CLASSIFIER_IDS> like line of i_CLASSIFIER_IDS.
      loop at i_CLASSIFIER_IDS assigning <l_CLASSIFIER_IDS>.
*        ls_form_part-cdata = <l_CLASSIFIER_IDS>.
*        append ls_form_part to lt_form_part.
        if ls_form_part-cdata is initial.
        ls_form_part-cdata = <l_CLASSIFIER_IDS>.
        else.
          ls_form_part-cdata = ls_form_part-cdata && `,` && <l_CLASSIFIER_IDS>.
        endif.

      endloop.
            append ls_form_part to lt_form_part.

    endif.



    if not i_IMAGES_FILE is initial.
      if not I_images_filename is initial.
        lv_value = `form-data; name="images_file"; filename="` && I_images_filename && `"`  ##NO_TEXT.
      else.
      lv_extension = get_file_extension( I_images_file_content_type ).
      lv_value = `form-data; name="images_file"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      endif.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_images_file_content_type.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_IMAGES_FILE.
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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V3->CREATE_CLASSIFIER
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_NAME        TYPE STRING
* | [--->] I_POSITIVE_EXAMPLES        TYPE TT_MAP_FILE
* | [--->] I_NEGATIVE_EXAMPLES        TYPE FILE(optional)
* | [--->] I_NEGATIVE_EXAMPLES_FILENAME        TYPE STRING(optional)
* | [--->] I_POSITIVE_EXAMPLES_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_NEGATIVE_EXAMPLES_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CLASSIFIER
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_CLASSIFIER.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/classifiers'.

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


    if not i_NAME is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="name"'  ##NO_TEXT.
      lv_formdata = i_NAME.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_POSITIVE_EXAMPLES is initial.
      lv_extension = get_file_extension( I_POSITIVE_EXAMPLES_CT ).
      field-symbols:
        <lv_map_POSITIVE_EXAMPLES> type line of TT_MAP_FILE.
      find regex '(\{.*\})' in '{{classname}}_positive_examples' submatches lv_keypattern.
      loop at i_POSITIVE_EXAMPLES assigning <lv_map_POSITIVE_EXAMPLES>.
        lv_base_name = '{{classname}}_positive_examples'.
        replace lv_keypattern in lv_base_name with <lv_map_POSITIVE_EXAMPLES>-key.
        lv_value = `form-data; name="` && lv_base_name && `"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
        lv_index = lv_index + 1.
        clear ls_form_part.
        ls_form_part-content_type = I_POSITIVE_EXAMPLES_CT.
        ls_form_part-content_disposition = lv_value.
        ls_form_part-xdata = <lv_map_POSITIVE_EXAMPLES>-data.
        append ls_form_part to lt_form_part.
      endloop.
    endif.

    if not i_NEGATIVE_EXAMPLES is initial.
      if not I_negative_examples_filename is initial.
        lv_value = `form-data; name="negative_examples"; filename="` && I_negative_examples_filename && `"`  ##NO_TEXT.
      else.
      lv_extension = get_file_extension( I_NEGATIVE_EXAMPLES_CT ).
      lv_value = `form-data; name="negative_examples"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      endif.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_NEGATIVE_EXAMPLES_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_NEGATIVE_EXAMPLES.
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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V3->LIST_CLASSIFIERS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_VERBOSE        TYPE BOOLEAN(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CLASSIFIERS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_CLASSIFIERS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/classifiers'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_VERBOSE is supplied.
    lv_queryparam = i_VERBOSE.
    add_query_parameter(
      exporting
        i_parameter  = `verbose`
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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V3->GET_CLASSIFIER
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CLASSIFIER_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CLASSIFIER
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_CLASSIFIER.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/classifiers/{classifier_id}'.
    replace all occurrences of `{classifier_id}` in ls_request_prop-url-path with i_CLASSIFIER_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V3->UPDATE_CLASSIFIER
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CLASSIFIER_ID        TYPE STRING
* | [--->] I_POSITIVE_EXAMPLES        TYPE TT_MAP_FILE(optional)
* | [--->] I_NEGATIVE_EXAMPLES        TYPE FILE(optional)
* | [--->] I_NEGATIVE_EXAMPLES_FILENAME        TYPE STRING(optional)
* | [--->] I_POSITIVE_EXAMPLES_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_NEGATIVE_EXAMPLES_CT     TYPE STRING (default = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-all)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_CLASSIFIER
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_CLASSIFIER.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/classifiers/{classifier_id}'.
    replace all occurrences of `{classifier_id}` in ls_request_prop-url-path with i_CLASSIFIER_ID ignoring case.

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




    if not i_POSITIVE_EXAMPLES is initial.
      lv_extension = get_file_extension( I_POSITIVE_EXAMPLES_CT ).
      field-symbols:
        <lv_map_POSITIVE_EXAMPLES> type line of TT_MAP_FILE.
      find regex '(\{.*\})' in '{{classname}}_positive_examples' submatches lv_keypattern.
      loop at i_POSITIVE_EXAMPLES assigning <lv_map_POSITIVE_EXAMPLES>.
        lv_base_name = '{{classname}}_positive_examples'.
        replace lv_keypattern in lv_base_name with <lv_map_POSITIVE_EXAMPLES>-key.
        lv_value = `form-data; name="` && lv_base_name && `"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
        lv_index = lv_index + 1.
        clear ls_form_part.
        ls_form_part-content_type = I_POSITIVE_EXAMPLES_CT.
        ls_form_part-content_disposition = lv_value.
        ls_form_part-xdata = <lv_map_POSITIVE_EXAMPLES>-data.
        append ls_form_part to lt_form_part.
      endloop.
    endif.

    if not i_NEGATIVE_EXAMPLES is initial.
      if not I_negative_examples_filename is initial.
        lv_value = `form-data; name="negative_examples"; filename="` && I_negative_examples_filename && `"`  ##NO_TEXT.
      else.
      lv_extension = get_file_extension( I_NEGATIVE_EXAMPLES_CT ).
      lv_value = `form-data; name="negative_examples"; filename="file` && lv_index && `.` && lv_extension && `"`  ##NO_TEXT.
      endif.
      lv_index = lv_index + 1.
      clear ls_form_part.
      ls_form_part-content_type = I_NEGATIVE_EXAMPLES_CT.
      ls_form_part-content_disposition = lv_value.
      ls_form_part-xdata = i_NEGATIVE_EXAMPLES.
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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V3->DELETE_CLASSIFIER
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CLASSIFIER_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_CLASSIFIER.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/classifiers/{classifier_id}'.
    replace all occurrences of `{classifier_id}` in ls_request_prop-url-path with i_CLASSIFIER_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V3->GET_CORE_ML_MODEL
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_CLASSIFIER_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/octet-stream')
* | [<---] E_RESPONSE                    TYPE        FILE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_CORE_ML_MODEL.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v3/classifiers/{classifier_id}/core_ml_model'.
    replace all occurrences of `{classifier_id}` in ls_request_prop-url-path with i_CLASSIFIER_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve file data
    e_response = get_response_binary( lo_response ).

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V3->DELETE_USER_DATA
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

    ls_request_prop-url-path = '/v3/user_data'.

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
* | Instance Private Method ZCL_IBMC_VISUAL_RECOGNITION_V3->SET_DEFAULT_QUERY_PARAMETERS
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
