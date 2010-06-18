From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Date: Fri, 18 Jun 2010 11:01:11 +0000
Subject: [PATCH v4 0/4] Add support for new board: SH-2007
Message-Id: <1276858875-10548-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
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

v3: I fixed this series according to advice by
    Nobuhiro-san and Magnus. Thanks!

v4: IDE support is disabled as temporary solution.
    Testers are welcome!

Hitoshi Mitake (4):
  Add the directory mach-sh2007 for SH-2007 board support
  Adds default configuration for SH-2007. This default configuration is
    nfs boot oriented.
  Modify Makefile and Kconfig for enabling and building SH-2007 related
    files.
  Very dirty and easy fix for sh-sci.

 arch/sh/Makefile                    |    1 +
 arch/sh/boards/Kconfig              |   11 +
 arch/sh/boards/mach-sh2007/Makefile |    1 +
 arch/sh/boards/mach-sh2007/setup.c  |  317 ++++++++
 arch/sh/configs/sh2007_defconfig    | 1357 +++++++++++++++++++++++++++++++++++
 arch/sh/tools/mach-types            |    1 +
 drivers/serial/sh-sci.h             |   17 +-
 7 files changed, 1701 insertions(+), 4 deletions(-)
 create mode 100644 arch/sh/boards/mach-sh2007/Makefile
 create mode 100644 arch/sh/boards/mach-sh2007/setup.c
 create mode 100644 arch/sh/configs/sh2007_defconfig

