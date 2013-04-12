From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 12 Apr 2013 08:15:12 +0000
Subject: Re: [PATCH] sh-pfc: R8A7779: add VIN pin groups
Message-Id: <1724637.xsbrB8zBI5@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <201304120251.38652.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304120251.38652.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

Thank you for the patch.

Beside Morimoto-san's request to use the RCAR_GP_PIN() macro, please see below 
for a small comment.

On Friday 12 April 2013 02:51:38 Sergei Shtylyov wrote:
> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> 
> Add VIN DATAx/CLK/HSYNC/VSYNC pin groups in R8A7779 PFC.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> These pins will be needed by the upcoming R-Car VIN driver...
> The patch is atop of Simon's 'renesas.git' tree, 'renesas-next-20130411v2'
> tag.
> 
>  drivers/pinctrl/sh-pfc/pfc-r8a7779.c |  139 ++++++++++++++++++++++++++++++-
>  1 file changed, 138 insertions(+), 1 deletion(-)
> 
> Index: renesas/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> =================================> --- renesas.orig/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> +++ renesas/drivers/pinctrl/sh-pfc/pfc-r8a7779.c

[snip]

> @@ -2413,6 +2414,102 @@ static const unsigned int usb2_pins[] >  static const unsigned int usb2_mux[] = {
>  	USB_OVC2_MARK, USB_PENC2_MARK,
>  };
> +/* - VIN0
> ------------------------------------------------------------------- */
> +static const unsigned int vin0_data8_pins[] = {
> +	/* D[0:7] */
> +	70, 71, 72, 73, 74, 75, 76, 77,
> +};
> +static const unsigned int vin0_data8_mux[] = {
> +	VI0_DATA0_VI0_B0_MARK, VI0_DATA1_VI0_B1_MARK, VI0_DATA2_VI0_B2_MARK,
> +	VI0_DATA3_VI0_B3_MARK, VI0_DATA4_VI0_B4_MARK, VI0_DATA5_VI0_B5_MARK,
> +	VI0_DATA6_VI0_B6_MARK, VI0_DATA7_VI0_B7_MARK,
> +};

Won't you also need to support the other input data formats ?

-- 
Regards,

Laurent Pinchart

