require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to :author }
  it { should have_many(:tags).through(:taggings) }
  it { should validate_presence_of :body }
  it { should validate_presence_of :title }
  it { should validate_presence_of :author }
end
