class AddInfectorReferenceToContact < ActiveRecord::Migration[6.0]
  def change
    add_reference :contacts, :infector, foriegn_key: true
  end
end
