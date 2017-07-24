# EngineeringTest

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
  
**Engineering Test API**
----
  Here is the available APIs for the engineering test.

* **Base URL**

  `https://localhost:4000`

* **URL**

  `/api/users/sign_up`

* **Method:**

  `POST`
  
*  **Request Body**

   **Required:**
 
   ```
     {
       "email": "<user_email>",
       "password": "<user_password>",
       "password_confirmation": "<user_password_confirmation>"
     }
   ```

* **Success Response:**
 
  * **Code:** 201 <br />
    **Content:**
    ```
      {
        "data": {
          "token": "SFMyNTY.g3QAAAACZAAEZGF0YW0AAAAkNWM3ZjVjZWYtMjk2Yy00OGJkLWFkZDgtMmE1NDRiYmQzNjJiZAAGc2lnbmVkbgYAcbNCZF0B.Y28sM1RlzjgqoXI8IKE3iZjv9qUOo2p_mZqpSl13Xk8",
          "email": "user@sample.com"
        }
      }
    ```
    
* **URL**

  `/api/auth`

* **Method:**

  `POST`
  
*  **Request Body**

   **Required:**
 
   ```
     {
       "email": "<user_email>",
       "password": "<user_password>"
     }
   ```

* **Success Response:**
 
  * **Code:** 201 <br />
    **Content:**
    ```
      {
        "data": {
          "token": "SFMyNTY.g3QAAAACZAAEZGF0YW0AAAAkNWM3ZjVjZWYtMjk2Yy00OGJkLWFkZDgtMmE1NDRiYmQzNjJiZAAGc2lnbmVkbgYAcbNCZF0B.Y28sM1RlzjgqoXI8IKE3iZjv9qUOo2p_mZqpSl13Xk8",
          "email": "user@sample.com"
        }
      }
    ```

* **URL**

  `/api/stores`

* **Method:**

  `GET`
  
*  **Request Headers**
 
   - `Bearer=[string]`

* **Success Response:**
 
  * **Code:** 200 <br />
    **Content:**
    ```
      {
        "data":[
          {
            "id": "c2f622eb-0860-459f-9027-f3f97fff0b66",
            "tags": null,
            "name": "store 1",
            "is_open": false,
            "description": null,
            "location": {
              "longitude" 13.346545657,
              "latitude": 15.234234234
            }
          }
        ]
      }
    ```
    
* **URL**

  `/api/stores?lon=<lon>&lat=<lat>&radius=<radius_in_km>`

* **Method:**

  `GET`
  
*  **Request Headers**
 
   - `Bearer=[string]`

* **Success Response:**
 
  * **Code:** 200 <br />
    **Content:**
    ```
      {
        "data":[
          {
            "id": "c2f622eb-0860-459f-9027-f3f97fff0b66",
            "tags": null,
            "name": "store 1",
            "is_open": false,
            "description": null,
            "location": {
              "longitude" 13.346545657,
              "latitude": 15.234234234
            }
          }
        ]
      }
    ```
   
* **URL**

  `/api/stores`

* **Method:**

  `POST`

*  **Request Headers**
 
   - `Bearer=[string]`
  
*  **Request Body**

   **Required:**
 
   ```
     {
       "name": "<store_name>",
       "description": "<store_description>",
       "is_open": true
     }
   ```

* **Success Response:**
 
  * **Code:** 201 <br />
    **Content:**
    ```
      {
        "data": {
          "id": "387d39fc-53c4-419f-8b3d-4688a2f646e6", 
          "tags": null,
          "name": "store 4",
          "is_open": true,
          "descrption": null
        }
      }
    ```

* **URL**

  `/api/stores/:id`

* **Method:**

  `PUT`

*  **Request Headers**
 
   - `Bearer=[string]`
  
*  **Request Body**

   **Required:**
 
   ```
     {
       "name": "<store_name>",
       "description": "<store_description>",
       "is_open": true
     }
   ```

* **Success Response:**
 
  * **Code:** 201 <br />
    **Content:**
    ```
      {
        "data": {
          "id": "387d39fc-53c4-419f-8b3d-4688a2f646e6", 
          "tags": null,
          "name": "store 4",
          "is_open": true,
          "descrption": null
        }
      }
    ```
