From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Jan 2012 01:22:13 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: mackerel: use renesas_usbhs instead of r8a66597_hcd
Message-Id: <87ehuw7agu.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87hb11e0wa.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hb11e0wa.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

> Current renesas_usbhs driver can use both USB host/gadget.
> This patch removes current r8a66597_hcd driver settings,
> and adds renesas_usbhs host driver settings for mackerel USB1 port.
> You can still use this port as "gadget" with small modify.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---

I noticed that mackerel.c has some comment which became no longer needed by this patch.
Please drop it.
I send v2 patch

Best regards
---
Kuninori Morimoto
