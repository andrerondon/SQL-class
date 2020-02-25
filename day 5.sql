CREATE TABLE owner(
   id serial PRIMARY KEY,
   username VARCHAR (50) UNIQUE NOT NULL,
   password VARCHAR (50) NOT NULL,
   first_name VARCHAR (20) NOT NULL,
   last_name VARCHAR (20) NOT NULL,
   email VARCHAR (355) UNIQUE NOT NULL
);
