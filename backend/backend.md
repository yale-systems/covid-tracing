# Covid_Tracing

This is the backend repository for Yale's Covid Tracing project using Spring Frameworks.
More documentation is coming soon. For a rough sketch of the entities and fields, please refer to [this document](https://docs.google.com/document/d/1oObs0OEUgjgdBHZPQiFAQswYdpVXNwY6DABrJI0pXHs/edit?usp=sharing). 

## Startup

1. Install [Docker](https://www.docker.com/get-started), which will help set up the database for you.
2. In the `covid_tracing/backend` directory, run `./gradlew build`.
3. In the `covid_tracing` directory, run `./host_start_backend/sh`. This can take up to a minute. Once the terminal shows `Started ResearchApplication in ____ seconds`, you can now access the api!
4. To test the backend, call the root (localhost:8080) to see all the entities. Call endpoint patient (ie: localhost:8080/patient/getbypatientid/1) to see all the data associated with the patient. 

### Troubleshooting
- make sure nothing is running on port 8080 before you run the third step
- check to see if you have Java version 8 installed

# Contents

This section hosts information on the different directories within the Spring Frameworks. A general flow of the
application is a\) an endpoint is called in the controller b\) That end attempts to process the request through its
respective service c\) that service uses a repository to retrieve the data d\) that data is stored in the entity that
represents said data and returned to the service e\) the service translates the data from the entity class to the data
transfer object \(DTO\) as to not directly expose access to any underlying databases f\) the DTOs are returned to the
controller which responds to the client with the payload if the request is not fualty. Responds with a non-200 http
status otherwise.
### Controllers
This is where we host our actual endpoints. From here we control direct communication with the client and retrieve
request payloads.
### Entities
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


