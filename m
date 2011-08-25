From: kuninori.morimoto.gx@renesas.com
Date: Thu, 25 Aug 2011 04:03:50 +0000
Subject: [PATCH 0/7] ARM: ARM: mach-shmobile: mipi display support
Message-Id: <8739gquogt.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul, Magnus, Guennadi

These are MIPI display support for kota2 board

Kuninori Morimoto (7):
      fbdev: sh_mipi_dsi: typo fix of SH_MIPI_DSI_HBPBM
      fbdev: sh_mipi_dsi: tidyup VMCTR2 parameter expression
      fbdev: sh_mipi_dsi: add SH_MIPI_DSI_HFPBM flag
      fbdev: sh_mipi_dsi: add SH_MIPI_DSI_BL2E flag
      fbdev: sh_mipi_dsi: add extra dcs settings for platform
      ARM: mach-shmobile: kota2: Add comment out separator
      ARM: mach-shmobile: kota2: add mipi display support

These patches are based on current linus/master + Magnus's kota2 patch set
