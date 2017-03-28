set linesize 32767;
set line 10000;
set pagesize 1000;
set termout off;
set underline off;
set heading off;
set trimspool on;
set echo on;

spool FI_Config.txt;
/
insert into fimaster.ports_master (
 PORT_ID,
 PORT_NAME,
 PORT_DESC,
 PORT_LMU,
 PORT_LMD,
 PORT_STATUS,
 PORT_VER_NO,
 PORT_TYPE_ID,
 PORT_TYPE_STATUS,
 IS_GROUP,
 PORT_TIME_OUT) VALUES (
 fimaster.ports_master_seq.NEXTVAL,
 'FPRO_REQ_INQPORT_AU',
 'FPRO_REQ_INQPORT_AU',
 'SYSTEM',
 sysdate,
 'processed',
 1,
 (SELECT PORT_TYPE_ID FROM FIMASTER.PORT_TYPE WHERE PORT_TYPE='JMS'),
 'processed',
 'no',
 ''
 );

insert into fimaster.PORT_PARAM_MAPPING(
PORT_ID,
PORT_PARAMETER_ID,
PORT_PARAMETER_VALUE,
PORT_STATUS)values(
(SELECT PORT_ID FROM FIMASTER.PORTS_MASTER WHERE  PORT_NAME='FPRO_REQ_INQPORT_AU'),
(select PORT_PARAMETER_ID from fimaster.PORT_TYPE_PARAMETERS where parameter_name='JMS_QUEUE_CONNECTION_FACTORY_NAME'),
'jms/CBIG.ONLINE.RS.INQ.FPRO.CBAU_QCF',
'processed');

insert into fimaster.PORT_PARAM_MAPPING(
PORT_ID,
PORT_PARAMETER_ID,
PORT_PARAMETER_VALUE,
PORT_STATUS)values(
(SELECT PORT_ID FROM FIMASTER.PORTS_MASTER WHERE  PORT_NAME='FPRO_REQ_INQPORT_AU'),
(select PORT_PARAMETER_ID from fimaster.PORT_TYPE_PARAMETERS where parameter_name='JMS_QUEUE_NAME'),
'jms/CBIG.ONLINE.RS.INQ.FPRO.CBAU_Q',
'processed');

insert into fimaster.PORT_PARAM_MAPPING(
PORT_ID,
PORT_PARAMETER_ID,
PORT_PARAMETER_VALUE,
PORT_STATUS)values(
(SELECT PORT_ID FROM FIMASTER.PORTS_MASTER WHERE  PORT_NAME='FPRO_REQ_INQPORT_AU'),
(select PORT_PARAMETER_ID from fimaster.PORT_TYPE_PARAMETERS where parameter_name='PROVIDER_URL'),
'corbaloc::A01SCBEMAPP1A:50500,:A01SCBEMAPP2A:50500,:A01SCBEMAPP3A:50500,:A01SCBEMAPP4A:50500',
'processed');

insert into fimaster.PORT_PARAM_MAPPING(
PORT_ID,
PORT_PARAMETER_ID,
PORT_PARAMETER_VALUE,
PORT_STATUS)values(
(SELECT PORT_ID FROM FIMASTER.PORTS_MASTER WHERE  PORT_NAME='FPRO_REQ_INQPORT_AU'),
(select PORT_PARAMETER_ID from fimaster.PORT_TYPE_PARAMETERS where parameter_name='INITIAL_CONTEXT_FACTORY'),
'com.ibm.websphere.naming.WsnInitialContextFactory',
'processed');

INSERT INTO fimaster.fiusb_service_provider_table
            (fiusb_srv_prov_id,
             fiusb_srv_prov_name,
             fiusb_srv_prov_desc,
             host_interface_node_id, host_interface_node_status,
             fiusb_srv_prov_lmu, fiusb_srv_prov_lmd, fiusb_srv_prov_ver_no,
             fiusb_srv_prov_status,
             fiusb_srv_prov_class_name
            )
     VALUES (fimaster.fiusb_srv_prov_id_seq.NEXTVAL,
             'srvProvinquireLimitNode_AUS',
             'srvProvinquireLimitNode_AUS',
             (SELECT host_interface_node_id
                FROM fimaster.host_interface_node_table
               WHERE host_interface_code = 'FCRemoteKR'), 'processed',
             'SYSTEM', SYSDATE, 1,
             'processed',
             'com.infosys.ci.srvprov.FCORModuleBeanLookUpServiceProvider'
            );

INSERT INTO fimaster.fiusb_service_interface_table
            (fiusb_srv_int_id,
             fiusb_srv_prov_id,
             fiusb_reversal_srv_int_id, fiusb_srv_int_lmu, fiusb_srv_int_lmd,
             fiusb_srv_int_ver_no, fiusb_srv_int_status,
             fiusb_srv_prov_status, fiusb_srv_int_name, fiusb_srv_int_desc,
             fiusb_reversal_srv_int_status, fiusb_req_mapper,
             fiusb_resp_mapper, fiusb_srv_int_version, fiusb_mapper_status,
             MESSAGE_TYPE, message_sub_type
            )
     VALUES (fimaster.fiusb_srv_inter_id_seq.NEXTVAL,
             (SELECT fiusb_srv_prov_id
                FROM fimaster.fiusb_service_provider_table
               WHERE fiusb_srv_prov_name = 'srvProvinquireLimitNode_AUS'),
             NULL, 'SYSTEM', SYSDATE,
             1, 'processed',
             'processed', 'srvIntinquireLimitNode_AUS', 'srvIntinquireLimitNode_AUS',
             NULL, NULL,
             NULL, '1.1', NULL,
             'XML', 'FIXML'
            );


