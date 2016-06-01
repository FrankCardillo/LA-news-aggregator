require "sinatra"
require "pry"
require "csv"

require_relative "models/article.rb"

enable :sessions

get "/" do
  redirect "/articles"
end

get "/articles/new" do
  erb :post_article
end

post "/articles/new_post" do
  article_title = params['article_title']
  article_url = params['article_url']
  article_description = params['article_description']
  @my_article = Article.new(article_title, article_url, article_description)

  @my_article.check_and_add_http
  @my_article.set_dupe_value

  if @my_article.check_for_empty_form
    raise EmptyFormError, "You did not fill out all form fields."
  elsif @my_article.check_description_length
    raise DescriptionLengthError, "Your description length is < 20 chars."
  elsif @my_article.check_dupe_value
    raise DuplicateArticleError, "This article has already been submitted."
  else
    @my_article.save_article
    redirect "/articles"
  end
end

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
