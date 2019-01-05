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


## MVC

We have setup the app, it's time to code ! :shipit:

### M - for model

   This section involves the creation of an instance method that returns the `price` of an item and a class method that returns the `average_price` of all the items in the database.   

   Take a good look at the migration file in order to understand how the database was designed, you will eventually have to add attributes and create your own models.   

#### Item model

* original_price  
* has_discount  
* discount_percentage  

#### Specs

1. create a `price` method  

   You want to be able to call a single method `price` on your **item** object that will return a computed price if it has a discount or the original price otherwise.

   ```ruby
   item = Item.first
   item.price
   ```  
   Given the following attributes : (original_price: 15, has_discount: false, discount_percentage: nil)  
   The above code should return **15**

   Given the following attributes : (original_price: 15, has_discount: true, discount_percentage: 20)
   The above code should return **12**

2. create an `average_price` method  

   You want to be able to call a method `average_price` on your **Item** object that will return the average price of all the items in the database.

   ```ruby
   Item.average_price
   ```  

#### Creating the unit tests

1. using factories  

   Use **factories** and **faker** in order to build or create your test objects :   

   ```ruby
    FactoryBot.define do
      factory :item do
        original_price      { Faker::Number.decimal(2) }
        has_discount        { Faker::Boolean.boolean }

        trait :with_discount do
          has_discount { true }
        end

        factory :item_with_discount, traits: %i[with_discount]
      end
    end
   ```  
   This factory supplies two attributes for the `Item` model, it's up to you to add the **discount_percentage**.   

   This factory supplies one trait, it's up to you to add a trait called **without_discount** that will generate an item for which the attribute **has_discount** is set to **false**.   

   Similarly, create a factory named **item_without_discount** that will generate an item with the trait **without_discount**.   

   
2. testing the database  

   Use **shoulda-matchers** in order to test each field of the database. Here is an example of how you can do that :   

   ```ruby
    RSpec.describe Item, type: :model do
      describe 'Model instantiation' do
        subject(:new_item) { described_class.new }

        describe 'Database' do
          it { is_expected.to have_db_column(:id).of_type(:integer) }
          it { is_expected.to have_db_column(:original_price).of_type(:float).with_options(null: false) }
          it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
        end

      end
    end
   ```  
   3 of the attributes are tested, it's up to you to **add the 3 missing ones**. Don't forget to check the documentation for a thorough job. Don't worry, it's easier than it looks ;)

3. testing the model  

   This part can be a lot more tricky. It's relatively easy to learn **how** to tests an object or a method (learning the syntax and checking the documentation), but it can be an art to design **what** to test. You will soon find out that you can't rely solely on a good coverage in order to consider that your code is fully tested. Your unit tests should be as elementary as possible, meaning that they should only test **one** element.   

   ```ruby
    describe 'Price' do

      context 'when the item has a discount' do
        let(:item) { build(:item_with_discount, original_price: 100.00, discount_percentage: 20) }

        it { expect(item.price).to eq(80.00) }
      end

    end
   ```   

   I'm confident that you will remember to test that things that should work, actually do work. Try not to forget to test that things that shouldn't work, actually don't work ! Also, don't hesitate to use validations if necessary.   

### V - for view

   We will not tackle design issues during this course and overall, we will not focus on front-end development.   

   Nevertheless :
   * it is important to have a basic understanding of UX conventions in order to deliver practical functionalities   
   * it is important to know how to articulate views in your projects and how to structure them in a conventional rails way   

   In this section, we will write the view corresponding to the index of the items resource in the administration namespace. Run the command `rails db:seed`. You will notice that the table is empty for now. Make sure that it fills with the information from the database. Don't hesitate to use a partial.   

### C - for controller

   In this section, we will try to write lean controllers that hold close to no logic.

   We want to write a simple update method in the items controller that will allow us to update the discount_percentage of each item in our index table.  

   Obviously, updating the discount_percentage will modify the price.


## Tips to go further

**Congratulation! You're done for the week!**

As you know, it is mandatory to go further. It's up to you to choose which topic to dig. My advice would be to :

  * play around with FactoryBot
  * play around with RSpec
