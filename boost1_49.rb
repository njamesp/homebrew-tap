require 'formula'

#Builds Boost with clang and c++11

class Boost149 < Formula
  homepage 'http://boost.org'
  url 'http://sourceforge.net/projects/boost/files/boost/1.49.0/boost_1_49_0.tar.gz'
  sha256 'a3ec4475feefa4b57c93de4c6b1bf4db1a63557c53e64b9844968c603e539bf3'

  def install
    system "./bootstrap.sh", "--libdir=#{prefix}/lib/", "--includedir=#{prefix}/include/", "--with-python=#{HOMEBREW_PREFIX}/bin/python"

    system "./b2", "toolset=clang", "cxxflags=-std=c++0x -stdlib=libc++", "linkflags=-stdlib=libc++", "--without-mpi", "--without-signals", "variant=release", "threading=multi", "install"
  end
end

