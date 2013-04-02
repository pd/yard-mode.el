# @see OtherClass
class SomeClass
  # @!group Lifecycle
  def setup; end
  def teardown;  end
  # @!endgroup

  # Something else
  # @param library [String] the name of the library
  # @param [String] version_number the version you have
  # @param [Hash] options the options
  # @option options [String] :an_option an option
  def initialize(library, version_number, options = {})
    @version = version
  end

  # @return [Boolean, Array] true if the given version is outdated
  def old?; end

  # @yield Consecutive newer version numbers.
  # @yieldparam version [String] the newer version
  # @yieldreturn [Boolean] whether to fetch the newer version
  def outdated; end
end
