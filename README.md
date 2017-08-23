**Build and Run**
----
Download this file and run following commands in the terminal from the directory of this file.

```bash
gem install rails

bundle install

rails db:drop
rails db:create
rails db:migrate
rails db:seed
```

run `rails s` to start a server and check out the results on `localhost:3000/`

-----------------------

**Show Employees**
----
  Giving a company name(case insensitive) as a URL param and it will return JSON data about all the employees.

URL | Method | URL Params(Required)
--- | ------ | --------------------
/company/:name | `GET` |  `company=[name]`

* **Sample Response:**

```javascript
{
  "number_of_employees": 3,
  "employees": [
    {
        "name": "Darlene Jones",
        "age": 57
    },
    {
        "name": "Booth Haynes",
        "age": 46
    },
    {
        "name": "Lakeisha Noel",
        "age": 42
    },
  ]
}
```

* **Error Response:**

  * **Code:** 404 NOT FOUND <br />
    **Content:** `{ "status":"error","code":404,"message":"Company doesn't exist" }`
    
-----------------------

**Show 2 People & Their Shared Friends**
----
  Giving 2 people's indexes, it will return JSON data about their information (Name, Age, Address, Phone) and the list of their friends in common which have *brown eyes* and are *still alive*.

URL | Method | Data Params(Required)
--- | ------ | --------------------
/people | `GET` |  `?index1=[integer]&index2=[integer]`

* **Sample Response:**

```javascript
{
  "person1": {
      "name": "Bonnie Bass",
      "age": 54,
      "index": 2,
      "phone": "+1 (823) 428-3710",
      "address": "455 Dictum Court, Nadine, Mississippi, 6499"
  },
  "person2": {
      "name": "Cote Booth",
      "age": 26,
      "index": 6,
      "phone": "+1 (842) 598-3525",
      "address": "394 Loring Avenue, Salvo, Maryland, 9396"
  },
  "common_friends": [
      {
          "name": "Decker Mckenzie",
          "age": 60,
          "index": 1,
          "has_died": false,
          "eyeColor": "brown",
          "phone": "+1 (893) 587-3311",
          "address": "492 Stockton Street, Lawrence, Guam, 4854"
      }
  ]
}
```

* **Error Response:**

  * **Code:** 404 NOT FOUND <br />
    **Content:** `{ "status":"error","code":404,"message":"Person doesn't exist or missing indexes" }`

-----------------------

**Show Person**
----
  Giving 1 person's index, it will return JSON data about his/her personal info(name and age) and a list of fruits and vegetables this person likes.

URL | Method | URL Params(Required)
--- | ------ | --------------------
/person/:index | `GET` |  `index=[integer]`

* **Sample Response:**

```javascript
{
  "name": "Bonnie Bass",
  "age": 54,
  "fruits": [
      "orange",
      "banana",
      "strawberry"
  ],
  "vegetables": [
      "beetroot"
  ]
}
```

* **Error Response:**

  * **Code:** 404 NOT FOUND <br />
    **Content:** `{ "status":"error","code":404,"message":"Person doesn't exist" }`
