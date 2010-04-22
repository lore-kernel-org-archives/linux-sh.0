From: Conrad Parker <conrad@metadecks.org>
Date: Thu, 22 Apr 2010 08:07:06 +0000
Subject: libshveu 1.2.0 released
Message-Id: <s2idba6c0831004220107xdf676a17o10d449e201b1fd1a@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

libshveu 1.2.0
=======

libshveu: A library for controlling SH-Mobile VEU

The source archive, and more information about the library are available from:

	http://oss.renesas.com/modules/document/?libshveu


New in this release
-------------------

	* Added support for building for Android.

	* Fixed colorspace issues when enlarging from VGA to D1

	* Add detection of VEU hardware revision

Changes
-------

This release includes the following changes since version 1.1.0:

Atsuhiro Ito (2):
      Handle VRPBR register setting for enlargement
      Add ifdef KERNEL 2.6.33 branch

Conrad Parker (8):
      configure.ac typo: shveu_pkgdeps
      add VEU3F detection
      Add VRPBR register handling for VEU3F (sh7724)
      shveu_open: propagate error conditions
      shveu_convert: fail on error opening VEU
      add TODO file with some suggested improvements.
      TODO: update with simpler API ideas
      Release 1.2.0

Katsuya Matsubara (3):
      fix pixel density to calculate VDAYR offset for rotation
      android: add Android.mk
      shveu-convert: fix wrong destination pitch for shveu_operation()

Phil Edworthy (1):
      Added parameter checks.

 Android.mk                    |    4 ++
 TODO                          |   19 +++++++
 configure.ac                  |    4 +-
 src/Android.mk                |    1 +
 src/libshveu/Android.mk       |   17 +++++++
 src/libshveu/shveu_regs.h     |    2 +
 src/libshveu/veu_colorspace.c |  107 ++++++++++++++++++++++++++++++++++++-----
 src/tools/Android.mk          |   10 ++++
 src/tools/shveu-convert.c     |    7 ++-
 9 files changed, 154 insertions(+), 17 deletions(-)
 create mode 100644 Android.mk
 create mode 100644 TODO
 create mode 100644 src/Android.mk
 create mode 100644 src/libshveu/Android.mk
 create mode 100644 src/tools/Android.mk
