-- FOREST
-- bears
insert into Encounters
select   NULL, ChallengeRating, id, 2  from creatures where FirstName like '%bear%';
-- spiders
insert into Encounters
select NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%spider%';

-- goblins
insert into Encounters
select NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%goblin%';

-- orc
insert into Encounters
select NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%orc%';
-- gnoll
insert into Encounters
select NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%gnoll%';

--treant
insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%treant%';

-- satyr
insert into Encounters
select NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%satyr%';

-- pixie
insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%pixie%' and _FactionName = 'Hostile';
-- Nymph
insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%nymph%' and _FactionName = 'Hostile';


insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%boar%'
                            and _FactionName = 'Hostile';

insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%hill%'
                            and _FactionName = 'Hostile';

insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%green dragon Adult'
                            and _FactionName = 'Hostile';


insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%worg%'
                            and _FactionName = 'Hostile';

insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%beetle%'
                            and _FactionName = 'Hostile';


insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%leech%'
                            and _FactionName = 'Hostile';

insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%Rat'
                            and _FactionName = 'Hostile';

insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%frog%'
                            and _FactionName = 'Hostile';

insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%badger%'
                            and _FactionName = 'Hostile';


insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%eagle%'
                            and _FactionName = 'Hostile';

insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%scorpion%'
                            and _FactionName = 'Hostile';

insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%hawk%'
                            and _FactionName = 'Hostile';


insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%lizard%'
                            and _FactionName = 'Hostile';

insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%crab%'
                            and _FactionName = 'Hostile';

insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%wasp%'
                            and _FactionName = 'Hostile';

insert into Encounters
select  NULL,  ChallengeRating, id , 2 from creatures where FirstName like '% ant%'
                            and _FactionName = 'Hostile';



--select  FirstName, NULL,  ChallengeRating, id , 2 from creatures where FirstName like '%trap%'
 --                           and _FactionName = 'Hostile';
