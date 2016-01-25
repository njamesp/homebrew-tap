require 'formula'

#Builds Boost with clang and c++11

class Boost151 < Formula
  homepage 'http://boost.org'
  url 'http://sourceforge.net/projects/boost/files/boost/1.51.0/boost_1_51_0.tar.gz'
  sha256 'b0f7ecc66eb7d6ee5a865f34dbe6791dcdf0ffeac5925142deeaa67d3c8c23f5'

  def install
    system "./bootstrap.sh", "--libdir=#{prefix}/lib/", "--includedir=#{prefix}/include/", "--with-python=#{HOMEBREW_PREFIX}/bin/python"

    system "./b2", "toolset=clang", "cxxflags=-std=c++0x -stdlib=libc++", "linkflags=-stdlib=libc++", "--without-mpi", "--without-signals", "variant=release", "threading=multi", "install"
  end
end

