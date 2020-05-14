## Maps Prototype

Uses Google Map's API to load markers onto a simple map instance. 

## Setup

1. Install the vue cli tool (it's what allows us to run the dev server) with `npm install -g @vue/cli`

2. Inside the maps project, run `npm install` and `npm install node-sass`. This will install all the dependencies associated with the project (listed in package-lock.json)

3. Add the file `apiKey.js` to the `/src/constants` directory. 

4. In the file `covid-tracing/frontend/vue.config.js`, change the proxy's url from 'localhost' to your machine's IP address. Then do the same thing for the baseurl variable in `covid-tracing/frontend/src/constants/baseurl.js`. 

5. Run `npm run serve` to start the app! 
