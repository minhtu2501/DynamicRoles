Role.create(name: 'Super Admin')
Role.create(name: 'PM')
Role.create(name: 'Team Leader')
Role.create(name: 'Staff')

Permission.create(action: 'manage', subject_class:'all')

User.create(name: "Hoang Minh Tu", email: "minhtu250192@gmail.com", password: "haithangban", password_confirmation: "haithangban")

User.create(name: "Tu Rau", email: "staff@gmail.com", password: "haithangban", password_confirmation: "haithangban")

User.create(name: "Staff 01", email: "staff1@gmail.com", password: "haithangban", password_confirmation: "haithangban")

User.create(name: "Staff 02", email: "staff2@gmail.com", password: "haithangban", password_confirmation: "haithangban")
