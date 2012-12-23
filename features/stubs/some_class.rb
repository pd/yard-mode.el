# @see OtherClass
class SomeClass
  # @param [String] version the version
  def initialize(version)
    @version = version
  end

  # @return [Boolean] true if the given version is outdated
  def old?
  end
end
