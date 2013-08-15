require 'formula'

#Builds Libkml with clang and c++11

class Libkml < Formula
  homepage 'http://code.google.com/p/libkml/'
  url 'http://libkml.googlecode.com/files/libkml-1.2.0.tar.gz'
  sha1 '3fa5acdc2b2185d7f0316d205002b7162f079894'

  depends_on :automake
  depends_on :libtool

  def patches
    # Disable -Werror (viral)
    # Fix an include
    # Fix a few dumb coding errors (cerr << ... << cerr;)
    DATA
  end

  def install
    system "./configure", "--prefix=#{prefix}", "CC=/usr/bin/clang", "CXX=/usr/bin/clang++", "CXXFLAGS=-stdlib=libc++ -std=c++0x", "LDFLAGS=-stdlib=libc++"
    system "make install"
  end
end


#The Script I generated this Formula from:
#
#  wget http://libkml.googlecode.com/files/libkml-1.2.0.tar.gz
#  tar -xvf libkml-1.2.0.tar.gz
#  cd libkml-1.2.0
#   
#  #Fix a missing include
#  mv src/kml/base/file_posix.cc src/kml/base/file_posix.cc.bak
#  awk 'NR == 34 {print "#include <unistd.h>"} {print}' src/kml/base/file_posix.cc.bak > src/kml/base/file_posix.cc
#   
#  #Use clang, libc++ and c++11
#  ./configure CC=/usr/bin/clang CXX=/usr/bin/clang++ CXXFLAGS="-stdlib=libc++ -std=c++0x" LDFLAGS="-stdlib=libc++"
#   
#  #Don't use -Werror
#  for x in `find . -name "Makefile*"`; do echo $x; sed -e "s/-Werror//g" < $x > $x.bak; mv $x.bak $x; done
#   
#  #Fix stupid coding (cerr << "hello world" << cerr;)  WTF?
#  for f in ./examples/engine/inlinestyles.cc ./examples/engine/splitstyles.cc; do mv $f $f.bak; sed "s/cerr;/endl;/" < $f.bak > $f; done
#  #Build & Install
#  make
#  sudo make install


#Patches Follow

