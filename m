From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 18 Sep 2012 07:42:44 +0000
Subject: Re: [PATCH 01/24] ARM: shmobile: use __iomem pointers for MMIO
Message-Id: <20120918074244.GO13568@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-2-git-send-email-arnd@arndb.de>
In-Reply-To: <1347658492-11608-2-git-send-email-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Sep 14, 2012 at 11:34:29PM +0200, Arnd Bergmann wrote:
> ARM is moving to stricter checks on readl/write functions,
> so we need to use the correct types everywhere.
> 
> This patch is a bit ugly for shmobile, which is the only platform
> that just uses integer literals all over the place, but I can't
> see a better way to do this.
> 
If you want to crap up the ARM side with this stuff, that's fine, but
leave sh-sci out of it.

So, NAK on this part:

> diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
> index eb763ad..d323290 100644
> --- a/include/linux/serial_sci.h
> +++ b/include/linux/serial_sci.h
> @@ -150,7 +150,7 @@ struct plat_sci_port {
>  	int		overrun_bit;
>  	unsigned int	error_mask;
>  
> -	int		port_reg;
> +	void __iomem   *port_reg;
>  	unsigned char	regshift;
>  	unsigned char	regtype;
>  
but I don't mind if you cast the callsite in drivers/tty/serial/sh-sci.c
