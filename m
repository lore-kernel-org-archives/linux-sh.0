From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 01 Sep 2014 09:20:13 +0000
Subject: [PATCH 0/7] mmc: remove MMC_CAP2_NO_MULTI_READ flags
Message-Id: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>
Cc: Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>


Hi Ulf, Chris, and Simon

These patches remove MMC_CAP2_NO_MULTI_READ from mmc.
This flag should be implemented under each driver,
not mmc block framework.

Simon
5) and 6) are for sh-arm patches.
Can you check it ?

Kuninori Morimoto (7):
      1) mmc: add blk_size_workaround for HW bug
      2) mmc: omap_hsmmc: use blk_size_workaround
      3) mmc: tmio_mmc: use blk_size_workaround
      4) mmc: sh_mobile_sdhi: use blk_size_workaround
      5) ARM: shmobile: koelsch: remove MMC_CAP2_NO_MULTI_READ
      6) ARM: shmobile: lager: remove MMC_CAP2_NO_MULTI_READ
      7) mmc: remove MMC_CAP2_NO_MULTI_READ flags

 arch/arm/mach-shmobile/board-koelsch.c |    3 ---
 arch/arm/mach-shmobile/board-lager.c   |    2 --
 drivers/mmc/card/block.c               |    8 ++++----
 drivers/mmc/host/omap_hsmmc.c          |   17 ++++++++++++++++-
 drivers/mmc/host/sh_mobile_sdhi.c      |   20 +++++++++++++++++++-
 drivers/mmc/host/tmio_mmc_pio.c        |   13 +++++++++++++
 include/linux/mfd/tmio.h               |    4 ++++
 include/linux/mmc/host.h               |    5 ++++-
 8 files changed, 60 insertions(+), 12 deletions(-)
