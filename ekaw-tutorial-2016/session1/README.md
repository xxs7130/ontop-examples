First session: Basics of OBDA System Modeling and Usage
=======================================================

In this hands-on session, we are considering fragments of the information systems
of some universities, that is, some information about students, academic staff and courses.


Requirements
------------

* Java 8
* [Protégé bundle with Ontop 1.18](https://sourceforge.net/projects/ontop4obda/files/ontop-1.18.0/ontop-protege-bundle-1.18.0.zip/download) (TODO: should use a special version?)
* [H2 (relational database)](https://sourceforge.net/projects/ontop4obda/files/sample-data/) TODO: update the link


First data source: university 1
--------------------------------

As a first step, we focus on the database of a first university. It has
the prefix "uni1".
It is composed of 4 tables.

#### *uni1.student*

The table *uni1.student* contains the local ID, first and last names of the students.

s_id | first_name |  last_name
---- | ---------- | ----------
  1  | Mary       | Smith
  2  | John       | Doe

The column *s_id* is a primary key.  

#### *uni1.academic*

Similarly, the table *uni1.academic* contains the local ID,
first and last names of the academic staff, but also information about their position.

a_id | first_name |  last_name | position
---- | ---------- | ---------- | --------
  1  | Anna       | Chambers   | 1
  2  | Edward     | May        | 9
  3  | Rachel     | Ward       | 8

The column *position* is populated of magic numbers:
  - 1 -> Full Professor
  - 2 -> Associate Professor
  - 3 -> Assistant Professor
  - 4 -> ?
  - 5 -> ?
  - 6 -> ?
  - 7 -> ?
  - 8 -> External Teacher
  - 9 -> PostDoc

The column *a_id* is a primary key.

#### *uni1.course*

The table *uni1.course* contains the local ID
and the title of the courses.

c_id | title
---- | -----
1234 | Linear Algebra

The column *c_id* is a primary key.

#### *uni1.teaching*

The table *uni1.teaching* contains the n-n relation
between courses and teachers.

c_id | a_id
---- | ----
1234 | 1
1234 | 2

There is no primary key, but two foreign keys to the tables *uni1.course* and *uni1.academic*.

## Database setup

Procedure:

1. Unzip the archive of H2 *(h2.zip)*
2. Start the database:
   * On Mac/Linux: open a terminal, go into *h2/bin* and run `sh h2.sh`
   * On Windows: click on the executable `h2w.bat`
3. After being automatically redirect to the web interface of H2, connect with the default parameters:
     * JDBC URL:  *jdbc:h2:tcp://localhost/./helloworld*
     * User name: *sa*
     * No password

4. Create the table *tbl_patient* by executing the following query:

```sql
CREATE TABLE "tbl_patient" (
patientid INT NOT NULL PRIMARY KEY,
name VARCHAR(40) NOT NULL,
type BOOLEAN NOT NULL,
stage TINYINT NOT NULL
)
```

5- Insert some entries:

```sql
INSERT INTO "tbl_patient"
(patientid,name,type,stage) VALUES
(1,'Mary',false, 4),
(2,'John',true, 1);
```

6- Try a first SQL query: "Give me all patients that have a NSCLC at stage IIIa"

```sql
SELECT patientid
FROM "tbl_patient"
WHERE stage = 4 AND type = false
```

Ontology: classes and properties
--------------------------------


0. Unzip the Protégé archive and go into its folder
1. Run it (*run.bat* on Windows, *run.sh* on Mac/Linux)
2. Register the H2 JDBC driver: go to "Preferences", "JDBC Drivers" and add an entry with the following information
     * Description: *h2*
     * Class Name: *org.h2.Driver*
     * Driver file (jar): */path/to/h2/bin/h2-1.3.176.jar*

3. Download [this OWL ontology file](https://github.com/ontop/ontop-examples/blob/master/swj-2015/PatientOnto.owl).
4. Go to "File/Open..." to load the ontology file.
5. In the tab "Classes" you can visualize the class hierarchy
6. In the tab "Object properties" you can see the properties *hasNeoplasm* and *hasStage*
7. In the tab "Data properties" you can see the property *hasName*


Mappings
--------

1. Go to the "Ontop mapping" tab
2. Add a new data source (give it a name, e.g., *PatientDB*)
3. Define the connection parameters as follows:
    * Connection URL: *jdbc:h2:tcp://localhost/./helloworld*
    * Username: *sa*
    * Password: (leave empty)
    * Driver class: *org.h2.Driver* (choose it from the drop down menu)
4. Test the connection using the “Test Connection” button
5. Switch to the “Mapping Manager” tab in the ontop mappings tab
6. Select your datasource
7. Click on "Create" to create a new mapping


#### Mapping 1a: Patient
 * Target:
```turtle
inst:ds1/{patientid} a :Patient ; :hasName {name}^^xsd:string .
```
 * Source:
```sql
SELECT patientid, name
FROM "tbl_patient"
```

#### Mapping 2a: Neoplasm
 * Target:
```turtle
inst:ds1/{patientid} :hasNeoplasm inst:ds1/neoplasm/{patientid}.
```
 * Source:
```sql
SELECT patientid
FROM "tbl_patient"
```

#### Mapping 3a: NSCLC
 * Target:
```turtle
inst:ds1/neoplasm/{patientid} a :NSCLC .
```
 * Source:
```sql
SELECT patientid
FROM "tbl_patient"
WHERE type = false
```

#### Mapping 4a: SCLC
 * Target:
```turtle
inst:ds1/neoplasm/{patientid} a :SCLC .
```
 * Source:
```sql
SELECT patientid
FROM "tbl_patient"
WHERE type = true
```

#### Mapping 5a: Stage IIIa
 * Target:
```turtle
inst:ds1/neoplasm/{patientid} :hasStage inst:stage-IIIa .
```
 * Source:
```sql
SELECT patientid
FROM "tbl_patient"
WHERE stage = 4 AND type = false
```

Similarly to the mapping 5, seven additional mappings can be added
for the other stages.


# SPARQL

1. Select Quest (Ontop) in the “Reasoner” menu
2. Start the reasoner
3. Run the following query:
```sparql
PREFIX : <http://example.org/hospital#>
PREFIX inst: <http://example.org/hospital/instances/>

SELECT ?name
WHERE {
  ?p a :Patient ;
     :hasName ?name ;
     :hasNeoplasm ?tumor .
  ?tumor :hasStage inst:stage-IIIa .
}
```

Tip: do a right click on the SPARQL query field to visualize the generated SQL query.

### Inference

Ontop embeds some inference capabilities and is thus capable of answering a query as follows:
```sparql
PREFIX : <http://example.org/hospital#>

SELECT ?x
WHERE {
   ?x a :Neoplasm .
}
```

These inference capabilities can be, for a large part, understood as the ability to infer new mappings
from the original mappings and the ontological axioms.

To convince yourself:

1- Change the target of the mapping 1a by the following:
```turtle
:db1/{patientid} :hasName {name}^^xsd:string .    
```

2- Stop and start the reasoner.

3- Run the following query:
```sparql
PREFIX : <http://example.org/hospital#>

SELECT ?p WHERE {
   ?p a :Patient .
}
```

4- You should find all the patients in the list. The inferred mapping has been derived from the mapping 2 and the domain of the property *hasNeoplasm*.



# Second dataset

We now consider a second dataset also describing patients having a lung cancer.
However, this dataset has a different schema, composed of 3 tables:

*T_NAME*: describe the patient

PID | NAME
--- | ----
 1  |  Anna
 2  |  Mike
 3  |  Roger
 4  |  Jane

*T_NSCLC* : describe a NSCLC. *PID* is a foreign key refering to *T_NAME.PID*

PID | STAGE
--- | -------
 1  | three-a
 2  | one

*T_SCLC* : describe a SCLC. *PID* is a foreign key refering to *T_NAME.PID*

PID | STAGE
--- | ------
 3  |   Lim
 4  |   Ext


1- Create the new tables (in H2)

```sql
CREATE TABLE T_Name (
PID INT NOT NULL PRIMARY KEY,
NAME VARCHAR(40)
);

CREATE TABLE T_NSCLC (
PID INT NOT NULL PRIMARY KEY,
STAGE VARCHAR(40)
);

CREATE TABLE T_SCLC (
PID INT NOT NULL PRIMARY KEY,
STAGE VARCHAR(40)
);

ALTER TABLE T_NSCLC
ADD FOREIGN KEY (PID) REFERENCES T_Name(PID);

ALTER TABLE T_SCLC
ADD FOREIGN KEY (PID) REFERENCES T_Name(PID);
```

2 - Populate them
```sql

INSERT INTO T_NAME
(PID,NAME) VALUES
(1,'Anna'),
(2,'Mike'),
(3, 'Roger'),
(4, 'Jane');

INSERT INTO T_NSCLC
(PID,STAGE) VALUES
(1,'three-a'),
(2,'one');

INSERT INTO T_SCLC
(PID,STAGE) VALUES
(3,'Lim'),
(4,'Ext');
```

## New mappings


#### Mapping 1b: Patient
 * Target:
```turtle
inst:ds2/{PID} a :Patient ; :hasName {NAME}^^xsd:string .
```
 * Source:
```sql
SELECT PID, NAME
FROM T_NAME
```

#### Mapping 2b1: hasNeoplasm NSCLC
 * Target:
```turtle
inst:ds2/{PID} :hasNeoplasm inst:ds2/nsclc/{PID}.
```
 * Source:
```sql
SELECT PID
FROM T_NSCLC
```

#### Mapping 2b2: hasNeoplasm SCLC
 * Target:
```turtle
inst:ds2/{PID} :hasNeoplasm inst:ds2/sclc/{PID}.
```
 * Source:
```sql
SELECT PID
FROM T_SCLC
```

#### Mapping 3b: NSCLC
 * Target:
```turtle
inst:ds2/sclc/{PID} a :NSCLC .
```
 * Source:
```sql
SELECT PID
FROM T_NSCLC
```

#### Mapping 4b: SCLC
 * Target:
```turtle
inst:ds2/sclc/{PID} a :SCLC .
```
 * Source:
```sql
SELECT PID
FROM T_SCLC
```

#### Mapping 5: Stage IIIa
 * Target:
```turtle
inst:ds2/nsclc/{PID} :hasStage inst:stage-IIIa .
```
 * Source:
```sql
SELECT PID
FROM T_NSCLC
WHERE STAGE = 'three-a'
```

## SPARQL

We can now run the previous SPARQL queries and observe that the results combine
entries from the two datasets.