From: kuninori.morimoto.gx@renesas.com
Date: Fri, 30 Sep 2011 08:32:34 +0000
Subject: sh_mipi_dsi:
Message-Id: <87oby2ctwh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul, Magnus, and SH-ML members

These are sh_mipi_dsi update patches.

Kuninori Morimoto (6):
      fbdev: sh_mobile_lcdcfb: add struct sh_mobile_lcdc_clock_source
      fbdev: sh_mipi_dsi: Add HSxxCLK support
      fbdev: sh_mipi_dsi: sh_mipi has pdata instead of dev
      fbdev: sh_mipi_dsi: fixup setup timing of sh_mipi_setup()
      fbdev: sh_mipi_dsi: fixup setup timing of SYSCONF
      fbdev: sh_mipi_dsi: fixup setup timing DSICTRL

current LCDC driver has LCDC_CLK_xxx flags to select clock source.
But SH-Mobile / R-Mobile LCDC clock source is not same as SH LCDC.
ex) current AP4 board select LCDC_CLK_EXTERNAL to select HDMI clocks

1st patch modify lcdc clock source select method.
But it has compatibility for old LCDC (I hope =).

#2 - #6 patches are update patches for sh mipi driver.

It care HS4divCLK which needs 1920x1080p 60Hz output.
But you can NOT find HS4divCLK explain and calculation method
on AP5R manual.

