* Copyright 2019,2020 IBM Corp. All Rights Reserved.
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
class ZCL_IBMC_UTIL definition
  public
  final
  create public .

public section.


  "! Converts an internal table to JSON string in table schema format.
  "!   E.g.: '&#123;"fields": ["PET", "NUMBER"], "values": [["Cat",5],["Rabbit",2]]&#125;'
  "!
  "! @parameter I_ITAB | Internal table to be converted.
  "! @parameter I_DICTIONARY | Dictionary to be used for mapping ABAP identifiers to JSON keys.
  "! @parameter I_LOWER_CASE | If set to C_BOOLEAN_TRUE all keys in JSON string will be lower case.
  "! @parameter IT_EXCLUDED_FIELDS | Internal table of table fields in I_ITAB that should not occur in result.
  "! @parameter E_JSON | JSON string.
  "!
  class-methods ITAB_TO_TABLESCHEMA
    importing
      !I_ITAB type ANY TABLE
      !I_DICTIONARY type ANY optional
      !I_LOWER_CASE type ZCL_IBMC_SERVICE=>BOOLEAN default ZCL_IBMC_SERVICE=>C_BOOLEAN_FALSE
      !IT_EXCLUDED_FIELDS type ZCL_IBMC_SERVICE=>TT_STRING optional
    returning
      value(E_JSON) type STRING .
  "! Converts a JSON string in table schema format to an internal table.
  "!   E.g.: '&#123;"tableschema_key": &#123;"fields": ["PET", "NUMBER"], "values": [["Cat",5],["Rabbit",2]]&#125;&#125;'
  "!
  "! @parameter I_JSON | JSON string.
  "! @parameter I_TABLESCHEMA_KEY | Key in JSON string that holds the table schema.
  "! @parameter E_ITAB | Internal table containing converted data.
  "!
  class-methods TABLESCHEMA_TO_ITAB
    importing
      !I_JSON type STRING
      !I_TABLESCHEMA_KEY type STRING optional
    exporting
      !E_ITAB type ANY TABLE .
  "! Converts a timestamp in UTC to a timestamp in local time.
  "!
  "! @parameter IV_TIMESTAMP | Timestamp (UTC).
  "! @parameter EV_LOCAL | Timestamp (local time).
  "!
  class-methods CONVERT_TIMESTAMP_TO_LOCAL
    importing
      !IV_TIMESTAMP type TIMESTAMP
    returning
      value(EV_LOCAL) type STRING .
  "! Determine MIME type from a file name, e.g. 'docu.txt' -&gt; 'text_/plain'.
  "!
  "! @parameter I_FILENAME | Filename with extension.
  "! @parameter E_MIMETYPE | MIME type.
  "!
  class-methods GET_MIMETYPE_FROM_EXTENSION
    importing
      !I_FILENAME type STRING
    returning
      value(E_MIMETYPE) type STRING .
  "! Converts a timestamp in UTC to a timestamp in another timezone.
  "!
  "! @parameter I_TIMESTAMP | Timestamp (UTC).
  "! @parameter I_TIMEZONE | Time zone
  "! @parameter E_TIMESTAMP | Timestamp in give time zone.
  "!
  class-methods UTC_TO_TIMEZONE
    importing
      !I_TIMESTAMP type TIMESTAMP
      !I_TIMEZONE type ZIF_IBMC_SERVICE_ARCH=>TY_TIMEZONE optional
    returning
      value(E_TIMESTAMP) type TIMESTAMP .
  "! Converts datetime format to a timestamp, i.e. yyyy-mm-ddThh:mm:ssZ -&gt; YYYYMMDDHHMMSS
  "!
  "! @parameter I_DATETIME | Input in datetime format.
  "! @parameter E_TIMESTAMP | Timestamp.
  "!
  class-methods CONVERT_DATETIME_TO_TIMESTAMP
    importing
      !I_DATETIME type ZCL_IBMC_SERVICE=>DATETIME
    returning
      value(E_TIMESTAMP) type TIMESTAMP .
  "! Converts a timestamp to datetime format, i.e. YYYYMMDDHHMMSS -&gt; yyyy-mm-ddThh:mm:ssZ
  "!
  "! @parameter I_TIMESTAMP | Timestamp.
  "! @parameter E_DATETIME | Datetime format.
  "!
  class-methods CONVERT_TIMESTAMP_TO_DATETIME
    importing
      !I_TIMESTAMP type TIMESTAMP
    returning
      value(E_DATETIME) type ZCL_IBMC_SERVICE=>DATETIME .
