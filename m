From: Simon Horman <horms@verge.net.au>
Date: Thu, 30 Oct 2014 01:21:51 +0000
Subject: Re: [PATCH 0/3] ARM: shmobile: koelsch: Removal cleanups
Message-Id: <20141030012150.GH22052@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414592918-25138-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414592918-25138-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Oct 29, 2014 at 03:28:35PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series does some cleanups after the removal of koelsch-legacy
> support.
> 
> Thanks for applying!

Thanks. I have taken the liberty of rewording the changelogs a little
as the commit ids they refer to are not stable.

> 
> Geert Uytterhoeven (3):
>   MAINTAINERS: Remove reference to shmobile / koelsch_defconfig
>   ARM: dts: koelsch: Stop building r8a7791-koelsch.dtb in legacy builds
>   ARM: shmobile: koelsch dts: Drop console= bootargs parameter
> 
>  MAINTAINERS                           | 1 -
>  arch/arm/boot/dts/Makefile            | 1 -
>  arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
>  3 files changed, 1 insertion(+), 3 deletions(-)
> 
> -- 
> 1.9.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
