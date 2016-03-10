require 'active_support'
require 'rapidfire'

Rails.application.config.to_prepare do

  Rapidfire::QuestionGroup.class_eval do
    has_and_belongs_to_many :surveys, :join_table => "surveys_question_groups", :foreign_key => "rapidfire_question_group_id"
  end

  Rapidfire::ApplicationController.class_eval do
    layout 'surveys'
  end
end