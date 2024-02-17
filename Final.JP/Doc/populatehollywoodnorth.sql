--
-- Script to populate hollywood north with some sample data
--
rem set language to english to avoid problems with non-english machines
alter session set NLS_LANGUAGE = ENGLISH;
rem delete data first, children first, parents second

delete from hn_entertainergig;
delete from hn_client;
delete from hn_agent;
delete from hn_entertainermusicalstyles;
delete from hn_musicalstyles;
delete from hn_entertainer;
delete from hn_manager;
delete from hn_type;

rem Agent Tables (2 Agents)
rem

rem Managers
rem Tammy S. Johnson - Jeff Dunham, Dave Chappelle, Chris Rock
rem Oliver El-Khatib - Drake, Jay-Z
rem Scooter Braun - Justin Beiber

insert into hn_manager values (1, 'Tammy', 'Johnson', 'Laughs R on Us', '403.234.3844',
   '403.234.4948', 'tammy@laughRonus.com');
insert into hn_manager values (2, 'Oliver', 'El-Khatib', 'R U Serious...yo', '416.444.3234',
   '416.777.7777', 'rap@ruserious.com');
insert into hn_manager values (3, 'Scooter', 'Braun', 'Nice Guy Records', '416.423.2345',
    '416.454.4545', 'scooter@niceguys.com');

rem Entertainer Types

rem the types: Comedian, Singer, Singer/Pianist, Electric Guitar, Bass Guitar, Magician
insert into hn_type values (1, 'Comedian');
insert into hn_type values (2, 'Singer');
insert into hn_type values (3, 'Singer/Pianist');
insert into hn_type values (4, 'Electric Guitar');
insert into hn_type values (5, 'Bass Guitar');
insert into hn_type values (6, 'Magician');

rem entertainers
rem Tammy S. Johnson - Jeff Dunham, Dave Chappelle, Chris Rock
rem Oliver El-Khatib - Drake, Jay-Z, Chance the Rapper
rem Scooter Braun - Justin Beiber

insert into hn_entertainer values (1, 1, 1, 'Jeff', 'Dunham', 'Jeff Dunham', 'Puppet Ventriloquist',
  '214.233.3456', '214.255.4432', 'achmedthedeadterrorist@puppets.com');
insert into hn_entertainer values (2, 1, 1, 'Dave', 'Webber', 'Dave Chappelle', 'Stand-up Comedy',
  '416.333.2345', '416.234.4875', 'famous@chappelleenterprises.com');
insert into hn_entertainer values (3, 1, 1, 'Chris', 'Rock', 'Chris Rock', 'Stand-up Comedy',
   '843.234.1957', '843.234.1984', 'demonsanddarkmoods@chris.rock.com');
insert into hn_entertainer values (4, 2, 2, 'Aubrey', 'Graham', 'Drake', 'Rap Singer',
   '416.543.3456', '416.234.1223', 'countyourblessings@drake.com');
insert into hn_entertainer values (5, 2, 2, 'Shawn', 'Carter', 'Jay-Z', 'Rap Singer',
   '768.364.1283', '768.234.5943', 'hip-hop@jayz.com');
insert into hn_entertainer values (6, 2, 3, 'Justin', 'Bieber', 'Justin Bieber', 'Multi-instrumentalist Singer',
   '416.345.5676', '416.394.3948', 'workpraybelieve@biebs.com');

rem musical styles
rem set of styles: Rock, Rap, 80s, 90s, 2000s, Top 40, Jazz, Classical, Pop

insert into hn_musicalStyles values (1, 'Rock');
insert into hn_musicalStyles values (2, 'Rap');
insert into hn_musicalStyles values (3, '80s');
insert into hn_musicalStyles values (4, '90s');
insert into hn_musicalStyles values (5, '2000s');
insert into hn_musicalStyles values (6, 'Top 40');
insert into hn_musicalStyles values (7, 'Jazz');
insert into hn_musicalStyles values (8, 'Classical');
insert into hn_musicalStyles values (9, 'Pop');

rem 
rem set entertainer styles 
rem Oliver El-Khatib - Drake-4 (Rock, Rap, Top-40), Jay-Z-5 (Rap)
rem Scooter Braun - Justin Beiber-6 (Top 40, Rap, Pop, 2000s)

insert into hn_entertainerMusicalStyles values (1, 4);
insert into hn_entertainerMusicalStyles values (2, 4);
insert into hn_entertainerMusicalStyles values (6, 4);

insert into hn_entertainerMusicalStyles values (2,5);

