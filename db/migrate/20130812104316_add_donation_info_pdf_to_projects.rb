class AddDonationInfoPdfToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :donation_info_pdf, :string
  end
end
