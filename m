From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 02 Aug 2013 00:41:18 +0000
Subject: Re: [PATCH 2/2 v2] ARM: shmobile: bockw: add USB Function support
Message-Id: <874nb8apqs.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87pptzb68g.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87pptzb68g.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> > +static struct renesas_usbhs_platform_info usbhs_info = {
> 
>     Forgot __initdata here.

This is reasonable assignment for me
I will send v3 patch

Thanks

Best regards
---
Kuninori Morimoto
