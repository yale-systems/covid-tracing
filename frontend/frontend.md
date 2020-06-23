## Overview

The frontend currently consists of two websites: a patient portal and a volunteer portal. The patient portal hosts an interview form that patients can fill out themselves. The volunteer portal provides a place for volunteers to view and edit data for assigned patients, and request or self-assign new patients. To run each of these sites, navigate into the corresponding directory (either `patient_website` or `volunteer_website`) and follow the instructions below.

## Setup

1. Install the vue cli tool (it's what allows us to run the dev server) with `npm install -g @vue/cli`

2. Inside the project, run `npm install` and `npm install node-sass`. This will install all the dependencies associated with the project (listed in package-lock.json)

3. Add the file `apiKey.js` to the `/src/constants` directory. 

4. In the file `vue.config.js`, change the proxy's url from 'localhost' to your machine's IP address. Then do the same thing for the baseurl variable in `/src/constants/baseurl.js`. 

5. Run `npm run serve` to start the app! The url should be displayed in your terminal. 

### Notes:

These websites do communicate with the backend, so if you haven't done so yet, head over to the backend folder and set that up first. The backend runs on port 8080 and is quite inflexible about that, so it must be started before any of the frontend sites.
