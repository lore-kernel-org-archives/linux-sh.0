From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 25 Aug 2014 02:57:50 +0000
Subject: Re: [PATCH 0/9 v3] mmc: tmio: fixup patches
Message-Id: <87bnr9tgwj.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <d3d6aa34548248768494ad88056cf4bd@SINPR06MB105.apcprd06.prod.outlook.com>	<87simtenpi.wl%kuninori.morimoto.gx@renesas.com>	<cb608c5e763f47b597936724ec05b615@SINPR06MB105.apcprd06.prod.outlook.com>	<87pphxe2q0.wl%kuninori.morimoto.gx@renesas.com>	<53AD638C.5060907@renesas.com>	<87egxehsec.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87egxehsec.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ian Molton <ian@mnementh.co.uk>, Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org


Hi Chris, Ulf, Simon

These are v3 fixup patches for mmc tmio/shmobile.
I dropped [1/10] patch (which Ulf was pointed) from v2 patch-set.
We will post it again in the future,
but we want last 9 patches in upstream at this point.

Kuninori Morimoto (4):
      mmc: tmio: care about DMA tx/rx addr offset
      mmc: tmio: remove Renesas specific #ifdef
      mmc: tmio: remove SCLKEN bit setting from tmio_mmc_set_clock()
      mmc: tmio: ensure that the clock has been stopped before set_clock

Shinobu Uehara (5):
      mmc: tmio: clear error IRQ status
      mmc: tmio: control multiple block transfer mode
      mmc: tmio: add TMIO_MMC_SDIO_STATUS_QUIRK
      mmc: tmio: check ILL_FUNC instead of CBSY
      mmc: tmio: add actual clock support as option

 drivers/mmc/host/sh_mobile_sdhi.c |   24 ++++++++++++++++++++--
 drivers/mmc/host/tmio_mmc_dma.c   |    8 +++-----
 drivers/mmc/host/tmio_mmc_pio.c   |   40 ++++++++++++++++++++++++++++++++++---
 include/linux/mfd/tmio.h          |   22 ++++++++++++++++++++
 4 files changed, 84 insertions(+), 10 deletions(-)

Best regards
---
Kuninori Morimoto
