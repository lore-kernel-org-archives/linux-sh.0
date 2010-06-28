From: Conrad Parker <conrad@metadecks.org>
Date: Mon, 28 Jun 2010 08:41:55 +0000
Subject: UIOMux release 1.2.0
Message-Id: <AANLkTiltmS7JSk-7DCaDYl98SWpYQgiSa9VGkRh1Msp9@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

UIOMux Release 1.2.0
==========

UIOMux is a conflict manager for system resources, including UIO devices.

The source archive, and more information about the library are available from:

	http://oss.renesas.com/modules/document/?libuiomux

This release of libuiomux targets Renesas SH-Mobile processors.

New in this release
-------------------

This release improves support for applications which use multiple UIO device
instances by allowing nested calls to uiomux_open(). This allows calls to
uiomux_open()/uiomux_close() to be encapsulated in device handling libraries,
rather than requiring management by the top-level application.

Changes
-------

This release includes the following changes since version 1.1.0:

Conrad Parker (2):
      Allow multiple uiomux_open() calls
      Release 1.2.0

Phil Edworthy (2):
      tests: Added nested open test
      Remove generated files.

 INSTALL                           |    1 -
 TODO                              |    1 -
 config.h.in                       |   87 -------------------------------------
 configure.ac                      |    2 +-
 release_notes/libuiomux-1.2.0.txt |   42 ++++++++++++++++++
 src/libuiomux/uiomux.c            |    8 +++-
 src/tests/Android.mk              |    9 ++++
 src/tests/Makefile.am             |    5 ++-
 src/tests/multiple-open.c         |   56 ++++++++++++++++++++++++
 9 files changed, 119 insertions(+), 92 deletions(-)
 delete mode 120000 INSTALL
 delete mode 100644 config.h.in
 create mode 100644 release_notes/libuiomux-1.2.0.txt
 create mode 100644 src/tests/multiple-open.c
