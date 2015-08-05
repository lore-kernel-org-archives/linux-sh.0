From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 05 Aug 2015 09:34:12 +0000
Subject: Re: [PATCH v4 1/6] ARM: shmobile: r8a7740 dtsi: Add L2 cache-controller node
Message-Id: <55C1D894.8070302@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1438765090-823-1-git-send-email-geert+renesas@glider.be>
 <1438765090-823-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1438765090-823-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org



On 05/08/15 09:58, Geert Uytterhoeven wrote:
> Add the missing L2 cache-controller node. This will allow migration to
> the generic l2c OF initialization.
>
> The L2 cache is an ARM L2C-310 (r3p1-150rel0), of size 256 KiB (32 KiB x
> 8 ways).
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v4:
>    - Commit eeedcea69e927857 ("ARM: 8395/1: l2c: Add support for the
>      "arm,shared-override" property") is queued for 4.3 in arm/for-next,
>
> v3:
>    - Add "arm,shared-override",
>
> v2:
>    - Fix interrupt (should be 3 cells, not 1),
>    - Describe cache better.
> ---
>   arch/arm/boot/dts/r8a7740.dtsi | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
> index d84714468cce18df..ddef5b1c68fa06b3 100644
> --- a/arch/arm/boot/dts/r8a7740.dtsi
> +++ b/arch/arm/boot/dts/r8a7740.dtsi
> @@ -37,6 +37,22 @@
>   		      <0xc2000000 0x1000>;
>   	};
>
> +	L2: cache-controller {
> +		compatible = "arm,pl310-cache";
> +		reg = <0xf0100000 0x1000>;
> +		interrupts = <0 84 IRQ_TYPE_LEVEL_HIGH>;
> +		power-domains = <&pd_a3sm>;
> +		arm,data-latency = <3 3 3>;
> +		arm,tag-latency = <2 2 2>;
> +		arm,shared-override;
> +		cache-unified;
> +		cache-level = <2>;
> +		cache-size = <0x40000>;
> +		cache-sets = <1024>;
> +		cache-block-size = <32>;
> +		cache-line-size = <32>;

Any particular reason whey you need all this cache-* properties ? Is
something broken on these SoCs ? We should be able to get most of these
information from the SoC(reading some registers). It's good to avoid
passing them via DT if they can be discovered from hardware.

Regards,
Sudeep
