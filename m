From: kuninori.morimoto.gx@renesas.com
Date: Fri, 11 Nov 2011 02:42:35 +0000
Subject: [PATCH 0/20] ARM/sh: re-send morimoto's patch set
Message-Id: <871utfbcrr.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

These are my sh/sh-arm patch set which are posted to ML but still
can not find in your branch.

I'm so sorry that my patch set was very confusable.
These are based on paul/rmobile-latest.

I posted more patches, but they were based on sh_mipi patches.
I dropped it this time.
I will re-post it if fbdev ML accepted it.

Kuninori Morimoto (20):
      mailmap: Fix up renesas member's attribution
      serial: sh-sci: clean up white space
      sh: clkfwk: add clk_rate_mult_range_round()
      ARM: mach-shmobile: sh73a0: add MMC data pin pull-up
      ARM: mach-shmobile: kota2: add comment out separator
      ARM: mach-shmobile: clock-sh7372: remove un-necessary index
      ARM: mach-shmobile: ap4evb: remove white space from end of line
      ARM: mach-shmobile: move helper macro PORT_DATA_xx to sh_pfc.h
      ARM: mach-shmobile: move helper macro PORT_xx to sh_pfc.h
      ARM: mach-shmobile: move helper macro PORTCR to sh_pfc.h
      ARM: mach-shmobile: R-Mobile A1 support.
      ARM: mach-shmobile: r8a7740: add PFC support.
      ARM: mach-shmobile: r8a7740: add i2c support
      ARM: mach-shmobile: r8a7740: add INTC support
      ARM: mach-shmobile: add bonito board support.
      ARM: mach-shmobile: bonito: Add dip-switch selector
      ARM: mach-shmobile: bonito: add PMIC settings
      ARM: mach-shmobile: bonito: Add LCDC0 support
      ARM: mach-shmobile: bonito: add FPGA irq demux
      ARM: mach-shmobile: bonito: add SMSC9221 support
