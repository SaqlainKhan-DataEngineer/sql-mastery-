CREATE TABLE players (
    player_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE games (
    game_id INT PRIMARY KEY,
    name VARCHAR(50),
    type VARCHAR(50)
);

CREATE TABLE plays (
    play_id INT PRIMARY KEY,
    player_id INT,
    game_id INT,
    score INT
);

INSERT INTO players VALUES
(1,'Ali'),
(2,'Saqlain'),
(3,'Ahmed'),
(4,'Sara'),
(5,'Hina');

INSERT INTO games VALUES
(1,'Chess','Mind'),
(2,'Cricket','Sport'),
(3,'Football','Sport'),
(4,'Ludo','Casual'),
(5,'Coding','Tech');

INSERT INTO plays VALUES
(1,1,1,80),
(2,1,2,70),
(3,1,1,85),
(4,2,3,60),
(5,2,3,65),
(6,2,4,75),
(7,3,5,90),
(8,3,5,95),
(9,4,1,88),
(10,5,2,50),
(11,5,3,55),
(12,5,4,60); 
select * from players 
select * from plays 
select * from games 

-- players jinhone exactly 2 different games khele ho  
select 
pl.player_id,pl.name 
from players as pl
left join plays as p 
on pl.player_id=p.player_id 
group by pl.player_id,pl.name 
having count(distinct game_id)=2 
/* players jinhone sirf 1 type ke games khele ho
aur total plays ≥ 2 */  
select 
pl.player_id,pl.name 
from players as pl
join plays as p 
on pl.player_id=p.player_id  
join games as g 
on p.game_id=g.game_id
group by pl.player_id,pl.name 
having count(distinct g.type)=1 and count(play_id)>=2
/*players jinhone:

3 ya zyada plays kiye ho
aur har play me different game ho */ 
select 
pl.player_id,pl.name 
from players as pl
left join plays as p 
on pl.player_id=p.player_id 
group by pl.player_id,pl.name 
having count(p.play_id)>=3 and count(distinct p.game_id)=count(p.play_id) 
/*players jinhone:

exactly 3 plays kiye ho
aur:
2 plays same game ke ho
1 play different game ka ho */
select 
pl.player_id,pl.name 
from players as pl
left join plays as p 
on pl.player_id=p.player_id 
group by pl.player_id,pl.name 
having count(p.play_id)=3 and count(distinct p.game_id)+1=count(p.play_id)  
/*games lao:

jo sirf 1 player ne khele ho
aur us player ne us game ko multiple times khela ho*/  

select g.game_id,g.name 
from games as g 
left join plays as p 
on g.game_id=p.game_id 
group by g.game_id,g.name 
having count(distinct p.player_id)=1 and count(play_id)>1 

/*players jinhone:

2 ya zyada games khele ho
lekin sirf 1 game repeat hua ho */
select 
pl.player_id,pl.name 
from players as pl
left join plays as p 
on pl.player_id=p.player_id 
group by pl.player_id,pl.name 
having count(p.play_id)>=2 and count(distinct p.game_id)+1=count(p.play_id)   

/*players jinhone:

total plays = distinct games */ 
select 
pl.player_id,pl.name 
from players as pl
left join plays as p 
on pl.player_id=p.player_id 
group by pl.player_id,pl.name 
having count(p.play_id)=count(distinct p.game_id)
/*players jinhone:

total plays = distinct games + 2*/ 
select 
pl.player_id,pl.name 
from players as pl
left join plays as p 
on pl.player_id=p.player_id 
group by pl.player_id,pl.name 
having count(p.play_id)=count(distinct p.game_id)+2
