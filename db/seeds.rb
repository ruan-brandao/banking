foo_user = User.create({email: 'foo@example.com', password: '12345678'})
bar_user = User.create({email: 'bar@example.com', password: '12345678'})
foo_user.account.update_attributes(balance: 100000)
bar_user.account.update_attributes(balance: 100000)
