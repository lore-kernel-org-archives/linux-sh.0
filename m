From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 19 Aug 2020 12:58:57 +0000
Subject: [PATCH v2 0/7] spi: rspi: Bit rate improvements
Message-Id: <20200819125904.20938-1-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Chris Brandt <chris.brandt@renesas.com>, linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Mark,

This patch series contains several improvements for the Renesas SPI/QSPI
driver related to bit rate configuration.

Changes compared to v1
(https://lore.kernel.org/r/20200608095940.30516-1-geert+renesas@glider.be):
  - Drop accepted patch.

This has been tested on RSK+RZA1 (RSPI) and R-Car M2-W/Koelsch (QSPI),
using a scope and logic analyzer, except for the by-one divider on QSPI.
This has not been tested on legacy SuperH, due to lack of hardware.

Thanks for your comments!

Geert Uytterhoeven (7):
  spi: rspi: Remove useless .set_config_register() check
  spi: rspi: Clean up Bit Rate Division Setting handling
  spi: rspi: Increase bit rate accuracy on RZ/A
  spi: rspi: Increase bit rate range for RSPI on SH
  spi: rspi: Increase bit rate range for QSPI
  spi: rspi: Fill in spi_transfer.effective_speed_hz
  spi: rspi: Fill in controller speed limits

 drivers/spi/spi-rspi.c | 81 +++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 29 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
