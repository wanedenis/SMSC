CREATE SEQUENCE customer_contact_seq;

CREATE SEQUENCE customer_seq START WITH 40000 INCREMENT BY 1;

CREATE SEQUENCE customer_user_account_seq;

CREATE SEQUENCE dashboard_box_seq;

CREATE SEQUENCE dashboard_box_type_seq;

CREATE SEQUENCE dashboard_seq;

CREATE SEQUENCE role_seq;

CREATE SEQUENCE user_account_seq;

CREATE TABLE "CUSTOMER" (
  ID                 INT8         NOT NULL DEFAULT nextval('customer_seq'),
  LAST_MODIFIED_DATE TIMESTAMP    NOT NULL,
  VERSION            INT8         NOT NULL,
  CITY               VARCHAR(255) NOT NULL,
  COMPANY_NAME       VARCHAR(255) NOT NULL,
  COUNTRY            VARCHAR(255) NOT NULL,
  POSTCODE           VARCHAR(255) NOT NULL,
  STREET             VARCHAR(255) NOT NULL,
  STREET2            VARCHAR(255) NOT NULL,
  VATID              VARCHAR(255),
  PARENT_ID          INT8,
  PRIMARY KEY (ID)
);

CREATE TABLE "CUSTOMER_CONTACT" (
  ID                 INT8         NOT NULL DEFAULT nextval('customer_contact_seq'),
  LAST_MODIFIED_DATE TIMESTAMP    NOT NULL,
  VERSION            INT8         NOT NULL,
  EMAIL_ADDRESS      VARCHAR(255) NOT NULL,
  FAX                VARCHAR(255) NOT NULL,
  FIRST_NAME         VARCHAR(255) NOT NULL,
  MOBILE_PHONE       VARCHAR(255) NOT NULL,
  PHONE              VARCHAR(255) NOT NULL,
  SALUTATION         VARCHAR(255) NOT NULL,
  SURNAME            VARCHAR(255) NOT NULL,
  TYPE               VARCHAR(255) NOT NULL,
  CUSTOMER_ID        INT8         NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE "CUSTOMER_USER_ACCOUNT" (
  ID                 INT8         NOT NULL DEFAULT nextval('customer_user_account_seq'),
  LAST_MODIFIED_DATE TIMESTAMP    NOT NULL,
  VERSION            INT8         NOT NULL,
  ACTIVE             BOOLEAN      NOT NULL,
  BLOCKED            BOOLEAN      NOT NULL,
  CREATED            TIMESTAMP    NOT NULL,
  EMAIL              VARCHAR(255) NOT NULL,
  FIRST_NAME         VARCHAR(255) NOT NULL,
  PASSWORD           VARCHAR(255) NOT NULL,
  SALT               VARCHAR(255),
  SURNAME            VARCHAR(255) NOT NULL,
  USERNAME           VARCHAR(255) NOT NULL,
  SALUTATION         VARCHAR(255) NOT NULL,
  CUSTOMER_ID        INT8         NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE "DASHBOARD" (
  ID                 INT8         NOT NULL DEFAULT nextval('dashboard_seq'),
  LAST_MODIFIED_DATE TIMESTAMP    NOT NULL,
  VERSION            INT8         NOT NULL,
  ICON               VARCHAR(255) NOT NULL,
  NAME               VARCHAR(255) NOT NULL,
  USER_ACCOUNT_ID    INT8         NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE "DASHBOARD_BOX" (
  ID                    INT8         NOT NULL DEFAULT nextval('dashboard_box_seq'),
  LAST_MODIFIED_DATE    TIMESTAMP    NOT NULL,
  VERSION               INT8         NOT NULL,
  DESCRIPTION           VARCHAR(255) NOT NULL,
  HEIGHT                VARCHAR(255) NOT NULL,
  NAME                  VARCHAR(255) NOT NULL,
  ORDER_NUMBER          INT4         NOT NULL,
  WIDTH                 VARCHAR(255) NOT NULL,
  DASHBOARD_ID          INT8         NOT NULL,
  DASHBOARD_BOX_TYPE_ID INT8         NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE "DASHBOARD_BOX_TYPE" (
  ID                 INT8         NOT NULL DEFAULT nextval('dashboard_box_type_seq'),
  LAST_MODIFIED_DATE TIMESTAMP    NOT NULL,
  VERSION            INT8         NOT NULL,
  KIND               VARCHAR(255) NOT NULL,
  NAME               VARCHAR(255) NOT NULL,
  TYPE               VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE "ROLE" (
  ID                 INT8         NOT NULL DEFAULT nextval('role_seq'),
  LAST_MODIFIED_DATE TIMESTAMP    NOT NULL,
  VERSION            INT8         NOT NULL,
  NAME               VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE "USER_ACCOUNT" (
  ID                 INT8         NOT NULL DEFAULT nextval('user_account_seq'),
  LAST_MODIFIED_DATE TIMESTAMP    NOT NULL,
  VERSION            INT8         NOT NULL,
  ACTIVE             BOOLEAN      NOT NULL,
  BLOCKED            BOOLEAN      NOT NULL,
  CREATED            TIMESTAMP    NOT NULL,
  EMAIL              VARCHAR(255) NOT NULL,
  FIRST_NAME         VARCHAR(255) NOT NULL,
  PASSWORD           VARCHAR(255) NOT NULL,
  SALT               VARCHAR(255),
  SURNAME            VARCHAR(255) NOT NULL,
  USERNAME           VARCHAR(255) NOT NULL,
  SALUTATION         VARCHAR(255) NOT NULL,
  PRIMARY KEY (ID)
);

CREATE TABLE "USER_ROLE" (
  USER_ID INT8 NOT NULL,
  ROLE_ID INT8 NOT NULL,
  PRIMARY KEY (USER_ID, ROLE_ID)
);

ALTER TABLE "CUSTOMER_CONTACT"
  ADD CONSTRAINT UK_rt1h2souk5fkc2l0yojlch8ng UNIQUE (EMAIL_ADDRESS);

ALTER TABLE "CUSTOMER_USER_ACCOUNT"
  ADD CONSTRAINT UK_ocoo1ta18u6p16unw7h8b7i8h UNIQUE (USERNAME);

ALTER TABLE "DASHBOARD"
  ADD CONSTRAINT UK_k452w4cpbviagh85ll1q6gfc UNIQUE (NAME);

ALTER TABLE "DASHBOARD_BOX_TYPE"
  ADD CONSTRAINT UK_calopw9wexb9vek0fnkaotp2n UNIQUE (NAME);

ALTER TABLE "ROLE"
  ADD CONSTRAINT UK_lqaytvswxwacb7s84gcw7tk7l UNIQUE (NAME);

ALTER TABLE "USER_ACCOUNT"
  ADD CONSTRAINT UK_5b1ufubngfek527jhb11aure0 UNIQUE (USERNAME);

ALTER TABLE "CUSTOMER"
  ADD CONSTRAINT FK_k3k4147v3m5pjyjgfcrs0cdpj
FOREIGN KEY (PARENT_ID)
REFERENCES "CUSTOMER";

ALTER TABLE "CUSTOMER_CONTACT"
  ADD CONSTRAINT FK_32q3wpxac3cbvhn1t9bxmcr81
FOREIGN KEY (CUSTOMER_ID)
REFERENCES "CUSTOMER"
ON DELETE CASCADE;

ALTER TABLE "CUSTOMER_USER_ACCOUNT"
  ADD CONSTRAINT FK_jup37owwps8o8ntgoxdmn0th2
FOREIGN KEY (CUSTOMER_ID)
REFERENCES "CUSTOMER"
ON DELETE CASCADE;

ALTER TABLE "DASHBOARD"
  ADD CONSTRAINT FK_agttn8ptawhkdx8qse4hnkvpr
FOREIGN KEY (USER_ACCOUNT_ID)
REFERENCES "USER_ACCOUNT"
ON DELETE CASCADE;

ALTER TABLE "DASHBOARD_BOX"
  ADD CONSTRAINT FK_dgep5oi78i2irrmue308doxrp
FOREIGN KEY (DASHBOARD_ID)
REFERENCES "DASHBOARD"
ON DELETE CASCADE;

ALTER TABLE "DASHBOARD_BOX"
  ADD CONSTRAINT FK_pdct77x9bvtflrsx224gkvhhs
FOREIGN KEY (DASHBOARD_BOX_TYPE_ID)
REFERENCES "DASHBOARD_BOX_TYPE"
ON DELETE CASCADE;

ALTER TABLE "USER_ROLE"
  ADD CONSTRAINT FK_oqmdk7xj0ainhxpvi79fkaq3y
FOREIGN KEY (ROLE_ID)
REFERENCES "ROLE";

ALTER TABLE "USER_ROLE"
  ADD CONSTRAINT FK_j2j8kpywaghe8i36swcxv8784
FOREIGN KEY (USER_ID)
REFERENCES "USER_ACCOUNT";
