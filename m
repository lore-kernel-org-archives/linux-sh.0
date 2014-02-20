From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 20 Feb 2014 14:42:59 +0000
Subject: [PATCH 00/10] spi: sh-msiof: Add support for R-Car H2 and M2
Message-Id: <1392907389-21798-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Takashi Yoshii <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

	Hi Mark,

This patch series refactors the sh-msiof SPI driver and adds support for
the MSIOF variant in the Renesas R-Car H2 (r8a7790) and M2 (r8a7791) SoCs.

It was tested on the Lager and Koelsch development boards, using a dummy
driver for the Renesas r2a11302ft PMIC that reads out the PMIC's version ID.

  [01/10] spi: sh-msiof: Fix SPI bus population from DT
  [02/10] spi: sh-msiof: Typo in comment s/tx/rx/
  [03/10] spi: sh-msiof: Change hz from unsigned long to u32
  [04/10] spi: sh-msiof: Add more register documentation
  [05/10] spi: sh-msiof: Use the core cs_gpio field, and make it optional
  [06/10] spi: sh-msiof: Improve binding documentation
  [07/10] spi: sh-msiof: Add support for R-Car H2 and M2
  [08/10] spi: sh-msiof: Move clock management to (un)prepare_message()
  [09/10] spi: sh-msiof: Convert to let spi core validate xfer->bits_per_word
  [10/10] spi: sh-msiof: Use core message handling instead of spi-bitbang

Some of this work was based on a patch series by Takashi Yoshii
<takasi-y@ops.dti.ne.jp>.

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
