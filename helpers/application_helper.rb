# frozen_string_literal: true

module ApplicationHelper
  def production_branch?
    `git branch --show-current`.chomp == 'main'
  end
end
