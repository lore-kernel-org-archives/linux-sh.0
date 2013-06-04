From: Simon Horman <horms@verge.net.au>
Date: Tue, 04 Jun 2013 02:18:34 +0000
Subject: Re: [PATCH] sh-pfc: r8a7779: Fix merge conflict
Message-Id: <20130604021834.GS23054@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, May 29, 2013 at 09:15:41AM +0200, Laurent Pinchart wrote:
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> Hi Simon,
> 
> The following commit introduced a bug in pinmux support for r8a7779.c. Would
> you be able to squash this patch into the commit when pushing it to mainline ?

Done. It should appear the next time I push into the renesas tree.
Hopefully later today.

> 
> commit e15dfb923186955690b56406eb6e8adcbafbea40
> Author: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Date:   Mon Apr 8 12:05:31 2013 +0200
> 
>     sh-pfc: r8a7779: Replace hardcoded pin numbers with RCAR_GP_PIN macro
>     
>     Use the RCAR_GP_PIN macro to convert from the documentation pin number
>     space to the linear pinctrl space.
>     
>     Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>     Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> index 6ad6fdd..96bdf48 100644
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> @@ -2425,7 +2425,6 @@ static const unsigned int sdhi3_wp_mux[] = {
>  /* - USB0 ------------------------------------------------------------------- */
>  static const unsigned int usb0_pins[] = {
>  	/* PENC */
> -	154,
>  	RCAR_GP_PIN(4, 26),
>  };
>  static const unsigned int usb0_mux[] = {
> @@ -2440,7 +2439,6 @@ static const unsigned int usb0_ovc_mux[] = {
>  };
>  /* - USB1 ------------------------------------------------------------------- */
>  static const unsigned int usb1_pins[] = {
> -
>  	/* PENC */
>  	RCAR_GP_PIN(4, 27),
>  };
> -- 
> Regards,
> 
> Laurent Pinchart
> 
