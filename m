From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Sep 2015 04:09:35 +0000
Subject: [PATCH 0/3] sh-pfc: r8a7795: add I2C/Audio pin support
Message-Id: <87mvx4qkzo.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87oahkql0v.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oahkql0v.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>


Hi Linus W
Cc: Geert, Laurent, Wolfram

These are I2C / Audio pinchart support for Renesas r8a7795

Kuninori Morimoto (3):
      pinctrl: sh-pfc: r8a7795: add I2C pin support
      pinctrl: sh-pfc: r8a7795: add Audio clock pin support
      pinctrl: sh-pfc: r8a7795: add Audio SSI pin support

 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 459 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 459 insertions(+)
