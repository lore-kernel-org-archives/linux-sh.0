From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 03 Jan 2014 15:34:13 +0000
Subject: [PATCH 0/3] Add QSPI support on r8a7791/koelsch
Message-Id: <1388763256-25851-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This series adds support for the Spansion s25fl512s SPI FLASH on the
r8a7791-based Koelsch board:

    [1/3] pinctrl: sh-pfc: r8a7791: Add QSPI pin groups
    [2/3] ARM: shmobile: r8a7791: add QSPI clock
    [3/3] ARM: shmobile: Koelsch: Add QSPI support

This applies to non-multiplatform Koelsch only.  Multi-platform Koelsch
support will be added when the spi-rspi driver gains DT support.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
