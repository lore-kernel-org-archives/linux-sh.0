From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Dec 2015 06:05:51 +0000
Subject: Re: [PATCH 1/2] usb: renesas_usbhs: add fallback compatibility string
Message-Id: <87egex5vfl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449553911-21412-1-git-send-email-horms+renesas@verge.net.au>
	<1449553911-21412-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1449553911-21412-2-git-send-email-horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Hi Simon

> Add fallback compatibility string.
> This is in keeping with the fallback scheme being adopted wherever
> appropriate for drivers for Renesas SoCs.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
(snip)
> +	{
> +		.compatible = "renesas,usbhs",
> +		.data = (void *)USBHS_TYPE_RCAR_GEN2,
> +	},
>  	{ },
>  };

I think this is too much. This driver is used not only from R-Car Gen2.
It will work as normal mode if .data was 0.
see usbhs_parse_dt()
