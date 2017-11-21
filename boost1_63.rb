require 'formula'

#Builds Boost with clang and c++11

class Boost163 < Formula
  homepage 'http://boost.org'
  url 'http://sourceforge.net/projects/boost/files/boost/1.63.0/boost_1_63_0.tar.gz'
  sha256 'fe34a4e119798e10b8cc9e565b3b0284e9fd3977ec8a1b19586ad1dec397088b'

  def install
    system "./bootstrap.sh", "--libdir=#{prefix}/lib/", "--includedir=#{prefix}/include/", "--with-python=#{HOMEBREW_PREFIX}/bin/python"

    system "./b2", "toolset=clang", "cxxflags=-std=c++1z -stdlib=libc++", "linkflags=-stdlib=libc++", "--without-mpi", "--without-signals", "variant=release", "threading=multi", "install"
  end
end

