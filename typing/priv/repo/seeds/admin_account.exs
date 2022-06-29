alias Typing.Repo
alias Typing.Admin

name = "taro"

account =
  %Admin.Account{
    name: name,
    email: name <> "@sample.com",
    hashed_password: Bcrypt.hash_pwd_salt(name <> "999"),
    authority_status: 2
  }

Repo.insert(account)
