module Pagination
  extend ActiveSupport::Concern

  included do
    def custom_paginate(resource)
      default_per_page = 10 #Rails.application.secrets.default_per_page

      case resource
      when ActiveRecord::Relation, Mongoid::Criteria, Mongoid::Relations::Targets::Enumerable
        resource.page(
          params[:page] || 1
        ).per(
          params[:per_page] || default_per_page
        )
      when Array
        Kaminari.paginate_array(resource).page(
          params[:page] || 1
        ).per(
          params[:per_page] || default_per_page
        )
      else
        logger.warn("Could not figure out resource class, #{resource.class}")
        resource.page(
          params[:page] || 1
        ).per(
          params[:per_page] || default_per_page
        )
      end
    end
  end
end

