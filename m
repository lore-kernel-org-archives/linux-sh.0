From: Simon Horman <horms@verge.net.au>
Date: Wed, 16 Jul 2014 14:23:30 +0000
Subject: Re: [PATCH] ARM: shmobile: Remove MACH_GENMAI from Makefile.boot
Message-Id: <20140716142329.GA4360@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1405511936-6079-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405511936-6079-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 16, 2014 at 01:58:56PM +0200, Laurent Pinchart wrote:
> The CONFIG_MACH_GENMAI option has been removed in commit bec652e2fbfe
> ("ARM: shmobile: r7s72100: genmai: Remove legacy board file"). Remove
> the leftovers from Makefile.boot.
> 
> Reported-by: Paul Bolle <pebolle@tiscali.nl>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/mach-shmobile/Makefile.boot | 1 -
>  1 file changed, 1 deletion(-)
> 
> Simon, could you please queue this on top of your MACH_GENMAI removal
> branch ?

Thanks, applied.

> diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
> index ebf97d4..a23e155 100644
> --- a/arch/arm/mach-shmobile/Makefile.boot
> +++ b/arch/arm/mach-shmobile/Makefile.boot
> @@ -6,7 +6,6 @@ loadaddr-$(CONFIG_MACH_ARMADILLO800EVA) += 0x40008000
>  loadaddr-$(CONFIG_MACH_ARMADILLO800EVA_REFERENCE) += 0x40008000
>  loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
>  loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
> -loadaddr-$(CONFIG_MACH_GENMAI) += 0x08008000
>  loadaddr-$(CONFIG_MACH_KOELSCH) += 0x40008000
>  loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
>  loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
> -- 
> Regards,
> 
> Laurent Pinchart
> 
