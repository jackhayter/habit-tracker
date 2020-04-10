# frozen_string_literal: true

class PostgresSetup < ActiveRecord::Migration[6.0]
  def change

    enable_extension 'pgcrypto'

  end
end
