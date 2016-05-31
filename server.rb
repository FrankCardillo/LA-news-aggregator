require "sinatra"
require "pry"
require "csv"

# error InvalidSubmission do
#   'So what happened was...' + env['sinatra.error'].message
# end

get "/articles/new" do
  erb :post_article
end

# post "/articles/new_post" do
#   article_title = params['article_title']
#   article_url = params['article_url']
#   article_description = params['article_description']
#
#   if article_url[0..3] != "http"
#     article_url = "http://" + article_url
#   end
#
#   if article_title == nil || article_url == nil || article_description == nil
#     raise InvalidSubmission, "you did not fill out all of the required fields."
#     redirect '/articles/new'
#   elsif article_description.length < 20
#     raise InvalidSubmission, "you did not provide a description with a length of at least 20 characters."
#     redirect '/articles/new'
#   else
#     CSV.foreach("articles.csv") do |row|
#       if article_url == row[1]
#         raise InvalidSubmission, "you are trying to submit an article that has previously been submitted."
#       end
#     end
#
#     File.open('articles.csv', 'a') do |file|
#       file.puts(article_title + ", " + article_url + ", " + article_description)
#     end
#
#     redirect '/articles'
#   end
# end

get "/articles" do
  @titles = []
  @urls = []
  @descriptions = []
  CSV.foreach("articles.csv") do |row|
    @titles << row[0]
    @urls << row[1]
    @descriptions << row[2]
  end
  erb :articles
end
