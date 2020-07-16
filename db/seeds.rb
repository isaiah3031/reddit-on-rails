# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
bm = User.create(username:'big_moderator', password: 'password')
bp = User.create(username: 'big_poster', password: 'password')

Sub.create(
  title: 'the_main_sub',
  description: 'Lotsa Posts',
  moderator_id: User.find_by(username: 'big_moderator').id
)

main_post = Post.create(
  title: 'Contriversal',
  content: 'Back and fourth',
  author_id: User.find_by(username: 'big_poster').id
)

comment = Comment.create(
  content: 'child1',
  author_id: bm.id,
  post_id: main_post.id
)

loop do
  poster = Comment.last.author == bm ? (bp) : (bm)
  Comment.create(
    content: "child#{Comment.count}",
    author_id: poster.id,
    post_id: main_post.id,
    parent_comment_id: comment.id
  )
  break if Comment.count == 10
  
  comment = Comment.last
end