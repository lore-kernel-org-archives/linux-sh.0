From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Dec 2014 06:42:38 +0000
Subject: Re: [PATCH] ARM: shmobile: ape6evm-reference: Correct BSC bus range
Message-Id: <20141204064237.GG19568@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <ba6094d6e8f30a538e08e9a892f3e37debd84413.1377652718.git.horms+renesas@verge.net.au>
In-Reply-To: <ba6094d6e8f30a538e08e9a892f3e37debd84413.1377652718.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Tue, Dec 02, 2014 at 06:35:55PM +0100, Geert Uytterhoeven wrote:
> The address space for the r8a73a4 Bus State Controller covers the first
> 512 MiB, not the first 2 GiB.
> Correct the size in the "ranges" property to reflect this, and to no
> longer overlap with PCI Express Memory.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> No impact for now, just correctness.

Thanks, I have queued up as a DT change for v3.20.

> ---
>  arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> index 84e05f713c5425a6..b3d8f844b57a8fc2 100644
> --- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> +++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> @@ -67,7 +67,7 @@
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> -		ranges = <0 0 0 0x80000000>;
> +		ranges = <0 0 0 0x20000000>;
>  	};
>  };
>  
> -- 
> 1.9.1
> 
