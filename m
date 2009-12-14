From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 14 Dec 2009 02:10:01 +0000
Subject: Re: [PATCH] sh: Add CONFIG_PARAM_* to set boot parameters.
Message-Id: <20091214021001.GA12196@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
In-Reply-To: <20091130170254.65d2a0ab.yoshii.takashi@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 10, 2009 at 02:00:25PM +0900, yoshii.takashi@gmail.com wrote:
> diff --git a/arch/sh/kernel/head_32.S b/arch/sh/kernel/head_32.S
> index a78be74..58325fe 100644
> --- a/arch/sh/kernel/head_32.S
> +++ b/arch/sh/kernel/head_32.S
> @@ -27,17 +27,36 @@
>  
>  	.section	.empty_zero_page, "aw"
>  ENTRY(empty_zero_page)
> +#ifdef CONFIG_PARAM_BOOL
> +	.long	CONFIG_PARAM_MOUNT_ROOT_RDONLY
> +	.long	CONFIG_PARAM_RAMDISK_FLAGS
> +	.long	CONFIG_PARAM_ORIG_ROOT_DEV
> +	.long	CONFIG_PARAM_LOADER_TYPE
> +	.long	CONFIG_PARAM_INITRD_START
> +	.long	CONFIG_PARAM_INITRD_SIZE
> +#else
>  	.long	1		/* MOUNT_ROOT_RDONLY */
>  	.long	0		/* RAMDISK_FLAGS */
>  	.long	0x0200		/* ORIG_ROOT_DEV */
>  	.long	1		/* LOADER_TYPE */
>  	.long	0x00000000	/* INITRD_START */
>  	.long	0x00000000	/* INITRD_SIZE */
> +#endif

There's not really any point in conditionalizing these. If you want to
have them as config options, then just drop the bool and make them
unconditionally defined. You can just use the values that are there now
for the default values.

>  #ifdef CONFIG_32BIT
>  	.long	0x53453f00 + 32	/* "SE?" = 32 bit */
>  #else
>  	.long	0x53453f00 + 29	/* "SE?" = 29 bit */
>  #endif
> +#if defined(CONFIG_CMDLINE)
> +	.long	0x100		/* offset of the default command line */
> +#else
> +	.long	0
> +#endif
> +#if defined(CONFIG_CMDLINE)
> +	.skip	empty_zero_page + 0x100 - .
> +cmdline:
> +	.asciz	CONFIG_CMDLINE	! default command line
> +#endif
>  1:
>  	.skip	PAGE_SIZE - empty_zero_page - 1b
>  
The command line handling could go the same way, with a bit of Kconfig
reordering there is no need for any ifdefs besides the 32/29bit stuff.
