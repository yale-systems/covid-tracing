# Covid_Tracing

This is the backend repository for Yale's Covid Tracing project using Spring Frameworks.

## Startup

1. If you don't have gradle, run brew install gradle. If you don't have brew, I'd recommend getting it just so we have
   the same versions.
2. Make sure Java version 8 is installed.
3. Run gradle build in the directory.
4. cd to build/libs
5. there should be a war file in there. Run java -jar warfilename.
6. if port refused, make sure nothing is running on port 8080.
7. You can now access the api! Call endpoint getone (ie: localhost:8080/getone) to retrieve a random piece of dummy
   data. Call endpoint getrange with query parameter range (ie: localhost:8080/getrange?range=100) to retrieve a list of
   size range entities from the api (up to 9000).

## Docker

1. Build Docker Image `docker build -t tracing .`
2. Run `docker run -p 8080:8080 tracing`
3. Test `http://localhost:8080/getone`

# Contents

This section hosts information on the different directories within the Spring Frameworks. A general flow of the
application is a\) an endpoint is called in the controller b\) That end attempts to process the request through its
respective service c\) that service uses a repository to retrieve the data d\) that data is stored in the entity that
represents said data and returned to the service e\) the service translates the data from the entity class to the data
transfer object \(DTO\) as to not directly expose access to any underlying databases f\) the DTOs are returned to the
controller which responds to the client with the payload if the request is not fualty. Responds with a non-200 http
status otherwise.
###Controllers
This is where we host our actual endpoints. From here we control direct communication with the client and retrieve
request payloads.
###Entities
Entities are an object oriented way of representing database relations as classes via object relational mapping \(ORM\).
A standard relation may be an entity representing a simple row in a database, but they can be much more complex.
**Do Not** directly manipulate entities unless you are just receiving them from database retrieval, updating an entry in the
database, inserting an entry, or deleting one. These should only perfectly reflect the mapping between the program and
database. Any other transformation should be processed in DTO.

### Repositories

Repositories are a Spring Frameworks abstraction over Java Persistence API, the defined suite of APIs for ORM. Well
JPA defines the APIs, its just a specification. There exists different implementation of Java JPA. The one currently
implemented under the hood of the repositories interface is hibernate.

### Services

Services actually defines what actions the service called can do. More specifically, it's where we run the actions the
controller needs to retrieve the expected payload.

### DTOs

This is the object we either retrieve from the client or return to them, depending on the type of operation. We don't
want to return the actual entity, as that allows direct exposure to our database. Often, we might want different subsets
of the entity for different client certifications. One client may have permission to view more tracing information than
another, even though the information exists in the same underlying entity. It can also be useful if we want to make
transformation to the entity data to return to the client that we never want persisted to the database.

# TODOS

For any tasks assigned to you, please create a new branch from the master. **Do not commit to master**.

1. Establish a connection with a postgresql database. You'll need to change the application.properties file under
   resources to something similar to this:
   spring.datasource.url=jdbc:postgresql://localhost:5432/registry  
   spring.datasource.username=apiclient  
   spring.datasource.password=testingrole  
   spring.datasource.driver-class-name=org.postgresql.Driver  
   spring.jpa.show-sql=true  
   logging.level.org.hibernate.SQL=DEBUG  
   logging.level.org.hibernate.type.descriptor.sql.BasicBinder=TRACE  
   spring.jpa.properties.hibernate.jdbc.lob.non_contextual_creation=true  
   spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect  
   spring.session.store-type=none  
   spring.session.jdbc.initialize-schema=never  
   I'll modify gradle to have the Java dependencies on the API end, just establish via the log that the connection was
   successful. (ALEX)
2. Extend postgres with postgis and create triggers within postgres to first retrieve the longitude and latitude
   within a certain radius of a specified point. I have the command history I used to make a finalized schema, but I have
   to transfer it into a sql script and will send it out tomorrow. Start with the previous task. (ALEX)
3. Create an insertion operation that will apply jitter to a longitude and latitude in a dto and then insert it into
   the dummy database. Just make an endpoint and ignore the input to it. Right now, don't worry about processing physical
   request, just make an hard-coded DTO when the endpoint is called, add random jitter to it of a constant radius, and
   insert into database. You can verify insertion by logging into the h2 console at localhost:8080/h2-console. Enable it
   in applications.properties first, though (it's commented out). (HAO)  
   If we could get some of these task done by monday, we'd be in great shape!
