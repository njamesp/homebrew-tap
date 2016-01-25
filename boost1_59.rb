require 'formula'

#Builds Boost with clang and c++11

class Boost159 < Formula
  homepage 'http://boost.org'
  url 'http://sourceforge.net/projects/boost/files/boost/1.59.0/boost_1_59_0.tar.gz'
  sha256 '47f11c8844e579d02691a607fbd32540104a9ac7a2534a8ddaef50daf502baac'

  def install
    system "./bootstrap.sh", "--libdir=#{prefix}/lib/", "--includedir=#{prefix}/include/", "--with-python=#{HOMEBREW_PREFIX}/bin/python"

    system "./b2", "toolset=clang", "cxxflags=-std=c++0x -stdlib=libc++", "linkflags=-stdlib=libc++", "--without-mpi", "--without-signals", "variant=release", "threading=multi", "install"
  end
end

