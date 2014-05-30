From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 May 2014 10:40:04 +0000
Subject: [PATCH 0/3] mmc:
Message-Id: <87ppivpn25.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>
Cc: Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org



Hi Chris

These patches fixup R-Car SDHI / TMIO driver.

1st/2nd patch adds new flag to avoid 2 block read HW bug
which Renesas SDHI has.

3rd patch cares Tx/Rx dma_offset.
Because Renesas SDHI
has non-normal register mapping

Kuninori Morimoto (3):
      mmc: block: add block number limitation flag for lultiple block read
      mmc: sdhi: tidyup mmc_data setting for R-Car SDHI
      mmc: tmio: care about DMA tx/rx addr offset

 drivers/mmc/card/block.c          |   19 +++++++++++++++++--
 drivers/mmc/host/sh_mobile_sdhi.c |    5 ++++-
 drivers/mmc/host/tmio_mmc_dma.c   |    2 +-
 include/linux/mfd/tmio.h          |    1 +
 include/linux/mmc/host.h          |    3 +++
 5 files changed, 26 insertions(+), 4 deletions(-)
