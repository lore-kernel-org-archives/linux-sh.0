From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 31 Jul 2014 00:34:03 +0000
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Shdma Updates for v3.17
Message-Id: <cover.1406766014.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1381222967.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1381222967.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Vinod,

Please consider these second round of Renesas ARM based SoC shdma updates
for v3.17.

This pull request is based on the previous round of
such requests, tagged as renesas-shdma-for-v3.17,
which you have already pulled.


The following changes since commit 0cdbee33ea42bfd5f61f824e258a1a0944dd2a27:

  dmaengine: shdma: Use defines instead of hardcoded numbers (2014-07-15 18:02:29 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-shdma2-for-v3.17

for you to fetch changes up to dff5450f372ee87b5e0b5762b3ca8944dae8bf7e:

  dma/sh: fix rcar-dma.c printk format warnings (2014-07-29 10:24:52 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Shdma Updates for v3.17

* R-Car Gen2 DMA Controller driver

----------------------------------------------------------------
Laurent Pinchart (5):
      dmaengine: sh: Rework Kconfig and Makefile
      dmaengine: shdma: Make channel filter ignore unrelated devices
      dmaengine: shdma: Allocate cyclic sg list dynamically
      dmaengine: rcar-dmac: Add device tree bindings documentation
      dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver

Randy Dunlap (1):
      dma/sh: fix rcar-dma.c printk format warnings

 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |   98 ++
 drivers/dma/sh/Kconfig                             |   30 +-
 drivers/dma/sh/Makefile                            |   17 +-
 drivers/dma/sh/rcar-dmac.c                         | 1525 ++++++++++++++++++++
 drivers/dma/sh/shdma-base.c                        |  101 +-
 drivers/dma/sh/shdma.h                             |    2 +-
 6 files changed, 1723 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
 create mode 100644 drivers/dma/sh/rcar-dmac.c
