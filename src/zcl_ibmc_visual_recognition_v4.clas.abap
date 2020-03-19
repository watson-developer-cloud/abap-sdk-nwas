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
"! <p class="shorttext synchronized" lang="en">Visual Recognition v4</p>
"! Provide images to the IBM Watson&trade; Visual Recognition service for analysis.
"!  The service detects objects based on a set of images with training data. <br/>
class ZCL_IBMC_VISUAL_RECOGNITION_V4 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Defines the location of the bounding box around the object.</p>
    begin of T_LOCATION,
      "!   Y-position of top-left pixel of the bounding box.
      TOP type INTEGER,
      "!   X-position of top-left pixel of the bounding box.
      LEFT type INTEGER,
      "!   Width in pixels of of the bounding box.
      WIDTH type INTEGER,
      "!   Height in pixels of the bounding box.
      HEIGHT type INTEGER,
    end of T_LOCATION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Training status for the objects in the collection.</p>
    begin of T_OBJECT_TRAINING_STATUS,
      "!   Whether you can analyze images in the collection with the **objects** feature.
      READY type BOOLEAN,
      "!   Whether training is in progress.
      IN_PROGRESS type BOOLEAN,
      "!   Whether there are changes to the training data since the most recent training.
      DATA_CHANGED type BOOLEAN,
      "!   Whether the most recent training failed.
      LATEST_FAILED type BOOLEAN,
      "!   Details about the training. If training is in progress, includes information
      "!    about the status. If training is not in progress, includes a success message or
      "!    information about why training failed.
      DESCRIPTION type STRING,
    end of T_OBJECT_TRAINING_STATUS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Training status information for the collection.</p>
    begin of T_TRAINING_STATUS,
      "!   Training status for the objects in the collection.
      OBJECTS type T_OBJECT_TRAINING_STATUS,
    end of T_TRAINING_STATUS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Basic information about an object.</p>
    begin of T_OBJECT_METADATA,
      "!   The name of the object.
      OBJECT type STRING,
      "!   Number of bounding boxes with this object name in the collection.
      COUNT type INTEGER,
    end of T_OBJECT_METADATA.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The source type of the image.</p>
    begin of T_IMAGE_SOURCE,
      "!   The source type of the image.
      TYPE type STRING,
      "!   Name of the image file if uploaded. Not returned when the image is passed by
      "!    URL.
      FILENAME type STRING,
      "!   Name of the .zip file of images if uploaded. Not returned when the image is
      "!    passed directly or by URL.
      ARCHIVE_FILENAME type STRING,
      "!   Source of the image before any redirects. Not returned when the image is
      "!    uploaded.
      SOURCE_URL type STRING,
      "!   Fully resolved URL of the image after redirects are followed. Not returned when
      "!    the image is uploaded.
      RESOLVED_URL type STRING,
    end of T_IMAGE_SOURCE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Details about the training data.</p>
    begin of T_TRAINING_DATA_OBJECT,
      "!   The name of the object.
      OBJECT type STRING,
      "!   Defines the location of the bounding box around the object.
      LOCATION type T_LOCATION,
    end of T_TRAINING_DATA_OBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Training data for all objects.</p>
    begin of T_TRAINING_DATA_OBJECTS,
      "!   Training data for specific objects.
      OBJECTS type STANDARD TABLE OF T_TRAINING_DATA_OBJECT WITH NON-UNIQUE DEFAULT KEY,
    end of T_TRAINING_DATA_OBJECTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Details about a collection.</p>
    begin of T_COLLECTION,
      "!   The identifier of the collection.
      COLLECTION_ID type STRING,
      "!   The name of the collection.
      NAME type STRING,
      "!   The description of the collection.
      DESCRIPTION type STRING,
      "!   Date and time in Coordinated Universal Time (UTC) that the collection was
      "!    created.
      CREATED type DATETIME,
      "!   Date and time in Coordinated Universal Time (UTC) that the collection was most
      "!    recently updated.
      UPDATED type DATETIME,
      "!   Number of images in the collection.
      IMAGE_COUNT type INTEGER,
      "!   Training status information for the collection.
      TRAINING_STATUS type T_TRAINING_STATUS,
    end of T_COLLECTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Height and width of an image.</p>
    begin of T_IMAGE_DIMENSIONS,
      "!   Height in pixels of the image.
      HEIGHT type INTEGER,
      "!   Width in pixels of the image.
      WIDTH type INTEGER,
    end of T_IMAGE_DIMENSIONS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Details about the specific area of the problem.</p>
    begin of T_ERROR_TARGET,
      "!   The parameter or property that is the focus of the problem.
      TYPE type STRING,
      "!   The property that is identified with the problem.
      NAME type STRING,
    end of T_ERROR_TARGET.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Details about an error.</p>
    begin of T_ERROR,
      "!   Identifier of the problem.
      CODE type STRING,
      "!   An explanation of the problem with possible solutions.
      MESSAGE type STRING,
      "!   A URL for more information about the solution.
      MORE_INFO type STRING,
      "!   Details about the specific area of the problem.
      TARGET type T_ERROR_TARGET,
    end of T_ERROR.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A container for the list of request-level problems.</p>
    begin of T_ERROR_RESPONSE,
      "!   A container for the problems in the request.
      ERRORS type STANDARD TABLE OF T_ERROR WITH NON-UNIQUE DEFAULT KEY,
      "!   A unique identifier of the request.
      TRACE type STRING,
    end of T_ERROR_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Details about an object and its location.</p>
    begin of T_BASE_OBJECT,
      "!   The name of the object. The name can contain alphanumeric, underscore, hyphen,
      "!    space, and dot characters. It cannot begin with the reserved prefix `sys-`.
      OBJECT type STRING,
      "!   Defines the location of the bounding box around the object.
      LOCATION type T_LOCATION,
    end of T_BASE_OBJECT.
  types:
    "! No documentation available.
    begin of T_INLINE_OBJECT,
      "!   The IDs of the collections to analyze.
      COLLECTION_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The features to analyze.
      FEATURES type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of image files (.jpg or .png) or .zip files with images.<br/>
      "!   - Include a maximum of 20 images in a request.<br/>
      "!   - Limit the .zip file to 100 MB.<br/>
      "!   - Limit each image file to 10 MB.<br/>
      "!   <br/>
      "!   You can also include an image with the **image_url** parameter.
      IMAGES_FILE type STANDARD TABLE OF FILE WITH NON-UNIQUE DEFAULT KEY,
      "!   An array of URLs of image files (.jpg or .png).<br/>
      "!   - Include a maximum of 20 images in a request.<br/>
      "!   - Limit each image file to 10 MB.<br/>
      "!   - Minimum width and height is 30 pixels, but the service tends to perform better
      "!    with images that are at least 300 x 300 pixels. Maximum is 5400 pixels for
      "!    either height or width.<br/>
      "!   <br/>
      "!   You can also include images with the **images_file** parameter.
      IMAGE_URL type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   The minimum score a feature must have to be returned.
      THRESHOLD type FLOAT,
    end of T_INLINE_OBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Details about an object in the collection.</p>
    begin of T_OBJECT_DETAIL,
      "!   The label for the object.
      OBJECT type STRING,
      "!   Defines the location of the bounding box around the object.
      LOCATION type T_LOCATION,
      "!   Confidence score for the object in the range of 0 to 1. A higher score indicates
      "!    greater likelihood that the object is depicted at this location in the image.
      SCORE type FLOAT,
    end of T_OBJECT_DETAIL.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    The objects in a collection that are detected in an image.</p>
    begin of T_COLLECTION_OBJECTS,
      "!   The identifier of the collection.
      COLLECTION_ID type STRING,
      "!   The identified objects in a collection.
      OBJECTS type STANDARD TABLE OF T_OBJECT_DETAIL WITH NON-UNIQUE DEFAULT KEY,
    end of T_COLLECTION_OBJECTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Container for the list of collections that have objects</p>
    "!     detected in an image.
    begin of T_DETECTED_OBJECTS,
      "!   The collections with identified objects.
      COLLECTIONS type STANDARD TABLE OF T_COLLECTION_OBJECTS WITH NON-UNIQUE DEFAULT KEY,
    end of T_DETECTED_OBJECTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A file returned in the response.</p>
      T_JPEG_IMAGE type FILE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    A container for the list of collections.</p>
    begin of T_COLLECTIONS_LIST,
      "!   The collections in this service instance.
      COLLECTIONS type STANDARD TABLE OF T_COLLECTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_COLLECTIONS_LIST.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Details about the training event.</p>
    begin of T_TRAINING_EVENT,
      "!   Trained object type. Only `objects` is currently supported.
      TYPE type STRING,
      "!   Identifier of the trained collection.
      COLLECTION_ID type STRING,
      "!   Date and time in Coordinated Universal Time (UTC) that training on the
      "!    collection finished.
      COMPLETION_TIME type DATETIME,
      "!   Training status of the training event.
      STATUS type STRING,
      "!   The total number of images that were used in training for this training event.
      IMAGE_COUNT type INTEGER,
    end of T_TRAINING_EVENT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Details about the training events.</p>
    begin of T_TRAINING_EVENTS,
      "!   The starting day for the returned training events in Coordinated Universal Time
      "!    (UTC). If not specified in the request, it identifies the earliest training
      "!    event.
      START_TIME type DATETIME,
      "!   The ending day for the returned training events in Coordinated Universal Time
      "!    (UTC). If not specified in the request, it lists the current time.
      END_TIME type DATETIME,
      "!   The total number of training events in the response for the start and end times.
      "!
      COMPLETED_EVENTS type INTEGER,
      "!   The total number of images that were used in training for the start and end
      "!    times.
      TRAINED_IMAGES type INTEGER,
      "!   The completed training events for the start and end time.
      EVENTS type STANDARD TABLE OF T_TRAINING_EVENT WITH NON-UNIQUE DEFAULT KEY,
    end of T_TRAINING_EVENTS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Details about an image.</p>
    begin of T_IMAGE_DETAILS,
      "!   The identifier of the image.
      IMAGE_ID type STRING,
      "!   Date and time in Coordinated Universal Time (UTC) that the image was most
      "!    recently updated.
      UPDATED type DATETIME,
      "!   Date and time in Coordinated Universal Time (UTC) that the image was created.
      CREATED type DATETIME,
      "!   The source type of the image.
      SOURCE type T_IMAGE_SOURCE,
      "!   Height and width of an image.
      DIMENSIONS type T_IMAGE_DIMENSIONS,
      "!   No documentation available.
      ERRORS type STANDARD TABLE OF T_ERROR WITH NON-UNIQUE DEFAULT KEY,
      "!   Training data for all objects.
      TRAINING_DATA type T_TRAINING_DATA_OBJECTS,
    end of T_IMAGE_DETAILS.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Details about a problem.</p>
    begin of T_WARNING,
      "!   Identifier of the problem.
      CODE type STRING,
      "!   An explanation of the problem with possible solutions.
      MESSAGE type STRING,
      "!   A URL for more information about the solution.
      MORE_INFO type STRING,
    end of T_WARNING.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    List of information about the images.</p>
    begin of T_IMAGE_DETAILS_LIST,
      "!   The images in the collection.
      IMAGES type STANDARD TABLE OF T_IMAGE_DETAILS WITH NON-UNIQUE DEFAULT KEY,
      "!   Information about what might cause less than optimal output.
      WARNINGS type STANDARD TABLE OF T_WARNING WITH NON-UNIQUE DEFAULT KEY,
      "!   A unique identifier of the request. Included only when an error or warning is
      "!    returned.
      TRACE type STRING,
    end of T_IMAGE_DETAILS_LIST.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Empty response.</p>
      T_EMPTY type JSONOBJECT.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Basic information about an image.</p>
    begin of T_IMAGE_SUMMARY,
      "!   The identifier of the image.
      IMAGE_ID type STRING,
      "!   Date and time in Coordinated Universal Time (UTC) that the image was most
      "!    recently updated.
      UPDATED type DATETIME,
    end of T_IMAGE_SUMMARY.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Container for the training data.</p>
    begin of T_BASE_TRAINING_DATA_OBJECTS,
      "!   Training data for specific objects.
      OBJECTS type STANDARD TABLE OF T_TRAINING_DATA_OBJECT WITH NON-UNIQUE DEFAULT KEY,
    end of T_BASE_TRAINING_DATA_OBJECTS.
  types:
    "! No documentation available.
    begin of T_INLINE_OBJECT1,
      "!   An array of image files (.jpg or .png) or .zip files with images.<br/>
      "!   - Include a maximum of 20 images in a request.<br/>
      "!   - Limit the .zip file to 100 MB.<br/>
      "!   - Limit each image file to 10 MB.<br/>
      "!   <br/>
      "!   You can also include an image with the **image_url** parameter.
      IMAGES_FILE type STANDARD TABLE OF FILE WITH NON-UNIQUE DEFAULT KEY,
      "!   The array of URLs of image files (.jpg or .png).<br/>
      "!   - Include a maximum of 20 images in a request.<br/>
      "!   - Limit each image file to 10 MB.<br/>
      "!   - Minimum width and height is 30 pixels, but the service tends to perform better
      "!    with images that are at least 300 x 300 pixels. Maximum is 5400 pixels for
      "!    either height or width.<br/>
      "!   <br/>
      "!   You can also include images with the **images_file** parameter.
      IMAGE_URL type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      "!   Training data for a single image. Include training data only if you add one
      "!    image with the request.<br/>
      "!   <br/>
      "!   The `object` property can contain alphanumeric, underscore, hyphen, space, and
      "!    dot characters. It cannot begin with the reserved prefix `sys-` and must be no
      "!    longer than 32 characters.
      TRAINING_DATA type STRING,
    end of T_INLINE_OBJECT1.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    List of images.</p>
    begin of T_IMAGE_SUMMARY_LIST,
      "!   The images in the collection.
      IMAGES type STANDARD TABLE OF T_IMAGE_SUMMARY WITH NON-UNIQUE DEFAULT KEY,
    end of T_IMAGE_SUMMARY_LIST.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Details about an image.</p>
    begin of T_IMAGE,
      "!   The source type of the image.
      SOURCE type T_IMAGE_SOURCE,
      "!   Height and width of an image.
      DIMENSIONS type T_IMAGE_DIMENSIONS,
      "!   Container for the list of collections that have objects detected in an image.
      OBJECTS type T_DETECTED_OBJECTS,
      "!   A container for the problems in the request.
      ERRORS type STANDARD TABLE OF T_ERROR WITH NON-UNIQUE DEFAULT KEY,
    end of T_IMAGE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Results for all images.</p>
    begin of T_ANALYZE_RESPONSE,
      "!   Analyzed images.
      IMAGES type STANDARD TABLE OF T_IMAGE WITH NON-UNIQUE DEFAULT KEY,
      "!   Information about what might cause less than optimal output.
      WARNINGS type STANDARD TABLE OF T_WARNING WITH NON-UNIQUE DEFAULT KEY,
      "!   A unique identifier of the request. Included only when an error or warning is
      "!    returned.
      TRACE type STRING,
    end of T_ANALYZE_RESPONSE.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Base details about a collection.</p>
    begin of T_BASE_COLLECTION,
      "!   The identifier of the collection.
      COLLECTION_ID type STRING,
      "!   The name of the collection. The name can contain alphanumeric, underscore,
      "!    hyphen, and dot characters. It cannot begin with the reserved prefix `sys-`.
      NAME type STRING,
      "!   The description of the collection.
      DESCRIPTION type STRING,
      "!   Date and time in Coordinated Universal Time (UTC) that the collection was
      "!    created.
      CREATED type DATETIME,
      "!   Date and time in Coordinated Universal Time (UTC) that the collection was most
      "!    recently updated.
      UPDATED type DATETIME,
      "!   Number of images in the collection.
      IMAGE_COUNT type INTEGER,
      "!   Training status information for the collection.
      TRAINING_STATUS type T_TRAINING_STATUS,
    end of T_BASE_COLLECTION.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    Basic information about an updated object.</p>
    begin of T_UPDATE_OBJECT_METADATA,
      "!   The updated name of the object. The name can contain alphanumeric, underscore,
      "!    hyphen, space, and dot characters. It cannot begin with the reserved prefix
      "!    `sys-`.
      OBJECT type STRING,
      "!   Number of bounding boxes in the collection with the updated object name.
      COUNT type INTEGER,
    end of T_UPDATE_OBJECT_METADATA.
  types:
    "! <p class="shorttext synchronized" lang="en">
    "!    List of objects.</p>
    begin of T_OBJECT_METADATA_LIST,
      "!   Number of unique named objects in the collection.
      OBJECT_COUNT type INTEGER,
      "!   The objects in the collection.
      OBJECTS type STANDARD TABLE OF T_OBJECT_METADATA WITH NON-UNIQUE DEFAULT KEY,
    end of T_OBJECT_METADATA_LIST.

