From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 27 Aug 2008 14:45:27 +0000
Subject: Re: [PATCH] smc91x support for edosk7760 (smc91c96 ethernet chip)
Message-Id: <20080827144527.GB32530@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48B53015.9000203@spesonline.com>
In-Reply-To: <48B53015.9000203@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

In the future, please send patches inline, or at the very least, using a
text/plain mime type. Whoever came up with text/x-diff was an idiot.

On Wed, Aug 27, 2008 at 12:44:37PM +0200, Luca Santini wrote:

> --- a/drivers/net/smc91x.h	2008-07-13 23:51:29.000000000 +0200
> +++ b/drivers/net/smc91x.h	2008-08-27 10:40:01.000000000 +0200
> @@ -429,6 +429,36 @@
>  
>  #include <asm/unit/smc91111.h>
>  
> +
> +
> +#elif defined(CONFIG_SH_EDOSK7760) //SPES
> +
> +/* SMC91C96 registers are 4 byte aligned rather than the
> + * usual 2 byte!
> + */
> +#define SMC_IO_SHIFT 1 //SPES
> +
> +#define SMC_CAN_USE_8BIT	1
> +#define SMC_CAN_USE_16BIT	1
> +#define SMC_CAN_USE_32BIT	1
> +#define SMC_NOWAIT		1
> +
> +#define SMC_inb(a, r)		readb((a) + (r))
> +#define SMC_inw(a, r)		readw((a) + (r))
> +#define SMC_inl(a, r)		readl((a) + (r))
> +#define SMC_outb(v, a, r)	writeb(v, (a) + (r))
> +#define SMC_outw(v, a, r)	writew(v, (a) + (r))
> +#define SMC_outl(v, a, r)	writel(v, (a) + (r))
> +#define SMC_insw(a, r, p, l)	readsw((a) + (r), p, l)
> +#define SMC_outsw(a, r, p, l)	writesw((a) + (r), p, l)
> +#define SMC_insl(a, r, p, l)	readsl((a) + (r), p, l)
> +#define SMC_outsl(a, r, p, l)	writesl((a) + (r), p, l)
> +
> +#define RPC_LSA_DEFAULT		RPC_LED_100_10
> +#define RPC_LSB_DEFAULT		RPC_LED_TX_RX
> +
> +#define SMC_DYNAMIC_BUS_CONFIG
> +
>  #else
>  
I think you've totally missed the point of the "dynamic" bus
configuration. Please explain why you need to hardcode things here for
your platform rather than using the platform data, as all new platforms
should be doing. If there is something insufficient in the current
dynamic bus configuration data, we should fix that, not add back in more
of this hardcoded board support damage.

>  /*
> @@ -702,7 +732,6 @@
>  */
>  #define BANK_SELECT		(14 << SMC_IO_SHIFT)
>  
> -
>  // Transmit Control Register
>  /* BANK 0  */
>  #define TCR_REG(lp) 	SMC_REG(lp, 0x0000, 0)
> @@ -1252,9 +1281,9 @@
>  
>  #define SMC_PUT_PKT_HDR(lp, status, length)				\
>  	do {								\
> -		if (SMC_32BIT(lp))					\
> +		if (SMC_32BIT(lp)){					\
>  			SMC_outl((status) | (length)<<16, ioaddr,	\
> -				 DATA_REG(lp));			\
> +				 DATA_REG(lp));	}		\
>  		else {							\
>  			SMC_outw(status, ioaddr, DATA_REG(lp));	\
>  			SMC_outw(length, ioaddr, DATA_REG(lp));	\
> @@ -1334,4 +1363,10 @@
>  			SMC_insb(ioaddr, DATA_REG(lp), p, l);		\
>  	} while (0)
>  
> +
> +
> +
> +
> +
> +
>  #endif  /* _SMC91X_H_ */


This part of the patch is nothing but whitespace damage. Please be more
careful and make sure you are only patching useful things in the future,
as this adds a lot of noise that has to be manually removed otherwise.
