From: Conrad Parker <conrad@metadecks.org>
Date: Tue, 27 Apr 2010 02:41:05 +0000
Subject: libshveu 1.3.0 released
Message-Id: <r2odba6c0831004261941gca92e353ie4595c3c5e90f868@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

libshveu Release 1.3.0
===========

libshveu: A library for controlling SH-Mobile VEU

The source archive, and more information about the library are available from:

	http://oss.renesas.com/modules/document/?libshveu

New in this release
-------------------

This is a quick bugfix release, adding the required VEU register settings for
downscaling from D1 to VGA size. In version 1.2.0 this particular rescaling
introduced green artifacts to the output image.

Additionally, the shveu-convert tool was updated to include support for
D1 (720x480) sized images.

Changes
-------

This release includes the following changes since version 1.2.0:

Atsuhiro Ito (2):
      Add D1 size in shveu-convert
      Improve the condition of VRPBR register.

Conrad Parker (1):
      Release 1.3.0

 configure.ac                  |    2 +-
 src/libshveu/veu_colorspace.c |   15 +++++----------
 src/tools/shveu-convert.c     |   11 +++++++++--
 3 files changed, 15 insertions(+), 13 deletions(-)
