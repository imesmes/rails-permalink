require 'test/unit'
require 'rubygems'
require 'active_record'
require 'permalink'

ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")

def setup_db
  silence_stream(STDOUT) do
    ActiveRecord::Schema.define(:version => 1) do
      create_table :pages do |t|
        t.string :name
        t.string :permalink
      end

      create_table :posts do |t|
        t.string :title
        t.string :slug
      end
    end
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

class Page < ActiveRecord::Base
  permalink :name
end

class Post < ActiveRecord::Base
  permalink :title, :slug
end

class SimplifiedPermalinkTest < Test::Unit::TestCase

  def setup
    setup_db
  end

  def teardown
    teardown_db
  end

  def test_should_convert_page_name
    post = Page.create(:name => "Chunky Bacon")
    assert_equal "chunky-bacon", post.permalink
  end

  def test_should_convert_page_name_when_permalink_is_blank
    post = Page.create(:name => "Chunky Bacon", :permalink => "")
    assert_equal "chunky-bacon", post.permalink
  end

  def test_should_not_convert_page_name_when_permalink_is_present
    post = Page.create(:name => "Chunky Bacon", :permalink => "bacon")
    assert_equal "bacon", post.permalink
  end

  def test_should_convert_post_title_to_slug
    post = Post.create(:title => "Chunky Bacon")
    assert_equal "chunky-bacon", post.slug
  end

  def test_should_convert_post_title_to_slug_when_slug_is_blank
    post = Post.create(:title => "Chunky Bacon", :slug => "")
    assert_equal "chunky-bacon", post.slug
  end

  def test_should_not_convert_post_title_when_slug_is_present
    post = Post.create(:title => "Chunky Bacon", :slug => "bacon")
    assert_equal "bacon", post.slug
  end

end
