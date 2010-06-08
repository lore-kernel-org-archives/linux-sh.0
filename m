From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Date: Tue, 08 Jun 2010 10:08:43 +0000
Subject: [PATCH v2 0/4] Add support for new board: SH-2007
Message-Id: <1275991727-4730-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch series add support of SH-2007.
I brought these changes from the out-of-tree kernel
provided by the manufacture of this board, ITO Inc.
Website of company: http://www.itonet.co.jp/
The URL of kernel: http://ms-n.org/sh-linux/kernel/

Adding support of new board is trivial,
but as I'll describe, 4/4 of this series contains
some dirty and mysterious fixes.

According to Paul's advice, I rewrote this patch series.
New points are described in each patch.
Request for comments!

Hitoshi Mitake (4):
  Add the directory mach-sh2007 for SH-2007 board support
  Add sh2007_defconfig for default configuration of SH-2007
  Add Kconfig and Makefile for SH-2007 support
  Modify sh-sci.h to adopt specific serial behaviour of SH-2007

 arch/sh/Makefile                    |    1 +
 arch/sh/boards/Kconfig              |   11 +
 arch/sh/boards/mach-sh2007/Makefile |    1 +
 arch/sh/boards/mach-sh2007/setup.c  |  314 ++++++++
 arch/sh/configs/sh2007_defconfig    | 1482 +++++++++++++++++++++++++++++++++++
 drivers/serial/sh-sci.h             |   17 +-
 6 files changed, 1822 insertions(+), 4 deletions(-)
 create mode 100644 arch/sh/boards/mach-sh2007/Makefile
 create mode 100644 arch/sh/boards/mach-sh2007/setup.c
 create mode 100644 arch/sh/configs/sh2007_defconfig

