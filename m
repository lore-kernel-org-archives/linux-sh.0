From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 24 Aug 2015 18:29:09 +0000
Subject: Re: [PATCH v2 03/07] ARM: shmobile: Add APMU nodes to r8a7790 DTSI
Message-Id: <1534893.ppOlo5pCGu@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20150823072427.14156.1960.sendpatchset@little-apple> <20150823072500.14156.35604.sendpatchset@little-apple>
In-Reply-To: <20150823072500.14156.35604.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com, keita.kobayashi.ym@renesas.com, horms@verge.net.au, geert@linux-m68k.org

Hi Magnus,

Thank you for the patch.

On Sunday 23 August 2015 16:25:00 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Add an APMU DT node for the r8a7790 SoC and use the enable-method to
> point out that the APMU should be used for SMP support.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  Changes from V1:
>  - New patch
> 
>  arch/arm/boot/dts/r8a7790.dtsi |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> --- 0001/arch/arm/boot/dts/r8a7790.dtsi
> +++ work/arch/arm/boot/dts/r8a7790.dtsi	2015-08-23 15:51:24.132366518 +0900
> @@ -43,6 +43,7 @@
>  	cpus {
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> +		enable-method = "renesas,apmu";
> 
>  		cpu0: cpu@0 {
>  			device_type = "cpu";
> @@ -112,6 +113,18 @@
>  		};
>  	};
> 
> +	apmu@e6151000 {
> +		compatible = "renesas,apmu-r8a7790", "renesas,apmu";
> +		reg = <0 0xe6151000 0 0x188>;
> +		cpus = <&cpu4 &cpu5 &cpu6 &cpu7>;
> +	};
> +
> +	apmu@e6152000 {
> +		compatible = "renesas,apmu-r8a7790", "renesas,apmu";
> +		reg = <0 0xe6152000 0 0x188>;
> +		cpus = <&cpu0 &cpu1 &cpu2 &cpu3>;
> +	};

I wonder whether those two nodes shouldn't be moved inside the CPG node as it 
seems that the APMU is part of the CPG IP core. We can delay that though, as 
the Gen3 DTS will need to be refactored anyway.

> +
>  	gic: interrupt-controller@f1001000 {
>  		compatible = "arm,gic-400";
>  		#interrupt-cells = <3>;

-- 
Regards,

Laurent Pinchart

