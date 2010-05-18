From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 18 May 2010 14:42:29 +0000
Subject: [PATCH 00/04] sh: romImage MMCIF boot patches V2
Message-Id: <20100518144229.29239.19891.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh: romImage MMCIF boot patches V2

[PATCH 01/04] sh: allow romImage data between head.S and the zero page
[PATCH 02/04] sh: prepare MMCIF driver header file
[PATCH 03/04] sh: add boot code to MMCIF driver header
[PATCH 04/04] sh: add romImage MMCIF boot for sh7724 and Ecovec V2

These patches makes it possible to build a Linux kernel that supports
loading itself over the MMCIF interface on sh7724 processors.

The SH kernel has been used as a boot loader ever since the romImage
build target was introduced. This patch extends the romImage code from
only supporting boot from NOR flash to support building a kernel image
that can be written directly to a MMC card and booted by the sh7724
processor.

Yes, on selected boards the upstream SH kernel can be booted without any
boot loader using the romImage build target. Work is currently being done
to support this feature on SH-Mobile ARM processors as well.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to the sh-2.6 git tree and the MMCIF driver from mmotd

 arch/sh/Kconfig                               |   11 +
 arch/sh/boot/romimage/Makefile                |   13 +-
 arch/sh/boot/romimage/head.S                  |   42 ++++++
 arch/sh/boot/romimage/mmcif-sh7724.c          |   72 +++++++++++
 arch/sh/boot/romimage/vmlinux.scr             |    2 
 arch/sh/include/cpu-sh4/cpu/sh7724.h          |    1 
 arch/sh/include/mach-common/mach/romimage.h   |   10 +
 arch/sh/include/mach-ecovec24/mach/romimage.h |   27 ++++
 arch/sh/include/mach-kfr2r09/mach/romimage.h  |   10 +
 drivers/mmc/host/sh_mmcif.c                   |  125 +++++++------------
 include/linux/mmc/sh_mmcif.h                  |  161 +++++++++++++++++++++++++
 11 files changed, 392 insertions(+), 82 deletions(-)
