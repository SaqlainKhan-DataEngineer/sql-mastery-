CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE subjects (
    subject_id INT PRIMARY KEY,
    name VARCHAR(50),
    category VARCHAR(50)
);

CREATE TABLE enrollments (
    enroll_id INT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    marks INT
);

INSERT INTO students VALUES
(1,'Ali'),
(2,'Saqlain'),
(3,'Ahmed'),
(4,'Sara'),
(5,'Hina');

INSERT INTO subjects VALUES
(1,'Math','Science'),
(2,'Physics','Science'),
(3,'English','Arts'),
(4,'History','Arts'),
(5,'CS','Tech');

INSERT INTO enrollments VALUES
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


select * from enrollments 
select * from students 
select * from subjects   
--students jinhone exactly 2 different subjects liye ho
select s.student_id,s.name 
from students as s
left join enrollments as e 
on s.student_id=e.student_id 
group by s.student_id,s.name 
having count(distinct subject_id)=2  
/* students jinhone sirf 1 category se subjects liye ho
aur total enrollments ≥ 2 */ 
select s.student_id,s.name 
from students as s 
inner join enrollments as e
on s.student_id=e.subject_id 
inner join subjects as sb
on e.subject_id=sb.subject_id
group by  s.student_id,s.name  
having count(distinct sb.category)=1  and count( e.enroll_id)>=2 
/* students jinhone 3 ya zyada enrollments kiye ho
aur har baar different subject ho */ 
select s.student_id,s.name 
from students as s  
left join enrollments as e 
on s.student_id=e.student_id 
group by s.student_id,s.name  
having count(e.enroll_id)>=3 and  count(distinct e.subject_id) =count(e.enroll_id) 
/*students jinhone exactly 3 enrollments kiye ho
aur un me:

2 baar same subject
1 baar different subject */ 
select s.student_id,s.name 
from students as s  
left join enrollments as e 
on s.student_id=e.student_id 
group by s.student_id,s.name  
having count(e.enroll_id)=3 and  count(e.enroll_id) = count(distinct e.subject_id)+1 
/* subjects lao:

jo sirf 1 student ne liye ho
aur us student ne us subject ko multiple times liya ho */ 
select sb.subject_id,sb.name  
from subjects as sb 
left join enrollments as e 
on sb.subject_id=e.subject_id 
group by sb.subject_id,sb.name 
having count(distinct e.student_id)=1 and count(distinct e.enroll_id)>1 

/* students jinhone:

2 ya zyada subjects liye ho
lekin sirf 1 subject repeat hua ho */ 
select s.student_id,s.name
from students as s  
left join enrollments as e 
on s.student_id=e.student_id 
group by s.student_id,s.name  
having count(e.enroll_id)>=2 and  count(distinct e.subject_id)+1 =count(e.enroll_id)  
/*students jinhone:

total enrollments = distinct subjects*/ 
select s.student_id,s.name 
from students as s  
left join enrollments as e 
on s.student_id=e.student_id 
group by s.student_id,s.name  
having  count(distinct e.subject_id) =count(e.enroll_id)  

/*students jinhone:

total enrollments > distinct subjects
aur difference = 2 ho */ 
select s.student_id,s.name 
from students as s  
left join enrollments as e 
on s.student_id=e.student_id 
group by s.student_id,s.name  
having count(e.enroll_id)=count(distinct e.subject_id) +2 
