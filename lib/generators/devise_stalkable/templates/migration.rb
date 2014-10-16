class DeviseCreate<%= table_name.camelize.singularize %>Logins < ActiveRecord::Migration

  def up
    create_table :<%= table_name.singularize %>_logins do |t|
      t.integer  :<%= table_name.classify.foreign_key  %>
      t.string :ip_address
      t.string :user_agent
      t.string :host
      t.integer :port
      t.datetime :signed_in_at
      t.datetime :last_seen_at
      t.datetime :signed_out_at
    end

    add_index :<%= table_name.singularize %>_logins, :<%= table_name.classify.foreign_key  %>
  end

  def down
    drop_table :<%= table_name.singularize %>_logins
  end

end
