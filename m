From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Sep 2015 01:52:34 +0000
Subject: [PATCH 0/3 v2] pinctrl: sh-pfc: r8a7795: add I2C/Audio pin support
Message-Id: <87si6c1org.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87twqs1osz.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87twqs1osz.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Linus Walleij <linus.walleij@linaro.org>, Laurent <laurent.pinchart@ideasonboard.com>
Cc: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>


Hi Linus W
Cc: Geert, Laurent, Wolfram

These are v2 of I2C / Audio pinchart support for Renesas r8a7795

Kuninori Morimoto (3):
      pinctrl: sh-pfc: r8a7795: add I2C pin support
      pinctrl: sh-pfc: r8a7795: add Audio clock pin support
      pinctrl: sh-pfc: r8a7795: add Audio SSI pin support

 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 459 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 459 insertions(+)
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
