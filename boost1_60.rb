require 'formula'

#Builds Boost with clang and c++11

class Boost160 < Formula
  homepage 'http://boost.org'
  url 'http://sourceforge.net/projects/boost/files/boost/1.60.0/boost_1_60_0.tar.gz'
  sha256 '21ef30e7940bc09a0b77a6e59a8eee95f01a766aa03cdfa02f8e167491716ee4'

  def install
    system "./bootstrap.sh", "--libdir=#{prefix}/lib/", "--includedir=#{prefix}/include/", "--with-python=#{HOMEBREW_PREFIX}/bin/python"

    system "./b2", "toolset=clang", "cxxflags=-std=c++0x -stdlib=libc++", "linkflags=-stdlib=libc++", "--without-mpi", "--without-signals", "variant=release", "threading=multi", "install"
  end
end

