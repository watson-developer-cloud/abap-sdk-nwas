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
"! <h1>Visual Recognition v4</h1>
"! Provide images to the IBM Watson&trade; Visual Recognition service for analysis.
"!  The service detects objects based on a set of images with training data.
"!
"! **Beta:** The Visual Recognition v4 API and Object Detection model are beta
"!  features. For more information about beta features, see the [Release
"!  notes](https://cloud.ibm.com/docs/services/visual-recognition?topic=visual-reco
"! gnition-release-notes#beta).
"! &#123;: important&#125; <br/>
class ZCL_IBMC_VISUAL_RECOGNITION_V4 DEFINITION
  public
  inheriting from ZCL_IBMC_SERVICE_EXT
  create public .

public section.
  types:
    "!   Defines the location of the bounding box around the object.
    begin of T_LOCATION,
      TOP type INTEGER,
      LEFT type INTEGER,
      WIDTH type INTEGER,
      HEIGHT type INTEGER,
    end of T_LOCATION.
  types:
    "!   Training status for the objects in the collection.
    begin of T_OBJECT_TRAINING_STATUS,
      READY type BOOLEAN,
      IN_PROGRESS type BOOLEAN,
      DATA_CHANGED type BOOLEAN,
      LATEST_FAILED type BOOLEAN,
      DESCRIPTION type STRING,
    end of T_OBJECT_TRAINING_STATUS.
  types:
    "!   Training status information for the collection.
    begin of T_TRAINING_STATUS,
      OBJECTS type T_OBJECT_TRAINING_STATUS,
    end of T_TRAINING_STATUS.
  types:
    "!   The source type of the image.
    begin of T_IMAGE_SOURCE,
      TYPE type STRING,
      FILENAME type STRING,
      ARCHIVE_FILENAME type STRING,
      SOURCE_URL type STRING,
      RESOLVED_URL type STRING,
    end of T_IMAGE_SOURCE.
  types:
    "!   Details about the training data.
    begin of T_TRAINING_DATA_OBJECT,
      OBJECT type STRING,
      LOCATION type T_LOCATION,
    end of T_TRAINING_DATA_OBJECT.
  types:
    "!   Training data for all objects.
    begin of T_TRAINING_DATA_OBJECTS,
      OBJECTS type STANDARD TABLE OF T_TRAINING_DATA_OBJECT WITH NON-UNIQUE DEFAULT KEY,
    end of T_TRAINING_DATA_OBJECTS.
  types:
    "!   Details about a collection.
    begin of T_COLLECTION,
      COLLECTION_ID type STRING,
      NAME type STRING,
      DESCRIPTION type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
      IMAGE_COUNT type INTEGER,
      TRAINING_STATUS type T_TRAINING_STATUS,
    end of T_COLLECTION.
  types:
    "!   Height and width of an image.
    begin of T_IMAGE_DIMENSIONS,
      HEIGHT type INTEGER,
      WIDTH type INTEGER,
    end of T_IMAGE_DIMENSIONS.
  types:
    "!   Details about the specific area of the problem.
    begin of T_ERROR_TARGET,
      TYPE type STRING,
      NAME type STRING,
    end of T_ERROR_TARGET.
  types:
    "!   Details about an error.
    begin of T_ERROR,
      CODE type STRING,
      MESSAGE type STRING,
      MORE_INFO type STRING,
      TARGET type T_ERROR_TARGET,
    end of T_ERROR.
  types:
    "!   A container for the list of request-level problems.
    begin of T_ERROR_RESPONSE,
      ERRORS type STANDARD TABLE OF T_ERROR WITH NON-UNIQUE DEFAULT KEY,
      TRACE type STRING,
    end of T_ERROR_RESPONSE.
  types:
    "!   Details about an object and its location.
    begin of T_BASE_OBJECT,
      OBJECT type STRING,
      LOCATION type T_LOCATION,
    end of T_BASE_OBJECT.
  types:
    "!
    begin of T_INLINE_OBJECT,
      COLLECTION_IDS type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      FEATURES type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      IMAGES_FILE type STANDARD TABLE OF FILE WITH NON-UNIQUE DEFAULT KEY,
      IMAGE_URL type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      THRESHOLD type FLOAT,
    end of T_INLINE_OBJECT.
  types:
    "!   Details about an object in the collection.
    begin of T_OBJECT_DETAIL,
      OBJECT type STRING,
      LOCATION type T_LOCATION,
      SCORE type FLOAT,
    end of T_OBJECT_DETAIL.
  types:
    "!   The objects in a collection that are detected in an image.
    begin of T_COLLECTION_OBJECTS,
      COLLECTION_ID type STRING,
      OBJECTS type STANDARD TABLE OF T_OBJECT_DETAIL WITH NON-UNIQUE DEFAULT KEY,
    end of T_COLLECTION_OBJECTS.
  types:
    "!   Container for the list of collections that have objects detected in an image.
    begin of T_DETECTED_OBJECTS,
      COLLECTIONS type STANDARD TABLE OF T_COLLECTION_OBJECTS WITH NON-UNIQUE DEFAULT KEY,
    end of T_DETECTED_OBJECTS.
  types:
    "!   A file returned in the response.
      T_JPEG_IMAGE type FILE.
  types:
    "!   A container for the list of collections.
    begin of T_COLLECTIONS_LIST,
      COLLECTIONS type STANDARD TABLE OF T_COLLECTION WITH NON-UNIQUE DEFAULT KEY,
    end of T_COLLECTIONS_LIST.
  types:
    "!   Details about an image.
    begin of T_IMAGE_DETAILS,
      IMAGE_ID type STRING,
      UPDATED type DATETIME,
      CREATED type DATETIME,
      SOURCE type T_IMAGE_SOURCE,
      DIMENSIONS type T_IMAGE_DIMENSIONS,
      ERRORS type T_ERROR,
      TRAINING_DATA type T_TRAINING_DATA_OBJECTS,
    end of T_IMAGE_DETAILS.
  types:
    "!   Details about a problem.
    begin of T_WARNING,
      CODE type STRING,
      MESSAGE type STRING,
      MORE_INFO type STRING,
    end of T_WARNING.
  types:
    "!   List of information about the images.
    begin of T_IMAGE_DETAILS_LIST,
      IMAGES type STANDARD TABLE OF T_IMAGE_DETAILS WITH NON-UNIQUE DEFAULT KEY,
      WARNINGS type STANDARD TABLE OF T_WARNING WITH NON-UNIQUE DEFAULT KEY,
      TRACE type STRING,
    end of T_IMAGE_DETAILS_LIST.
  types:
    "!   Empty response.
      T_EMPTY type JSONOBJECT.
  types:
    "!   Basic information about an image.
    begin of T_IMAGE_SUMMARY,
      IMAGE_ID type STRING,
      UPDATED type DATETIME,
    end of T_IMAGE_SUMMARY.
  types:
    "!   Container for the training data.
    begin of T_BASE_TRAINING_DATA_OBJECTS,
      OBJECTS type STANDARD TABLE OF T_TRAINING_DATA_OBJECT WITH NON-UNIQUE DEFAULT KEY,
    end of T_BASE_TRAINING_DATA_OBJECTS.
  types:
    "!
    begin of T_INLINE_OBJECT1,
      IMAGES_FILE type STANDARD TABLE OF FILE WITH NON-UNIQUE DEFAULT KEY,
      IMAGE_URL type STANDARD TABLE OF STRING WITH NON-UNIQUE DEFAULT KEY,
      TRAINING_DATA type STRING,
    end of T_INLINE_OBJECT1.
  types:
    "!   List of images.
    begin of T_IMAGE_SUMMARY_LIST,
      IMAGES type STANDARD TABLE OF T_IMAGE_SUMMARY WITH NON-UNIQUE DEFAULT KEY,
    end of T_IMAGE_SUMMARY_LIST.
  types:
    "!   Details about an image.
    begin of T_IMAGE,
      SOURCE type T_IMAGE_SOURCE,
      DIMENSIONS type T_IMAGE_DIMENSIONS,
      OBJECTS type T_DETECTED_OBJECTS,
      ERRORS type T_ERROR,
    end of T_IMAGE.
  types:
    "!   Results for all images.
    begin of T_ANALYZE_RESPONSE,
      IMAGES type STANDARD TABLE OF T_IMAGE WITH NON-UNIQUE DEFAULT KEY,
      WARNINGS type STANDARD TABLE OF T_WARNING WITH NON-UNIQUE DEFAULT KEY,
      TRACE type STRING,
    end of T_ANALYZE_RESPONSE.
  types:
    "!   Base details about a collection.
    begin of T_BASE_COLLECTION,
      COLLECTION_ID type STRING,
      NAME type STRING,
      DESCRIPTION type STRING,
      CREATED type DATETIME,
      UPDATED type DATETIME,
      IMAGE_COUNT type INTEGER,
      TRAINING_STATUS type T_TRAINING_STATUS,
    end of T_BASE_COLLECTION.