constants:
  "! <p class="shorttext synchronized" lang="en">List of required fields per type.</p>
  begin of C_REQUIRED_FIELDS,
    T_LOCATION type string value '|TOP|LEFT|WIDTH|HEIGHT|',
    T_OBJECT_TRAINING_STATUS type string value '|READY|IN_PROGRESS|DATA_CHANGED|LATEST_FAILED|DESCRIPTION|',
    T_TRAINING_STATUS type string value '|OBJECTS|',
    T_OBJECT_METADATA type string value '|',
    T_IMAGE_SOURCE type string value '|TYPE|',
    T_TRAINING_DATA_OBJECT type string value '|',
    T_TRAINING_DATA_OBJECTS type string value '|',
    T_COLLECTION type string value '|COLLECTION_ID|NAME|DESCRIPTION|CREATED|UPDATED|IMAGE_COUNT|TRAINING_STATUS|',
    T_IMAGE_DIMENSIONS type string value '|',
    T_ERROR_TARGET type string value '|TYPE|NAME|',
    T_ERROR type string value '|CODE|MESSAGE|',
    T_ERROR_RESPONSE type string value '|ERRORS|TRACE|',
    T_BASE_OBJECT type string value '|',
    T_INLINE_OBJECT type string value '|COLLECTION_IDS|FEATURES|',
    T_OBJECT_DETAIL type string value '|OBJECT|LOCATION|SCORE|',
    T_COLLECTION_OBJECTS type string value '|COLLECTION_ID|OBJECTS|',
    T_DETECTED_OBJECTS type string value '|',
    T_COLLECTIONS_LIST type string value '|COLLECTIONS|',
    T_TRAINING_EVENT type string value '|',
    T_TRAINING_EVENTS type string value '|',
    T_IMAGE_DETAILS type string value '|SOURCE|',
    T_WARNING type string value '|CODE|MESSAGE|',
    T_IMAGE_DETAILS_LIST type string value '|',
    T_IMAGE_SUMMARY type string value '|',
    T_BASE_TRAINING_DATA_OBJECTS type string value '|',
    T_INLINE_OBJECT1 type string value '|',
    T_IMAGE_SUMMARY_LIST type string value '|IMAGES|',
    T_IMAGE type string value '|SOURCE|DIMENSIONS|OBJECTS|',
    T_ANALYZE_RESPONSE type string value '|IMAGES|',
    T_BASE_COLLECTION type string value '|',
    T_UPDATE_OBJECT_METADATA type string value '|OBJECT|COUNT|',
    T_OBJECT_METADATA_LIST type string value '|OBJECT_COUNT|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
  "! <p class="shorttext synchronized" lang="en">Map ABAP identifiers to service identifiers.</p>
  begin of C_ABAPNAME_DICTIONARY,
     CODE type string value 'code',
     MESSAGE type string value 'message',
     MORE_INFO type string value 'more_info',
     TARGET type string value 'target',
     TYPE type string value 'type',
     NAME type string value 'name',
     ERRORS type string value 'errors',
     TRACE type string value 'trace',
     IMAGES type string value 'images',
     WARNINGS type string value 'warnings',
     COLLECTION_ID type string value 'collection_id',
     DESCRIPTION type string value 'description',
     CREATED type string value 'created',
     UPDATED type string value 'updated',
     IMAGE_COUNT type string value 'image_count',
     TRAINING_STATUS type string value 'training_status',
     COLLECTIONS type string value 'collections',
     START_TIME type string value 'start_time',
     END_TIME type string value 'end_time',
     COMPLETED_EVENTS type string value 'completed_events',
     TRAINED_IMAGES type string value 'trained_images',
     EVENTS type string value 'events',
     COMPLETION_TIME type string value 'completion_time',
     STATUS type string value 'status',
     OBJECTS type string value 'objects',
     OBJECT_COUNT type string value 'object_count',
     OBJECT type string value 'object',
     COUNT type string value 'count',
     READY type string value 'ready',
     IN_PROGRESS type string value 'in_progress',
     DATA_CHANGED type string value 'data_changed',
     LATEST_FAILED type string value 'latest_failed',
     IMAGE_ID type string value 'image_id',
     SOURCE type string value 'source',
     DIMENSIONS type string value 'dimensions',
     TRAINING_DATA type string value 'training_data',
     HEIGHT type string value 'height',
     WIDTH type string value 'width',
     LOCATION type string value 'location',
     FILENAME type string value 'filename',
     ARCHIVE_FILENAME type string value 'archive_filename',
     SOURCE_URL type string value 'source_url',
     RESOLVED_URL type string value 'resolved_url',
     SCORE type string value 'score',
     TOP type string value 'top',
     LEFT type string value 'left',
     COLLECTION_IDS type string value 'collection_ids',
     COLLECTIONIDS type string value 'collectionIds',
     FEATURES type string value 'features',
     IMAGES_FILE type string value 'images_file',
     IMAGESFILE type string value 'imagesFile',
     IMAGE_URL type string value 'image_url',
     IMAGEURL type string value 'imageUrl',
     THRESHOLD type string value 'threshold',
  end of C_ABAPNAME_DICTIONARY .


  methods GET_APPNAME
    redefinition .
  methods GET_REQUEST_PROP
    redefinition .
  methods GET_SDK_VERSION_DATE
    redefinition .


    "! <p class="shorttext synchronized" lang="en">Analyze images</p>
    "!   Analyze images by URL, by file, or both against your own collection. Make sure
    "!    that **training_status.objects.ready** is `true` for the feature before you use
    "!    a collection to analyze images.<br/>
    "!   <br/>
    "!   Encode the image and .zip file names in UTF-8 if they contain non-ASCII
    "!    characters. The service assumes UTF-8 encoding if it encounters non-ASCII
    "!    characters.
    "!
    "! @parameter I_COLLECTION_IDS |
    "!   The IDs of the collections to analyze.
    "! @parameter I_FEATURES |
    "!   The features to analyze.
    "! @parameter I_IMAGES_FILE |
    "!   An array of image files (.jpg or .png) or .zip files with images.<br/>
    "!   - Include a maximum of 20 images in a request.<br/>
    "!   - Limit the .zip file to 100 MB.<br/>
    "!   - Limit each image file to 10 MB.<br/>
    "!   <br/>
    "!   You can also include an image with the **image_url** parameter.
    "! @parameter I_IMAGE_URL |
    "!   An array of URLs of image files (.jpg or .png).<br/>
    "!   - Include a maximum of 20 images in a request.<br/>
    "!   - Limit each image file to 10 MB.<br/>
    "!   - Minimum width and height is 30 pixels, but the service tends to perform better
    "!    with images that are at least 300 x 300 pixels. Maximum is 5400 pixels for
    "!    either height or width.<br/>
    "!   <br/>
    "!   You can also include images with the **images_file** parameter.
    "! @parameter I_THRESHOLD |
    "!   The minimum score a feature must have to be returned.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ANALYZE_RESPONSE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods ANALYZE
    importing
      !I_COLLECTION_IDS type TT_STRING
      !I_FEATURES type TT_STRING
      !I_IMAGES_FILE type TT_FILE_WITH_METADATA optional
      !I_IMAGE_URL type TT_STRING optional
      !I_THRESHOLD type FLOAT optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ANALYZE_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Create a collection</p>
    "!   Create a collection that can be used to store images.<br/>
    "!   <br/>
    "!   To create a collection without specifying a name and description, include an
    "!    empty JSON object in the request body.<br/>
    "!   <br/>
    "!   Encode the name and description in UTF-8 if they contain non-ASCII characters.
    "!    The service assumes UTF-8 encoding if it encounters non-ASCII characters.
    "!
    "! @parameter I_COLLECTION_INFO |
    "!   The new collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods CREATE_COLLECTION
    importing
      !I_COLLECTION_INFO type T_BASE_COLLECTION
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List collections</p>
    "!   Retrieves a list of collections for the service instance.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTIONS_LIST
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_COLLECTIONS
    importing
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTIONS_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get collection details</p>
    "!   Get details of one collection.
    "!
    "! @parameter I_COLLECTION_ID |
    "!   The identifier of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_COLLECTION
    importing
      !I_COLLECTION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update a collection</p>
    "!   Update the name or description of a collection.<br/>
    "!   <br/>
    "!   Encode the name and description in UTF-8 if they contain non-ASCII characters.
    "!    The service assumes UTF-8 encoding if it encounters non-ASCII characters.
    "!
    "! @parameter I_COLLECTION_ID |
    "!   The identifier of the collection.
    "! @parameter I_COLLECTION_INFO |
    "!   The updated collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_COLLECTION
    importing
      !I_COLLECTION_ID type STRING
      !I_COLLECTION_INFO type T_BASE_COLLECTION optional
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete a collection</p>
    "!   Delete a collection from the service instance.
    "!
    "! @parameter I_COLLECTION_ID |
    "!   The identifier of the collection.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_COLLECTION
    importing
      !I_COLLECTION_ID type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Add images</p>
    "!   Add images to a collection by URL, by file, or both.<br/>
    "!   <br/>
    "!   Encode the image and .zip file names in UTF-8 if they contain non-ASCII
    "!    characters. The service assumes UTF-8 encoding if it encounters non-ASCII
    "!    characters.
    "!
    "! @parameter I_COLLECTION_ID |
    "!   The identifier of the collection.
    "! @parameter I_IMAGES_FILE |
    "!   An array of image files (.jpg or .png) or .zip files with images.<br/>
    "!   - Include a maximum of 20 images in a request.<br/>
    "!   - Limit the .zip file to 100 MB.<br/>
    "!   - Limit each image file to 10 MB.<br/>
    "!   <br/>
    "!   You can also include an image with the **image_url** parameter.
    "! @parameter I_IMAGE_URL |
    "!   The array of URLs of image files (.jpg or .png).<br/>
    "!   - Include a maximum of 20 images in a request.<br/>
    "!   - Limit each image file to 10 MB.<br/>
    "!   - Minimum width and height is 30 pixels, but the service tends to perform better
    "!    with images that are at least 300 x 300 pixels. Maximum is 5400 pixels for
    "!    either height or width.<br/>
    "!   <br/>
    "!   You can also include images with the **images_file** parameter.
    "! @parameter I_TRAINING_DATA |
    "!   Training data for a single image. Include training data only if you add one
    "!    image with the request.<br/>
    "!   <br/>
    "!   The `object` property can contain alphanumeric, underscore, hyphen, space, and
    "!    dot characters. It cannot begin with the reserved prefix `sys-` and must be no
    "!    longer than 32 characters.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_IMAGE_DETAILS_LIST
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods ADD_IMAGES
    importing
      !I_COLLECTION_ID type STRING
      !I_IMAGES_FILE type TT_FILE_WITH_METADATA optional
      !I_IMAGE_URL type TT_STRING optional
      !I_TRAINING_DATA type STRING optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_IMAGE_DETAILS_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">List images</p>
    "!   Retrieves a list of images in a collection.
    "!
    "! @parameter I_COLLECTION_ID |
    "!   The identifier of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_IMAGE_SUMMARY_LIST
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_IMAGES
    importing
      !I_COLLECTION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_IMAGE_SUMMARY_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get image details</p>
    "!   Get the details of an image in a collection.
    "!
    "! @parameter I_COLLECTION_ID |
    "!   The identifier of the collection.
    "! @parameter I_IMAGE_ID |
    "!   The identifier of the image.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_IMAGE_DETAILS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_IMAGE_DETAILS
    importing
      !I_COLLECTION_ID type STRING
      !I_IMAGE_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_IMAGE_DETAILS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete an image</p>
    "!   Delete one image from a collection.
    "!
    "! @parameter I_COLLECTION_ID |
    "!   The identifier of the collection.
    "! @parameter I_IMAGE_ID |
    "!   The identifier of the image.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_IMAGE
    importing
      !I_COLLECTION_ID type STRING
      !I_IMAGE_ID type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get a JPEG file of an image</p>
    "!   Download a JPEG representation of an image.
    "!
    "! @parameter I_COLLECTION_ID |
    "!   The identifier of the collection.
    "! @parameter I_IMAGE_ID |
    "!   The identifier of the image.
    "! @parameter I_SIZE |
    "!   The image size. Specify `thumbnail` to return a version that maintains the
    "!    original aspect ratio but is no larger than 200 pixels in the larger dimension.
    "!    For example, an original 800 x 1000 image is resized to 160 x 200 pixels.
    "! @parameter E_RESPONSE |
    "!   Service return value of type FILE
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_JPEG_IMAGE
    importing
      !I_COLLECTION_ID type STRING
      !I_IMAGE_ID type STRING
      !I_SIZE type STRING default 'full'
      !I_accept      type string default 'image/jpeg'
    exporting
      !E_RESPONSE type FILE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">List object metadata</p>
    "!   Retrieves a list of object names in a collection.
    "!
    "! @parameter I_COLLECTION_ID |
    "!   The identifier of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_OBJECT_METADATA_LIST
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods LIST_OBJECT_METADATA
    importing
      !I_COLLECTION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_OBJECT_METADATA_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Update an object name</p>
    "!   Update the name of an object. A successful request updates the training data for
    "!    all images that use the object.
    "!
    "! @parameter I_COLLECTION_ID |
    "!   The identifier of the collection.
    "! @parameter I_OBJECT |
    "!   The name of the object.
    "! @parameter I_UPDATEOBJECTMETADATA |
    "!   No documentation available.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_UPDATE_OBJECT_METADATA
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods UPDATE_OBJECT_METADATA
    importing
      !I_COLLECTION_ID type STRING
      !I_OBJECT type STRING
      !I_UPDATEOBJECTMETADATA type T_UPDATE_OBJECT_METADATA
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_UPDATE_OBJECT_METADATA
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get object metadata</p>
    "!   Get the number of bounding boxes for a single object in a collection.
    "!
    "! @parameter I_COLLECTION_ID |
    "!   The identifier of the collection.
    "! @parameter I_OBJECT |
    "!   The name of the object.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_OBJECT_METADATA
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_OBJECT_METADATA
    importing
      !I_COLLECTION_ID type STRING
      !I_OBJECT type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_OBJECT_METADATA
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Delete an object</p>
    "!   Delete one object from a collection. A successful request deletes the training
    "!    data from all images that use the object.
    "!
    "! @parameter I_COLLECTION_ID |
    "!   The identifier of the collection.
    "! @parameter I_OBJECT |
    "!   The name of the object.
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods DELETE_OBJECT
    importing
      !I_COLLECTION_ID type STRING
      !I_OBJECT type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! <p class="shorttext synchronized" lang="en">Train a collection</p>
    "!   Start training on images in a collection. The collection must have enough
    "!    training data and untrained data (the **training_status.objects.data_changed**
    "!    is `true`). If training is in progress, the request queues the next training
    "!    job.
    "!
    "! @parameter I_COLLECTION_ID |
    "!   The identifier of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTION
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods TRAIN
    importing
      !I_COLLECTION_ID type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Add training data to an image</p>
    "!   Add, update, or delete training data for an image. Encode the object name in
    "!    UTF-8 if it contains non-ASCII characters. The service assumes UTF-8 encoding
    "!    if it encounters non-ASCII characters.<br/>
    "!   <br/>
    "!   Elements in the request replace the existing elements.<br/>
    "!   <br/>
    "!   - To update the training data, provide both the unchanged and the new or changed
    "!    values.<br/>
    "!   <br/>
    "!   - To delete the training data, provide an empty value for the training data.
    "!
    "! @parameter I_COLLECTION_ID |
    "!   The identifier of the collection.
    "! @parameter I_IMAGE_ID |
    "!   The identifier of the image.
    "! @parameter I_TRAINING_DATA |
    "!   Training data. Elements in the request replace the existing elements.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_DATA_OBJECTS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods ADD_IMAGE_TRAINING_DATA
    importing
      !I_COLLECTION_ID type STRING
      !I_IMAGE_ID type STRING
      !I_TRAINING_DATA type T_BASE_TRAINING_DATA_OBJECTS
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_DATA_OBJECTS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! <p class="shorttext synchronized" lang="en">Get training usage</p>
    "!   Information about the completed training events. You can use this information to
    "!    determine how close you are to the training limits for the month.
    "!
    "! @parameter I_START_TIME |
    "!   The earliest day to include training events. Specify dates in YYYY-MM-DD format.
    "!    If empty or not specified, the earliest training event is included.
    "! @parameter I_END_TIME |
    "!   The most recent day to include training events. Specify dates in YYYY-MM-DD
    "!    format. All events for the day are included. If empty or not specified, the
    "!    current day is used. Specify the same value as `start_time` to request events
    "!    for a single day.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_EVENTS
    "! @raising ZCX_IBMC_SERVICE_EXCEPTION | Exception being raised in case of an error.
    "!
  methods GET_TRAINING_USAGE
    importing
      !I_START_TIME type STRING optional
      !I_END_TIME type STRING optional
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_EVENTS
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

