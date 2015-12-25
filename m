From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 25 Dec 2015 11:36:14 +0000
Subject: Re: [PATCH 2/6] arm64: renesas: r8a7795: add USB2.0 Host (EHCI/OHCI) device nodes
Message-Id: <567D2A2E.1080705@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1451037839-572-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1451037839-572-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1451037839-572-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 12/25/2015 1:03 PM, Yoshihiro Shimoda wrote:

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>   arch/arm64/boot/dts/renesas/r8a7795.dtsi | 66 ++++++++++++++++++++++++++++++++
>   1 file changed, 66 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index 89393ea..e26073c 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -809,5 +809,71 @@
>   			#phy-cells = <0>;
>   			status = "disabled";
>   		};
> +
> +		ehci0: usb@ee080100 {
> +			compatible = "renesas,ehci-r8a7795", "generic-ehci";
> +			reg = <0 0xee080100 0 0xff>;

    s/0xff/0x100? This is size, not limit.

> +			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 703>;
> +			phys = <&usb2_phy0>;
> +			phy-names = "usb";
> +			power-domains = <&cpg>;
> +			status = "disabled";
> +		};
> +
> +		ehci1: usb@ee0a0100 {
> +			compatible = "renesas,ehci-r8a7795", "generic-ehci";
> +			reg = <0 0xee0a0100 0 0xff>;

    Likewise?

> +			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 702>;
> +			phys = <&usb2_phy1>;
> +			phy-names = "usb";
> +			power-domains = <&cpg>;
> +			status = "disabled";
> +		};
> +
> +		ehci2: usb@ee0c0100 {
> +			compatible = "renesas,ehci-r8a7795", "generic-ehci";
> +			reg = <0 0xee0c0100 0 0xff>;

    Likewise?

> +			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 701>;
> +			phys = <&usb2_phy2>;
> +			phy-names = "usb";
> +			power-domains = <&cpg>;
> +			status = "disabled";
> +		};
> +
> +		ohci0: usb@ee080000 {
> +			compatible = "renesas,ohci-r8a7795", "generic-ohci";
> +			reg = <0 0xee080000 0 0xff>;

    Likewise?

> +			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 703>;
> +			phys = <&usb2_phy0>;
> +			phy-names = "usb";
> +			power-domains = <&cpg>;
> +			status = "disabled";
> +		};
> +
> +		ohci1: usb@ee0a0000 {
> +			compatible = "renesas,ohci-r8a7795", "generic-ohci";
> +			reg = <0 0xee0a0000 0 0xff>;

    Likewise?

> +			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 702>;
> +			phys = <&usb2_phy1>;
> +			phy-names = "usb";
> +			power-domains = <&cpg>;
> +			status = "disabled";
> +		};
> +
> +		ohci2: usb@ee0c0000 {
> +			compatible = "renesas,ohci-r8a7795", "generic-ohci";
> +			reg = <0 0xee0c0000 0 0xff>;

    Likewise?

[...]

MBR, Sergei

