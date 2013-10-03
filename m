From: Simon Horman <horms@verge.net.au>
Date: Thu, 03 Oct 2013 02:44:29 +0000
Subject: Re: [PATCH 05/10] ARM: shmobile: r8a7791 Arch timer device tree node
Message-Id: <20131003024428.GD28463@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131001081143.4136.46925.sendpatchset@w520>
 <20131001081238.4136.38665.sendpatchset@w520>
In-Reply-To: <20131001081238.4136.38665.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Oct 01, 2013 at 05:12:38PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add r8a7791 arch timer device tree information.
> 
> This needs to be used together with r8a7791 support
> code that ties in the R-Car Gen2 arch timer workarounds.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/boot/dts/r8a7791.dtsi |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> --- 0005/arch/arm/boot/dts/r8a7791.dtsi
> +++ work/arch/arm/boot/dts/r8a7791.dtsi	2013-10-01 16:30:54.000000000 +0900
> @@ -39,6 +39,14 @@
>  		interrupts = <1 9 0xf04>;
>  	};
>  
> +	timer {
> +		compatible = "arm,armv7-timer";
> +		interrupts = <1 13 0xf08>,
> +				<1 14 0xf08>,
> +				<1 11 0xf08>,
> +				<1 10 0xf08>;
> +	};
> +
>  	irqc0: interrupt-controller@e61c0000 {
>  		compatible = "renesas,irqc";
>  		#interrupt-cells = <2>;


Thanks, I have queued this up in the dt3 branch.
It should make it into v3.13 but if not I'll rename the branch
dt after rebasing it on v3.13-rcX which will then be targeted at v3.14.

The dt3 branch is a merge of other dt changes queued up for v3.13
with renesas-soc-for-v3.13, which I sent a pull request for a few
days ago. The reason for the merge is to provide the dts for the
r8a7791 SoC which is changed by this patch.

It might have been better to merge the dt for the r8a7791 SoC 
in a separate patch in the dt branch. But it wasn't.