constants:
  begin of C_REQUIRED_FIELDS,
    T_LOCATION type string value '|TOP|LEFT|WIDTH|HEIGHT|',
    T_OBJECT_TRAINING_STATUS type string value '|READY|IN_PROGRESS|DATA_CHANGED|LATEST_FAILED|DESCRIPTION|',
    T_TRAINING_STATUS type string value '|OBJECTS|',
    T_IMAGE_SOURCE type string value '|TYPE|',
    T_TRAINING_DATA_OBJECT type string value '|',
    T_TRAINING_DATA_OBJECTS type string value '|OBJECTS|',
    T_COLLECTION type string value '|COLLECTION_ID|NAME|DESCRIPTION|CREATED|UPDATED|IMAGE_COUNT|TRAINING_STATUS|',
    T_IMAGE_DIMENSIONS type string value '|HEIGHT|WIDTH|',
    T_ERROR_TARGET type string value '|TYPE|NAME|',
    T_ERROR type string value '|CODE|MESSAGE|',
    T_ERROR_RESPONSE type string value '|ERRORS|TRACE|',
    T_BASE_OBJECT type string value '|',
    T_INLINE_OBJECT type string value '|COLLECTION_IDS|FEATURES|',
    T_OBJECT_DETAIL type string value '|OBJECT|LOCATION|SCORE|',
    T_COLLECTION_OBJECTS type string value '|COLLECTION_ID|OBJECTS|',
    T_DETECTED_OBJECTS type string value '|',
    T_COLLECTIONS_LIST type string value '|COLLECTIONS|',
    T_IMAGE_DETAILS type string value '|IMAGE_ID|UPDATED|CREATED|SOURCE|DIMENSIONS|TRAINING_DATA|',
    T_WARNING type string value '|CODE|MESSAGE|',
    T_IMAGE_DETAILS_LIST type string value '|',
    T_IMAGE_SUMMARY type string value '|',
    T_BASE_TRAINING_DATA_OBJECTS type string value '|',
    T_INLINE_OBJECT1 type string value '|',
    T_IMAGE_SUMMARY_LIST type string value '|IMAGES|',
    T_IMAGE type string value '|SOURCE|DIMENSIONS|OBJECTS|',
    T_ANALYZE_RESPONSE type string value '|IMAGES|',
    T_BASE_COLLECTION type string value '|',
    __DUMMY type string value SPACE,
  end of C_REQUIRED_FIELDS .

