## Front End Website

The front end website currently consists of two parts: 

- An interactive map displaying the public locations that COVID patients visited while they were contagious
- An interview form to enable volunteers (or patients themselves) to provide contact tracing and locational information. The contact tracing information can be then accessed and used by medical volunteers (portal for this coming soon!); whatever locational information is public can then be viewed by the public via the interactive map

## Setup

1. Install the vue cli tool (it's what allows us to run the dev server) with `npm install -g @vue/cli`

2. Inside the maps project, run `npm install` and `npm install node-sass`. This will install all the dependencies associated with the project (listed in package-lock.json)

3. Add the file `apiKey.js` to the `/src/constants` directory (if you need this key, and cannot just obtain your own, email either tom.coile@yale.edu or ivy.fan@yale.edu). 

4. Run `npm run serve` to start the app! 

## Current Project Status

We are currently working on building out the form into a usable prototype. By May 10th, we hope to have an MVP built for the form interface. After that is complete, we'll work on a) styling it and making iterative design improvements and b) improving the map visualizations. 
