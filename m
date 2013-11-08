From: Kumar Gala <galak@codeaurora.org>
Date: Fri, 08 Nov 2013 14:26:47 +0000
Subject: Re: [PATCH V3 2/2] dt: Document sata_rcar bindings
Message-Id: <E0BF568D-6856-4DDE-AEBA-7C21CB1CE1F3@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1383912570-8393-1-git-send-email-valentine.barshak@cogentembedded.com> <1383912570-8393-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383912570-8393-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Valentine Barshak <valentine.barshak@cogentembedded.com>
Cc: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Tejun Heo <tj@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>


On Nov 8, 2013, at 6:09 AM, Valentine Barshak wrote:

> These bindings can be used to register SATA devices found on R-Car SoC.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---
> Documentation/devicetree/bindings/ata/sata_rcar.txt | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/ata/sata_rcar.txt
> 
> diff --git a/Documentation/devicetree/bindings/ata/sata_rcar.txt b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> new file mode 100644
> index 0000000..1e61113
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/ata/sata_rcar.txt
> @@ -0,0 +1,18 @@
> +* Renesas R-Car SATA
> +
> +Required properties:
> +- compatible		: should contain one of the following:
> +			  - "renesas,sata-r8a7779" for R-Car H1
> +			  - "renesas,sata-r8a7790" for R-Car H2
> +			  - "renesas,sata-r8a7791" for R-Car M2
> +- reg			: address and length of the SATA registers;
> +- interrupts		: must consist of one interrupt specifier.
> +
> +Example:
> +
> +sata: sata@fc600000 {
> +	compatible = "renesas,sata-r8a7779";
> +	reg = <0xfc600000 0x2000>;
> +	interrupt-parent = <&gic>;
> +	interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;

Sorry, I missed the discussion on this, but I think it would be better in the example to leave this as 4.  There is no reference in the binding at all to figure out where IRQ_TYPE_LEVEL_HIGH is defined.

> +};
> -- 
> 1.8.3.1
> 

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

