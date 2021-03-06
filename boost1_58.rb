require 'formula'

#Builds Boost with clang and c++11

class Boost158 < Formula
  homepage 'http://boost.org'
  url 'http://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.gz'
  sha256 'a004d9b3fa95e956383693b86fce1b68805a6f71c2e68944fa813de0fb8c8102'

  def install
    system "./bootstrap.sh", "--libdir=#{prefix}/lib/", "--includedir=#{prefix}/include/", "--with-python=#{HOMEBREW_PREFIX}/bin/python"

    system "./b2", "toolset=clang", "cxxflags=-std=c++0x -stdlib=libc++", "linkflags=-stdlib=libc++", "--without-mpi", "--without-signals", "variant=release", "threading=multi", "install"
  end
end

