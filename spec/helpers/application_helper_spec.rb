require "rails_helper"

RSpec.describe ApplicationHelper do
  describe "#markdown" do
    it "formats correctly" do
      bold = markdown("**bold**")
      italics = markdown("*italics*")

      expect(bold).to eq("<p><strong>bold</strong></p>\n")
      expect(italics).to eq("<p><em>italics</em></p>\n")
    end
  end
end
