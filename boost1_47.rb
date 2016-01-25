require 'formula'

#Builds Boost with clang and c++11

class Boost147 < Formula
  homepage 'http://boost.org'
  url 'http://sourceforge.net/projects/boost/files/boost/1.47.0/boost_1_47_0.tar.gz'
  sha256 '73d62846091af316cfe4efbc112f21d02b7c2cfe8511737be5e497bcb61ce1a3'

  def install
    system "./bootstrap.sh", "--libdir=#{prefix}/lib/", "--includedir=#{prefix}/include/", "--with-python=#{HOMEBREW_PREFIX}/bin/python"

    system "./b2", "toolset=clang", "cxxflags=-std=c++0x -stdlib=libc++", "linkflags=-stdlib=libc++", "--without-mpi", "--without-signals", "variant=release", "threading=multi", "install"
  end
end

