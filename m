From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 08 Sep 2015 06:59:01 +0000
Subject: Re: [PATCH][RFC] arm64: renesas: Add EXTAL configuration to Salvator-X
Message-Id: <7037545.Z4NQMM7rZH@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20150908044957.4919.98690.sendpatchset@little-apple>
In-Reply-To: <20150908044957.4919.98690.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

Thank you for the patch.

On Tuesday 08 September 2015 13:49:57 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Configure EXTAL to 16.666 MHz on Salvator-X.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

This looks quite straightforward and good to me. I don't think it requires the 
RFC status.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  This sets the EXTAL frequency for the V9 integration series:
>  [PATCH v9 00/07][RFC] Renesas R-Car H3 (r8a7795) integration patches V9
> 
>  To be used with the V7 CPG:
>  [PATCH v7 00/05] Renesas R-Car Gen3 CPG support V7
> 
>  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- 0007/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> +++ work/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts	2015-09-08
> 13:44:53.682366518 +0900 @@ -32,6 +32,10 @@
>  	};
>  };
> 
> +&extal_clk {
> +	clock-frequency = <16666666>;
> +};
> +
>  &pfc {
>  	scif1_pins: scif1 {
>  		renesas,groups = "scif1_data_a", "scif1_ctrl";

-- 
Regards,

Laurent Pinchart

