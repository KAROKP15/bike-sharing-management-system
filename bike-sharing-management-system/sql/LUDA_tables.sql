USE LUDA;

/*车辆信息*/
DROP table IF EXISTS bikeInfo;
CREATE TABLE bikeInfo (  
bikeID CHAR(9) NOT NULL PRIMARY KEY, /*车辆编号*/  
state TINYINT(1) NOT NULL DEFAULT 0,  /*租借中1、空闲中0、待维修中-1、已下架-2*/  
bikeArea VARCHAR(100)/*投放区域*/
  );
 
/*用户信息*/
DROP table IF EXISTS userInfo;
CREATE TABLE userInfo (  
userID CHAR(9) NOT NULL PRIMARY KEY,  /*用户编号*/  
account VARCHAR(9) NOT NULL,     /*账号 */ 
password VARCHAR(9) NOT NULL,    /*密码*/ 
isVIP TINYINT(1) NOT NULL DEFAULT 0,  /*是VIP 1 不是 0*/  
area VARCHAR(100) NOT NULL,     /*当前区域*/  
balance TINYINT(5) NULL,	/*账户余额*/
email VARCHAR(30) NULL  /*注册邮箱*/
  );
   
/*会员信息*/
DROP table IF EXISTS VIPInfo;
CREATE TABLE VIPInfo (  
userID CHAR(9) REFERENCES userInfo(userID),  /*会员编号*/  
registTime DATE NOT NULL,  /*注册时间*/
invalidTime DATE NOT NULL   /*注册时间*/
  );

/*管理人员信息*/
DROP table IF EXISTS managerInfo;
CREATE TABLE managerInfo (  
managerID CHAR(9) NOT NULL PRIMARY KEY,  /*管理者编号*/  
account VARCHAR(9) NOT NULL,     /*账号 */ 
password VARCHAR(9) NOT NULL   /*密码*/ 
  );
  
/*维修人员信息*/  
DROP table IF EXISTS maintainerInfo;
CREATE TABLE maintainerInfo (  
maintainerID CHAR(9) NOT NULL PRIMARY KEY,  /*维修者编号*/  
account VARCHAR(9) NOT NULL,     /*账号 */ 
password VARCHAR(9) NOT NULL,    /*密码*/  
area VARCHAR(100) NOT NULL    /*管辖区域*/  
  );

/*车辆使用记录表*/  
DROP table IF EXISTS useRecord;
CREATE TABLE useRecord (  
no CHAR(9) NOT NULL PRIMARY KEY,  /*使用记录编号*/  
bikeID CHAR(9) REFERENCES bikeInfo(bikeID), 
userID CHAR(9) REFERENCES userInfo(userID),  /*使用者编号*/  
beginTime timestamp NULL,  /*使用开始时间*/
endTime timestamp NULL,  /*使用结束时间*/
timeLong TIME NULL, /*使用时长*/
mileage VARCHAR(5) NULL, /*里程*/
fee VARCHAR(3) NULL /*费用*/
  );  

/*车辆维修记录表*/  
DROP table IF EXISTS maintainRecord;
CREATE TABLE maintainRecord (  
no CHAR(9) NOT NULL PRIMARY KEY,  /*维修编号*/  
bikeID CHAR(9) REFERENCES bikeInfo(bikeID), 
maintainerID CHAR(9) REFERENCES maintainerInfo(maintainerID),
maintainState TINYINT(1) NULL,	/*待维修0、已维修1*/
maintainTime timestamp NULL  /*维修结束时间*/
  );