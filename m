From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Nov 2013 08:30:03 +0000
Subject: [PATCH 0/4] mmc: tmio/SDHI fixup patches
Message-Id: <87iovn8ohs.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>
Cc: Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org


Hi Chris

Now, our new board would like to use sh_mobile_sdhi driver,
then, it is expecting sh_mobile_sdhi use regulator.
But, this regulator is based on GPIO driver,
and GPIO driver probe timing is after sh_mobile_sdhi.
So, sh_mobile_sdhi (= tmio_mmc_pio) use default ocr_avail,
and it doesn't work for us.
#1 patch returns -EPROBE_DEFER in such case.
it changes tmio_mmc_host_probe() behavior, but
in my check, tmio_mmc_pio driver user is sh_mobile_sdhi/tmio-mmc only,
and, current user has no conflict by this patch.

sh_mobile_sdhi/tmio-mmc is very similar, but, have some difference.
#2 - #4 cares such case.

These were part of "SDHI support for r8a7790" patch set,
but was separated

Kuninori Morimoto (4):
      mmc: tmio: use -EPROBE_DEFER if driver can't find regulator
      mmc: tmio: bus_shift become tmio_mmc_data member
      mmc: tmio: add new TMIO_MMC_HAVE_HIGH_REG flags
      mmc: SDHI: add SoC specific workaround via HW version

 drivers/mmc/host/sh_mobile_sdhi.c |   19 +++++++++++++++++++
 drivers/mmc/host/tmio_mmc.c       |    9 +++++++++
 drivers/mmc/host/tmio_mmc.h       |   17 ++++++++---------
 drivers/mmc/host/tmio_mmc_dma.c   |    2 +-
 drivers/mmc/host/tmio_mmc_pio.c   |   36 +++++++++++++++++++-----------------
 include/linux/mfd/tmio.h          |    8 ++++++++
 include/linux/mmc/tmio.h          |    1 +
 7 files changed, 65 insertions(+), 27 deletions(-)


Best regards
---
Kuninori Morimoto
