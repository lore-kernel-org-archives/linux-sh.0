From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 08 Feb 2010 02:50:28 +0000
Subject: Re: [PATCH] sh-sci: remove SCIF code in sci_rxd_in()
Message-Id: <20100208025028.GD6839@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100205104100.16820.16353.sendpatchset@rxone.opensource.se>
In-Reply-To: <20100205104100.16820.16353.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 05, 2010 at 07:41:00PM +0900, Magnus Damm wrote:
> --- 0001/drivers/serial/sh-sci.h
> +++ work/drivers/serial/sh-sci.h	2010-02-05 16:02:19.000000000 +0900
> @@ -518,34 +456,6 @@ static inline int sci_rxd_in(struct uart
>  {
>  	if (port->mapbase = 0xfffffe80)
>  		return __raw_readb(SCPDR)&0x01 ? 1 : 0; /* SCI */
> -	if (port->mapbase = 0xa4000150)
> -		return __raw_readb(SCPDR)&0x10 ? 1 : 0; /* SCIF */
> -	if (port->mapbase = 0xa4000140)
> -		return __raw_readb(SCPDR)&0x04 ? 1 : 0; /* IRDA */
> -	return 1;
> -}

I've applied the parts that clean up sci_rxd_in(), but dropped all of the
register definition deletions. Those definitions are used throughout the
driver in random locations by different subtypes, as well as places like
sci_init_pins().

There's a lot of work that needs to be done before we can safely kill
them off.