constants:
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
     OBJECTS type string value 'objects',
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
     OBJECT type string value 'object',
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


    "! Analyze images.
    "!
    "! @parameter I_collection_ids |
    "!   The IDs of the collections to analyze.
    "! @parameter I_features |
    "!   The features to analyze.
    "! @parameter I_images_file |
    "!   An array of image files (.jpg or .png) or .zip files with images.
    "!   - Include a maximum of 20 images in a request.
    "!   - Limit the .zip file to 100 MB.
    "!   - Limit each image file to 10 MB.
    "!
    "!   You can also include an image with the **image_url** parameter.
    "! @parameter I_image_url |
    "!   An array of URLs of image files (.jpg or .png).
    "!   - Include a maximum of 20 images in a request.
    "!   - Limit each image file to 10 MB.
    "!   - Minimum width and height is 30 pixels, but the service tends to perform better
    "!    with images that are at least 300 x 300 pixels. Maximum is 5400 pixels for
    "!    either height or width.
    "!
    "!   You can also include images with the **images_file** parameter.
    "! @parameter I_threshold |
    "!   The minimum score a feature must have to be returned.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_ANALYZE_RESPONSE
    "!
  methods ANALYZE
    importing
      !I_collection_ids type TT_STRING
      !I_features type TT_STRING
      !I_images_file type TT_FILE_WITH_METADATA optional
      !I_image_url type TT_STRING optional
      !I_threshold type FLOAT optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_ANALYZE_RESPONSE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Create a collection.
    "!
    "! @parameter I_collection_info |
    "!   The new collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTION
    "!
  methods CREATE_COLLECTION
    importing
      !I_collection_info type T_BASE_COLLECTION
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! List collections.
    "!
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTIONS_LIST
    "!
  methods LIST_COLLECTIONS
    importing
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTIONS_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get collection details.
    "!
    "! @parameter I_collection_id |
    "!   The identifier of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTION
    "!
  methods GET_COLLECTION
    importing
      !I_collection_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Update a collection.
    "!
    "! @parameter I_collection_id |
    "!   The identifier of the collection.
    "! @parameter I_collection_info |
    "!   The updated collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTION
    "!
  methods UPDATE_COLLECTION
    importing
      !I_collection_id type STRING
      !I_collection_info type T_BASE_COLLECTION optional
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete a collection.
    "!
    "! @parameter I_collection_id |
    "!   The identifier of the collection.
    "!
  methods DELETE_COLLECTION
    importing
      !I_collection_id type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Add images.
    "!
    "! @parameter I_collection_id |
    "!   The identifier of the collection.
    "! @parameter I_images_file |
    "!   An array of image files (.jpg or .png) or .zip files with images.
    "!   - Include a maximum of 20 images in a request.
    "!   - Limit the .zip file to 100 MB.
    "!   - Limit each image file to 10 MB.
    "!
    "!   You can also include an image with the **image_url** parameter.
    "! @parameter I_image_url |
    "!   The array of URLs of image files (.jpg or .png).
    "!   - Include a maximum of 20 images in a request.
    "!   - Limit each image file to 10 MB.
    "!   - Minimum width and height is 30 pixels, but the service tends to perform better
    "!    with images that are at least 300 x 300 pixels. Maximum is 5400 pixels for
    "!    either height or width.
    "!
    "!   You can also include images with the **images_file** parameter.
    "! @parameter I_training_data |
    "!   Training data for a single image. Include training data only if you add one
    "!    image with the request.
    "!
    "!   The `object` property can contain alphanumeric, underscore, hyphen, space, and
    "!    dot characters. It cannot begin with the reserved prefix `sys-` and must be no
    "!    longer than 32 characters.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_IMAGE_DETAILS_LIST
    "!
  methods ADD_IMAGES
    importing
      !I_collection_id type STRING
      !I_images_file type TT_FILE_WITH_METADATA optional
      !I_image_url type TT_STRING optional
      !I_training_data type STRING optional
      !I_contenttype type string default 'multipart/form-data'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_IMAGE_DETAILS_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! List images.
    "!
    "! @parameter I_collection_id |
    "!   The identifier of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_IMAGE_SUMMARY_LIST
    "!
  methods LIST_IMAGES
    importing
      !I_collection_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_IMAGE_SUMMARY_LIST
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get image details.
    "!
    "! @parameter I_collection_id |
    "!   The identifier of the collection.
    "! @parameter I_image_id |
    "!   The identifier of the image.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_IMAGE_DETAILS
    "!
  methods GET_IMAGE_DETAILS
    importing
      !I_collection_id type STRING
      !I_image_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_IMAGE_DETAILS
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Delete an image.
    "!
    "! @parameter I_collection_id |
    "!   The identifier of the collection.
    "! @parameter I_image_id |
    "!   The identifier of the image.
    "!
  methods DELETE_IMAGE
    importing
      !I_collection_id type STRING
      !I_image_id type STRING
      !I_accept      type string default 'application/json'
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Get a JPEG file of an image.
    "!
    "! @parameter I_collection_id |
    "!   The identifier of the collection.
    "! @parameter I_image_id |
    "!   The identifier of the image.
    "! @parameter I_size |
    "!   Specify the image size.
    "! @parameter E_RESPONSE |
    "!   Service return value of type FILE
    "!
  methods GET_JPEG_IMAGE
    importing
      !I_collection_id type STRING
      !I_image_id type STRING
      !I_size type STRING default 'full'
      !I_accept      type string default 'image/jpeg'
    exporting
      !E_RESPONSE type FILE
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .

    "! Train a collection.
    "!
    "! @parameter I_collection_id |
    "!   The identifier of the collection.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_COLLECTION
    "!
  methods TRAIN
    importing
      !I_collection_id type STRING
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_COLLECTION
    raising
      ZCX_IBMC_SERVICE_EXCEPTION .
    "! Add training data to an image.
    "!
    "! @parameter I_collection_id |
    "!   The identifier of the collection.
    "! @parameter I_image_id |
    "!   The identifier of the image.
    "! @parameter I_training_data |
    "!   Training data. Elements in the request replace the existing elements.
    "! @parameter E_RESPONSE |
    "!   Service return value of type T_TRAINING_DATA_OBJECTS
    "!
  methods ADD_IMAGE_TRAINING_DATA
    importing
      !I_collection_id type STRING
      !I_image_id type STRING
      !I_training_data type T_BASE_TRAINING_DATA_OBJECTS
      !I_contenttype type string default 'application/json'
      !I_accept      type string default 'application/json'
    exporting
      !E_RESPONSE type T_TRAINING_DATA_OBJECTS
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

    e_sdk_version_date = '20191002122856'.

  endmethod.