__END__
diff --git a/aclocal.m4 b/aclocal.m4
index c05ecd4..b163d00 100644
--- a/aclocal.m4
+++ b/aclocal.m4
@@ -249,7 +249,7 @@ AC_CACHE_CHECK([dependency style of $depcc],
        grep sub/conftest.${OBJEXT-o} sub/conftest.Po > /dev/null 2>&1 &&
        ${MAKE-make} -s -f confmf > /dev/null 2>&1; then
       # icc doesn't choke on unknown options, it will just issue warnings
-      # or remarks (even with -Werror).  So we grep stderr for any message
+      # or remarks (even with).  So we grep stderr for any message
       # that says an option was ignored or not supported.
       # When given -MP, icc 7.0 and 7.1 complain thusly:
       #   icc: Command line warning: ignoring option '-M'; no argument required
diff --git a/configure b/configure
index da42831..6b277b9 100755
--- a/configure
+++ b/configure
@@ -3635,7 +3635,7 @@ else
        grep sub/conftest.${OBJEXT-o} sub/conftest.Po > /dev/null 2>&1 &&
        ${MAKE-make} -s -f confmf > /dev/null 2>&1; then
       # icc doesn't choke on unknown options, it will just issue warnings
-      # or remarks (even with -Werror).  So we grep stderr for any message
+      # or remarks (even with).  So we grep stderr for any message
       # that says an option was ignored or not supported.
       # When given -MP, icc 7.0 and 7.1 complain thusly:
       #   icc: Command line warning: ignoring option '-M'; no argument required
@@ -4351,7 +4351,7 @@ else
        grep sub/conftest.${OBJEXT-o} sub/conftest.Po > /dev/null 2>&1 &&
        ${MAKE-make} -s -f confmf > /dev/null 2>&1; then
       # icc doesn't choke on unknown options, it will just issue warnings
-      # or remarks (even with -Werror).  So we grep stderr for any message
+      # or remarks (even with).  So we grep stderr for any message
       # that says an option was ignored or not supported.
       # When given -MP, icc 7.0 and 7.1 complain thusly:
       #   icc: Command line warning: ignoring option '-M'; no argument required
@@ -7959,7 +7959,7 @@ else
        grep sub/conftest.${OBJEXT-o} sub/conftest.Po > /dev/null 2>&1 &&
        ${MAKE-make} -s -f confmf > /dev/null 2>&1; then
       # icc doesn't choke on unknown options, it will just issue warnings
-      # or remarks (even with -Werror).  So we grep stderr for any message
+      # or remarks (even with).  So we grep stderr for any message
       # that says an option was ignored or not supported.
       # When given -MP, icc 7.0 and 7.1 complain thusly:
       #   icc: Command line warning: ignoring option '-M'; no argument required
diff --git a/configure.ac b/configure.ac
index fff8c92..52ae41d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -6,7 +6,7 @@ AC_PREREQ(2.57)
 AC_INIT(libkml, 1.2.0, http://code.google.com/p/libkml/issues)
 AC_CONFIG_SRCDIR(README)
 AC_CONFIG_AUX_DIR(config)
-AM_INIT_AUTOMAKE(-Wall -Werror)
+AM_INIT_AUTOMAKE(-Wall)
 
 AC_PROG_CPP
 AC_PROG_CXX
diff --git a/examples/engine/Makefile.am b/examples/engine/Makefile.am
index baf346b..a62b033 100644
--- a/examples/engine/Makefile.am
+++ b/examples/engine/Makefile.am
@@ -2,7 +2,7 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
 	      -I$(top_srcdir)/third_party/boost_1_34_1
 
 if GCC
-AM_CXXFLAGS = -Wall -Werror -ansi -pedantic -fno-rtti
+AM_CXXFLAGS = -Wall -ansi -pedantic -fno-rtti
 endif
 
 noinst_PROGRAMS = \
diff --git a/examples/engine/Makefile.in b/examples/engine/Makefile.in
index 36cf9f9..808c56d 100644
--- a/examples/engine/Makefile.in
+++ b/examples/engine/Makefile.in
@@ -303,7 +303,7 @@ top_srcdir = @top_srcdir@
 AM_CPPFLAGS = -I$(top_srcdir)/src \
 	      -I$(top_srcdir)/third_party/boost_1_34_1
 
-@GCC_TRUE@AM_CXXFLAGS = -Wall -Werror -ansi -pedantic -fno-rtti
+@GCC_TRUE@AM_CXXFLAGS = -Wall -ansi -pedantic -fno-rtti
 balloonwalker_SOURCES = balloonwalker.cc
 balloonwalker_LDADD = \
 	$(top_builddir)/src/kml/engine/libkmlengine.la \
diff --git a/examples/engine/inlinestyles.cc b/examples/engine/inlinestyles.cc
index 1cb4755..8ad1f57 100644
--- a/examples/engine/inlinestyles.cc
+++ b/examples/engine/inlinestyles.cc
@@ -35,20 +35,20 @@
 bool InlineStyles(const char* input_filename, const char* output_filename) {
   std::string kml_input;
   if (!kmlbase::File::ReadFileToString(input_filename, &kml_input)) {
-    std::cerr << "read failed: " << input_filename << std::cerr;
+    std::cerr << "read failed: " << input_filename << std::endl;
     return false;
   }
   std::string errors;
   kmldom::ElementPtr root = kmlengine::InlineStyles(kml_input, &errors);
   if (!root) {
-    std::cerr << "parse failed: " << input_filename << std::cerr;
-    std::cerr << "parse failed: " << errors << std::cerr;
+    std::cerr << "parse failed: " << input_filename << std::endl;
+    std::cerr << "parse failed: " << errors << std::endl;
     return false;
   }
 
   std::string kml_output = kmldom::SerializePretty(root);
   if (!kmlbase::File::WriteStringToFile(kml_output, output_filename)) {
-    std::cerr << "write failed: " << output_filename << std::cerr;
+    std::cerr << "write failed: " << output_filename << std::endl;
     return false;
   }
   return true;
diff --git a/examples/engine/splitstyles.cc b/examples/engine/splitstyles.cc
index a3b190a..56203c9 100644
--- a/examples/engine/splitstyles.cc
+++ b/examples/engine/splitstyles.cc
@@ -35,20 +35,20 @@
 bool SplitStyles(const char* input_filename, const char* output_filename) {
   std::string kml_input;
   if (!kmlbase::File::ReadFileToString(input_filename, &kml_input)) {
-    std::cerr << "read failed: " << input_filename << std::cerr;
+    std::cerr << "read failed: " << input_filename << std::endl;
     return false;
   }
   std::string errors;
   kmldom::ElementPtr root = kmlengine::SplitStyles(kml_input, &errors);
   if (!root) {
-    std::cerr << "parse failed: " << input_filename << std::cerr;
-    std::cerr << "parse failed: " << errors << std::cerr;
+    std::cerr << "parse failed: " << input_filename << std::endl;
+    std::cerr << "parse failed: " << errors << std::endl;
     return false;
   }
 
   std::string kml_output = kmldom::SerializePretty(root);
   if (!kmlbase::File::WriteStringToFile(kml_output, output_filename)) {
-    std::cerr << "write failed: " << output_filename << std::cerr;
+    std::cerr << "write failed: " << output_filename << std::endl;
     return false;
   }
   return true;
diff --git a/examples/gpx/Makefile.am b/examples/gpx/Makefile.am
index 056cd1d..c8efbff 100644
--- a/examples/gpx/Makefile.am
+++ b/examples/gpx/Makefile.am
@@ -2,7 +2,7 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
 	      -I$(top_srcdir)/third_party/boost_1_34_1
 
 if GCC
-AM_CXXFLAGS = -Wall -Werror -ansi -pedantic -fno-rtti
+AM_CXXFLAGS = -Wall -ansi -pedantic -fno-rtti
 endif
 
 noinst_PROGRAMS = gpxtracktokml
diff --git a/examples/gpx/Makefile.in b/examples/gpx/Makefile.in
index f182e28..0b0c26e 100644
--- a/examples/gpx/Makefile.in
+++ b/examples/gpx/Makefile.in
@@ -204,7 +204,7 @@ top_srcdir = @top_srcdir@
 AM_CPPFLAGS = -I$(top_srcdir)/src \
 	      -I$(top_srcdir)/third_party/boost_1_34_1
 
-@GCC_TRUE@AM_CXXFLAGS = -Wall -Werror -ansi -pedantic -fno-rtti
+@GCC_TRUE@AM_CXXFLAGS = -Wall -ansi -pedantic -fno-rtti
 gpxtracktokml_SOURCES = gpxtracktokml.cc
 gpxtracktokml_LDADD = \
 	$(top_builddir)/src/kml/convenience/libkmlconvenience.la \
diff --git a/examples/gx/Makefile.am b/examples/gx/Makefile.am
index 85040ab..3ecced2 100644
--- a/examples/gx/Makefile.am
+++ b/examples/gx/Makefile.am
@@ -2,7 +2,7 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
 	      -I$(top_srcdir)/third_party/boost_1_34_1
 
 if GCC
-AM_CXXFLAGS = -Wall -Werror -ansi -pedantic -fno-rtti
+AM_CXXFLAGS = -Wall -ansi -pedantic -fno-rtti
 endif
 
 noinst_PROGRAMS = \
diff --git a/examples/gx/Makefile.in b/examples/gx/Makefile.in
index aacfc1a..2b3b9fb 100644
--- a/examples/gx/Makefile.in
+++ b/examples/gx/Makefile.in
@@ -211,7 +211,7 @@ top_srcdir = @top_srcdir@
 AM_CPPFLAGS = -I$(top_srcdir)/src \
 	      -I$(top_srcdir)/third_party/boost_1_34_1
 
-@GCC_TRUE@AM_CXXFLAGS = -Wall -Werror -ansi -pedantic -fno-rtti
+@GCC_TRUE@AM_CXXFLAGS = -Wall -ansi -pedantic -fno-rtti
 gpxfly_SOURCES = gpxfly.cc
 gpxfly_LDADD = \
 	$(top_builddir)/src/kml/convenience/libkmlconvenience.la \
diff --git a/examples/hellonet/Makefile.am b/examples/hellonet/Makefile.am
index f4d313e..7af15d5 100644
--- a/examples/hellonet/Makefile.am
+++ b/examples/hellonet/Makefile.am
@@ -4,7 +4,7 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
 	      -I$(top_srcdir)/third_party/boost_1_34_1
 
 if GCC
-AM_CXXFLAGS = -Wall -Werror -ansi -pedantic -fno-rtti
+AM_CXXFLAGS = -Wall -ansi -pedantic -fno-rtti
 endif
 
 noinst_PROGRAMS = csvurl2gmap getgmapkml getgsheetcsv getgsheetkml \
diff --git a/examples/hellonet/Makefile.in b/examples/hellonet/Makefile.in
index d71720f..44a4c85 100644
--- a/examples/hellonet/Makefile.in
+++ b/examples/hellonet/Makefile.in
@@ -379,7 +379,7 @@ top_srcdir = @top_srcdir@
 @HAVE_CURL_TRUE@	      -I$(top_srcdir)/examples/hellonet \
 @HAVE_CURL_TRUE@	      -I$(top_srcdir)/third_party/boost_1_34_1
 
-@GCC_TRUE@@HAVE_CURL_TRUE@AM_CXXFLAGS = -Wall -Werror -ansi -pedantic -fno-rtti
+@GCC_TRUE@@HAVE_CURL_TRUE@AM_CXXFLAGS = -Wall -ansi -pedantic -fno-rtti
 @HAVE_CURL_TRUE@noinst_LTLIBRARIES = libcurlfetch.la
 @HAVE_CURL_TRUE@libcurlfetch_la_SOURCES = curlfetch.cc
 @HAVE_CURL_TRUE@libcurlfetch_la_LIBADD = -lcurl
diff --git a/examples/helloworld/Makefile.am b/examples/helloworld/Makefile.am
index 76f4e92..f8e9c75 100644
--- a/examples/helloworld/Makefile.am
+++ b/examples/helloworld/Makefile.am
@@ -4,7 +4,7 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
 
 
 if GCC
-AM_CXXFLAGS = -Wall -Werror -ansi -pedantic -fno-rtti
+AM_CXXFLAGS = -Wall -ansi -pedantic -fno-rtti
 endif
 
 noinst_LTLIBRARIES = libhelloutil.la
diff --git a/examples/helloworld/Makefile.in b/examples/helloworld/Makefile.in
index 939cb49..13c968f 100644
--- a/examples/helloworld/Makefile.in
+++ b/examples/helloworld/Makefile.in
@@ -327,7 +327,7 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
 	      -I$(top_srcdir)/examples/helloworld \
 	      -I$(top_srcdir)/third_party/boost_1_34_1
 
-@GCC_TRUE@AM_CXXFLAGS = -Wall -Werror -ansi -pedantic -fno-rtti
+@GCC_TRUE@AM_CXXFLAGS = -Wall -ansi -pedantic -fno-rtti
 noinst_LTLIBRARIES = libhelloutil.la
 libhelloutil_la_SOURCES = print.cc
 libhelloutil_la_LIBADD = $(top_builddir)/third_party/libminizip.la
diff --git a/examples/regionator/Makefile.am b/examples/regionator/Makefile.am
index fa42288..cb9ba61 100644
--- a/examples/regionator/Makefile.am
+++ b/examples/regionator/Makefile.am
@@ -3,7 +3,7 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
               -I$(top_srcdir)/third_party/zlib-1.2.3/contrib
 
 if GCC
-AM_CXXFLAGS = -Wall -Werror -ansi -pedantic -fno-rtti
+AM_CXXFLAGS = -Wall -ansi -pedantic -fno-rtti
 endif
 
 noinst_PROGRAMS = csvregionator
diff --git a/examples/regionator/Makefile.in b/examples/regionator/Makefile.in
index 57cdb76..7052e2e 100644
--- a/examples/regionator/Makefile.in
+++ b/examples/regionator/Makefile.in
@@ -206,7 +206,7 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
               -I$(top_srcdir)/third_party/boost_1_34_1 \
               -I$(top_srcdir)/third_party/zlib-1.2.3/contrib
 
-@GCC_TRUE@AM_CXXFLAGS = -Wall -Werror -ansi -pedantic -fno-rtti
+@GCC_TRUE@AM_CXXFLAGS = -Wall -ansi -pedantic -fno-rtti
 csvregionator_SOURCES = csvregionator.cc
 csvregionator_LDADD = \
 	$(top_builddir)/src/kml/base/libkmlbase.la \
diff --git a/examples/xsd/Makefile.am b/examples/xsd/Makefile.am
index 5d2dea7..477cd6d 100644
--- a/examples/xsd/Makefile.am
+++ b/examples/xsd/Makefile.am
@@ -3,7 +3,7 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
 	      -I$(top_srcdir)/third_party/boost_1_34_1
 
 if GCC
-AM_CXXFLAGS = -Wall -Werror -ansi -pedantic -fno-rtti
+AM_CXXFLAGS = -Wall -ansi -pedantic -fno-rtti
 endif
 
 noinst_PROGRAMS = xsdchildren xsdcoverage xsdelements xsdenums xsdfind xsdtypes
diff --git a/examples/xsd/Makefile.in b/examples/xsd/Makefile.in
index 48c39a0..b5cf8ad 100644
--- a/examples/xsd/Makefile.in
+++ b/examples/xsd/Makefile.in
@@ -236,7 +236,7 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
 	      -I$(top_srcdir)/examples/xsd \
 	      -I$(top_srcdir)/third_party/boost_1_34_1
 
-@GCC_TRUE@AM_CXXFLAGS = -Wall -Werror -ansi -pedantic -fno-rtti
+@GCC_TRUE@AM_CXXFLAGS = -Wall -ansi -pedantic -fno-rtti
 xsdchildren_SOURCES = xsdchildren.cc
 xsdchildren_LDADD = \
 	$(top_builddir)/src/kml/xsd/libkmlxsd.la \
diff --git a/src/kml/base/Makefile.am b/src/kml/base/Makefile.am
index 2c57c53..f413dc4 100644
--- a/src/kml/base/Makefile.am
+++ b/src/kml/base/Makefile.am
@@ -5,8 +5,8 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
               -I$(top_srcdir)/third_party/zlib-1.2.3/contrib
 
 if GCC
-AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -pedantic -fno-rtti
-AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -fno-rtti -DGTEST_HAS_RTTI=0
+AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -pedantic -fno-rtti
+AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -fno-rtti -DGTEST_HAS_RTTI=0
 endif
 
 libkmlbase_la_LDFLAGS = -lexpat
diff --git a/src/kml/base/Makefile.in b/src/kml/base/Makefile.in
index db87c71..b6db00d 100644
--- a/src/kml/base/Makefile.in
+++ b/src/kml/base/Makefile.in
@@ -446,8 +446,8 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
               -I$(top_srcdir)/third_party/uriparser-0.7.5/include \
               -I$(top_srcdir)/third_party/zlib-1.2.3/contrib
 
-@GCC_TRUE@AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -pedantic -fno-rtti
-@GCC_TRUE@AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -fno-rtti -DGTEST_HAS_RTTI=0
+@GCC_TRUE@AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -pedantic -fno-rtti
+@GCC_TRUE@AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -fno-rtti -DGTEST_HAS_RTTI=0
 libkmlbase_la_LDFLAGS = -lexpat
 lib_LTLIBRARIES = libkmlbase.la
 libkmlbase_la_SOURCES = \
diff --git a/src/kml/base/file_posix.cc b/src/kml/base/file_posix.cc
index 764ae55..7a4a16d 100644
--- a/src/kml/base/file_posix.cc
+++ b/src/kml/base/file_posix.cc
@@ -31,6 +31,7 @@
 #include <string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <unistd.h>
 
 namespace kmlbase {
 
diff --git a/src/kml/convenience/Makefile.am b/src/kml/convenience/Makefile.am
index 8327c8c..a5f9cc6 100644
--- a/src/kml/convenience/Makefile.am
+++ b/src/kml/convenience/Makefile.am
@@ -3,8 +3,8 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
               -I$(top_srcdir)/third_party/googletest-r108/include
 
 if GCC
-AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -pedantic -fno-rtti
-AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -fno-rtti -DGTEST_HAS_RTTI=0
+AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -pedantic -fno-rtti
+AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -fno-rtti -DGTEST_HAS_RTTI=0
 endif
 
 # These header files are added to the distribution such that it can be built,
diff --git a/src/kml/convenience/Makefile.in b/src/kml/convenience/Makefile.in
index 2461c53..cfd88f1 100644
--- a/src/kml/convenience/Makefile.in
+++ b/src/kml/convenience/Makefile.in
@@ -403,8 +403,8 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
 	      -I$(top_srcdir)/third_party/boost_1_34_1 \
               -I$(top_srcdir)/third_party/googletest-r108/include
 
-@GCC_TRUE@AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -pedantic -fno-rtti
-@GCC_TRUE@AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -fno-rtti -DGTEST_HAS_RTTI=0
+@GCC_TRUE@AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -pedantic -fno-rtti
+@GCC_TRUE@AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -fno-rtti -DGTEST_HAS_RTTI=0
 
 # These header files are added to the distribution such that it can be built,
 # but these header files should not be used in application code.
diff --git a/src/kml/dom/Makefile.am b/src/kml/dom/Makefile.am
index 9dfd56b..da35d21 100644
--- a/src/kml/dom/Makefile.am
+++ b/src/kml/dom/Makefile.am
@@ -3,8 +3,8 @@ AM_CPPFLAGS= -I$(top_srcdir)/src \
 	     -I$(top_srcdir)/third_party/googletest-r108/include
 
 if GCC
-AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -pedantic -fno-rtti
-AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -fno-rtti -DGTEST_HAS_RTTI=0
+AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -pedantic -fno-rtti
+AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -fno-rtti -DGTEST_HAS_RTTI=0
 endif
 
 lib_LTLIBRARIES = libkmldom.la
diff --git a/src/kml/dom/Makefile.in b/src/kml/dom/Makefile.in
index 7e0b40e..aee83b2 100644
--- a/src/kml/dom/Makefile.in
+++ b/src/kml/dom/Makefile.in
@@ -777,8 +777,8 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
 	     -I$(top_srcdir)/third_party/boost_1_34_1 \
 	     -I$(top_srcdir)/third_party/googletest-r108/include
 
-@GCC_TRUE@AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -pedantic -fno-rtti
-@GCC_TRUE@AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -fno-rtti -DGTEST_HAS_RTTI=0
+@GCC_TRUE@AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -pedantic -fno-rtti
+@GCC_TRUE@AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -fno-rtti -DGTEST_HAS_RTTI=0
 lib_LTLIBRARIES = libkmldom.la
 libkmldom_la_SOURCES = \
 	abstractlatlonbox.cc \
diff --git a/src/kml/engine/Makefile.am b/src/kml/engine/Makefile.am
index 4fecdfb..8c6e7bd 100644
--- a/src/kml/engine/Makefile.am
+++ b/src/kml/engine/Makefile.am
@@ -3,8 +3,8 @@ AM_CPPFLAGS= -I$(top_srcdir)/src \
 	     -I$(top_srcdir)/third_party/googletest-r108/include
 
 if GCC
-AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -pedantic -fno-rtti
-AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -fno-rtti -DGTEST_HAS_RTTI=0
+AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -pedantic -fno-rtti
+AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -fno-rtti -DGTEST_HAS_RTTI=0
 endif
 
 lib_LTLIBRARIES = libkmlengine.la
diff --git a/src/kml/engine/Makefile.in b/src/kml/engine/Makefile.in
index ec7dfbb..1286335 100644
--- a/src/kml/engine/Makefile.in
+++ b/src/kml/engine/Makefile.in
@@ -627,8 +627,8 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
 	     -I$(top_srcdir)/third_party/boost_1_34_1 \
 	     -I$(top_srcdir)/third_party/googletest-r108/include
 
-@GCC_TRUE@AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -pedantic -fno-rtti
-@GCC_TRUE@AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -fno-rtti -DGTEST_HAS_RTTI=0
+@GCC_TRUE@AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -pedantic -fno-rtti
+@GCC_TRUE@AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -fno-rtti -DGTEST_HAS_RTTI=0
 lib_LTLIBRARIES = libkmlengine.la
 libkmlengine_la_SOURCES = \
 	clone.cc \
diff --git a/src/kml/regionator/Makefile.am b/src/kml/regionator/Makefile.am
index 523c913..0fec2fa 100644
--- a/src/kml/regionator/Makefile.am
+++ b/src/kml/regionator/Makefile.am
@@ -4,8 +4,8 @@ AM_CPPFLAGS= -I$(top_srcdir)/src \
 
 
 if GCC
-AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -pedantic -fno-rtti
-AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -fno-rtti -DGTEST_HAS_RTTI=0
+AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -pedantic -fno-rtti
+AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -fno-rtti -DGTEST_HAS_RTTI=0
 endif
 
 lib_LTLIBRARIES = libkmlregionator.la
diff --git a/src/kml/regionator/Makefile.in b/src/kml/regionator/Makefile.in
index 22b29e1..bdc30c4 100644
--- a/src/kml/regionator/Makefile.in
+++ b/src/kml/regionator/Makefile.in
@@ -279,8 +279,8 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
              -I$(top_srcdir)/third_party/boost_1_34_1 \
 	     -I$(top_srcdir)/third_party/googletest-r108/include
 
-@GCC_TRUE@AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -pedantic -fno-rtti
-@GCC_TRUE@AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -fno-rtti -DGTEST_HAS_RTTI=0
+@GCC_TRUE@AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -pedantic -fno-rtti
+@GCC_TRUE@AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -fno-rtti -DGTEST_HAS_RTTI=0
 lib_LTLIBRARIES = libkmlregionator.la
 libkmlregionator_la_SOURCES = \
 	feature_list_region_handler.cc \
diff --git a/src/kml/xsd/Makefile.am b/src/kml/xsd/Makefile.am
index 3db1f15..99e3a54 100644
--- a/src/kml/xsd/Makefile.am
+++ b/src/kml/xsd/Makefile.am
@@ -3,8 +3,8 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
 	      -I$(top_srcdir)/third_party/googletest-r108/include
 
 if GCC
-AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -pedantic -fno-rtti
-AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -fno-rtti -DGTEST_HAS_RTTI=0
+AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -pedantic -fno-rtti
+AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -fno-rtti -DGTEST_HAS_RTTI=0
 endif
 
 lib_LTLIBRARIES = libkmlxsd.la
diff --git a/src/kml/xsd/Makefile.in b/src/kml/xsd/Makefile.in
index 8f748cc..b0a80f8 100644
--- a/src/kml/xsd/Makefile.in
+++ b/src/kml/xsd/Makefile.in
@@ -322,8 +322,8 @@ AM_CPPFLAGS = -I$(top_srcdir)/src \
               -I$(top_srcdir)/third_party/boost_1_34_1 \
 	      -I$(top_srcdir)/third_party/googletest-r108/include
 
-@GCC_TRUE@AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -pedantic -fno-rtti
-@GCC_TRUE@AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -Werror -ansi -fno-rtti -DGTEST_HAS_RTTI=0
+@GCC_TRUE@AM_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -pedantic -fno-rtti
+@GCC_TRUE@AM_TEST_CXXFLAGS = -Wall -Wextra -Wno-unused-parameter -ansi -fno-rtti -DGTEST_HAS_RTTI=0
 lib_LTLIBRARIES = libkmlxsd.la
 libkmlxsd_la_SOURCES = \
 	xsd_complex_type.cc \
