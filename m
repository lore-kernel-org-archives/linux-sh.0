From: Matt Fleming <matt@console-pimps.org>
Date: Thu, 26 Nov 2009 10:51:30 +0000
Subject: Re: [PATCH 1/2] sh: mach-ecovec24: modify memory area calculation
Message-Id: <20091126105130.GA6612@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <u8wdto9qh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u8wdto9qh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 26, 2009 at 07:34:30PM +0900, Kuninori Morimoto wrote:
> diff --git a/arch/sh/include/mach-ecovec24/mach/romimage.h b/arch/sh/include/mach-ecovec24/mach/romimage.h
> index 1c8787e..115495d 100644
> --- a/arch/sh/include/mach-ecovec24/mach/romimage.h
> +++ b/arch/sh/include/mach-ecovec24/mach/romimage.h
> @@ -11,10 +11,13 @@
>  	icbi	@r0
>  
>  	/* jump to cached area */
> -	mova	2f, r0
> +	mov.l	2f, r1
> +	mova	3f, r0
> +	sub	r1, r0
>  	jmp	@r0
>  	nop
>  
>  	.align 2
>  1 :	.long 0xa8000000
> -2 :
> +2 :	.long 0x20000000 /* 0xA0000000 - 0x80000000 */
> +3 :
> -- 
> 1.6.3.3
> 

I think both of these patches should be using the variable
"cached_to_uncached", rather than hard coding the value 0x20000000.
