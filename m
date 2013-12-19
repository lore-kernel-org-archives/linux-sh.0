From: Simon Horman <horms@verge.net.au>
Date: Thu, 19 Dec 2013 08:27:35 +0000
Subject: Re: [PATCH] ARM: shmobile: mackerel: Fix USBHS pinconf entry
Message-Id: <20131219082735.GB12239@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1387032301-6609-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387032301-6609-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Dec 14, 2013 at 03:45:01PM +0100, Laurent Pinchart wrote:
> Fix a typo in the USBHS1 pinconf entry that prevented the pull-down from
> being enabled.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/mach-shmobile/board-mackerel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Simon,
> 
> The bug that this patch fixes got introduced in "ARM: shmobile: mackerel: Use
> pinconf API to configure pin pull-down". Feel free to squash the fix with the
> original patch if possible.

Thanks, Laurent.

I will queue this up as an incremental patch.

> 
> diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
> index 207acf0..b3ee96e 100644
> --- a/arch/arm/mach-shmobile/board-mackerel.c
> +++ b/arch/arm/mach-shmobile/board-mackerel.c
> @@ -1406,7 +1406,7 @@ static const struct pinctrl_map mackerel_pinctrl_map[] = {
>  	/* USBHS1 */
>  	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs.1", "pfc-sh7372",
>  				  "usb1_vbus", "usb1"),
> -	PIN_MAP_CONFIGS_GROUP_DEFAULT("renesas_usbhs.&", "pfc-sh7372",
> +	PIN_MAP_CONFIGS_GROUP_DEFAULT("renesas_usbhs.1", "pfc-sh7372",
>  				      "usb1_vbus", pin_pulldown_conf),
>  	PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs.1", "pfc-sh7372",
>  				  "usb1_otg_id_0", "usb1"),
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
