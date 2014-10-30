From: Simon Horman <horms@verge.net.au>
Date: Thu, 30 Oct 2014 01:03:30 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: r8a7779 dtsi: Add SoC-specific SATA compatible property
Message-Id: <20141030010329.GE22052@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414591131-21771-1-git-send-email-geert+renesas@glider.be>
 <1414591131-21771-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414591131-21771-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Tejun Heo <tj@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Valentine Barshak <valentine.barshak@cogentembedded.com>, linux-ide@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Oct 29, 2014 at 02:58:51PM +0100, Geert Uytterhoeven wrote:
> The SATA node used the generic compatible property only, which was
> deprecated by commit e67adb4e669db834 ("sata_rcar: Add R-Car Gen2 SATA
> PHY support"). Add the SoC-specific one introduced by that commit.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I have queued this up.

> ---
>  arch/arm/boot/dts/r8a7779.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> index fda814ed191d1531..a8845328827a3f0c 100644
> --- a/arch/arm/boot/dts/r8a7779.dtsi
> +++ b/arch/arm/boot/dts/r8a7779.dtsi
> @@ -303,7 +303,7 @@
>  	};
>  
>  	sata: sata@fc600000 {
> -		compatible = "renesas,rcar-sata";
> +		compatible = "renesas,sata-r8a7779", "renesas,rcar-sata";
>  		reg = <0xfc600000 0x2000>;
>  		interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&mstp1_clks R8A7779_CLK_SATA>;
> -- 
> 1.9.1
> 
