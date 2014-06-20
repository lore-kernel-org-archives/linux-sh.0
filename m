From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 20 Jun 2014 10:16:15 +0000
Subject: [PATCH 0/5] spi: sh-msiof: Add DMA support
Message-Id: <1403259380-13634-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-spi@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

This patch series refactors the Renesas MSIOF SPI driver and adds DMA
support.

  [1/5] spi: sh-msiof: Add more register documentation
  [2/5] spi: sh-msiof: Extract sh_msiof_spi_{start,stop}() helpers
  [3/5] spi: sh-msiof: Improve transfer error handling
  [4/5] spi: sh-msiof: Refactor sh_msiof_transfer_one()
  [5/5] spi: sh-msiof: Add DMA support

 drivers/spi/spi-sh-msiof.c   | 516 +++++++++++++++++++++++++++++++++++++++----
 include/linux/spi/sh_msiof.h |   2 +
 2 files changed, 469 insertions(+), 49 deletions(-)

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
