shared_examples_for "dsl wrapper" do
  describe "#evaluate_block" do
    it "should support passing itself in as the context" do
      test_block = Proc.new { |i| i.foo 'bar'}
      klass.stub(:foo)
      klass.should_receive(:foo).with('bar')
      klass.evaluate_block(&test_block)
    end
  end
end

