From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 24 Aug 2015 18:25:10 +0000
Subject: Re: [PATCH v2 01/07] devicetree: bindings: Renesas APMU and SMP Enable method
Message-Id: <20008630.OlgzF7YJEU@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20150823072427.14156.1960.sendpatchset@little-apple> <20150823072439.14156.96621.sendpatchset@little-apple>
In-Reply-To: <20150823072439.14156.96621.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, keita.kobayashi.ym@renesas.com, horms@verge.net.au, geert@linux-m68k.org

Hi Magnus,

Thank you for the patch.

On Sunday 23 August 2015 16:24:39 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Add DT binding documentation for the APMU hardware and add "renesas,apmu"
> to the list of enable methods for the ARM cpus.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Changes since V1:
>  - None
> 
>  Documentation/devicetree/bindings/arm/cpus.txt           |    1
>  Documentation/devicetree/bindings/power/renesas,apmu.txt |   31 +++++++++++
>  2 files changed, 32 insertions(+)
> 
> --- 0001/Documentation/devicetree/bindings/arm/cpus.txt
> +++ work/Documentation/devicetree/bindings/arm/cpus.txt	2015-05-20
> 21:55:51.912366518 +0900 @@ -197,6 +197,7 @@ nodes to be present and
> contain the prop
>  			    "qcom,gcc-msm8660"
>  			    "qcom,kpss-acc-v1"
>  			    "qcom,kpss-acc-v2"
> +			    "renesas,apmu"
>  			    "rockchip,rk3066-smp"
> 
>  	- cpu-release-addr
> --- /dev/null
> +++ work/Documentation/devicetree/bindings/power/renesas,apmu.txt	
2015-05-20
> 22:39:34.872366518 +0900 @@ -0,0 +1,31 @@
> +DT bindings for the Renesas Advanced Power Management Unit
> +
> +Renesas R-Car line of SoCs utilize one or more APMU hardware units
> +for CPU core power domain control including SMP boot and CPU Hotplug.
> +
> +Required properties:
> +
> +- compatible: Should be "renesas,apmu-<soctype>", "renesas,apmu" as
> fallback.
> +	      Examples with soctypes are:
> +		- "renesas,apmu-r8a7790" (R-Car H2)
> +		- "renesas,apmu-r8a7791" (R-Car M2-W)
> +		- "renesas,apmu-r8a7792" (R-Car V2H)
> +		- "renesas,apmu-r8a7793" (R-Car M2-N)
> +		- "renesas,apmu-r8a7794" (R-Car E2)
> +
> +- reg: Base address and length of the I/O registers used by the APMU.
> +
> +- cpus: This node contains a list of CPU cores, which should match the
> order
> +  of CPU cores used by the WUPCR and PSTR registers in the Advanced Power
> +  Management Until section of the device's datasheet.
> +
> +
> +Example:
> +
> +This shows the r8a7791 APMU that can control CPU0 and CPU1.
> +
> +	apmu@e6152000 {
> +		compatible = "renesas,apmu-r8a7791", "renesas,apmu";
> +		reg = <0 0xe6152000 0 0x188>;

Are the CA7 and CA15 APMUs identical ? If not you won't be able to instantiate 
two APMU nodes, and it might be better to span the whole registers range of 
both CA7 and CA15.

> +		cpus = <&cpu0 &cpu1>;
> +	};

-- 
Regards,

Laurent Pinchart

