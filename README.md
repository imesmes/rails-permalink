Permalink
====================

This plugin will create permalink for the provided attributes.

Example
-------

Add to your posts the permalink attribute.

    add_column :posts, :permalink, :null => false
    add_index :posts, :permalink, :unique => true

And use it on your controllers.

    class Post < ActiveRecord::Base
      permalink :title
    end

    class Post < ActiveRecord::Base
      permalink :title, :slug
    end

So now you can find your posts with:

    class Posts < ApplicationController

      def show
        @post = Post.published.find_by_permalink!(params[:id])
      end

    end

Copyright (c) 2008-2010 Francesc Esplugas Marti, released under the MIT license
