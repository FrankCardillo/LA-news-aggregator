require "csv"

class Article
  attr_reader :title, :url, :description, :dupe_article

  def initialize(title, url, description)
    @title = title
    @url = url
    @description = description
    @dupe_article = false
  end

  def check_and_add_http
    if @url[0..3] != "http"
      @url = "http://" + @url
    end
  end

  def set_dupe_value
    CSV.foreach("articles.csv") do |row|
      if @url == row[1]
        @dupe_article = true
        break
      end
    end
  end

  def check_for_empty_form
    @title.length == 0 || @url.length == 0 || @description.length == 0
  end

  def check_description_length
    @description.length < 20
  end

  def check_dupe_value
    @dupe_article
  end

  def save_article
    File.open('articles.csv', 'a') do |file|
      file.puts(@title + "," + @url + "," + @description)
    end
  end
end


class EmptyFormError < StandardError
end

class DescriptionLengthError < StandardError
end

class DuplicateArticleError < StandardError
end
