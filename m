From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Date: Tue, 24 Dec 2013 09:49:29 +0000
Subject: [PATCH 0/5] spi: rspi: cleanups
Message-Id: <1387878574-21445-1-git-send-email-geert+renesas@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org

	Hi Mark,

This is a series of small cleanups for the Renesas RSPI driver:

    [1/5] spi: rspi: Use dev_get_platdata() instead of raw
    [2/5] spi: rspi: Remove casts
    [3/5] spi: rspi: Make more pointers const
    [4/5] spi: rspi: Use DUMMY_DATA macro instead of hardcoded
    [5/5] spi: rspi: Use u8 for 8-bit register values

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
