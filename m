From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 17 Jul 2014 00:45:31 +0000
Subject: [GIT PULL] Renesas ARM Based SoC Shdma Updates for v3.17
Message-Id: <cover.1405557829.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Vinod,

Please consider these Renesas shdma updates for v3.17.


The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-shdma-for-v3.17

for you to fetch changes up to 0cdbee33ea42bfd5f61f824e258a1a0944dd2a27:

  dmaengine: shdma: Use defines instead of hardcoded numbers (2014-07-15 18:02:29 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Shdma Updates for v3.17

* Add more register documentation and;
* Replace some hardcoded numbers by defines

----------------------------------------------------------------
Geert Uytterhoeven (3):
      dmaengine: shdma: Add more register documentation
      sh: dma: Use defines instead of hardcoded numbers
      dmaengine: shdma: Use defines instead of hardcoded numbers

 arch/sh/drivers/dma/dma-sh.c           |  2 +-
 arch/sh/include/asm/dma-register.h     | 36 ++++++++++---------
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c | 24 ++++++-------
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c | 48 ++++++++++++-------------
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c | 64 +++++++++++++++++-----------------
 drivers/dma/sh/shdma-arm.h             |  4 +--
 drivers/dma/sh/shdmac.c                | 15 ++++----
 include/linux/sh_dma.h                 | 24 +++++++------
 8 files changed, 110 insertions(+), 107 deletions(-)
