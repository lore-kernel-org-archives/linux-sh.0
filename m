From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 26 Oct 2009 00:29:04 +0000
Subject: Re: [PATCH] sh: Use SYS_SUPPORTS_32BIT for managing 32BIT dependencies.
Message-Id: <20091026002903.GA6108@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1256403131-20140-1-git-send-email-plagnioj@jcrosoft.com>
In-Reply-To: <1256403131-20140-1-git-send-email-plagnioj@jcrosoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Oct 24, 2009 at 06:52:11PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> diff --git a/arch/sh/mm/Kconfig b/arch/sh/mm/Kconfig
> index 64dc1ad..64b5d43 100644
> --- a/arch/sh/mm/Kconfig
> +++ b/arch/sh/mm/Kconfig
> @@ -82,7 +82,7 @@ config 32BIT
>  
>  config PMB_ENABLE
>  	bool "Support 32-bit physical addressing through PMB"
> -	depends on MMU && EXPERIMENTAL && (CPU_SUBTYPE_SH7757 || CPU_SUBTYPE_SH7780 || CPU_SUBTYPE_SH7785)
> +	depends on MMU && EXPERIMENTAL && SYS_SUPPORTS_32BIT
>  	select 32BIT
>  	default y
>  	help

I don't recall why we started conditionalizing this in the first place. I
think it was because out of the first-gen SH-4A boards the SH7770 was
lacking support for the PMB, while SH7780 had it, as did SH73180. Any
sensible SH-4A part ought to have the PMB, so it probably makes more
sense to just invert the logic and explicitly disable it for the one-off
chips that don't make any sense in the first place.