* <SIGNATURE>---------------------------------------------------------------------------------------+
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->ANALYZE
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_collection_ids        TYPE TT_STRING
* | [--->] I_features        TYPE TT_STRING
* | [--->] I_images_file        TYPE TT_FILE_WITH_METADATA(optional)
* | [--->] I_image_url        TYPE TT_STRING(optional)
* | [--->] I_threshold        TYPE FLOAT(optional)
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


    if not i_collection_ids is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="collection_ids"'  ##NO_TEXT.
      field-symbols:
        <l_collection_ids> like line of i_collection_ids.
      loop at i_collection_ids assigning <l_collection_ids>.
        ls_form_part-cdata = <l_collection_ids>.
        append ls_form_part to lt_form_part.
      endloop.
    endif.

    if not i_features is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="features"'  ##NO_TEXT.
      field-symbols:
        <l_features> like line of i_features.
      loop at i_features assigning <l_features>.
        ls_form_part-cdata = <l_features>.
        append ls_form_part to lt_form_part.
      endloop.
    endif.

    if not i_image_url is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="image_url"'  ##NO_TEXT.
      field-symbols:
        <l_image_url> like line of i_image_url.
      loop at i_image_url assigning <l_image_url>.
        ls_form_part-cdata = <l_image_url>.
        append ls_form_part to lt_form_part.
      endloop.
    endif.

    if not i_threshold is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="threshold"'  ##NO_TEXT.
      lv_formdata = i_threshold.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_images_file is initial.
      data:
        lv_filename     type string,
        lv_content_type type string.
      field-symbols:
        <lv_images_file> like line of i_images_file.
      loop at i_images_file assigning <lv_images_file>.
        if not <lv_images_file>-content_type is initial.
          lv_content_type = <lv_images_file>-content_type.
        else.
          lv_content_type = 'application/octet-stream'  ##NO_TEXT.
        endif.
        if not <lv_images_file>-filename is initial.
          lv_filename = <lv_images_file>-filename.
        else.
          lv_extension = get_file_extension( lv_content_type ).
          lv_filename = `file` && lv_index && `.` && lv_extension  ##NO_TEXT.
          lv_index = lv_index + 1.
        endif.
        clear ls_form_part.
        ls_form_part-content_type = lv_content_type.
        ls_form_part-content_disposition = `form-data; name="images_file"; filename="` && lv_filename && `"`  ##NO_TEXT.
        ls_form_part-xdata = <lv_images_file>-data.
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
* | [--->] I_collection_info        TYPE T_BASE_COLLECTION
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
    lv_datatype = get_datatype( i_collection_info ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_collection_info i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'collection_info' i_value = i_collection_info ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_collection_info to <lv_text>.
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
* | [--->] I_collection_id        TYPE STRING
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
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

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
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_collection_info        TYPE T_BASE_COLLECTION(optional)
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
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

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
    if not i_collection_info is initial.
    lv_datatype = get_datatype( i_collection_info ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_collection_info i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'collection_info' i_value = i_collection_info ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_collection_info to <lv_text>.
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
* | [--->] I_collection_id        TYPE STRING
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
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

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
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_images_file        TYPE TT_FILE_WITH_METADATA(optional)
* | [--->] I_image_url        TYPE TT_STRING(optional)
* | [--->] I_training_data        TYPE STRING(optional)
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
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

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


    if not i_image_url is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="image_url"'  ##NO_TEXT.
      field-symbols:
        <l_image_url> like line of i_image_url.
      loop at i_image_url assigning <l_image_url>.
        ls_form_part-cdata = <l_image_url>.
        append ls_form_part to lt_form_part.
      endloop.
    endif.

    if not i_training_data is initial.
      clear ls_form_part.
      ls_form_part-content_type = ZIF_IBMC_SERVICE_ARCH~C_MEDIATYPE-TEXT_PLAIN.
      ls_form_part-content_disposition = 'form-data; name="training_data"'  ##NO_TEXT.
      lv_formdata = i_training_data.
      ls_form_part-cdata = lv_formdata.
      append ls_form_part to lt_form_part.
    endif.



    if not i_images_file is initial.
      data:
        lv_filename     type string,
        lv_content_type type string.
      field-symbols:
        <lv_images_file> like line of i_images_file.
      loop at i_images_file assigning <lv_images_file>.
        if not <lv_images_file>-content_type is initial.
          lv_content_type = <lv_images_file>-content_type.
        else.
          lv_content_type = 'application/octet-stream'  ##NO_TEXT.
        endif.
        if not <lv_images_file>-filename is initial.
          lv_filename = <lv_images_file>-filename.
        else.
          lv_extension = get_file_extension( lv_content_type ).
          lv_filename = `file` && lv_index && `.` && lv_extension  ##NO_TEXT.
          lv_index = lv_index + 1.
        endif.
        clear ls_form_part.
        ls_form_part-content_type = lv_content_type.
        ls_form_part-content_disposition = `form-data; name="images_file"; filename="` && lv_filename && `"`  ##NO_TEXT.
        ls_form_part-xdata = <lv_images_file>-data.
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
* | [--->] I_collection_id        TYPE STRING
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
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

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
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_image_id        TYPE STRING
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
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.
    replace all occurrences of `{image_id}` in ls_request_prop-url-path with i_image_id ignoring case.

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
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_image_id        TYPE STRING
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
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.
    replace all occurrences of `{image_id}` in ls_request_prop-url-path with i_image_id ignoring case.

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
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_image_id        TYPE STRING
* | [--->] I_size        TYPE STRING (default ='full')
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
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.
    replace all occurrences of `{image_id}` in ls_request_prop-url-path with i_image_id ignoring case.

    " standard headers
    ls_request_prop-header_accept = I_accept.
    set_default_query_parameters(
      changing
        c_url =  ls_request_prop-url ).

    " process query parameters
    data:
      lv_queryparam type string.

    if i_size is supplied.
    lv_queryparam = escape( val = i_size format = cl_abap_format=>e_uri_full ).
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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->TRAIN
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_collection_id        TYPE STRING
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
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.

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
* | [--->] I_collection_id        TYPE STRING
* | [--->] I_image_id        TYPE STRING
* | [--->] I_training_data        TYPE T_BASE_TRAINING_DATA_OBJECTS
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
    replace all occurrences of `{collection_id}` in ls_request_prop-url-path with i_collection_id ignoring case.
    replace all occurrences of `{image_id}` in ls_request_prop-url-path with i_image_id ignoring case.

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
    lv_datatype = get_datatype( i_training_data ).

    if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
       lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep or
       ls_request_prop-header_content_type cp '*json*'.
      if lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct or
         lv_datatype eq ZIF_IBMC_SERVICE_ARCH~c_datatype-struct_deep.
        lv_bodyparam = abap_to_json( i_value = i_training_data i_dictionary = c_abapname_dictionary i_required_fields = c_required_fields ).
      else.
        lv_bodyparam = abap_to_json( i_name = 'training_data' i_value = i_training_data ).
      endif.
      lv_body = lv_body && lv_separator && lv_bodyparam.
    else.
      assign i_training_data to <lv_text>.
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
* | Instance Public Method ZCL_IBMC_VISUAL_RECOGNITION_V4->DELETE_USER_DATA
* +-------------------------------------------------------------------------------------------------+
* | [--->] I_customer_id        TYPE STRING
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
