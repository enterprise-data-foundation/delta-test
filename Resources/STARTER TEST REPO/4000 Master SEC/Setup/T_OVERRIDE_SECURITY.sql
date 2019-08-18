-- SEC_ID 1000

INSERT INTO [dbo].[T_OVERRIDE_SECURITY]
           ([TOP_LEVEL_RUN_ID]
           ,[MASTER_TOP_LEVEL_RUN_ID]
           ,[SEC_ID]
           ,[APIR_IDENTIFICATION_CODE]
           ,[ASSET_TYPE]
           ,[BLOOMBERG_COMPANY_ID]
           ,[BLOOMBERG_COMPOSITE_GLOBAL_ID]
           ,[BLOOMBERG_EXCHANGE_CODE]
           ,[BLOOMBERG_GLOBAL_COMPANY_ID]
           ,[BLOOMBERG_GLOBAL_COMPANY_NAME]
           ,[BLOOMBERG_GLOBAL_ID]
           ,[BLOOMBERG_GLOBAL_SHARE_CLASS_ID]
           ,[BLOOMBERG_INDUSTRY_GROUP_CODE]
           ,[BLOOMBERG_INDUSTRY_GROUP_NAME]
           ,[BLOOMBERG_INDUSTRY_SECTOR_CODE]
           ,[BLOOMBERG_INDUSTRY_SECTOR_NAME]
           ,[BLOOMBERG_INDUSTRY_SUBGROUP_CODE]
           ,[BLOOMBERG_INDUSTRY_SUBGROUP_NAME]
           ,[BLOOMBERG_ISSUE_COUNTRY_CODE]
           ,[BLOOMBERG_MARKET_SECTOR_DESCRIPTION]
           ,[BLOOMBERG_MARKET_STATUS]
           ,[BLOOMBERG_MTF_COMPOSITE_GLOBAL_ID]
           ,[BLOOMBERG_MTF_PRIMARY_GLOBAL_ID]
           ,[BLOOMBERG_PARENT_COMPANY_ID]
           ,[BLOOMBERG_PRIMARY_COMPOSITE_GLOBAL_ID]
           ,[BLOOMBERG_PRIMARY_SECURITY_FLAG]
           ,[BLOOMBERG_PRIMARY_SECURITY_ID]
           ,[BLOOMBERG_PRIMARY_UNDERLYING_GLOBAL_ID]
           ,[BLOOMBERG_SECURITY_ID]
           ,[BLOOMBERG_UNDERLYING_GLOBAL_ID]
           ,[BLOOMBERG_UNIQUE_ID]
           ,[CLASSIFICATION_FINANCIAL_INSTRUMENTS_CODE]
           ,[COMMON_NUMBER]
           ,[COUNTRY_CALENDAR_CODE]
           ,[CUSIP]
           ,[DAYS_TO_SETTLE]
           ,[DOMICILE_ISO_COUNTRY_CODE]
           ,[EFFECTIVE_DATE]
           ,[EXCHANGE_CALENDAR_CODE]
           ,[FILE_NAME]
           ,[IDENTIFIER_NUMBER_DESCRIPTION]
           ,[INCORPORATION_ISO_COUNTRY_CODE]
           ,[IS_REMOVED_BLOOMBERG]
           ,[ISIN]
           ,[ISSUE_ISO_COUNTRY_CODE]
           ,[LOCAL_EXCHANGE_SYMBOL]
           ,[MIC_EXCHANGE_LOCAL_CODE]
           ,[MIC_EXCHANGE_PRIMARY_CODE]
           ,[NAICS_CODE]
           ,[PAR_AMOUNT]
           ,[PAR_VALUE_CCY]
           ,[PARENT_COMPANY_NAME]
           ,[PARENT_COMPANY_TICKER]
           ,[PARENT_INDUSTRY_GROUP]
           ,[PARENT_INDUSTRY_SECTOR]
           ,[PARENT_INDUSTRY_SUBGROUP]
           ,[POST_EURO_ISIN]
           ,[POST_EURO_PAR_AMOUNT]
           ,[POST_EURO_REDOMINATION_CCY]
           ,[PRE_EURO_ISIN]
           ,[PRE_EURO_PAR_AMOUNT]
           ,[PRE_EURO_REDOMINATION_CCY]
           ,[PRICING_FEED_SOURCE_CODE]
           ,[PRIMARY_EXCHANGE_CODE]
           ,[PRIMARY_EXCHANGE_NAME]
           ,[PRIVATE_PLACEMENT_INDICATOR]
           ,[QUOTE_LOT_SIZE]
           ,[REDENOMIATION_ROUNDING_METHOD]
           ,[REDENOMINATION_DATE]
           ,[REDENOMINATION_METHOD]
           ,[REGION_CODE]
           ,[ROUND_LOT_SIZE]
           ,[RULE_144A_INDICATOR]
           ,[SECURITY_DESCRIPTION]
           ,[CURRENCY_ISO_CODE]
           ,[SECURITY_NAME]
           ,[SECURITY_RESTRICTION]
           ,[SECURITY_SHORTNAME]
           ,[SECURITY_TYPE]
           ,[SECURITY_TYPE_DESCRIPTION]
           ,[SEDOL]
           ,[SEDOL_ISO_COUNTRY_CODE]
           ,[SEDOL2]
           ,[SEDOL2_ISO_COUNTRY_CODE]
           ,[SETTLEMENT_CALENDAR_CODE]
           ,[STANDARD_INDUSTRIAL_CLASSIFICATION_CODE]
           ,[STANDARD_INDUSTRIAL_CLASSIFICATION_NAME]
           ,[STATE_CODE]
           ,[TICKER]
           ,[TICKER_AND_EXCHANGE_CODE]
           ,[TRADE_LOT_SIZE]
           ,[TRADING_SYSTEM_IDENTIFIER]
           ,[TRADING_SYSTEM_IDENTIFIER_NAME]
           ,[VALOREN]
           ,[WERTPAPIER]
           ,[WHEN_ISSUED_FLAG]
           ,[CADIS_SYSTEM_INSERTED]
           ,[CADIS_SYSTEM_UPDATED]
           ,[CADIS_SYSTEM_CHANGEDBY]
           ,[CADIS_SYSTEM_PRIORITY]
           ,[CADIS_SYSTEM_LASTMODIFIED]
		)
     VALUES
           (2147000 -- <TOP_LEVEL_RUN_ID, int,>
           ,2147001 -- <MASTER_TOP_LEVEL_RUN_ID, int,>
           ,1000 -- <SEC_ID, int,>
           ,'OA' -- <APIR_IDENTIFICATION_CODE, varchar(9),>
           ,'OB' -- <ASSET_TYPE, varchar(10),>
           ,'OC' -- <BLOOMBERG_COMPANY_ID, varchar(8),>
           ,'OD' -- <BLOOMBERG_COMPOSITE_GLOBAL_ID, varchar(12),>
           ,'OE' -- <BLOOMBERG_EXCHANGE_CODE, varchar(18),>
           ,'OF' -- <BLOOMBERG_GLOBAL_COMPANY_ID, varchar(12),>
           ,'OG' -- <BLOOMBERG_GLOBAL_COMPANY_NAME, varchar(80),>
           ,'OH' -- <BLOOMBERG_GLOBAL_ID, varchar(12),>
           ,'OI' -- <BLOOMBERG_GLOBAL_SHARE_CLASS_ID, varchar(12),>
           ,2147002 -- <BLOOMBERG_INDUSTRY_GROUP_CODE, int,>
           ,'OJ' -- <BLOOMBERG_INDUSTRY_GROUP_NAME, varchar(24),>
           ,2147003 -- <BLOOMBERG_INDUSTRY_SECTOR_CODE, int,>
           ,'OK' -- <BLOOMBERG_INDUSTRY_SECTOR_NAME, varchar(22),>
           ,2147004 -- <BLOOMBERG_INDUSTRY_SUBGROUP_CODE, int,>
           ,'OL' -- <BLOOMBERG_INDUSTRY_SUBGROUP_NAME, varchar(24),>
           ,'OM' -- <BLOOMBERG_ISSUE_COUNTRY_CODE, varchar(2),>
           ,'OO' -- <BLOOMBERG_MARKET_SECTOR_DESCRIPTION, varchar(6),>
           ,'OP' -- <BLOOMBERG_MARKET_STATUS, varchar(6),>
           ,'OQ' -- <BLOOMBERG_MTF_COMPOSITE_GLOBAL_ID, varchar(12),>
           ,'OR' -- <BLOOMBERG_MTF_PRIMARY_GLOBAL_ID, varchar(12),>
           ,'OS' -- <BLOOMBERG_PARENT_COMPANY_ID, varchar(8),>
           ,'OT' -- <BLOOMBERG_PRIMARY_COMPOSITE_GLOBAL_ID, varchar(12),>
           ,2147005 -- <BLOOMBERG_PRIMARY_SECURITY_FLAG, int,>
           ,2147006 -- <BLOOMBERG_PRIMARY_SECURITY_ID, int,>
           ,'OU' -- <BLOOMBERG_PRIMARY_UNDERLYING_GLOBAL_ID, varchar(12),>
           ,'OV' -- <BLOOMBERG_SECURITY_ID, varchar(8),>
           ,'OW' -- <BLOOMBERG_UNDERLYING_GLOBAL_ID, varchar(12),>
           ,'OX' -- <BLOOMBERG_UNIQUE_ID, varchar(18),>
           ,'OY' -- <CLASSIFICATION_FINANCIAL_INSTRUMENTS_CODE, varchar(6),>
           ,2147007 -- <COMMON_NUMBER, int,>
           ,'OZ' -- <COUNTRY_CALENDAR_CODE, varchar(2),>
           ,'OA' -- <CUSIP, varchar(9),>
           ,2147008 -- <DAYS_TO_SETTLE, int,>
           ,'OB' -- , varchar(2),>
           ,'2018-01-01' -- <EFFECTIVE_DATE, datetime,>
           ,'OC' -- <EXCHANGE_CALENDAR_CODE, varchar(2),>
           ,'OD' -- <FILE_NAME, varchar(30),>
           ,'OE' -- <IDENTIFIER_NUMBER_DESCRIPTION, varchar(26),>
           ,'OF' -- <INCORPORATION_ISO_COUNTRY_CODE, varchar(4),>
           ,2147009 -- <IS_REMOVED_BLOOMBERG, int,>
           ,'OG' -- <ISIN, varchar(12),>
           ,'OH' -- <ISSUE_ISO_COUNTRY_CODE, varchar(2),>
           ,'OI' -- <LOCAL_EXCHANGE_SYMBOL, varchar(16),>
           ,'OJ' -- <MIC_EXCHANGE_LOCAL_CODE, varchar(13),>
           ,'OK' -- <MIC_EXCHANGE_PRIMARY_CODE, varchar(4),>
           ,'OL' -- <NAICS_CODE, varchar(6),>
           ,3.14 -- <PAR_AMOUNT, decimal(22,8),>
           ,'OM' -- <PAR_VALUE_CCY, varchar(3),>
           ,'ON' -- <PARENT_COMPANY_NAME, varchar(30),>
           ,'OO' -- <PARENT_COMPANY_TICKER, varchar(8),>
           ,'OP' -- <PARENT_INDUSTRY_GROUP, varchar(24),>
           ,'OQ' -- <PARENT_INDUSTRY_SECTOR, varchar(22),>
           ,'OR' -- <PARENT_INDUSTRY_SUBGROUP, varchar(24),>
           ,'OS' -- <POST_EURO_ISIN, varchar(12),>
           ,2.03 -- <POST_EURO_PAR_AMOUNT, decimal(22,8),>
           ,'OU' -- <POST_EURO_REDOMINATION_CCY, varchar(3),>
           ,'OV' -- <PRE_EURO_ISIN, varchar(12),>
           ,4.25 -- <PRE_EURO_PAR_AMOUNT, decimal(22,8),>
           ,'OW' -- <PRE_EURO_REDOMINATION_CCY, varchar(3),>
           ,'OX' -- <PRICING_FEED_SOURCE_CODE, varchar(4),>
           ,'OY' -- <PRIMARY_EXCHANGE_CODE, varchar(2),>
           ,'OZ' -- <PRIMARY_EXCHANGE_NAME, varchar(12),>
           ,'OA' -- <PRIVATE_PLACEMENT_INDICATOR, varchar(10),>
           ,5.36 -- <QUOTE_LOT_SIZE, decimal(22,8),>
           ,'OB' -- <REDENOMIATION_ROUNDING_METHOD, varchar(30),>
           ,'OC' -- <REDENOMINATION_DATE, varchar(19),>
           ,'OD' -- <REDENOMINATION_METHOD, varchar(16),>
           ,'OE' -- <REGION_CODE, varchar(5),>
           ,2147010 -- <ROUND_LOT_SIZE, int,>
           ,2147011 -- <RULE_144A_INDICATOR, int,>
           ,'OF' -- <SECURITY_DESCRIPTION, varchar(18),>
           ,'OG' -- <CURRENCY_ISO_CODE, varchar(3),>
           ,'OH' -- <SECURITY_NAME, varchar(100),>
           ,2147012 -- <SECURITY_RESTRICTION, int,>
           ,'OI' -- <SECURITY_SHORTNAME, varchar(50),>
           ,'OJ' -- <SECURITY_TYPE, varchar(16),>
           ,'OK' -- <SECURITY_TYPE_DESCRIPTION, varchar(20),>
           ,'OL' -- <SEDOL, varchar(7),>
           ,'OM' -- <SEDOL_ISO_COUNTRY_CODE, varchar(2),>
           ,'ON' -- <SEDOL2, varchar(7),>
           ,'OO' -- <SEDOL2_ISO_COUNTRY_CODE, varchar(2),>
           ,'OP' -- <SETTLEMENT_CALENDAR_CODE, varchar(2),>
           ,2147013 -- <STANDARD_INDUSTRIAL_CLASSIFICATION_CODE, int,>
           ,'OQ' -- <STANDARD_INDUSTRIAL_CLASSIFICATION_NAME, varchar(14),>
           ,'OR' -- <STATE_CODE, varchar(10),>
           ,'OS' -- <TICKER, varchar(8),>
           ,'OT' -- <TICKER_AND_EXCHANGE_CODE, varchar(11),>
           ,2147014 -- <TRADE_LOT_SIZE, int,>
           ,'OU' -- <TRADING_SYSTEM_IDENTIFIER, varchar(12),>
           ,'OV' -- <TRADING_SYSTEM_IDENTIFIER_NAME, varchar(25),>
           ,2147015 -- <VALOREN, int,>
           ,'OW' -- <WERTPAPIER, varchar(6),>
           ,2147016 -- <WHEN_ISSUED_FLAG, int,>
           ,GETDATE()
           ,GETDATE()
           ,'TEST'
           ,1
           ,GETDATE()
		)

