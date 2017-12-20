# Banking

[![Ebert](https://ebertapp.io/github/ruan-brandao/banking.svg)](https://ebertapp.io/github/ruan-brandao/banking)
[![Build Status](https://semaphoreci.com/api/v1/ruan-brandao/banking/branches/master/badge.svg)](https://semaphoreci.com/ruan-brandao/banking)

Simple implementation of a RESTFul API to manage banking accounts.

## Dependencies
This project has the following dependencies:

* Ruby 2.4
* Rails 5.1.4

## Setup the project
To run the project, do the following steps:

1. Install the dependencies listed above
2. `$ git clone <REPOSITORY_URL> banking` - Clone the repository
3. `$ cd banking` - Go into the project directory
4. `$ bundle install` - Install the project's gems
5. `$ bin/rails db:setup` - Setup the project's database

If everything goes OK, you can now run the project.

## Running the project
1. Run `$ bin/rails server` on the project directory
2. Open [http://localhost:3000](http://localhost:3000) at your web browser

## Usage

This system is a RESTFul API that implements simple banking features. In it each
user has an account and can check his/her current balance and transfer money
to another account. The system only handles one currency that is Brazilian Real (BRL).

When setting up the project some test users will be automatically created with
money on their accounts. To see the test users' credentials and initial balance
check the [database seeds](https://github.com/ruan-brandao/banking/blob/master/db/seeds.rb) file.

### Authentication

This project uses the [Devise Token Auth](https://github.com/lynndylanhurley/devise_token_auth#configuration-cont)
gem to implement API authentication. The main actions are the following.

#### Create an account

This action will create a new user account.

```
POST /auth/
```

**Input**:

| Name                    | Type     | Description                                      |
| ----------------------- | -------- | ------------------------------------------------ |
| `email`                 | `string` | **Required**. New account email.                 |
| `password`              | `string` | **Required**. New account password.              |
| `password_confirmation` | `string` | **Required**. New account password confirmation. |

**Example**:

```json
{
  "email": "user@example.com",
  "password": "p4$$w0rd",
  "password_confirmation": "p4$$w0rd"
}
```

**Response**:

```
Status: 200 OK
```
```json
{
  "status": "success",
  "data": {
    "id": 1,
    "email": "user@example.com",
    "provider": "email",
    "uid": "user@example.com",
    "name": null,
    "created_at": "2017-12-20T05:31:59.889Z",
    "updated_at": "2017-12-20T05:31:59.976Z"
  }
}
```

#### Sign In

This action creates a new token to be used on authenticated requests.

```
POST /auth/sign_in
```

**Input**:

| Name                    | Type     | Description                                  |
| ----------------------- | -------- | -------------------------------------------- |
| `email`                 | `string` | **Required**. Account email.                 |
| `password`              | `string` | **Required**. Account password.              |

**Example**:

```json
{
  "email": "user@example.com",
  "password": "p4$$w0rd"
}
```

**Response**:

```
Status: 200 OK
Custom Headers:
  access-token: new-access-token
  client: client-token
  uid: user@example.com
```
```json
{
  "data": {
    "id": 1,
    "email": "user@example.com",
    "provider": "email",
    "uid": "user@example.com",
    "name": null
  }
}
```

The custom headers received in this request are the following:

| Name           | Type     | Description                                                           |
| -------------- | -------- | --------------------------------------------------------------------- |
| `access-token` | `string` | User access token. Defines a valid session.                           |
| `client`       | `string` | User session client. Responsible for keeping track of changing tokens |
| `uid`          | `string` | Unique user identification. Defaults to user email.                   |

These three headers must be sent as request headers with the received values on authenticated requests.

#### Sign out

This action invalidates the authenticated user token.

```
DELETE /auth/sign_out
```

**Response**:

```
Status: 200 OK
```
```json
{
    "success": true
}
```

### Get account balance

This action will return the current balance of the authenticated user's account

```
GET /accounts/balance
```

**Response**:

```
Status: 200 OK
```
```json
{
  "balance": "R$ 200,00"
}
```

**Response if account is not found**:

```
Status: 404 Not Found
```
```json
{
  "errors": [
    "Account does not exist."
  ]
}
```

### Transfer money

This action will transfer the specified amount of money from the authenticated
user's account to the specified destination account.

```
POST /accounts/transfer
```

**Input**:

| Name                     | Type      | Description                                       |
| ------------------------ | --------- | ------------------------------------------------- |
| `destination_account_id` | `integer` | **Required**. Id of account to receive the money. |
| `amount`                 | `integer` | **Required**. Amount of money to be transfered.   |

**Example**:

```json
{
  "destination_account_id": 1,
  "amount": 5000
}
```

**Note about currency formatting**:

Using floating point numbers for currency representation can lead to [several problems](http://blog.plataformatec.com.br/2014/09/floating-point-and-currency/)
when performing calculations on a computer. To avoid this kind of errors money amounts
are represented with integer numbers on this system. Because of that the amount entered
in this action must be in cents. So to represent, say, R$ 25,40, you should use the
value `2540`.

**Response**:

```
Status: 200 OK
```
```json
{
  "transfered_amount": "R$ 25,40",
  "current_balance": "R$ 24,60"
}
```

**Response when informed amount is bigger than current balance**:
```
Status: 400 Bad Request
```
```json
{
  "errors": [
    "The current balance is not enough to make the transfer"
  ]
}
```

## Running the tests
The project uses [RSpec](http://rspec.info/) for the tests. You can run the tests with the command: `$ bin/rspec`

## Contributing

In order to contribute with the project, please check our [contribution guidelines](https://github.com/ruan-brandao/banking/blob/master/CONTRIBUTING.md).
