class Movie < ApplicationRecord
  belongs_to :director

  # including pg-search search script
  include PgSearch::Model

  # adding a class method to perfom the search
  pg_search_scope :search_by_title_and_synopsis,

    # which columns I am searching against
    against: [ :title, :synopsis ],

    associated_against: {
      director: [:first_name, :last_name]
    },

    # full text search -> @@
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