-- SEC_ID 1001

INSERT INTO [dbo].[T_OVERRIDE_SECURITY]
           ([TOP_LEVEL_RUN_ID]
           ,[MASTER_TOP_LEVEL_RUN_ID]
           ,[SEC_ID]
           ,[APIR_IDENTIFICATION_CODE]
           ,[ASSET_TYPE]
           ,[BLOOMBERG_COMPANY_ID]
           ,[BLOOMBERG_COMPOSITE_GLOBAL_ID]
           ,[BLOOMBERG_EXCHANGE_CODE]
           ,[BLOOMBERG_GLOBAL_COMPANY_ID]
           ,[BLOOMBERG_GLOBAL_COMPANY_NAME]
           ,[BLOOMBERG_GLOBAL_ID]
           ,[BLOOMBERG_GLOBAL_SHARE_CLASS_ID]
           ,[BLOOMBERG_INDUSTRY_GROUP_CODE]
           ,[BLOOMBERG_INDUSTRY_GROUP_NAME]
           ,[BLOOMBERG_INDUSTRY_SECTOR_CODE]
           ,[BLOOMBERG_INDUSTRY_SECTOR_NAME]
           ,[BLOOMBERG_INDUSTRY_SUBGROUP_CODE]
           ,[BLOOMBERG_INDUSTRY_SUBGROUP_NAME]
           ,[BLOOMBERG_ISSUE_COUNTRY_CODE]
           ,[BLOOMBERG_MARKET_SECTOR_DESCRIPTION]
           ,[BLOOMBERG_MARKET_STATUS]
           ,[BLOOMBERG_MTF_COMPOSITE_GLOBAL_ID]
           ,[BLOOMBERG_MTF_PRIMARY_GLOBAL_ID]
           ,[BLOOMBERG_PARENT_COMPANY_ID]
           ,[BLOOMBERG_PRIMARY_COMPOSITE_GLOBAL_ID]
           ,[BLOOMBERG_PRIMARY_SECURITY_FLAG]
           ,[BLOOMBERG_PRIMARY_SECURITY_ID]
           ,[BLOOMBERG_PRIMARY_UNDERLYING_GLOBAL_ID]
           ,[BLOOMBERG_SECURITY_ID]
           ,[BLOOMBERG_UNDERLYING_GLOBAL_ID]
           ,[BLOOMBERG_UNIQUE_ID]
           ,[CLASSIFICATION_FINANCIAL_INSTRUMENTS_CODE]
           ,[COMMON_NUMBER]
           ,[COUNTRY_CALENDAR_CODE]
           ,[CUSIP]
           ,[DAYS_TO_SETTLE]
           ,[DOMICILE_ISO_COUNTRY_CODE]
           ,[EFFECTIVE_DATE]
           ,[EXCHANGE_CALENDAR_CODE]
           ,[FILE_NAME]
           ,[IDENTIFIER_NUMBER_DESCRIPTION]
           ,[INCORPORATION_ISO_COUNTRY_CODE]
           ,[IS_REMOVED_BLOOMBERG]
           ,[ISIN]
           ,[ISSUE_ISO_COUNTRY_CODE]
           ,[LOCAL_EXCHANGE_SYMBOL]
           ,[MIC_EXCHANGE_LOCAL_CODE]
           ,[MIC_EXCHANGE_PRIMARY_CODE]
           ,[NAICS_CODE]
           ,[PAR_AMOUNT]
           ,[PAR_VALUE_CCY]
           ,[PARENT_COMPANY_NAME]
           ,[PARENT_COMPANY_TICKER]
           ,[PARENT_INDUSTRY_GROUP]
           ,[PARENT_INDUSTRY_SECTOR]
           ,[PARENT_INDUSTRY_SUBGROUP]
           ,[POST_EURO_ISIN]
           ,[POST_EURO_PAR_AMOUNT]
           ,[POST_EURO_REDOMINATION_CCY]
           ,[PRE_EURO_ISIN]
           ,[PRE_EURO_PAR_AMOUNT]
           ,[PRE_EURO_REDOMINATION_CCY]
           ,[PRICING_FEED_SOURCE_CODE]
           ,[PRIMARY_EXCHANGE_CODE]
           ,[PRIMARY_EXCHANGE_NAME]
           ,[PRIVATE_PLACEMENT_INDICATOR]
           ,[QUOTE_LOT_SIZE]
           ,[REDENOMIATION_ROUNDING_METHOD]
           ,[REDENOMINATION_DATE]
           ,[REDENOMINATION_METHOD]
           ,[REGION_CODE]
           ,[ROUND_LOT_SIZE]
           ,[RULE_144A_INDICATOR]
           ,[SECURITY_DESCRIPTION]
           ,[CURRENCY_ISO_CODE]
           ,[SECURITY_NAME]
           ,[SECURITY_RESTRICTION]
           ,[SECURITY_SHORTNAME]
           ,[SECURITY_TYPE]
           ,[SECURITY_TYPE_DESCRIPTION]
           ,[SEDOL]
           ,[SEDOL_ISO_COUNTRY_CODE]
           ,[SEDOL2]
           ,[SEDOL2_ISO_COUNTRY_CODE]
           ,[SETTLEMENT_CALENDAR_CODE]
           ,[STANDARD_INDUSTRIAL_CLASSIFICATION_CODE]
           ,[STANDARD_INDUSTRIAL_CLASSIFICATION_NAME]
           ,[STATE_CODE]
           ,[TICKER]
           ,[TICKER_AND_EXCHANGE_CODE]
           ,[TRADE_LOT_SIZE]
           ,[TRADING_SYSTEM_IDENTIFIER]
           ,[TRADING_SYSTEM_IDENTIFIER_NAME]
           ,[VALOREN]
           ,[WERTPAPIER]
           ,[WHEN_ISSUED_FLAG]
           ,[CADIS_SYSTEM_INSERTED]
           ,[CADIS_SYSTEM_UPDATED]
           ,[CADIS_SYSTEM_CHANGEDBY]
           ,[CADIS_SYSTEM_PRIORITY]
           ,[CADIS_SYSTEM_LASTMODIFIED]
		)
     VALUES
           (2148000 -- <TOP_LEVEL_RUN_ID, int,>
           ,2148001 -- <MASTER_TOP_LEVEL_RUN_ID, int,>
           ,1001 -- <SEC_ID, int,>
           ,'PA' -- <APIR_IDENTIFICATION_CODE, varchar(9),>
           ,'PB' -- <ASSET_TYPE, varchar(10),>
           ,'PC' -- <BLOOMBERG_COMPANY_ID, varchar(8),>
           ,'PD' -- <BLOOMBERG_COMPOSITE_GLOBAL_ID, varchar(12),>
           ,'PE' -- <BLOOMBERG_EXCHANGE_CODE, varchar(18),>
           ,'PF' -- <BLOOMBERG_GLOBAL_COMPANY_ID, varchar(12),>
           ,'PG' -- <BLOOMBERG_GLOBAL_COMPANY_NAME, varchar(80),>
           ,'PH' -- <BLOOMBERG_GLOBAL_ID, varchar(12),>
           ,'PI' -- <BLOOMBERG_GLOBAL_SHARE_CLASS_ID, varchar(12),>
           ,2148002 -- <BLOOMBERG_INDUSTRY_GROUP_CODE, int,>
           ,'PJ' -- <BLOOMBERG_INDUSTRY_GROUP_NAME, varchar(24),>
           ,2148003 -- <BLOOMBERG_INDUSTRY_SECTOR_CODE, int,>
           ,'PK' -- <BLOOMBERG_INDUSTRY_SECTOR_NAME, varchar(22),>
           ,2148004 -- <BLOOMBERG_INDUSTRY_SUBGROUP_CODE, int,>
           ,'PL' -- <BLOOMBERG_INDUSTRY_SUBGROUP_NAME, varchar(24),>
           ,'PM' -- <BLOOMBERG_ISSUE_COUNTRY_CODE, varchar(2),>
           ,'PO' -- <BLOOMBERG_MARKET_SECTOR_DESCRIPTION, varchar(6),>
           ,'PP' -- <BLOOMBERG_MARKET_STATUS, varchar(6),>
           ,'PQ' -- <BLOOMBERG_MTF_COMPOSITE_GLOBAL_ID, varchar(12),>
           ,'PR' -- <BLOOMBERG_MTF_PRIMARY_GLOBAL_ID, varchar(12),>
           ,'PS' -- <BLOOMBERG_PARENT_COMPANY_ID, varchar(8),>
           ,'PT' -- <BLOOMBERG_PRIMARY_COMPOSITE_GLOBAL_ID, varchar(12),>
           ,2148005 -- <BLOOMBERG_PRIMARY_SECURITY_FLAG, int,>
           ,2148006 -- <BLOOMBERG_PRIMARY_SECURITY_ID, int,>
           ,'PU' -- <BLOOMBERG_PRIMARY_UNDERLYING_GLOBAL_ID, varchar(12),>
           ,'PV' -- <BLOOMBERG_SECURITY_ID, varchar(8),>
           ,'PW' -- <BLOOMBERG_UNDERLYING_GLOBAL_ID, varchar(12),>
           ,'PX' -- <BLOOMBERG_UNIQUE_ID, varchar(18),>
           ,'PY' -- <CLASSIFICATION_FINANCIAL_INSTRUMENTS_CODE, varchar(6),>
           ,2148007 -- <COMMON_NUMBER, int,>
           ,'PZ' -- <COUNTRY_CALENDAR_CODE, varchar(2),>
           ,'PA' -- <CUSIP, varchar(9),>
           ,2148008 -- <DAYS_TO_SETTLE, int,>
           ,'PB' -- , varchar(2),>
           ,'2018-01-01' -- <EFFECTIVE_DATE, datetime,>
           ,'PC' -- <EXCHANGE_CALENDAR_CODE, varchar(2),>
           ,'PD' -- <FILE_NAME, varchar(30),>
           ,'PE' -- <IDENTIFIER_NUMBER_DESCRIPTION, varchar(26),>
           ,'PF' -- <INCORPORATION_ISO_COUNTRY_CODE, varchar(4),>
           ,2148009 -- <IS_REMOVED_BLOOMBERG, int,>
           ,'PG' -- <ISIN, varchar(12),>
           ,'PH' -- <ISSUE_ISO_COUNTRY_CODE, varchar(2),>
           ,'PI' -- <LOCAL_EXCHANGE_SYMBOL, varchar(16),>
           ,'PJ' -- <MIC_EXCHANGE_LOCAL_CODE, varchar(13),>
           ,'PK' -- <MIC_EXCHANGE_PRIMARY_CODE, varchar(4),>
           ,'PL' -- <NAICS_CODE, varchar(6),>
           ,3.141 -- <PAR_AMOUNT, decimal(22,8),>
           ,'PM' -- <PAR_VALUE_CCY, varchar(3),>
           ,'PN' -- <PARENT_COMPANY_NAME, varchar(30),>
           ,'PO' -- <PARENT_COMPANY_TICKER, varchar(8),>
           ,'PP' -- <PARENT_INDUSTRY_GROUP, varchar(24),>
           ,'PQ' -- <PARENT_INDUSTRY_SECTOR, varchar(22),>
           ,'PR' -- <PARENT_INDUSTRY_SUBGROUP, varchar(24),>
           ,'PS' -- <POST_EURO_ISIN, varchar(12),>
           ,2.031 -- <POST_EURO_PAR_AMOUNT, decimal(22,8),>
           ,'PU' -- <POST_EURO_REDOMINATION_CCY, varchar(3),>
           ,'PV' -- <PRE_EURO_ISIN, varchar(12),>
           ,4.251 -- <PRE_EURO_PAR_AMOUNT, decimal(22,8),>
           ,'PW' -- <PRE_EURO_REDOMINATION_CCY, varchar(3),>
           ,'PX' -- <PRICING_FEED_SOURCE_CODE, varchar(4),>
           ,'PY' -- <PRIMARY_EXCHANGE_CODE, varchar(2),>
           ,'PZ' -- <PRIMARY_EXCHANGE_NAME, varchar(12),>
           ,'PA' -- <PRIVATE_PLACEMENT_INDICATOR, varchar(10),>
           ,5.361 -- <QUOTE_LOT_SIZE, decimal(22,8),>
           ,'PB' -- <REDENOMIATION_ROUNDING_METHOD, varchar(30),>
           ,'PC' -- <REDENOMINATION_DATE, varchar(19),>
           ,'PD' -- <REDENOMINATION_METHOD, varchar(16),>
           ,'PE' -- <REGION_CODE, varchar(5),>
           ,2148010 -- <ROUND_LOT_SIZE, int,>
           ,2148011 -- <RULE_144A_INDICATOR, int,>
           ,'PF' -- <SECURITY_DESCRIPTION, varchar(18),>
           ,'PG' -- <CURRENCY_ISO_CODE, varchar(3),>
           ,'PH' -- <SECURITY_NAME, varchar(100),>
           ,2148012 -- <SECURITY_RESTRICTION, int,>
           ,'PI' -- <SECURITY_SHORTNAME, varchar(50),>
           ,'PJ' -- <SECURITY_TYPE, varchar(16),>
           ,'PK' -- <SECURITY_TYPE_DESCRIPTION, varchar(20),>
           ,'PL' -- <SEDOL, varchar(7),>
           ,'PM' -- <SEDOL_ISO_COUNTRY_CODE, varchar(2),>
           ,'PN' -- <SEDOL2, varchar(7),>
           ,'PO' -- <SEDOL2_ISO_COUNTRY_CODE, varchar(2),>
           ,'PP' -- <SETTLEMENT_CALENDAR_CODE, varchar(2),>
           ,2148013 -- <STANDARD_INDUSTRIAL_CLASSIFICATION_CODE, int,>
           ,'PQ' -- <STANDARD_INDUSTRIAL_CLASSIFICATION_NAME, varchar(14),>
           ,'PR' -- <STATE_CODE, varchar(10),>
           ,'PS' -- <TICKER, varchar(8),>
           ,'PT' -- <TICKER_AND_EXCHANGE_CODE, varchar(11),>
           ,2148014 -- <TRADE_LOT_SIZE, int,>
           ,'PU' -- <TRADING_SYSTEM_IDENTIFIER, varchar(12),>
           ,'PV' -- <TRADING_SYSTEM_IDENTIFIER_NAME, varchar(25),>
           ,2148015 -- <VALOREN, int,>
           ,'PW' -- <WERTPAPIER, varchar(6),>
           ,2148016 -- <WHEN_ISSUED_FLAG, int,>
           ,GETDATE()
           ,GETDATE()
           ,'TEST'
           ,1
           ,GETDATE()
		)

