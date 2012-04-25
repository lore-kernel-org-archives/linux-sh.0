From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 25 Apr 2012 07:25:56 +0000
Subject: Re: [PATCH 6/6] ARM: mach-shmobile: kzm9g: add PCF8757 gpio-key
Message-Id: <877gx4z30f.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8762d63oni.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8762d63oni.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > please enable GPIO_PCF857X, not INPUT_PCF8574
> > 
> > O  GPIO_PCF857X
> > X  INPUT_PCF8574
> > 
> > and enable KEYBOARD_GPIO_POLLED too
> 
> Thanks, I have it working now.
> 
> Do you think it is worth updating the default config?

Yes. very nice
Thank you for pointing it.
I send defconfig update patch.
for KZM9G and Armadillo

Best regards
---
Kuninori Morimoto
