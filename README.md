# README

## App specifications

* Ruby version : 2.5.3  

* Rails version : 5.2  

* Test framework : rspec  


## Guidelines

   :raising_hand: **Ask for help !**
   This exercice is very guided. However, it important that you remember to ask for help if you're really stuck on an issue (specially if it's a configuration type !). You are a member of THP community. You have teammates and there is a slack channel dedicated to this course. 

   :gun: **Don't change the configuration files !**
   This configuration is partly dockerized and is supposed to be quite universal. At some point, it will be important for you to understand how all this works but the time is not now. Feel free to change anything you want and experiment on your side projects, it is part of the learning process. However, we strongly discourage you to stray from this readme in terms of application setup. In any case, we will not waste time debugging people who decided to procede differently from our instructions.

   :dizzy_face: **Do not delve too deeply in the documentation !**
   We expect you to be curious and we definitely expect you to go deeper in the weekly concepts. A lot of this is new and you will want to know it all. However, we recommand that you take your time or **it will drive you crazy**. Please, **FOCUS** on the tasks that are described. They are already a handful ! Our method consists in learning by doing, it is much less painful. 
   
## Cloning the repository

* Clone the repository

* Husky :
  * cd in the directory and run `npm install husky --save-dev`

* Bundle
  * run `bundle install`
  * run `bundle update`

* Docker :
  * check that Docker is properly installed with the command `docker run hello-world`
  * check that docker-compose is properly installed with the command `docker-compose --version`
  * check that you can build the dependencies with the command `docker-compose up redis postgres maildev`
  * open another terminal window and check that your services are up with the command `docker-compose ps`
  * setup the database with `rails db:create db:migrate` 
  * Launch local server with `rails server`

:fire: **Don't execute the following section if everything works well**

If you're reading this, it means that something is wrong in your docker configuration. Given the simplicity of our **docker-compose.yml** file, it is very likely that the issue stands with the ports allocation on your computer. Don't hesitate to contact us with the error message so that we can confirm. If it is indeed the case, here are the three steps that you need to reproduce in order to solve the issue :

1. check your open ports :
  * run `netstat -ln`
  * check for lines with protocol **tcp** and local address **127.0.0.1**. The open ports correspond to the value that follows the **":"**.
  * Choose a value that is not already taken. For example, if you see the value **5434**, then don't take it. Choose a random value, maybe **5435**.

1. edit the **docker-compose.yml** file :

   In the case of a postgres issue (it's generally postgres :angel:), you will have to change the port on your computer (that's the one on the left, after the first ":"), to the value you picked during the first step.
   - original postgres setup : `- 127.0.0.1:5434:5432` 
   - modified postgres setup : `- 127.0.0.1:5435:5432`

2. Tell rails where to look for the service :
   
   Depending on the service you modified, you will have to edit a file or another in your rails application. If you modified the port for the puma server to 3001 instead of 3000, then you will have to modify the **puma.rb** file consequently. 

   In the previous example, you modified the ports for your postgres container. It means that in rails, you will have to modify the following line in your **database.yml** file :
   - original postgres setup :
     ```yml
      port: <%= ENV.fetch("POSTGRES_PORT", '5434') %>
     ```   
   - modified postgres setup :
     ```yml
      port: <%= ENV.fetch("POSTGRES_PORT", '5435') %>
     ```   

:raising_hand: **If your docker configuration still doesn't work by now, notify a staff member.**


## Follow the wiki

We have setup the app, it's time to code ! :shipit:
All the instructions are given in the wiki.
