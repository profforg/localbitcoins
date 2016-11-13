require 'spec_helper'

describe 'LocalBitcoins' do
  describe '.new' do
    it 'returns a new client instance' do
      # LocalBitcoins.new.should be_a LocalBitcoins::Client
      expect(LocalBitcoins.new).to be_a LocalBitcoins::Client
    end
  end

  describe '.configure' do
    it 'sets a global configuration options' do
      r = LocalBitcoins.configure(client_id: 'TEST_ID', client_secret: 'TEST_SECRET')
      expect(r).to be_a Hash
      expect(r).to have_key(:client_id)
      expect(r).to have_key(:client_secret)
      expect(r[:client_id]).to eql('TEST_ID')
      expect(r[:client_secret]).to eql('TEST_SECRET')
    end

    it 'raises ConfigurationError on invalid config parameter' do
      expect(proc { LocalBitcoins.configure(nil) }).to raise_error(ArgumentError, "Options hash required.")

      expect(proc { LocalBitcoins.configure('foo') }).to raise_error(ArgumentError, "Options hash required.")
    end
  end

  describe '.configuration' do
    before do
      LocalBitcoins.configure(client_id: 'TEST_ID', client_secret: 'TEST_SECRET')
    end

    it 'returns global configuration options' do
      r = LocalBitcoins.configuration
      expect(r).to be_a Hash
      expect(r).to have_key(:client_id)
      expect(r).to have_key(:client_secret)
      expect(r[:client_id]).to eql('TEST_ID')
      expect(r[:client_secret]).to eql('TEST_SECRET')
    end
  end

  describe '.reset_configuration' do
    before do
      LocalBitcoins.configure(client_id: 'TEST_ID', client_secret: 'TEST_SECRET')
    end

    it 'resets global configuration options' do
      LocalBitcoins.reset_configuration
      expect(LocalBitcoins.configuration).to eql({})
    end
  end
end
