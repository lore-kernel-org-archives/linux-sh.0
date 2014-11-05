From: Simon Horman <horms@verge.net.au>
Date: Wed, 05 Nov 2014 05:51:29 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a73a4: fix scifb* naming
Message-Id: <20141105055129.GC32680@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1415118084-25911-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1415118084-25911-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Nov 04, 2014 at 05:21:24PM +0100, Ulrich Hecht wrote:
> Ports are named scifb0-3, not scifb2-5.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Thanks, I have queued this up.
> ---
>  arch/arm/boot/dts/r8a73a4.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
> index b5ead84..7f57dc7 100644
> --- a/arch/arm/boot/dts/r8a73a4.dtsi
> +++ b/arch/arm/boot/dts/r8a73a4.dtsi
> @@ -274,14 +274,14 @@
>  		status = "disabled";
>  	};
>  
> -	scifb2: serial@e6c20000 {
> +	scifb0: serial@e6c20000 {
>  		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
>  		reg = <0 0xe6c20000 0 0x100>;
>  		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
>  		status = "disabled";
>  	};
>  
> -	scifb3: serial@e6c30000 {
> +	scifb1: serial@e6c30000 {
>  		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
>  		reg = <0 0xe6c30000 0 0x100>;
>  		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
> @@ -302,14 +302,14 @@
>  		status = "disabled";
>  	};
>  
> -	scifb4: serial@e6ce0000 {
> +	scifb2: serial@e6ce0000 {
>  		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
>  		reg = <0 0xe6ce0000 0 0x100>;
>  		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
>  		status = "disabled";
>  	};
>  
> -	scifb5: serial@e6cf0000 {
> +	scifb3: serial@e6cf0000 {
>  		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
>  		reg = <0 0xe6cf0000 0 0x100>;
>  		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 1.8.4.5
> 
