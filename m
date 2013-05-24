From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 24 May 2013 04:39:33 +0000
Subject: Re: [PATCH 06/17 v2] ARM: shmobile: r8a7778: add I2C support
Message-Id: <871u8x2dq5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874ndu4c4n.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874ndu4c4n.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> > +void __init r8a7778_add_i2c_device(int id)
> > +{
> > +	BUG_ON(id < 0 || id > 3);
> > +
> > +	platform_device_register_simple(
> > +		"i2c-rcar", id,
> > +		i2c_resources + (2 * id), 2);
> 
>      I've already told you () is superfluous.

I can prevent misreading.


Best regards
---
Kuninori Morimoto
