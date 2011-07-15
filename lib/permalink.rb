module Permalink

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    # Specifies the given field as using permalink.
    #
    #   class Foo < ActiveRecord::Base
    #
    #     # stores the permalink version of title on permalink
    #     permalink :title
    #
    #     # stores the permalink version of title on slug
    #     permalink :title, :slug
    #
    #   end
    #
    def permalink(field_name, permalink_field_name = 'permalink')
      # Force default locale
      locale = I18n.locale
      I18n.locale = I18n.default_locale

      before_save do |record|
        if (record.send(permalink_field_name).blank?) || (record.send(field_name) && record.send(permalink_field_name).nil?)
          record.send "#{permalink_field_name}=", record.send(field_name).parameterize
        end
      end

      before_update do |record|
        if record.send("#{field_name}_changed?")
          record.send "#{permalink_field_name}=", record.send(field_name).parameterize
        end
      end

      #define_method "to_param" do
      #  send(permalink_field_name)
      #end

      # Restore locale
      I18n.locale = locale
    end
  end

end

ActiveRecord::Base.send :include, Permalink
