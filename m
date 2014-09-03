From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 03 Sep 2014 02:08:02 +0000
Subject: [PATCH 0/7 v3] mmc: remove MMC_CAP2_NO_MULTI_READ flags
Message-Id: <87bnqx78xr.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>


Hi Ulf, Chris, and Simon

These are v3 patches of removing MMC_CAP2_NO_MULTI_READ from mmc.

Simon
5) and 6) are for sh-arm patches.
Can you check it ?

Kuninori Morimoto (7):
      mmc: add .multi_io_quirk callback for multi I/O HW bug
      mmc: use .multi_io_quirk on omap_hsmmc
      mmc: use .multi_io_quirk on tmio_mmc
      mmc: use .multi_io_quirk on sh_mobile
      ARM: shmobile: remove MMC_CAP2_NO_MULTI_READ from koelsch
      ARM: shmobile: remove MMC_CAP2_NO_MULTI_READ from lager
      mmc: remove MMC_CAP2_NO_MULTI_READ flags

 arch/arm/mach-shmobile/board-koelsch.c |    3 ---
 arch/arm/mach-shmobile/board-lager.c   |    2 --
 drivers/mmc/card/block.c               |   13 +++++++++----
 drivers/mmc/host/omap_hsmmc.c          |   17 ++++++++++++++++-
 drivers/mmc/host/sh_mobile_sdhi.c      |   20 +++++++++++++++++++-
 drivers/mmc/host/tmio_mmc_pio.c        |   13 +++++++++++++
 include/linux/mfd/tmio.h               |    4 ++++
 include/linux/mmc/host.h               |    8 +++++++-
 8 files changed, 68 insertions(+), 12 deletions(-)

Best regards
---
Kuninori Morimoto
