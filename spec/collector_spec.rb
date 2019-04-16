describe TopologicalInventory::MockSource::Collector do

  # @see spec/support/settings_helper.rb
  context "with settings" do
    before do
      clear_settings
      # test settings
      expect(::Settings.multithreading).to be_nil
      # test amounts
      expect(::Settings.amounts&.container_images).to be_nil
      expect(::Settings.amounts&.container_groups).to be_nil
    end

    it "loads config from files" do
      described_class.new(nil, 'default', 'default')

      expect(::Settings.multithreading).to eq(:on)
      expect(::Settings.amounts.container_images).to eq(50)
      expect(::Settings.amounts.container_groups).to eq(50)
    end

    it "loads config from string" do
      described_class.new(nil, 'default', 'default', "multithreading: :yes\namounts:\n  container_images: 42")

      expect(::Settings.multithreading).to eq(:yes)
      expect(::Settings.amounts.container_images).to eq(42) # overriden
      expect(::Settings.amounts.container_groups).to eq(50) # from default config
    end
  end

  def clear_settings
    ::Settings.keys.dup.each { |k| ::Settings.delete_field(k) }
  end
end
