alias Typing.Repo
alias Typing.Core

name = "alpha"

account =
  %Core.Account{
    name: name,
    email: name <> "@sample.com",
    hashed_password: Bcrypt.hash_pwd_salt(name <> "999")
  }

Repo.insert(account)
