From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 26 Dec 2013 14:15:44 +0000
Subject: Re: [PATCH] pinctl: sh-pfc: r8a7790: Fix vsync value in the vin3_sync_mux array
Message-Id: <1875201.Ssrh3mNrfs@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1387830508-10710-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387830508-10710-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Valentine,

Thank you for the patch.

On Tuesday 24 December 2013 00:28:28 Valentine Barshak wrote:
> This fixes a typo in the vin3_sync_mux array (s/VI2/VI3/).
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c index 293a51a..01236c5 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
> @@ -3564,7 +3564,7 @@ static const unsigned int vin3_sync_pins[] = {
>  };
>  static const unsigned int vin3_sync_mux[] = {
>  	VI3_HSYNC_N_MARK,
> -	VI2_VSYNC_N_MARK,
> +	VI3_VSYNC_N_MARK,
>  };
>  static const unsigned int vin3_field_pins[] = {
>  	RCAR_GP_PIN(1, 15),
-- 
Regards,

Laurent Pinchart

