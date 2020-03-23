
# CoronaRM  
![ruby-2.7.0](https://img.shields.io/badge/Ruby-v2.7.0-green.svg) ![rails-5.2.4](https://img.shields.io/badge/Rails-v6.0.2-brightgreen.svg)   
  
This is a ruby on rails web-application built to help health and government officals who work continiously to control the corona outbreak of 2020   to track people who has been quarantined

## Getting started

### Install Dependencies
This application make use of couple of dependencies to function. please make sure you have installed the required dependencies before trying to run the app

 1. [Install Redis](https://redis.io/topics/quickstart)
 2. [Install PostgreSQL](https://www.postgresqltutorial.com/install-postgresql/)
 
 
### Clone
To get started with the app, clone the repo 
```
$ cd /path/to/repos
$ git clone https://github.com/coronasafe/coronaRM
$ cd coronaRM
```

### Installing Gems

```
$ bundle install
```

### Setting up the database
```
$ rake db:create
$ rake db:schema:load
```

this will create both the development and testing database.

### Running the application

```
$ rails server
```

this will start the app server. You can navigate to [http://localhost:3000](http://localhost:3000) to use the application in the browser.
