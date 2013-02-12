require 'spec_helper'

class DummyClass
  include KnifeSous::DSLWrapper
end

describe KnifeSous::DSLWrapper do
  it_should_behave_like "a dsl wrapper" do
    let(:klass) { DummyClass.new }
  end
end

