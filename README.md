![Yale COVID-19 Contact Tracing System](NewLogo.png)

The purpose of this project is to develop a database for storing contact tracing information, as well as information that can be used for predictive modeling, and accompanying infrastructure for streamlined input and visualization of the data. This will vastly improve the contact-tracing workflow for patients, managers, and volunteers alike, and will also provide public health experts with valuable information to aid their research. Our hope is to also make some of the aggregate information available to the public, whether through our own publicly-accessible website, or through a public-facing API that apps like [Hunala](https://news.yale.edu/2020/06/05/yale-app-hunala-aims-be-waze-coronavirus) could integrate into their product. 

Read more about each segment of the project below.

## Websites

We're currently in the process of building 4 websites, each targeted at a different user group. Using all these systems together, we hope to streamline the contact tracing project for patients and contact tracers alike. The anonymized aggregate data will then be made accessible on the public facing website. 

### Patient Portal

One of the major bottlenecks in the current contact tracing system is simply the time lag inherent in interviewing patients and notifying contacts due to the time required to interview patients. Our patient portal enables COVID-19 patients to complete their interview online individually. This cuts down on the number of patients contact tracers need to call, and allows patients to fill out the form at their earliest convenience. If patients would still prefer to conduct a phone interview, they can also request one easily through the website. Upon completion of either the phone interview or the form, all the patient's information is easily visible and editable in the website. 

The form will be integrated with the volunteer and manager portals through a centralized database, allowing a smooth handoff from the hostpial to the contact tracers. After diagnosis, medical professionals could simply enter the patient into the database. On the backend, the database would create credentials for the patient and send these to the patient through a secure link at a phone number or email on record. 

Furthermore, this website provides another touchstone to interact with patients and provide support to them after leaving the hospital. For example, our resources page contains a list of hotlines and organizations both national and local to New Haven that could be useful to patients. 

Please visit [http://oasis-patient.cs.yale.edu](http://oasis-patient.cs.yale.edu) on Yale VPN to see a demo of this website. The login credentials are "username1" and "password".

### Volunteer Portal

The volunteer website is intended to provide a centralized portal for contact tracer volunteers to view and input information on assigned patients and contacts. The main dashboard features an easy way to view key information on assigned people, as well as as a large interface to view and interact with all the information associated with one particular person. 

For volunteers who interview patients, the portal leads directly to a modified version of the interview form on the patient website. This provides the volunteer with more strucure during the interview, as well as an intuitive user interface to input information. For volunteers who notify contacts, the contact information is formatted in a highly human-readable format. A call script is embedded in the main website, with important information (exposure date, notification status) highlighted for easy access. Both approaches are designed to guide the volunteer through an interview or call, reminding them of the information that needs to be conveyed and gathered. No more transcribing notes from interviews; just input them directly into the website. 

Volunteers will be given more agency to edit their profiles to reflect their working capacity or language skills. Depending on the manager's preference, they can also self-assign patients/contacts, reducing administrative time on the part of the manager. 

Please visit [this link](http://172.28.229.7:8082/) on Yale VPN to see a demo. 

### Manager Portal and Public Portal

These two websites are still in the works...


## Database 
The goal of the centralized spatial database is to both provide a simple visualization tool for doctors, researchers, and the general public and to improve the ease of database entry. Additional factors considered include time and location, in addition to contacts. An informational risk-analysis system for the general public is built into the map visualization (to see what places are hot-spots). All data in the database is voluntarily provided and anonymous.

## **Team**

Current Members
* [Avi Silberschatz](https://codex.cs.yale.edu/avi/)
* [Robert Soul&eacute;](https://www.cs.yale.edu/homes/soule/)
* Tucker Moses (backend)
* Tom Coile (frontend and design)
* Ivy Fan (frontend and design)
* David Foster (design)

Past Members
* Alex Briasco-Stewart
* Hao Li
* Vikram Mullick


## **Installation Instructions**

* [Backend](backend/backend.md)
* [Frontend](frontend/frontend.md)

