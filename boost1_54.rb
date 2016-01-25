require 'formula'

#Builds Boost with clang and c++11

class Boost154 < Formula
  homepage 'http://boost.org'
  url 'http://sourceforge.net/projects/boost/files/boost/1.54.0/boost_1_54_0.tar.gz'
  sha256 '412d003299e72555e1e1f62f51d3b07eca2a1911e27c442ee1c08167826ef9e2'

  def install
    system "./bootstrap.sh", "--libdir=#{prefix}/lib/", "--includedir=#{prefix}/include/", "--with-python=#{HOMEBREW_PREFIX}/bin/python"

    system "./b2", "toolset=clang", "cxxflags=-std=c++0x -stdlib=libc++", "linkflags=-stdlib=libc++", "--without-mpi", "--without-signals", "variant=release", "threading=multi", "install"
  end
end

