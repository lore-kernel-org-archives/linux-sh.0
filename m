From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 27 May 2014 13:45:08 +0000
Subject: [PATCH RFC 0/3] ARM: shmobile: Add support for new R-Car Gen2 SoCs
Message-Id: <1401198311-21268-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi Simon, Magnus,

This patch series adds support for new R-Car Gen2 SoCs to PM runtime, and
the MSIOF and QSPI SPI drivers:
  - [1/3] drivers: sh: Enable PM runtime for new R-Car Gen2 SoCs
  - [2/3] spi: sh-msiof: Add support for new R-Car Gen2 SoCs
  - [3/3] spi: rspi: Add support for new R-Car Gen2 SoCs

Beyond compilation, it's completely untested on actual hardware, hence the
RFC state and the lack of other mailing lists in CC.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
