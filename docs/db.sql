PRAGMA foreign_keys = OFF;
drop table if exists  Environments;
drop table if exists Encounters;
PRAGMA foreign_keys = ON;

 -- Environments Table
CREATE TABLE IF NOT EXISTS Environments (
    EnvironmentID INTEGER PRIMARY KEY,
    Name TEXT	CHECK( Name  IN  ('FOREST',
	                                                                   'CAVES',
																	   'CITY_EXTERIOR',
																	   'CITY_INTERIOR',
																	   'CRYPT',
																	   'DESERT',
																	   'SEWER',
																	   'FROZEN',
																	   'DUNGEON',
																	   'UNDERDARK',
																	   'RUINS',
																	   'HAUNTED') )
);

 -- Adding environments
 INSERT INTO Environments ( Name ) values
 ('CAVES'), ( 'FOREST') ,('RUINS'), ('HAUNTED'),('CITY_EXTERIOR'), ('CITY_INTERIOR'),
 ('DUNGEON'),('CRYPT'), ('DESERT'), ('FROZEN'), ('UNDERDARK'), ('SEWER');
select * from Environments;

 CREATE TABLE IF NOT EXISTS Encounters (
    EncounterID INTEGER PRIMARY KEY,
    LVL INTEGER,
   CreatureID INTEGER,
   EnvironmentID INTEGER,
    FOREIGN KEY (CreatureID) REFERENCES creatures(id),
    FOREIGN KEY (EnvironmentID) REFERENCES Environments(EnvironmentID)
);




SELECT
 TemplateResRef, ChallengeRating
FROM Encounters
JOIN Creatures ON Encounters.CreatureID = Creatures.id and Encounters.LVL >= 0 and Encounters.LVL <=5
JOIN Environments ON Encounters.EnvironmentID = Environments.EnvironmentID
WHERE Environments.Name = 'FOREST' order by random() limit 1;