-- SEC_ID 1002

INSERT INTO [dbo].[T_OVERRIDE_SECURITY]
           ([TOP_LEVEL_RUN_ID]
           ,[MASTER_TOP_LEVEL_RUN_ID]
           ,[SEC_ID]
           ,[APIR_IDENTIFICATION_CODE]
           ,[ASSET_TYPE]
           ,[BLOOMBERG_COMPANY_ID]
           ,[BLOOMBERG_COMPOSITE_GLOBAL_ID]
           ,[BLOOMBERG_EXCHANGE_CODE]
           ,[BLOOMBERG_GLOBAL_COMPANY_ID]
           ,[BLOOMBERG_GLOBAL_COMPANY_NAME]
           ,[BLOOMBERG_GLOBAL_ID]
           ,[BLOOMBERG_GLOBAL_SHARE_CLASS_ID]
           ,[BLOOMBERG_INDUSTRY_GROUP_CODE]
           ,[BLOOMBERG_INDUSTRY_GROUP_NAME]
           ,[BLOOMBERG_INDUSTRY_SECTOR_CODE]
           ,[BLOOMBERG_INDUSTRY_SECTOR_NAME]
           ,[BLOOMBERG_INDUSTRY_SUBGROUP_CODE]
           ,[BLOOMBERG_INDUSTRY_SUBGROUP_NAME]
           ,[BLOOMBERG_ISSUE_COUNTRY_CODE]
           ,[BLOOMBERG_MARKET_SECTOR_DESCRIPTION]
           ,[BLOOMBERG_MARKET_STATUS]
           ,[BLOOMBERG_MTF_COMPOSITE_GLOBAL_ID]
           ,[BLOOMBERG_MTF_PRIMARY_GLOBAL_ID]
           ,[BLOOMBERG_PARENT_COMPANY_ID]
           ,[BLOOMBERG_PRIMARY_COMPOSITE_GLOBAL_ID]
           ,[BLOOMBERG_PRIMARY_SECURITY_FLAG]
           ,[BLOOMBERG_PRIMARY_SECURITY_ID]
           ,[BLOOMBERG_PRIMARY_UNDERLYING_GLOBAL_ID]
           ,[BLOOMBERG_SECURITY_ID]
           ,[BLOOMBERG_UNDERLYING_GLOBAL_ID]
           ,[BLOOMBERG_UNIQUE_ID]
           ,[CLASSIFICATION_FINANCIAL_INSTRUMENTS_CODE]
           ,[COMMON_NUMBER]
           ,[COUNTRY_CALENDAR_CODE]
           ,[CUSIP]
           ,[DAYS_TO_SETTLE]
           ,[DOMICILE_ISO_COUNTRY_CODE]
           ,[EFFECTIVE_DATE]
           ,[EXCHANGE_CALENDAR_CODE]
           ,[FILE_NAME]
           ,[IDENTIFIER_NUMBER_DESCRIPTION]
           ,[INCORPORATION_ISO_COUNTRY_CODE]
           ,[IS_REMOVED_BLOOMBERG]
           ,[ISIN]
           ,[ISSUE_ISO_COUNTRY_CODE]
           ,[LOCAL_EXCHANGE_SYMBOL]
           ,[MIC_EXCHANGE_LOCAL_CODE]
           ,[MIC_EXCHANGE_PRIMARY_CODE]
           ,[NAICS_CODE]
           ,[PAR_AMOUNT]
           ,[PAR_VALUE_CCY]
           ,[PARENT_COMPANY_NAME]
           ,[PARENT_COMPANY_TICKER]
           ,[PARENT_INDUSTRY_GROUP]
           ,[PARENT_INDUSTRY_SECTOR]
           ,[PARENT_INDUSTRY_SUBGROUP]
           ,[POST_EURO_ISIN]
           ,[POST_EURO_PAR_AMOUNT]
           ,[POST_EURO_REDOMINATION_CCY]
           ,[PRE_EURO_ISIN]
           ,[PRE_EURO_PAR_AMOUNT]
           ,[PRE_EURO_REDOMINATION_CCY]
           ,[PRICING_FEED_SOURCE_CODE]
           ,[PRIMARY_EXCHANGE_CODE]
           ,[PRIMARY_EXCHANGE_NAME]
           ,[PRIVATE_PLACEMENT_INDICATOR]
           ,[QUOTE_LOT_SIZE]
           ,[REDENOMIATION_ROUNDING_METHOD]
           ,[REDENOMINATION_DATE]
           ,[REDENOMINATION_METHOD]
           ,[REGION_CODE]
           ,[ROUND_LOT_SIZE]
           ,[RULE_144A_INDICATOR]
           ,[SECURITY_DESCRIPTION]
           ,[CURRENCY_ISO_CODE]
           ,[SECURITY_NAME]
           ,[SECURITY_RESTRICTION]
           ,[SECURITY_SHORTNAME]
           ,[SECURITY_TYPE]
           ,[SECURITY_TYPE_DESCRIPTION]
           ,[SEDOL]
           ,[SEDOL_ISO_COUNTRY_CODE]
           ,[SEDOL2]
           ,[SEDOL2_ISO_COUNTRY_CODE]
           ,[SETTLEMENT_CALENDAR_CODE]
           ,[STANDARD_INDUSTRIAL_CLASSIFICATION_CODE]
           ,[STANDARD_INDUSTRIAL_CLASSIFICATION_NAME]
           ,[STATE_CODE]
           ,[TICKER]
           ,[TICKER_AND_EXCHANGE_CODE]
           ,[TRADE_LOT_SIZE]
           ,[TRADING_SYSTEM_IDENTIFIER]
           ,[TRADING_SYSTEM_IDENTIFIER_NAME]
           ,[VALOREN]
           ,[WERTPAPIER]
           ,[WHEN_ISSUED_FLAG]
           ,[CADIS_SYSTEM_INSERTED]
           ,[CADIS_SYSTEM_UPDATED]
           ,[CADIS_SYSTEM_CHANGEDBY]
           ,[CADIS_SYSTEM_PRIORITY]
           ,[CADIS_SYSTEM_LASTMODIFIED]
		)
     VALUES
           (2149000 -- <TOP_LEVEL_RUN_ID, int,>
           ,2149001 -- <MASTER_TOP_LEVEL_RUN_ID, int,>
           ,1002 -- <SEC_ID, int,>
           ,'QA' -- <APIR_IDENTIFICATION_CODE, varchar(9),>
           ,'QB' -- <ASSET_TYPE, varchar(10),>
           ,'QC' -- <BLOOMBERG_COMPANY_ID, varchar(8),>
           ,'QD' -- <BLOOMBERG_COMPOSITE_GLOBAL_ID, varchar(12),>
           ,'QE' -- <BLOOMBERG_EXCHANGE_CODE, varchar(18),>
           ,'QF' -- <BLOOMBERG_GLOBAL_COMPANY_ID, varchar(12),>
           ,'QG' -- <BLOOMBERG_GLOBAL_COMPANY_NAME, varchar(80),>
           ,'QH' -- <BLOOMBERG_GLOBAL_ID, varchar(12),>
           ,'QI' -- <BLOOMBERG_GLOBAL_SHARE_CLASS_ID, varchar(12),>
           ,2149002 -- <BLOOMBERG_INDUSTRY_GROUP_CODE, int,>
           ,'QJ' -- <BLOOMBERG_INDUSTRY_GROUP_NAME, varchar(24),>
           ,2149003 -- <BLOOMBERG_INDUSTRY_SECTOR_CODE, int,>
           ,'QK' -- <BLOOMBERG_INDUSTRY_SECTOR_NAME, varchar(22),>
           ,2149004 -- <BLOOMBERG_INDUSTRY_SUBGROUP_CODE, int,>
           ,'QL' -- <BLOOMBERG_INDUSTRY_SUBGROUP_NAME, varchar(24),>
           ,'QM' -- <BLOOMBERG_ISSUE_COUNTRY_CODE, varchar(2),>
           ,'QO' -- <BLOOMBERG_MARKET_SECTOR_DESCRIPTION, varchar(6),>
           ,'QP' -- <BLOOMBERG_MARKET_STATUS, varchar(6),>
           ,'QQ' -- <BLOOMBERG_MTF_COMPOSITE_GLOBAL_ID, varchar(12),>
           ,'QR' -- <BLOOMBERG_MTF_PRIMARY_GLOBAL_ID, varchar(12),>
           ,'QS' -- <BLOOMBERG_PARENT_COMPANY_ID, varchar(8),>
           ,'QT' -- <BLOOMBERG_PRIMARY_COMPOSITE_GLOBAL_ID, varchar(12),>
           ,2149005 -- <BLOOMBERG_PRIMARY_SECURITY_FLAG, int,>
           ,2149006 -- <BLOOMBERG_PRIMARY_SECURITY_ID, int,>
           ,'QU' -- <BLOOMBERG_PRIMARY_UNDERLYING_GLOBAL_ID, varchar(12),>
           ,'QV' -- <BLOOMBERG_SECURITY_ID, varchar(8),>
           ,'QW' -- <BLOOMBERG_UNDERLYING_GLOBAL_ID, varchar(12),>
           ,'QX' -- <BLOOMBERG_UNIQUE_ID, varchar(18),>
           ,'QY' -- <CLASSIFICATION_FINANCIAL_INSTRUMENTS_CODE, varchar(6),>
           ,2149007 -- <COMMON_NUMBER, int,>
           ,'QZ' -- <COUNTRY_CALENDAR_CODE, varchar(2),>
           ,'QA' -- <CUSIP, varchar(9),>
           ,2149008 -- <DAYS_TO_SETTLE, int,>
           ,'QB' -- , varchar(2),>
           ,'2018-01-01' -- <EFFECTIVE_DATE, datetime,>
           ,'QC' -- <EXCHANGE_CALENDAR_CODE, varchar(2),>
           ,'QD' -- <FILE_NAME, varchar(30),>
           ,'QE' -- <IDENTIFIER_NUMBER_DESCRIPTION, varchar(26),>
           ,'QF' -- <INCORPORATION_ISO_COUNTRY_CODE, varchar(4),>
           ,2149009 -- <IS_REMOVED_BLOOMBERG, int,>
           ,'QG' -- <ISIN, varchar(12),>
           ,'QH' -- <ISSUE_ISO_COUNTRY_CODE, varchar(2),>
           ,'QI' -- <LOCAL_EXCHANGE_SYMBOL, varchar(16),>
           ,'QJ' -- <MIC_EXCHANGE_LOCAL_CODE, varchar(13),>
           ,'QK' -- <MIC_EXCHANGE_PRIMARY_CODE, varchar(4),>
           ,'QL' -- <NAICS_CODE, varchar(6),>
           ,3.142 -- <PAR_AMOUNT, decimal(22,8),>
           ,'QM' -- <PAR_VALUE_CCY, varchar(3),>
           ,'QN' -- <PARENT_COMPANY_NAME, varchar(30),>
           ,'QO' -- <PARENT_COMPANY_TICKER, varchar(8),>
           ,'QP' -- <PARENT_INDUSTRY_GROUP, varchar(24),>
           ,'QQ' -- <PARENT_INDUSTRY_SECTOR, varchar(22),>
           ,'QR' -- <PARENT_INDUSTRY_SUBGROUP, varchar(24),>
           ,'QS' -- <POST_EURO_ISIN, varchar(12),>
           ,2.032 -- <POST_EURO_PAR_AMOUNT, decimal(22,8),>
           ,'QU' -- <POST_EURO_REDOMINATION_CCY, varchar(3),>
           ,'QV' -- <PRE_EURO_ISIN, varchar(12),>
           ,4.252 -- <PRE_EURO_PAR_AMOUNT, decimal(22,8),>
           ,'QW' -- <PRE_EURO_REDOMINATION_CCY, varchar(3),>
           ,'QX' -- <PRICING_FEED_SOURCE_CODE, varchar(4),>
           ,'QY' -- <PRIMARY_EXCHANGE_CODE, varchar(2),>
           ,'QZ' -- <PRIMARY_EXCHANGE_NAME, varchar(12),>
           ,'QA' -- <PRIVATE_PLACEMENT_INDICATOR, varchar(10),>
           ,5.362 -- <QUOTE_LOT_SIZE, decimal(22,8),>
           ,'QB' -- <REDENOMIATION_ROUNDING_METHOD, varchar(30),>
           ,'QC' -- <REDENOMINATION_DATE, varchar(19),>
           ,'QD' -- <REDENOMINATION_METHOD, varchar(16),>
           ,'QE' -- <REGION_CODE, varchar(5),>
           ,2149010 -- <ROUND_LOT_SIZE, int,>
           ,2149011 -- <RULE_144A_INDICATOR, int,>
           ,'QF' -- <SECURITY_DESCRIPTION, varchar(18),>
           ,'QG' -- <CURRENCY_ISO_CODE, varchar(3),>
           ,'QH' -- <SECURITY_NAME, varchar(100),>
           ,2149012 -- <SECURITY_RESTRICTION, int,>
           ,'QI' -- <SECURITY_SHORTNAME, varchar(50),>
           ,'QJ' -- <SECURITY_TYPE, varchar(16),>
           ,'QK' -- <SECURITY_TYPE_DESCRIPTION, varchar(20),>
           ,'QL' -- <SEDOL, varchar(7),>
           ,'QM' -- <SEDOL_ISO_COUNTRY_CODE, varchar(2),>
           ,'QN' -- <SEDOL2, varchar(7),>
           ,'QO' -- <SEDOL2_ISO_COUNTRY_CODE, varchar(2),>
           ,'QP' -- <SETTLEMENT_CALENDAR_CODE, varchar(2),>
           ,2149013 -- <STANDARD_INDUSTRIAL_CLASSIFICATION_CODE, int,>
           ,'QQ' -- <STANDARD_INDUSTRIAL_CLASSIFICATION_NAME, varchar(14),>
           ,'QR' -- <STATE_CODE, varchar(10),>
           ,'QS' -- <TICKER, varchar(8),>
           ,'QT' -- <TICKER_AND_EXCHANGE_CODE, varchar(11),>
           ,2149014 -- <TRADE_LOT_SIZE, int,>
           ,'QU' -- <TRADING_SYSTEM_IDENTIFIER, varchar(12),>
           ,'QV' -- <TRADING_SYSTEM_IDENTIFIER_NAME, varchar(25),>
           ,2149015 -- <VALOREN, int,>
           ,'QW' -- <WERTPAPIER, varchar(6),>
           ,2149016 -- <WHEN_ISSUED_FLAG, int,>
           ,GETDATE()
           ,GETDATE()
           ,'TEST'
           ,1
           ,GETDATE()
		)

-- SELECT * FROM dbo.T_OVERRIDE_SECURITY WHERE SEC_ID BETWEEN 1000 AND 1007

-- DELETE dbo.T_OVERRIDE_SECURITY WHERE SEC_ID BETWEEN 1000 AND 1007

GO