protected section.
private section.
ENDCLASS.



CLASS ZCL_IBMC_UTIL IMPLEMENTATION.


  method CONVERT_DATETIME_TO_TIMESTAMP.

    constants:
      c_zero type timestamp value '0'.  " avoid conversion at runtime

    " check if input string applies to schema yyyy-mm-ddThh:mm:ssZ
    if i_datetime cp '++++-++-++T++:++:++*'.
      try.
          e_timestamp =
            i_datetime(4) * 10000000000 + i_datetime+5(2) * 100000000 + i_datetime+8(2) * 1000000 +
            i_datetime+11(2) * 10000 + i_datetime+14(2) * 100 + i_datetime+17(2).
        catch cx_sy_conversion_no_number.
          " invalid input
          e_timestamp = c_zero.
      endtry.
    else.
      " invalid input
      e_timestamp = c_zero.
    endif.

  endmethod.


  method CONVERT_TIMESTAMP_TO_DATETIME.

    data:
      lv_year(4) type n,
      lv_month(2) type n,
      lv_day(2) type n,
      lv_hour(2) type n,
      lv_min(2) type n,
      lv_sec(2) type n,
      lv_rest type timestamp.

    lv_rest = i_timestamp.
    lv_year = lv_rest div 10000000000.
    lv_rest = lv_rest - ( lv_year * 10000000000 ).
    lv_month = lv_rest div 100000000.
    lv_rest = lv_rest - ( lv_month * 100000000 ).
    lv_day = lv_rest div 1000000.
    lv_rest = lv_rest - ( lv_day * 1000000 ).
    lv_hour = lv_rest div 10000.
    lv_rest = lv_rest - ( lv_hour * 10000 ).
    lv_min = lv_rest div 100.
    lv_rest = lv_rest - ( lv_min * 100 ).
    lv_sec = lv_rest div 1.  " type conversion

    concatenate lv_year '-' lv_month '-' lv_day 'T' lv_hour ':' lv_min ':' lv_sec 'Z' into e_datetime.

  endmethod.


  method convert_timestamp_to_local.

    data:
      lv_dats     type d,
      lv_tims     type t,
      lv_timezone type zif_ibmc_service_arch=>ty_timezone,
      lv_datc(10) type c,
      lv_timc(8)  type c.

    " split timestamp to date and time according to time zone
    lv_timezone = zcl_ibmc_service_arch=>get_timezone( ).
    convert time stamp iv_timestamp time zone lv_timezone
            into date lv_dats time lv_tims.

    " write date and time to string using local date/time format
    lv_datc = conv #( lv_dats ).
    lv_timc = conv #( lv_tims ).
    concatenate lv_datc lv_timc into ev_local separated by space.

  endmethod.


  method get_mimetype_from_extension.
    data:
      l_extension type string.

    if i_filename is initial.
      e_mimetype = zif_ibmc_service_arch=>c_mediatype-all.
      exit.
    endif.

    find regex '\.([^\.]*)$' in i_filename submatches l_extension.
    if sy-subrc <> 0.
      l_extension = i_filename.
    endif.

    translate l_extension to lower case.

    case l_extension.
      when 'jpg' or 'jpeg'. e_mimetype = zif_ibmc_service_arch=>c_mediatype-image_jpeg.
      when 'png'. e_mimetype = zif_ibmc_service_arch=>c_mediatype-image_png.
      when 'txt'. e_mimetype = zif_ibmc_service_arch=>c_mediatype-text_plain.
      when 'csv'. e_mimetype = zif_ibmc_service_arch=>c_mediatype-text_csv.
      when others. e_mimetype = `application/` && l_extension ##NO_TEXT.
    endcase.

  endmethod.


  method itab_to_tableschema.
    " Converts an internal table to a JSON object string with keys "fields" and "values".
    " Example:   I_ITAB  =  | PET    | NUMBER |
    "                       -------------------
    "                       | Cat    |      5 |
    "                       | Rabbit |      2 |
    "      -->   E_JSON  =  '{"fields": ["PET", "NUMBER"], "values": [["Cat",5],["Rabbit",2]]}'
    " Field names are mapped according to I_DICTIONARY.
    " Example: BEGIN OF i_dictionary,
    "            PET type string value 'MyPet',
    "          END OF i_dictionary.
    "      -->   E_JSON  =  '{"fields": ["MyPet", "NUMBER"], "values": [["Cat",5],["Rabbit",2]]}'
    " Field names are translated to lower case, if I_LOWER_CASE = zcl_ibmc_service=>c_boolean_true.
    " Field types must be elementary or table of elementary.
    " Field names in table IT_EXCLUDED_FIELDS are skipped and will not appear in the JSON string.

    data:
      lt_comp      type cl_abap_structdescr=>component_table,
      ls_comp      like line of lt_comp,
      lo_datadescr type ref to cl_abap_datadescr,
      lo_tabledesc type ref to cl_abap_tabledescr,
      lo_struct    type ref to cl_abap_structdescr,
      lv_fieldname type string,
      lv_sep1(1)   type c,
      lv_sep2(1)   type c,
      lv_sep3(1)   type c.

    field-symbols:
      <ls_itab_line> type any,
      <lv_comp>      type any,
      <lt_comp>      type any table,
      <lv_jsonname>  type string.

    " the following data type are character-like, thus the according values must be quoted
    data(lc_character_types) =
      cl_abap_datadescr=>typekind_char &&
      cl_abap_datadescr=>typekind_clike &&
      cl_abap_datadescr=>typekind_csequence &&
      cl_abap_datadescr=>typekind_string &&
      cl_abap_datadescr=>typekind_date &&
      cl_abap_datadescr=>typekind_time &&
      cl_abap_datadescr=>typekind_num.

    " get internal table fields
    lo_tabledesc ?= cl_abap_tabledescr=>describe_by_data( i_itab ).
    lo_struct ?= lo_tabledesc->get_table_line_type( ).
    lt_comp = lo_struct->get_components( ).

    " append field names to JSON string
    e_json = `{"fields": [`  ##NO_TEXT.
    clear lv_sep1.
    loop at lt_comp into ls_comp.
      read table it_excluded_fields with key table_line = ls_comp-name transporting no fields.
      if sy-subrc = 0. continue. endif.
      lv_fieldname = ls_comp-name.
      if i_dictionary is supplied.
        assign component ls_comp-name of structure i_dictionary to <lv_jsonname>.
        if sy-subrc = 0.
          lv_fieldname = <lv_jsonname>.
        endif.
      endif.
      if i_lower_case eq zcl_ibmc_service=>c_boolean_true.
        translate lv_fieldname to lower case.
      endif.
      e_json = e_json && lv_sep1 && `"` && lv_fieldname && `"`.
      lv_sep1 = `,`.
    endloop.

    " append values to JSON string
    e_json = e_json && `], "values": [`  ##NO_TEXT.

    clear lv_sep1.
    loop at i_itab assigning <ls_itab_line>.  " loop on itab records
      clear lv_sep2.
      e_json = e_json && lv_sep1 && `[`.
      loop at lt_comp into ls_comp.  " loop on record fields
        read table it_excluded_fields with key table_line = ls_comp-name transporting no fields.
        if sy-subrc = 0. continue. endif.

        if ls_comp-type->type_kind eq cl_abap_datadescr=>typekind_table.

          " field type is subtable, get line type
          assign component ls_comp-name of structure <ls_itab_line> to <lt_comp>.
          lo_tabledesc ?= cl_abap_tabledescr=>describe_by_data( <lt_comp> ).
          lo_datadescr = lo_tabledesc->get_table_line_type( ).

          " add field values of subtable to JSON string
          clear lv_sep3.
          e_json = e_json && lv_sep2 && `[`.
          loop at <lt_comp> assigning <lv_comp>.
            if lo_datadescr->type_kind ca lc_character_types.
              e_json = e_json && lv_sep3 && `"` && <lv_comp> && `"`.
            else.
              e_json = e_json && lv_sep3 && <lv_comp>.
            endif.
            lv_sep3 = `,`.
          endloop.
          e_json = e_json && `]`.

        else.

          " field type is elementary, add field value to JSON string
          assign component ls_comp-name of structure <ls_itab_line> to <lv_comp>.
          if ls_comp-type->type_kind ca lc_character_types.
            e_json = e_json && lv_sep2 && `"` && <lv_comp> && `"`.
          else.
            e_json = e_json && lv_sep2 && <lv_comp>.
          endif.

        endif.

        lv_sep2 = `,`.
      endloop.

      e_json = e_json && `]`.
      lv_sep1 = `,`.
    endloop.

    e_json = e_json && `]}`  ##NO_TEXT.

  endmethod.


  method tableschema_to_itab.

    data:
      lt_comp            type cl_abap_structdescr=>component_table,
      ls_comp            like line of lt_comp,
      lv_field           type string,
      lt_field           type standard table of string,
      lv_fieldname       type string,
      lv_tabix           type i,
      lv_tableschema_key type string,
      lo_structdescr     type ref to cl_abap_structdescr,
      lo_datadescr       type ref to cl_abap_datadescr,
      lo_tabledescr      type ref to cl_abap_tabledescr,
      lr_values          type ref to data,
      lr_comp            type ref to data,
      lr_data            type ref to data,
      lv_json            type string.

    field-symbols:
      <lr_data>       type ref to data,
      <lt_field>      type any table,
      <la_comp>       type any,
      <lv_comp>       type any,
      <lt_comp>       type any table,
      <ls_root>       type any,
      <ls_parsed>     type any,
      <lr_values_tab> type ref to data,
      <lt_values_tab> type any table,
      <lt_values>     type any table,
      <ls_itab>       type any,
      <lt_itab>       type any table,
      <lt_ref>        type any table.

    " dynamically create data structure:
    "   begin of <ls_root>,
    "     tableschema_key type ref to data,
    "   end of <ls_root>.
    if i_tableschema_key is initial.
      lv_json = `{ "tableschema_key": ` && i_json && ` }`  ##NO_TEXT.
      lv_tableschema_key = `tableschema_key`  ##NO_TEXT.
    else.
      lv_json = i_json.
      lv_tableschema_key = i_tableschema_key.
    endif.
    ls_comp-name = lv_tableschema_key.
    ls_comp-type ?= cl_abap_datadescr=>describe_by_data( lr_data ).
    append ls_comp to lt_comp.
    lo_structdescr = cl_abap_structdescr=>create( lt_comp ).
    create data lr_data type handle lo_structdescr.
    assign lr_data->* to <ls_root>.

    " parse JSON
    try.
        zcl_ibmc_service=>parse_json(
        exporting
          i_json       = lv_json
          "i_dictionary = c_abapname_dictionary
        changing
          c_abap       = <ls_root> ).
      catch zcx_ibmc_service_exception.
        return.
    endtry.
    assign component lv_tableschema_key of structure <ls_root> to <lr_data>.
    assign <lr_data>->* to <ls_parsed>.



    unassign <lr_values_tab>.
    assign component 'VALUES' of structure <ls_parsed> to <lr_values_tab>.

    " I_JSON does not have table schema on highest level, check if any subkey has
    " check all components
    lo_structdescr ?= cl_abap_structdescr=>describe_by_data( <ls_parsed> ).
    clear lt_comp[].
    lt_comp = lo_structdescr->get_components( ).

    loop at lt_comp into ls_comp.
      assign component ls_comp-name of structure <ls_parsed> to <lr_data>.
      lo_datadescr ?= cl_abap_datadescr=>describe_by_data_ref( <lr_data> ).
      if lo_datadescr->type_kind eq cl_abap_datadescr=>typekind_table.
        assign <lr_data>->* to <lt_comp>.
        loop at <lt_comp> assigning <lr_data> ##GEN_OK.
          exit.
        endloop.
      endif.
      assign <lr_data>->* to <la_comp>.
      assign component 'VALUES' of structure <la_comp> to <lr_values_tab>.
      if sy-subrc = 0.
        assign <la_comp> to <ls_parsed>.
        exit.
      endif.

    endloop.


    if not <lr_values_tab> is assigned.
      return.
    endif.

    assign <lr_values_tab>->* to <lt_values_tab>.
    assign component 'FIELDS' of structure <ls_parsed> to <lr_data>.
    if sy-subrc = 0.
      assign <lr_data>->* to <lt_field>.
      loop at <lt_field> assigning <lr_data> ##GEN_OK.
        assign <lr_data>->* to <la_comp>.
        append <la_comp> to lt_field.
      endloop.
    else.
      data(lv_count) = lines( <lt_values_tab> ).
      data(lv_index) = 0.
      while lv_index < lv_count.
        lv_fieldname = `FIELD` && lv_index.
        lv_index = lv_index + 1.
        append lv_fieldname to lt_field.
      endwhile.
    endif.


    " get data fields; read first values for reference
    if lines( <lt_values_tab> ) < 1. return. endif.
    loop at <lt_values_tab> into lr_data.
      assign lr_data->* to <lt_values>.
      exit.
    endloop.

    clear lt_comp[].
    loop at <lt_values> into lr_values.

      " field name
      lv_tabix = lv_tabix + 1.
      read table lt_field index lv_tabix into lv_field.
      if sy-subrc <> 0.
        lv_field = `C` && lv_tabix.
      endif.
      ls_comp-name = lv_field.

      " read data type
      assign lr_values->* to <la_comp>.
      lo_datadescr ?= cl_abap_datadescr=>describe_by_data( <la_comp> ).

      if lo_datadescr->type_kind = cl_abap_structdescr=>typekind_table.

        " data type is internal table (of references)
        " -> create new internal table layout w/o references
        lo_tabledescr ?= cl_abap_tabledescr=>describe_by_data( <la_comp> ).
        lo_datadescr = lo_tabledescr->get_table_line_type( ).
        if lo_datadescr->type_kind = cl_abap_datadescr=>typekind_dref.
          assign <la_comp> to <lt_comp>.
          loop at <lt_comp> into lr_comp. exit. endloop.  " read first table record
          lo_datadescr ?= cl_abap_datadescr=>describe_by_data_ref( lr_comp ).
        endif.
        ls_comp-type = cl_abap_tabledescr=>create( p_line_type = lo_datadescr ).

      else.
        ls_comp-type = lo_datadescr.
      endif.

      append ls_comp to lt_comp.
    endloop.

    " create data structure
    lo_structdescr = cl_abap_structdescr=>create( lt_comp ).
    create data lr_data type handle lo_structdescr.
    assign lr_data->* to <ls_itab>.
    create data lr_data like table of <ls_itab>.
    assign lr_data->* to <lt_itab>.


    " populate data structure
    loop at <lt_values_tab> into lr_data.
      assign lr_data->* to <lt_values>.
      if not <ls_itab> is assigned.
        create data lr_data type handle lo_structdescr.
        assign lr_data->* to <ls_itab>.
      endif.
      lv_tabix = 0.
      loop at <lt_values> into lr_values.
        lv_tabix = lv_tabix + 1.
        read table lt_comp index lv_tabix into ls_comp.
        case ls_comp-type->type_kind.
          when cl_abap_structdescr=>typekind_table.
            assign component ls_comp-name of structure <ls_itab> to <lt_comp>.
            assign lr_values->* to <lt_ref>.
            loop at <lt_ref> into lr_data.
              assign lr_data->* to <la_comp>.
              insert <la_comp> into table <lt_comp>.
            endloop.
          when others.
            assign component ls_comp-name of structure <ls_itab> to <lv_comp>.
            assign lr_values->* to <la_comp>.
            <lv_comp> = <la_comp>.
        endcase.
      endloop.

      insert <ls_itab> into table <lt_itab>.
      unassign <ls_itab>.  " force data creation at next loop step

    endloop.

    move-corresponding <lt_itab> to e_itab.

  endmethod.


  method utc_to_timezone.

    data:
      lv_timezone type zif_ibmc_service_arch=>ty_timezone,
      lv_date     type d,
      lv_time     type t.

    if i_timezone is initial.
      lv_timezone = zcl_ibmc_service_arch=>get_timezone( ).
    else.
      lv_timezone = i_timezone.
    endif.

    convert time stamp i_timestamp time zone lv_timezone into date lv_date time lv_time.
    convert date lv_date time lv_time into time stamp e_timestamp time zone 'UTC'.

  endmethod.
ENDCLASS.
