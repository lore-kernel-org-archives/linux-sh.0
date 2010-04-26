From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 26 Apr 2010 07:48:15 +0000
Subject: [GIT PULL] sh updates for 2.6.34-rc6
Message-Id: <20100426074815.GA17288@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Please pull from:

	master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git sh/for-2.6.34

Which contains:

Guennadi Liakhovetski (2):
      SH: fix TS field shift calculation for DMA drivers
      SH: fix error paths in DMA driver

Magnus Damm (2):
      sh: Fix maximum number of SCIF ports in R2D defconfigs
      sh: sh7751 pci controller io port fix

 arch/sh/configs/rts7751r2d1_defconfig      |    2 +-
 arch/sh/configs/rts7751r2dplus_defconfig   |    2 +-
 arch/sh/drivers/pci/pci-sh7751.c           |    5 +++--
 arch/sh/include/cpu-sh4/cpu/dma-register.h |    2 +-
 drivers/dma/shdma.c                        |   27 +++++++++++++++++++++------
 5 files changed, 27 insertions(+), 11 deletions(-)
