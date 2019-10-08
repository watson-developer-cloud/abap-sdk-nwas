class ZCX_IBMC_SERVICE_EXCEPTION definition
  public
  inheriting from CX_STATIC_CHECK
  final
  create public .

public section.

  interfaces IF_T100_DYN_MSG .
  interfaces IF_T100_MESSAGE .

  data P_MSG_JSON type STRING .
  data P_HTTP_STATUS type STRING .
  data P_HTTP_REASON type STRING .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !P_MSG_JSON type STRING optional
      !P_HTTP_STATUS type STRING optional
      !P_HTTP_REASON type STRING optional .

  methods IF_MESSAGE~GET_LONGTEXT
    redefinition .
  methods IF_MESSAGE~GET_TEXT
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCX_IBMC_SERVICE_EXCEPTION IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->P_MSG_JSON = P_MSG_JSON .
me->P_HTTP_STATUS = P_HTTP_STATUS .
me->P_HTTP_REASON = P_HTTP_REASON .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.


  method if_message~get_longtext.
    call method super->if_message~get_longtext
      exporting
        preserve_newlines = preserve_newlines
      receiving
        result            = result.
  endmethod.


  method if_message~get_text.
    call method super->if_message~get_text
      receiving
        result = result.
  endmethod.
ENDCLASS.
