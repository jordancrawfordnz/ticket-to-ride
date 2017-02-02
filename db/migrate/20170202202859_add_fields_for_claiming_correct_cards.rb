class AddFieldsForClaimingCorrectCards < ActiveRecord::Migration[5.0]
  def change
    add_column :train_car_types, :wildcard, :boolean
    add_column :train_car_types, :colour, :string
    add_column :route_types, :accepts_all_train_cars, :boolean

    # Because http://strd6.com/2009/04/adding-a-non-null-column-with-no-default-value-in-a-rails-migration/
    change_column :train_car_types, :colour, :string, :null => false
  end
end
