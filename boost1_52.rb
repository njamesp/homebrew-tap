require 'formula'

#Builds Boost with clang and c++11

class Boost152 < Formula
  homepage 'http://boost.org'
  url 'http://sourceforge.net/projects/boost/files/boost/1.52.0/boost_1_52_0.tar.gz'
  sha256 'eea637a4ce9f9b45a0d5e00bb9462c9f084086264d85d63133dd6d240398b28f'

  def install
    system "./bootstrap.sh", "--libdir=#{prefix}/lib/", "--includedir=#{prefix}/include/", "--with-python=#{HOMEBREW_PREFIX}/bin/python"

    system "./b2", "toolset=clang", "cxxflags=-std=c++0x -stdlib=libc++", "linkflags=-stdlib=libc++", "--without-mpi", "--without-signals", "variant=release", "threading=multi", "install"
  end
end

