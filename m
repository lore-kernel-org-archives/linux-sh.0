From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 30 Nov 2015 13:32:10 +0000
Subject: [PATCH v3 0/2] pinctrl: sh-pfc: Improve pinmux macros documentation
Message-Id: <1448890332-773-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>, Magnus Damm <damm@opensource.se>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Laurent, Linus,

This patch series improves the documentation for the various macros used
to decribe pinmux configuration on Renesas SoCs.

Apart from more improvements, v3 renames the PINMUX_IPSR_DATA() macro to
PINMUX_IPSR_GPSR(). As this is a big changes in (LoD), I did that in a
separate patch.

You can find more detailed changelog information in the individual
patches.

Thanks!

Geert Uytterhoeven (2):
  pinctrl: sh-pfc: Improve pinmux macros documentation
  pinctrl: sh-pfc: Rename PINMUX_IPSR_DATA() to PINMUX_IPSR_GPSR()

 drivers/pinctrl/sh-pfc/pfc-r8a7778.c |  690 ++++++++++-----------
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 1136 +++++++++++++++++-----------------
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |  774 +++++++++++------------
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |  624 +++++++++----------
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c |  844 ++++++++++++-------------
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c |  554 ++++++++---------
 drivers/pinctrl/sh-pfc/pfc-sh7734.c  |  412 ++++++------
 drivers/pinctrl/sh-pfc/sh_pfc.h      |   96 ++-
 8 files changed, 2604 insertions(+), 2526 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
