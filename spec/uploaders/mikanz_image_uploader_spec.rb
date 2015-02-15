require 'rails_helper'

RSpec.describe MikanzImageUploader do
  let(:mikanz_image_uploader) { MikanzImageUploader.new }
  describe '#extension_white_list' do
    it 'expect array of `jpg`, `jpeg`, `gif` and `png`' do
      expect(mikanz_image_uploader.extension_white_list).to eq(['jpg', 'jpeg', 'gif', 'png'])
    end
  end
end
