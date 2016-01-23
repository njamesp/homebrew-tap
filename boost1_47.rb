require 'formula'

#Builds Boost with clang and c++11

class Boost147 < Formula
  homepage 'http://boost.org'
  url 'http://sourceforge.net/projects/boost/files/boost/1.47.0/boost_1_47_0.tar.gz'

  def install
    system "./bootstrap.sh", "--libdir=#{HOMEBREW_PREFIX}/Boost/1.47/lib/", "--includedir=#{HOMEBREW_PREFIX}/Boost/1.47/include/", "--with-python=#{HOMEBREW_PREFIX}/bin/python"

    system "./b2", "toolset=clang", "cxxflags=-std=c++0x -stdlib=libc++", "linkflags=-stdlib=libc++", "--without-mpi", "--without-signals", "variant=release", "threading=multi", "install"
  end
end
