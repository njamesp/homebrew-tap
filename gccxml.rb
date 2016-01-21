class Gccxml < Formula
  desc "GCC-XML, the XML output extension to GCC"
  homepage "http://gccxml.github.io/HTML/Index.html"
  url "https://github.com/gccxml/gccxml.git"
  version "master"

  depends_on "cmake" => :build

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end
end
