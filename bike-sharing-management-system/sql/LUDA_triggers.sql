use LUDA;

/*车状态*/
DROP TRIGGER IF EXISTS bikeState;
DELIMITER $$
CREATE TRIGGER bikeState
AFTER UPDATE 
ON bikeInfo  
FOR EACH ROW
BEGIN
#得到当前no
DECLARE tmp int;

SELECT no INTO tmp FROM useRecord 
#WHERE no <> NULL
ORDER BY no DESC 
LIMIT 1;  

 #getUserID()

IF old.state=0 AND new.state=1 THEN  #.state *0->1*，！
INSERT INTO useRecord
VALUES (tmp+1 , new.bikeID , '000001' , now() , NULL , NULL , NULL , NULL );

ELSEIF old.state=1 AND new.state=0 THEN  #.state *1->0*，！
UPDATE useRecord
SET endTime = now(), 
timeLong = TIMESTAMPDIFF(MINUTE, beginTime, endTime),
mileage = 2,  #=getMileage(),
fee = 2  #=getFee();
WHERE bikeID = new.bikeID;
END IF;
END $$
DELIMITER ;

/*增加VIP，！*/
DROP TRIGGER IF EXISTS vipAdd;
DELIMITER $$
CREATE TRIGGER vipAdd
AFTER INSERT 
ON VIPInfo  
FOR EACH ROW
BEGIN
UPDATE userInfo
SET isVIP = 1
WHERE userInfo.userID = new.userID;
END $$
DELIMITER ;

/*删除VIP，！*/
DROP TRIGGER IF EXISTS vipDel;
DELIMITER $$
CREATE TRIGGER vipDel
AFTER DELETE 
ON VIPInfo  
FOR EACH ROW
BEGIN
UPDATE userInfo
SET isVIP = 0
WHERE userInfo.userID = old.userID;
END $$
DELIMITER ;

/*维修中，！*/
DROP TRIGGER IF EXISTS maintainStateChange;
DELIMITER $$
CREATE TRIGGER maintainStateChange
AFTER UPDATE 
ON maintainRecord #.maintainState
FOR EACH ROW
BEGIN
IF new.maintainState = 0 THEN  #待维修，！
UPDATE bikeInfo
SET state = -1
WHERE bikeID = new.bikeID;
ELSEIF new.maintainState = 1 THEN  #维修完成，！
UPDATE bikeInfo
SET state = 0
WHERE bikeID = new.bikeID;
END IF;
END $$
DELIMITER ;

/*余额变化，！*/
DROP TRIGGER IF EXISTS balanceChange;
DELIMITER $$
CREATE TRIGGER balanceChange
AFTER UPDATE 
ON useRecord
FOR EACH ROW
BEGIN
UPDATE userInfo
SET balance = balance - new.fee
WHERE userID = new.userID;
END $$
DELIMITER ;