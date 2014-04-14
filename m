From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Apr 2014 17:35:56 +0000
Subject: [PATCH 0/4] ARM: shmobile: koelsch/lager: Enable Quad SPI transfers
Message-Id: <1397496960-27848-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi Simon,

Now Dual/Quad SPI support for Renesas QSPI is available in v3.15-rc1 (and
renesas-devel-v3.15-rc1-20140414v2), it's safe to apply the following 4
patches:

  - [1/4] ARM: shmobile: koelsch legacy: Enable Quad SPI transfers
  - [2/4] ARM: shmobile: koelsch dts: Enable Quad SPI transfers
  - [3/4] ARM: shmobile: lager legacy: Enable Quad SPI transfers
  - [4/4] ARM: shmobile: lager dts: Enable Quad SPI transfers for

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
