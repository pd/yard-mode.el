# @see OtherClass
class SomeClass
  # @!group Callbacks
  def before_filter; end
  def after_filter;  end
  # @!endgroup

  # @param [String] version the version
  def initialize(version)
    @version = version
  end

  # @return [Boolean] true if the given version is outdated
  def old?
  end
end
