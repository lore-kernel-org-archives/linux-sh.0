From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 14 Apr 2014 00:22:42 +0000
Subject: Re: [PATCH 0/2 v2]: sh-pfc: r8a7791: Add sound pin support
Message-Id: <87wqes220f.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87sipkoeqj.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87sipkoeqj.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


Hi Linus Walleij
Cc Simon, Laurent, Geert, Magnus

These are r8a7791 sound pin support patches
I added To Linus Walleij, Cc linux kernel on V2 patches.

Kuninori Morimoto (2):
      sh-pfc: r8a7791: Add SSI pin support
      sh-pfc: r8a7791: Add Audio pin support

 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |  375 ++++++++++++++++++++++++++++++++++
 1 file changed, 375 insertions(+)
