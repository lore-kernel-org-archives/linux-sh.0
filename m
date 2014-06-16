From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 16 Jun 2014 07:41:00 +0000
Subject: RE: [PATCH v3 3/8] ARM: shmobile: r8a7790: Add PCIe Controller device node
Message-Id: <23a9320ca26b4240ad27dd1d81f08b5d@HKXPR06MB168.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375963414-31096-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375963414-31096-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On 16 June 2014 01:55, Simon wrote:
> On Fri, Jun 13, 2014 at 10:37:17AM +0100, Phil Edworthy wrote:
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> > v3:
> >  - No change
> >
> > v2:
> >  - Changed PCIe controller names,etc from pcie to pciec
> >
> >  arch/arm/boot/dts/r8a7790.dtsi | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> 
> Hi Phil,
> 
> I encountered a minor conflict when applying this patch.
> The version that I have queued-up is below, please check that it is correct.
Looks good.

Thanks
Phil
 
> From: Phil Edworthy <phil.edworthy@renesas.com>
> 
> ARM: shmobile: r8a7790: Add PCIe Controller device node
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> [horms+renesas@verge.net.au: resolved conflict]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7790.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi
> b/arch/arm/boot/dts/r8a7790.dtsi
> index 2c55c4b..994330e 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -930,6 +930,31 @@
>  		status = "disabled";
>  	};
> 
> +	pciec: pcie@fe000000 {
> +		compatible = "renesas,pcie-r8a7790";
> +		reg = <0 0xfe000000 0 0x80000>;
> +		#address-cells = <3>;
> +		#size-cells = <2>;
> +		bus-range = <0x00 0xff>;
> +		device_type = "pci";
> +		ranges = <0x01000000 0 0x00000000 0 0xfe100000 0
> 0x00100000
> +			  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
> +			  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
> +			  0x42000000 0 0x38000000 0 0x38000000 0
> 0x08000000>;
> +		/* Map all possible DDR as inbound ranges */
> +		dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0
> 0x80000000
> +			      0x43000000 1 0x80000000 1 0x80000000 0
> 0x80000000>;
> +		interrupts = <0 116 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 117 IRQ_TYPE_LEVEL_HIGH>,
> +			     <0 118 IRQ_TYPE_LEVEL_HIGH>;
> +		#interrupt-cells = <1>;
> +		interrupt-map-mask = <0 0 0 0>;
> +		interrupt-map = <0 0 0 0 &gic 0 116 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&mstp3_clks R8A7790_CLK_PCIEC>,
> <&pcie_bus_clk>;
> +		clock-names = "pcie", "pcie_bus";
> +		status = "disabled";
> +	};
> +
>  	rcar_sound: rcar_sound@0xec500000 {
>  		#sound-dai-cells = <1>;
>  		compatible =  "renesas,rcar_sound-r8a7790",
> "renesas,rcar_sound-gen2", "renesas,rcar_sound";
> --
> 2.0.0.rc2
> 
> 