insert into hn_entertainerMusicalStyles values (6, 6);
insert into hn_entertainerMusicalStyles values (2, 6);
insert into hn_entertainerMusicalStyles values (9, 6);
insert into hn_entertainerMusicalStyles values (5, 6);

rem Client Agents
rem Sara Lace, Harvey Wallbanger, Jimmy Kricket


insert into hn_agent values (1,'Sara', 'Lace', to_date('01-jan-15', 'dd-mon-yy'), 
   '403.234.3988', '587.384.2933', 'sara@hollywoodnorth.com');
insert into hn_agent values (2, 'Harvey', 'Wallbanger', to_date('15-jun-02', 'dd-mon-yy'),
   '403.234.3989', '587.988.2734', 'harvey@hollywoodnorth.com');

insert into hn_agent values (3, 'Jimmy', 'Kricket', to_date('20-may-20', 'dd-mon-yy'),
   '403.234.3987', '587.389.8934', 'jimmy@hollywoodnorth.com');

rem Agents-clients
rem Harvey Wallbanger - johnny gaudreau, TJ Miller
rem Jimmy Kricket - Eddie Davis
rem Harvey Wallbanger (2) - Auston Matthews (4), Elias Pettersson (5)

insert into hn_client values (1,2,'Johnny', 'Gaudreau', '403.233.2345', '403.234.5855',
  'johnnyhockey@calgaryflames.com');
insert into hn_client values (2,2, 'TJ', 'Miller', '587.345.2856',  '587.266.2395', 'TJMiller@gmail.com');
insert into hn_client values (3,3, 'Eddie', 'Davis', '403.294.4833', '403.285.2759',
   'eddie.davis@gmail.com');
insert into hn_client values (4,2, 'Auston', 'Matthews', '480.384.3988', '480.222.4339',
   'toronto34@gmail.com');
insert into hn_client values (5,2, 'Elias', 'Pettersson', '604.988.4637', '604.404.4040',
   'youngstar@gmail.com');

rem johnny gaudreau(1) - Chris Rock (3) , May 21, 2021 4:00 PM
rem johnny gaudreau(1) - Drake (4), May 22, 2021 8 PM
rem
rem Eddie Davis(3) - Jeff Durham (1), July 1, 2021 12:00 pm
rem 
rem TJ Hiller(2) - Justin Beiber (6), July 1, 2021 10:00 pm
rem TJ Hiller(2) - Drake (4), July 1, 2021 8 PM

insert into hn_entertainerGig values (3,1, to_date('21-may-21 4:00 pm', 'dd-Mon-yy hh:mi pm'),
    5000, 3000, '555 Saddledome Rise SE', 'Calgary', 'AB', 'T2G2W1');

insert into hn_entertainerGig values (4,1, to_date('22-may-21 8:00 pm', 'dd-Mon-yy hh:mi pm'),
    5000, 3000, '555 Saddledome Rise SE', 'Calgary', 'AB', 'T2G2W1');

insert into hn_entertainerGig values (1,3, to_date('01-jul-21 8:00 pm', 'dd-Mon-yy hh:mi pm'),
    4000, 3000, '1020 8 Ave SW', 'Calgary', 'AB', 'T2P1J2');

insert into hn_entertainerGig values (6, 2, to_date('22-may-21 8:00 pm', 'dd-Mon-yy hh:mi pm'),
    6000, 3000, '215 8 Ave SE', 'Calgary', 'AB', 'T2G0K8');

insert into hn_entertainerGig values (4, 2, to_date('22-may-21 10:00 pm', 'dd-Mon-yy hh:mi pm'),
    10000, 8000,'215 8 Ave SE', 'Calgary', 'AB', 'T2G0K8');


rem Auston Matthews(4), Drake (4), Aug 2, 2021 6 pm
rem Scotiacenter Toronto, ON 

insert into hn_entertainerGig values (4, 4, to_date('2-aug21 6:00 pm', 'dd-Mon-yy hh:mi pm'),
    10000, 6000, '40 Bay St', 'Toronto', 'ON', 'M5J2X2');

rem Elias Petterrson(5) - Jay-Z(5), Aug 2, 2021 10 pm
rem Libra Room Vancouver , Vancouver, BC V5L 3Y4

insert into hn_entertainerGig values (5, 5, to_date('2-aug21 10:00 pm', 'dd-Mon-yy hh:mi pm'),
    7000, 5000, '1608 Commercial Dr', 'Vancouver', 'BC', 'V5L3Y4');

rem 
commit;
