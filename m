From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 03 Aug 2015 08:34:41 +0000
Subject: Re: [PATCH v2] ARM: shmobile: dts: Add common file for AA121TD01 panel
Message-Id: <87si80vkmd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbd4227u.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbd4227u.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Wolfram

> > I tested this panel on Koelsch board (with I2C fixup local patch),
> 
> I2C fixup? The NACK issue?

I don't know detail.
But, I need to use gpio-i2c to use HDMI, otherwise it doesn't work.

