CREATE TEMPORARY TABLE IF NOT EXISTS  tmp_email ( entity_id  INT,   new_email   VARCHAR(255));

SET     @rank=0;
INSERT INTO tmp_email (entity_id,new_email)
SELECT entity_id, CONCAT('demo',rank,'@', 'demo.com')new_email
FROM
(
SELECT entity_id, @rank:=@rank+1 AS rank
FROM customer_entity
)A;

CREATE INDEX ix_temp_tmp_email_entity_id ON tmp_email(entity_id);



UPDATE customer_entity p INNER JOIN
tmp_email pp ON p.entity_id = pp.entity_id
SET p.email = pp.new_email;

DROP TEMPORARY TABLE  tmp_email;

UPDATE customer_address_entity SET fax = '88888888';
UPDATE customer_address_entity SET telephone = '88888888';


UPDATE  quote_payment
SET
`cc_type`=NULL,
`cc_number_enc`=NULL,
-- `cc_last4`=NULL,
`cc_cid_enc`=NULL,
`cc_owner`=NULL,
`cc_exp_month`=0,
`cc_exp_year`=0,
`cc_ss_owner`=NULL,
`cc_ss_start_month`=0,
`cc_ss_start_year`=0,
`cc_ss_issue`=NULL;


UPDATE  sales_order_payment
SET
`cc_exp_month`=0,
`cc_ss_start_year`=0,
`cc_debug_request_body`= NULL,
`cc_secure_verify`=NULL,
`cc_approval`=NULL,
-- `cc_last4`=NULL,
`cc_status_description`=NULL,
`cc_debug_response_serialized`=NULL,
`cc_ss_start_month`=0,
`cc_cid_status`=NULL,
`cc_owner`=NULL,
`cc_type`=NULL,
`cc_exp_year`=0,
`cc_status`=NULL,
`cc_debug_response_body`=NULL,
`cc_ss_issue`=NULL,
`cc_avs_status`=NULL,
`cc_number_enc`=NULL,
`cc_trans_id`=NULL;


CREATE TEMPORARY TABLE IF NOT EXISTS tmp_quote ( entity_id INT, email VARCHAR(255) );

SET     @rank=0,@rank1=0,@rank2=0 ;
INSERT INTO tmp_quote (entity_id , email)
SELECT  entity_id,  CONCAT('demo',@rank:=@rank+1,'@', 'demo.com') email
FROM   `quote`;

CREATE INDEX ix_tmp_quote_address_entity_id ON tmp_quote(entity_id);

UPDATE `quote` p INNER JOIN  tmp_quote pp
ON p.entity_id = pp.entity_id
SET p.customer_email=pp.email,p.customer_lastname=CONCAT( 'surname_' , p.entity_id);

DROP TEMPORARY TABLE  tmp_quote;



CREATE TEMPORARY TABLE IF NOT EXISTS tmp_quote_address ( address_id INT, email VARCHAR(255), telephone VARCHAR(255),fax VARCHAR(255),fname VARCHAR(255),mname VARCHAR(255),lname VARCHAR(255) );

SET     @rank=0,@rank1=0,@rank2=0 ;
INSERT INTO tmp_quote_address (address_id, email, telephone, fax,fname,mname,lname)
SELECT  address_id,  CONCAT('demo',@rank:=@rank+1,'@', 'demo.com') email,
        @rank1:=@rank1+1  telephone, @rank2:=@rank2+1 fax,
        CONCAT('fname_',@rank:=@rank+1) fname,
        CONCAT('mname_',@rank:=@rank+1) mname,
        CONCAT('lname_',@rank:=@rank+1) lname
FROM   quote_address;

CREATE INDEX ix_tmp_quote_address_address_id ON tmp_quote_address  (address_id);

UPDATE quote_address p INNER JOIN  tmp_quote_address pp
ON p.address_id = pp.address_id
SET p.email=pp.email,
    p.telephone=pp.telephone,
    p.fax=pp.fax,
    p.`firstname`=pp.fname,
    p.`middlename`=pp.mname,
    p.`lastname`=pp.lname,
    p.`street`=NULL;

DROP TEMPORARY TABLE  tmp_quote_address;


CREATE TEMPORARY TABLE IF NOT EXISTS tmp_order ( entity_id INT, email VARCHAR(255) );

SET     @rank=0,@rank1=0,@rank2=0 ;
INSERT INTO tmp_order (entity_id , email)
SELECT  entity_id,  CONCAT('demo',@rank:=@rank+1,'@', 'demo.com') email
FROM   sales_order;

CREATE INDEX ix_tmp_order_address_entity_id ON tmp_order  (entity_id);

UPDATE sales_order p INNER JOIN  tmp_order pp
ON p.entity_id = pp.entity_id
SET p.customer_email=pp.email,p.customer_lastname=CONCAT( 'surname_' , p.entity_id);

DROP TEMPORARY TABLE  tmp_order;



