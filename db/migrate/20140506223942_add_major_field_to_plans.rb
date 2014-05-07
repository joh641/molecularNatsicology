class AddMajorFieldToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :major, :string, default: "Molecular Toxicology"
  end
end