INSERT INTO fimaster.fiusb_service_requestor_table
            (fiusb_srv_req_id,
             fiusb_srv_req_type, fiusb_srv_invoc_mode, fiusb_srv_req_lmu,
             fiusb_srv_req_lmd, fiusb_srv_req_ver_no, fiusb_srv_req_status,
             fiusb_srv_req_type_version, fiusb_srv_req_name,
             fiusb_srv_req_desc, fiusb_not_srv_req_id,
             fiusb_not_srv_req_status, fiusb_srv_interaction_type
            )
     VALUES (fimaster.fiusb_srv_req_id_seq.NEXTVAL,
             'inquireLimitNode', 'SYNCHRONOUS', 'SYSTEM',
             SYSDATE, 1, 'processed',
             '6', 'inquireLimitNode_AU',
             'inquireLimitNode_AUS', NULL,
             NULL, 'Invoker'
            );

INSERT INTO fimaster.fiusb_srv_req_mapping_table
            (fiusb_srv_req_id,
             fiusb_srv_int_id, fiusb_srv_req_status,
             fiusb_srv_int_status, fiusb_prov_invoc_mode, fiusb_prov_timeout
            )
     VALUES (fimaster.fiusb_srv_req_id_seq.CURRVAL,
             fimaster.fiusb_srv_inter_id_seq.CURRVAL, 'processed',
             'processed', 'S', NULL
            );

insert into fimaster.ports_master (
 PORT_ID,
 PORT_NAME,
 PORT_DESC,
 PORT_LMU,
 PORT_LMD,
 PORT_STATUS,
 PORT_VER_NO,
 PORT_TYPE_ID,
 PORT_TYPE_STATUS,
 IS_GROUP,
 PORT_TIME_OUT) VALUES (
 fimaster.ports_master_seq.NEXTVAL,
 'FPRO_REQ_LUTPORT_AU',
 'FPRO_REQ_LUTPORT_AU',
 'SYSTEM',
 sysdate,
 'processed',
 1,
 (SELECT PORT_TYPE_ID FROM FIMASTER.PORT_TYPE WHERE PORT_TYPE='JMS'),
 'processed',
 'no',
 ''
 );

insert into fimaster.PORT_PARAM_MAPPING(
PORT_ID,
PORT_PARAMETER_ID,
PORT_PARAMETER_VALUE,
PORT_STATUS)values(
(SELECT PORT_ID FROM FIMASTER.PORTS_MASTER WHERE  PORT_NAME='FPRO_REQ_LUTPORT_AU'),
(select PORT_PARAMETER_ID from fimaster.PORT_TYPE_PARAMETERS where parameter_name='JMS_QUEUE_CONNECTION_FACTORY_NAME'),
'jms/CBIG.ONLINE.RS.LUT.FPRO.CBAU_QCF',
'processed');

insert into fimaster.PORT_PARAM_MAPPING(
PORT_ID,
PORT_PARAMETER_ID,
PORT_PARAMETER_VALUE,
PORT_STATUS)values(
(SELECT PORT_ID FROM FIMASTER.PORTS_MASTER WHERE  PORT_NAME='FPRO_REQ_LUTPORT_AU'),
(select PORT_PARAMETER_ID from fimaster.PORT_TYPE_PARAMETERS where parameter_name='JMS_QUEUE_NAME'),
'jms/CBIG.ONLINE.RS.LUT.FPRO.CBAU_Q',
'processed');

insert into fimaster.PORT_PARAM_MAPPING(
PORT_ID,
PORT_PARAMETER_ID,
PORT_PARAMETER_VALUE,
PORT_STATUS)values(
(SELECT PORT_ID FROM FIMASTER.PORTS_MASTER WHERE  PORT_NAME='FPRO_REQ_LUTPORT_AU'),
(select PORT_PARAMETER_ID from fimaster.PORT_TYPE_PARAMETERS where parameter_name='PROVIDER_URL'),
'corbaloc::A01SCBEMAPP1A:50500,:A01SCBEMAPP2A:50500,:A01SCBEMAPP3A:50500,:A01SCBEMAPP4A:50500',
'processed');

insert into fimaster.PORT_PARAM_MAPPING(
PORT_ID,
PORT_PARAMETER_ID,
PORT_PARAMETER_VALUE,
PORT_STATUS)values(
(SELECT PORT_ID FROM FIMASTER.PORTS_MASTER WHERE  PORT_NAME='FPRO_REQ_LUTPORT_AU'),
(select PORT_PARAMETER_ID from fimaster.PORT_TYPE_PARAMETERS where parameter_name='INITIAL_CONTEXT_FACTORY'),
'com.ibm.websphere.naming.WsnInitialContextFactory',
'processed');

commit;

spool off;