CREATE TEMPORARY TABLE IF NOT EXISTS tmp_order_address ( entity_id INT, email VARCHAR(255), telephone VARCHAR(255),fax VARCHAR(255),fname VARCHAR(255),mname VARCHAR(255),lname VARCHAR(255) );

SET     @rank=0,@rank1=0,@rank2=0 ;
INSERT INTO tmp_order_address (entity_id , email, telephone, fax,fname,mname,lname)
SELECT  entity_id,  CONCAT('demo',@rank:=@rank+1,'@', 'demo.com') email,
        @rank1:=@rank1+1  telephone, @rank2:=@rank2+1 fax,
        CONCAT('fname_',@rank:=@rank+1) fname,
        CONCAT('mname_',@rank:=@rank+1) mname,
        CONCAT('lname_',@rank:=@rank+1) lname
FROM   sales_order_address;

CREATE INDEX ix_tmp_order_address_entity_id ON tmp_order_address  (entity_id);

UPDATE sales_order_address p INNER JOIN  tmp_order_address pp
ON p.entity_id = pp.entity_id
SET p.email=pp.email,
    p.telephone=pp.telephone,
    p.fax=pp.fax,
    p.`firstname`=pp.fname,
    p.`middlename`=pp.mname,
    p.`lastname`=pp.lname,
    p.`street`=NULL;

DROP TEMPORARY TABLE  tmp_order_address;


CREATE TEMPORARY TABLE IF NOT EXISTS tmp_subscriber( subscriber_id INT, subscriber_email VARCHAR(255));


SET     @rank=0;
INSERT INTO tmp_subscriber ( subscriber_id , subscriber_email)
SELECT  subscriber_id ,  CONCAT('demo',@rank:=@rank+1,'@', 'demo.com') subscriber_email
FROM  newsletter_subscriber ;

CREATE INDEX ix_tmp_subscriber_subscriber_id ON tmp_subscriber  (subscriber_id);

UPDATE newsletter_subscriber p INNER JOIN  tmp_subscriber pp
ON p.subscriber_id  = pp.subscriber_id
SET p.subscriber_email =pp.subscriber_email;

DROP TEMPORARY TABLE tmp_subscriber ;

UPDATE customer_entity  SET firstname = CONCAT( 'firstname_',entity_id);
UPDATE customer_entity  SET middlename = CONCAT( 'middlename_',entity_id);
UPDATE customer_entity  SET lastname = CONCAT( 'surname_',entity_id);



UPDATE customer_address_entity  SET firstname = CONCAT( 'firstname_',entity_id);
UPDATE customer_address_entity  SET middlename = CONCAT( 'middlename_',entity_id);
UPDATE customer_address_entity  SET lastname = CONCAT( 'surname_',entity_id);
UPDATE customer_address_entity  SET street = CONCAT( 'name_',entity_id);

-- SELECT * FROM `customer_address_entity_varchar`;


UPDATE sales_order sfo INNER JOIN `sales_order_grid` sfog ON sfo.`entity_id` = sfog.`entity_id`
SET shipping_name = CONCAT_WS('',sfo.`customer_firstname`,' ',sfo.`customer_lastname`),
billing_name = CONCAT_WS('',sfo.`customer_firstname`,' ',sfo.`customer_lastname`);


UPDATE sales_order sfo INNER JOIN `sales_invoice_grid` sfog ON sfo.`entity_id` = sfog.`order_id`
SET billing_name = CONCAT_WS('',sfo.`customer_firstname`,' ',sfo.`customer_lastname`);



UPDATE sales_order sfo INNER JOIN `sales_shipment_grid` sfog ON sfo.`entity_id` = sfog.`order_id`
SET shipping_name = CONCAT_WS('',sfo.`customer_firstname`,' ',sfo.`customer_lastname`);


UPDATE sales_order sfo INNER JOIN `sales_creditmemo_grid` sfog ON sfo.`entity_id` = sfog.`order_id`
SET billing_name = CONCAT_WS('',sfo.`customer_firstname`,' ',sfo.`customer_lastname`);

-- demo Store Locator data
-- CREATE TEMPORARY TABLE IF NOT EXISTS  tmp_store_email ( entity_id  INT,   new_email   VARCHAR(255));

-- SET     @rank=0;
-- INSERT INTO tmp_store_email (entity_id,new_email)
-- SELECT store_locator_id, CONCAT('demo',rank,'@', 'demo.com')new_email
-- FROM
-- (
-- SELECT store_locator_id, @rank:=@rank+1 AS rank
-- FROM ns_store_locator
-- )A;

-- CREATE INDEX ix_temp_tmp_email_entity_id ON tmp_store_email(entity_id);


-- UPDATE ns_store_locator p INNER JOIN
-- tmp_store_email pp ON p.store_locator_id = pp.entity_id
-- SET p.email = pp.new_email, p.`phone` = '88888888', p.`fax` = '88888888';

-- DROP TEMPORARY TABLE  tmp_store_email;

UPDATE core_config_data SET `value` = 'test@demotest.com' WHERE path LIKE '%copy_to';
