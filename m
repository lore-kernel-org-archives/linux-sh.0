From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Feb 2013 08:36:38 +0000
Subject: Re: [PATCH] net: sh_eth: Add support of device tree probe
Message-Id: <87pq0dg7ot.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1360116019-8870-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1360116019-8870-1-git-send-email-horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Hi Simon, Iwamatsu-san

> +Required properties:
> +- compatible:                   "renesas,sh-eth";
> +- interrupt-parent:             The phandle for the interrupt controller that
> +                                services interrupts for this device.
> +- reg:                          Offset and length of the register set for the
> +                                device.
> +- interrupts:                   Interrupt mapping for the sh_eth interrupt
> +                                sources (vector id).
> +- phy-mode:              String, operation mode of the PHY interface.
> +- sh-eth,edmac-endian:          String, endian of sh_eth dmac.

I believe endian is only little/big.
It can be "bool" settings, not "string" ?

> +- sh-eth,endian:                String, endian of sh_eth dmac.

Is this really used it in this driver ?

Best regards
---
Kuninori Morimoto
