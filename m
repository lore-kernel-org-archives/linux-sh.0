From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 29 Jul 2014 08:42:33 +0000
Subject: Re: [PATCH 0/10 v2] mmc: tmio: fixup patches
Message-Id: <87mwbso8sp.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <d3d6aa34548248768494ad88056cf4bd@SINPR06MB105.apcprd06.prod.outlook.com>	<87simtenpi.wl%kuninori.morimoto.gx@renesas.com>	<cb608c5e763f47b597936724ec05b615@SINPR06MB105.apcprd06.prod.outlook.com>	<87pphxe2q0.wl%kuninori.morimoto.gx@renesas.com>	<53AD638C.5060907@renesas.com>	<87egxehsec.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87egxehsec.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>
Cc: Ian Molton <ian@mnementh.co.uk>, TOSHIAKI KOMATSU <toshiaki.komatsu.ud@renesas.com>, NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, "goda (Renesas)" <yusuke.goda.sx@renesas.com>, linux-mmc@vger.kernel.org, ryo.kataoka.wt@renesas.com, shinobu.uehara.xc@renesas.com, kouei.abe.cp@renesas.com, cm-hiep@jinso.co.jp

Hi Chris, Simon

These are v2 of fixup patches for mmc tmio/shmobile.
I tesed these patches on my environment.
I'm very happy if someone test these patches.

Kuninori Morimoto (4):
      mmc: tmio: care about DMA tx/rx addr offset
      mmc: tmio: remove Renesas specific #ifdef
      mmc: tmio: remove SCLKEN bit setting from tmio_mmc_set_clock()
      mmc: tmio: ensure that the clock has been stopped before set_clock

Shinobu Uehara (6):
      mmc: block: add block number limitation flag for multiple block read
      mmc: tmio: clear error IRQ status
      mmc: tmio: control multiple block transfer mode
      mmc: tmio: add TMIO_MMC_SDIO_STATUS_QUIRK
      mmc: tmio: check ILL_FUNC instead of CBSY
      mmc: tmio: add actual clock support as option

 arch/arm/mach-shmobile/board-koelsch.c |    6 ++---
 arch/arm/mach-shmobile/board-lager.c   |    4 ++--
 drivers/mmc/card/block.c               |   19 +++++++++++++--
 drivers/mmc/host/sh_mobile_sdhi.c      |   26 ++++++++++++++++++---
 drivers/mmc/host/tmio_mmc_dma.c        |    8 +++----
 drivers/mmc/host/tmio_mmc_pio.c        |   40 +++++++++++++++++++++++++++++---
 include/linux/mfd/tmio.h               |   22 ++++++++++++++++++
 include/linux/mmc/host.h               |    3 +++
 8 files changed, 110 insertions(+), 18 deletions(-)

