From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 08 Jan 2014 07:52:28 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779: Remove unused clock constants
Message-Id: <2593623.Zsmb6Gy4Sn@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1389155679-27667-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1389155679-27667-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

Thank you for the patch.

On Wednesday 08 January 2014 13:34:39 Simon Horman wrote:
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v2
> * Rebase: MSTPSR1 is now used
> ---
>  arch/arm/mach-shmobile/clock-r8a7779.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c
> b/arch/arm/mach-shmobile/clock-r8a7779.c index 93a5625..8e403ae 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7779.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7779.c
> @@ -47,17 +47,10 @@
> 
>  #define MD(nr)	BIT(nr)
> 
> -#define FRQMR		IOMEM(0xffc80014)
>  #define MSTPCR0		IOMEM(0xffc80030)
>  #define MSTPCR1		IOMEM(0xffc80034)
>  #define MSTPCR3		IOMEM(0xffc8003c)
>  #define MSTPSR1		IOMEM(0xffc80044)
> -#define MSTPSR4		IOMEM(0xffc80048)
> -#define MSTPSR6		IOMEM(0xffc8004c)
> -#define MSTPCR4		IOMEM(0xffc80050)
> -#define MSTPCR5		IOMEM(0xffc80054)
> -#define MSTPCR6		IOMEM(0xffc80058)
> -#define MSTPCR7		IOMEM(0xffc80040)
> 
>  #define MODEMR		0xffcc0020

-- 
Regards,

Laurent Pinchart

