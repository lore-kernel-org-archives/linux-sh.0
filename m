From: kuninori.morimoto.gx@renesas.com
Date: Fri, 09 Sep 2011 10:18:59 +0000
Subject: [PATCH 0/10] ARM: mach-shmobile: sh_mipi_dsi: update patches
Message-Id: <87r53qqar7.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Dear Paul, Magnus, and SH-ML members

These are sh_mipi_dsi update patches.

Kuninori Morimoto (10):
      ARM: mach-shmobile: clock-sh73a0: add LCDC1 clock support
      fbdev: sh_mipi_dsi: tidyup dsip_clk
      fbdev: sh_mobile_lcdcfb: bugfix LDHAJR :: HSYNPAJ needs mask
      fbdev: sh_mipi_dsi: add lane control support
      fbdev: sh_mipi_dsi: add sync_pulses/sync_events/burst mode
      fbdev: sh_mipi_dsi: add VMLEN1/VMLEN2 calculation
      sh: clkfwk: add clk_rate_multi_range_round()
      ARM: mach-shmobile: clock-sh7372: remove un-necessary index
      fbdev: sh_mipi_dsi: add set_dot_clock() for each platform
      ARM: mach-shmobile: clock-sh73a0: add DSIxPHY clock support

Some register are not explained for detail in SH manual.
This time, I asked it to Renesas MIPI guys.
These patches include it.

I added new clock support for sh73a0.

These are tested on kota2, ag5evm panel.
It needs test on AP4-QHD panel. (I don't have it)
