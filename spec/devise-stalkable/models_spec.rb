require 'spec_helper'

class TestModel
  include Devise::Models::Stalkable

  def id
    1
  end
end

class TestModelLogin
end

describe Devise::Models::Stalkable do

  let(:model) { TestModel.new }

  describe '#mark_login!' do

    it 'creates a new login record' do
      expect(TestModelLogin).to receive(:create)
      request = double.as_null_object
      model.mark_login!(request)
    end

    it 'uses model id' do
      expect(TestModelLogin).to receive(:create).with(hash_including(user_id: 1))
      request = double.as_null_object
      model.mark_login!(request)
    end

    it 'records parameters' do
      expect(TestModelLogin).to receive(:create).with(hash_including(user_id: 1))
      request = double("request")
      expect(request).to receive(:ip_address).and_return('1.2.3.4')
      expect(request).to receive(:host).and_return('host.example.com')
      expect(request).to receive(:port).and_return(443)
      expect(request).to receive(:user_agent).and_return('Mozilla, fool!')
      model.mark_login!(request)
    end

  end

  describe '#mark_logout!' do

    let(:record) { double update_column: nil }

    before do
      allow(TestModelLogin).to receive(:find).and_return record
    end

    it 'finds the record by given ID' do
      expect(TestModelLogin).to receive(:find).with(1)
      model.mark_logout!(1)
    end

    it 'finds the record by given ID' do
      now = double
      allow(Time).to receive(:now).and_return now
      expect(record).to receive(:update_column).with(:signed_out_at, now)
      expect(record).to receive(:update_column).with(:last_seen_at, now)
      model.mark_logout!(1)
    end

  end

end

