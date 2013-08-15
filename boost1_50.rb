require 'formula'

#Builds Boost with clang and c++11

class Boost150 < Formula
  homepage 'http://boost.org'
  url 'http://sourceforge.net/projects/boost/files/boost/1.50.0/boost_1_50_0.tar.bz2'
  sha1 'ee06f89ed472cf369573f8acf9819fbc7173344e'

  def install
    system "./bootstrap.sh", "--prefix=#{prefix}"
    system "./b2", "toolset=clang", "cxxflags=-std=c++0x -stdlib=libc++", "linkflags=-stdlib=libc++", "--without-signals", "install"
  end
end

