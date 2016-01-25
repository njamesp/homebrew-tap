require 'formula'

#Builds Boost with clang and c++11

class Boost157 < Formula
  homepage 'http://boost.org'
  url 'http://sourceforge.net/projects/boost/files/boost/1.57.0/boost_1_57_0.tar.gz'
  sha256 'fea9c7472f7a52cec2a1640958145b2144bf17903a21db65b95efb6ae5817fa5'

  def install
    system "./bootstrap.sh", "--libdir=#{prefix}/lib/", "--includedir=#{prefix}/include/", "--with-python=#{HOMEBREW_PREFIX}/bin/python"

    system "./b2", "toolset=clang", "cxxflags=-std=c++0x -stdlib=libc++", "linkflags=-stdlib=libc++", "--without-mpi", "--without-signals", "variant=release", "threading=multi", "install"
  end
end