class ZCL_IBMC_VISUAL_RECOGNITION_V4 IMPLEMENTATION.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->GET_APPNAME
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_APPNAME                      TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method GET_APPNAME.

    e_appname = 'Visual Recognition v4'.

  endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Protected Method ZCL_IBMC_VISUAL_RECOGNITION_V4->GET_REQUEST_PROP
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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->GET_SDK_VERSION_DATE
* +-------------------------------------------------------------------------------------------------+
* | [<-()] E_SDK_VERSION_DATE             TYPE        STRING
* +--------------------------------------------------------------------------------------</SIGNATURE>
  method get_sdk_version_date.

    e_sdk_version_date = '20200310173444'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->ANALYZE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_COLLECTION_IDS        TYPE TT_STRING
* | [--->] I_FEATURES        TYPE TT_STRING
* | [--->] I_IMAGES_FILE        TYPE TT_FILE_WITH_METADATA(optional)
* | [--->] I_IMAGE_URL        TYPE TT_STRING(optional)
* | [--->] I_THRESHOLD        TYPE FLOAT(optional)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_ANALYZE_RESPONSE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method ANALYZE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v4/analyze'.

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


    if not i_COLLECTION_IDS is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="collection_ids"'  ##NO_TEXT.
      field-symbols:
        <l_COLLECTION_IDS> like line of i_COLLECTION_IDS.
      loop at i_COLLECTION_IDS assigning <l_COLLECTION_IDS>.
        ls_form_part-cdata = <l_COLLECTION_IDS>.
        append ls_form_part to lt_form_part.
      endloop.
    endif.

    if not i_FEATURES is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="features"'  ##NO_TEXT.
      field-symbols:
        <l_FEATURES> like line of i_FEATURES.
      loop at i_FEATURES assigning <l_FEATURES>.
        ls_form_part-cdata = <l_FEATURES>.
        append ls_form_part to lt_form_part.
      endloop.
    endif.

    if not i_IMAGE_URL is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="image_url"'  ##NO_TEXT.
      field-symbols:
        <l_IMAGE_URL> like line of i_IMAGE_URL.
      loop at i_IMAGE_URL assigning <l_IMAGE_URL>.
        ls_form_part-cdata = <l_IMAGE_URL>.
        append ls_form_part to lt_form_part.
      endloop.
    endif.

    if not i_THRESHOLD is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="threshold"'  ##NO_TEXT.
      lv_formdata = i_THRESHOLD.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_IMAGES_FILE is initial.
      data:
        lv_filename     type string,
        lv_content_type type string.
      field-symbols:
        <lv_IMAGES_FILE> like line of i_IMAGES_FILE.
      loop at i_IMAGES_FILE assigning <lv_IMAGES_FILE>.
        if not <lv_IMAGES_FILE>-content_type is initial.
          lv_content_type = <lv_IMAGES_FILE>-content_type.
        else.
          lv_content_type = 'application/octet-stream'  ##NO_TEXT.
        endif.
        if not <lv_IMAGES_FILE>-filename is initial.
          lv_filename = <lv_IMAGES_FILE>-filename.
        else.
          lv_extension = get_file_extension( lv_content_type ).
          lv_filename = `file` && lv_index && `.` && lv_extension  ##NO_TEXT.
          lv_index = lv_index + 1.
        endif.
        clear ls_form_part.
        ls_form_part-content_type = lv_content_type.
        ls_form_part-content_disposition = `form-data; name="images_file"; filename="` && lv_filename && `"`  ##NO_TEXT.
        ls_form_part-xdata = <lv_IMAGES_FILE>-data.
        append ls_form_part to lt_form_part.
      endloop.
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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->CREATE_COLLECTION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_COLLECTION_INFO        TYPE T_BASE_COLLECTION
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method CREATE_COLLECTION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v4/collections'.

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
    lv_datatype = get_datatype( i_COLLECTION_INFO ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_COLLECTION_INFO i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'collection_info' i_value = i_COLLECTION_INFO ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_COLLECTION_INFO to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->LIST_COLLECTIONS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_COLLECTIONS_LIST
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_COLLECTIONS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v4/collections'.

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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->GET_COLLECTION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_COLLECTION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v4/collections/{collection_id}'.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->UPDATE_COLLECTION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_COLLECTION_INFO        TYPE T_BASE_COLLECTION(optional)
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_COLLECTION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v4/collections/{collection_id}'.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

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
    if not i_COLLECTION_INFO is initial.
    lv_datatype = get_datatype( i_COLLECTION_INFO ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_COLLECTION_INFO i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'collection_info' i_value = i_COLLECTION_INFO ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_COLLECTION_INFO to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->DELETE_COLLECTION
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_COLLECTION.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v4/collections/{collection_id}'.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->ADD_IMAGES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_IMAGES_FILE        TYPE TT_FILE_WITH_METADATA(optional)
* | [--->] I_IMAGE_URL        TYPE TT_STRING(optional)
* | [--->] I_TRAINING_DATA        TYPE STRING(optional)
* | [--->] I_contenttype       TYPE string (default ='multipart/form-data')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_IMAGE_DETAILS_LIST
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method ADD_IMAGES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v4/collections/{collection_id}/images'.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

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


    if not i_IMAGE_URL is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="image_url"'  ##NO_TEXT.
      field-symbols:
        <l_IMAGE_URL> like line of i_IMAGE_URL.
      loop at i_IMAGE_URL assigning <l_IMAGE_URL>.
        ls_form_part-cdata = <l_IMAGE_URL>.
        append ls_form_part to lt_form_part.
      endloop.
    endif.

    if not i_TRAINING_DATA is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="training_data"'  ##NO_TEXT.
      lv_formdata = i_TRAINING_DATA.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_IMAGES_FILE is initial.
      data:
        lv_filename     type string,
        lv_content_type type string.
      field-symbols:
        <lv_IMAGES_FILE> like line of i_IMAGES_FILE.
      loop at i_IMAGES_FILE assigning <lv_IMAGES_FILE>.
        if not <lv_IMAGES_FILE>-content_type is initial.
          lv_content_type = <lv_IMAGES_FILE>-content_type.
        else.
          lv_content_type = 'application/octet-stream'  ##NO_TEXT.
        endif.
        if not <lv_IMAGES_FILE>-filename is initial.
          lv_filename = <lv_IMAGES_FILE>-filename.
        else.
          lv_extension = get_file_extension( lv_content_type ).
          lv_filename = `file` && lv_index && `.` && lv_extension  ##NO_TEXT.
          lv_index = lv_index + 1.
        endif.
        clear ls_form_part.
        ls_form_part-content_type = lv_content_type.
        ls_form_part-content_disposition = `form-data; name="images_file"; filename="` && lv_filename && `"`  ##NO_TEXT.
        ls_form_part-xdata = <lv_IMAGES_FILE>-data.
        append ls_form_part to lt_form_part.
      endloop.
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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->LIST_IMAGES
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_IMAGE_SUMMARY_LIST
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_IMAGES.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v4/collections/{collection_id}/images'.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->GET_IMAGE_DETAILS
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_IMAGE_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_IMAGE_DETAILS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_IMAGE_DETAILS.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v4/collections/{collection_id}/images/{image_id}'.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
    replace all occurrences of `{image_id}` in ls_request_prop-url-path with i_IMAGE_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->DELETE_IMAGE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_IMAGE_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_IMAGE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v4/collections/{collection_id}/images/{image_id}'.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
    replace all occurrences of `{image_id}` in ls_request_prop-url-path with i_IMAGE_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.

* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->GET_JPEG_IMAGE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_IMAGE_ID        TYPE STRING
* | [--->] I_SIZE        TYPE STRING (default ='full')
* | [--->] I_accept            TYPE string (default ='image/jpeg')
* | [<---] E_RESPONSE                    TYPE        FILE
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_JPEG_IMAGE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v4/collections/{collection_id}/images/{image_id}/jpeg'.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
    replace all occurrences of `{image_id}` in ls_request_prop-url-path with i_IMAGE_ID ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_SIZE is supplied.
    lv_queryparam = escape( val = i_SIZE format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `size`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.






    " execute HTTP GET request
    lo_response = HTTP_GET( i_request_prop = ls_request_prop ).


    " retrieve file data
    e_response = get_response_binary( lo_response ).

endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->LIST_OBJECT_METADATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_OBJECT_METADATA_LIST
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method LIST_OBJECT_METADATA.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v4/collections/{collection_id}/objects'.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->UPDATE_OBJECT_METADATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_OBJECT        TYPE STRING
* | [--->] I_UPDATEOBJECTMETADATA        TYPE T_UPDATE_OBJECT_METADATA
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_UPDATE_OBJECT_METADATA
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method UPDATE_OBJECT_METADATA.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v4/collections/{collection_id}/objects/{object}'.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
    replace all occurrences of `{object}` in ls_request_prop-url-path with i_OBJECT ignoring case.

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
    lv_datatype = get_datatype( i_UPDATEOBJECTMETADATA ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_UPDATEOBJECTMETADATA i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'UpdateObjectMetadata' i_value = i_UPDATEOBJECTMETADATA ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_UPDATEOBJECTMETADATA to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->GET_OBJECT_METADATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_OBJECT        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_OBJECT_METADATA
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_OBJECT_METADATA.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v4/collections/{collection_id}/objects/{object}'.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
    replace all occurrences of `{object}` in ls_request_prop-url-path with i_OBJECT ignoring case.

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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->DELETE_OBJECT
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_OBJECT        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method DELETE_OBJECT.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v4/collections/{collection_id}/objects/{object}'.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
    replace all occurrences of `{object}` in ls_request_prop-url-path with i_OBJECT ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).








    " execute HTTP DELETE request
    lo_response = HTTP_DELETE( i_request_prop = ls_request_prop ).



endmethod.


* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->TRAIN
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_COLLECTION
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method TRAIN.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v4/collections/{collection_id}/train'.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.

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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->ADD_IMAGE_TRAINING_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_COLLECTION_ID        TYPE STRING
* | [--->] I_IMAGE_ID        TYPE STRING
* | [--->] I_TRAINING_DATA        TYPE T_BASE_TRAINING_DATA_OBJECTS
* | [--->] I_contenttype       TYPE string (default ='application/json')
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRAINING_DATA_OBJECTS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method ADD_IMAGE_TRAINING_DATA.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v4/collections/{collection_id}/images/{image_id}/training_data'.
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_COLLECTION_ID ignoring case.
    replace all occurrences of `{image_id}` in ls_request_prop-url-path with i_IMAGE_ID ignoring case.

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
    lv_datatype = get_datatype( i_TRAINING_DATA ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_TRAINING_DATA i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'training_data' i_value = i_TRAINING_DATA ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_TRAINING_DATA to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->GET_TRAINING_USAGE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_START_TIME        TYPE STRING(optional)
* | [--->] I_END_TIME        TYPE STRING(optional)
* | [--->] I_accept            TYPE string (default ='application/json')
* | [<---] E_RESPONSE                    TYPE        T_TRAINING_EVENTS
* | [!CX!] ZCX_IBMC_SERVICE_EXCEPTION
* +--------------------------------------------------------------------------------------</SIGNATURE>
method GET_TRAINING_USAGE.

    data:
      ls_request_prop type ts_request_prop,
      lv_separator(1) type c  ##NEEDED,
      lv_sep(1)       type c  ##NEEDED,
      lo_response     type to_rest_response,
      lv_json         type string  ##NEEDED.

    ls_request_prop-url-path = '/v4/training_usage'.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_START_TIME is supplied.
    lv_queryparam = escape( val = i_START_TIME format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `start_time`
        i_value      = lv_queryparam
      changing
        c_url        = ls_request_prop-url )  ##NO_TEXT.
    endif.

    if i_END_TIME is supplied.
    lv_queryparam = escape( val = i_END_TIME format = cl_abap_format=>e_uri_full ).
    add_query_parameter(
      exporting
        i_parameter  = `end_time`
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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->DELETE_USER_DATA
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

    ls_request_prop-url-path = '/v4/user_data'.

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
* | Instance Private Method ZCL_IBMC_VISUAL_RECOGNITION_V4->SET_DEFAULT_QUERY_PARAMETERS
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
