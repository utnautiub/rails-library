# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Admins
Admin.create!([
  { name: "Super Admin", admin_name: "admins", password: "securepassword", delete_flag: false },
  { name: "Library Manager", admin_name: "manager", password: "anotherpassword", delete_flag: false }
])

# Authors
authors = Author.create!([
 { name: "J.K. Rowling", delete_flag: false },
 { name: "George R.R. Martin", delete_flag: false },
 { name: "J.R.R. Tolkien", delete_flag: false }
])

# Genres
genres = Genre.create!([
                         { name: "Fantasy", delete_flag: false },
                         { name: "Science Fiction", delete_flag: false },
                         { name: "Adventure", delete_flag: false }
                       ])

# Books
books = Book.create!([
                       {
                         title: "Harry Potter and the Philosopher's Stone",
                         image: "harry_potter.jpg",
                         subtitle: "Book 1",
                         author: authors[0],
                         genre: genres[0],
                         publishing_year: 1997,
                         quantity_in_stock: 5,
                         description: "A young wizard's journey begins.",
                         delete_flag: false
                       },
                       {
                         title: "A Game of Thrones",
                         image: "game_of_thrones.jpg",
                         subtitle: "Book 1",
                         author: authors[1],
                         genre: genres[1],
                         publishing_year: 1996,
                         quantity_in_stock: 3,
                         description: "Political intrigue and warfare in a fantasy world.",
                         delete_flag: false
                       },
                       {
                         title: "The Hobbit",
                         image: "hobbit.jpg",
                         subtitle: nil,
                         author: authors[2],
                         genre: genres[2],
                         publishing_year: 1937,
                         quantity_in_stock: 10,
                         description: "A hobbit's unexpected adventure.",
                         delete_flag: false
                       }
                     ])

# Users
users = User.create!([
                       { name: "John Doe", user_name: "johndoe", password: "password123", delete_flag: false },
                       { name: "Jane Smith", user_name: "janesmith", password: "password456", delete_flag: false }
                     ])

# Borrowings
borrowings = Borrowing.create!([
                                 {
                                   user: users[0],
                                   start_at: DateTime.now - 7.days,
                                   end_at: DateTime.now + 7.days,
                                   actual_end_at: nil,
                                   delete_flag: false
                                 },
                                 {
                                   user: users[1],
                                   start_at: DateTime.now - 10.days,
                                   end_at: DateTime.now - 3.days,
                                   actual_end_at: DateTime.now - 2.days,
                                   delete_flag: false
                                 }
                               ])

# Borrowing Items
BorrowingItem.create!([
                        { borrowing: borrowings[0], book: books[0], quantity: 1, delete_flag: false },
                        { borrowing: borrowings[1], book: books[1], quantity: 2, delete_flag: false }
                      ])

# Ratings
Rating.create!([
                 { book: books[0], user: users[0], star: 5, delete_flag: false },
                 { book: books[1], user: users[1], star: 4, delete_flag: false },
                 { book: books[2], user: users[0], star: 5, delete_flag: false }
               ])
