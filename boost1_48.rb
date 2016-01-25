require 'formula'

#Builds Boost with clang and c++11

class Boost148 < Formula
  homepage 'http://boost.org'
  url 'http://sourceforge.net/projects/boost/files/boost/1.48.0/boost_1_48_0.tar.gz'
  sha256 '01c8c3330a7a5013b8cfab18a3b80fcfd89001701ea5907c9ae635b97bc2c789'

  def install
    system "./bootstrap.sh", "--libdir=#{prefix}/lib/", "--includedir=#{prefix}/include/", "--with-python=#{HOMEBREW_PREFIX}/bin/python"

    system "./b2", "toolset=clang", "cxxflags=-std=c++0x -stdlib=libc++", "linkflags=-stdlib=libc++", "--without-mpi", "--without-signals", "variant=release", "threading=multi", "install"
  end
end

