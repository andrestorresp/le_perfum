class AddColumnToCheckouts < ActiveRecord::Migration[7.1]
  def change
    add_column :checkouts, :reference_info, :string
  end
end
