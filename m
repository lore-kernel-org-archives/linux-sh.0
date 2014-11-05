From: Simon Horman <horms@verge.net.au>
Date: Wed, 05 Nov 2014 05:54:07 +0000
Subject: Re: [PATCH] ARM: shmobile: alt dts: Drop console= bootargs parameter
Message-Id: <20141105055407.GD32680@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1415075018-27529-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1415075018-27529-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Nov 04, 2014 at 01:23:38PM +0900, Simon Horman wrote:
> Alt is booted from DT, so chosen/stdout-path is
> always used, and we can drop the "console=" parameter from chosen/bootargs.
> 
> This change has a side-effect of changing the console speed from 38400
> to 115200. This is intentional as 115200 is consistently used on
> all other shmobile boards.
> 
> Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

I have queued this up.

> ---
>  arch/arm/boot/dts/r8a7794-alt.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
> index 8aec512..f2cf757 100644
> --- a/arch/arm/boot/dts/r8a7794-alt.dts
> +++ b/arch/arm/boot/dts/r8a7794-alt.dts
> @@ -20,7 +20,7 @@
>  	};
>  
>  	chosen {
> -		bootargs = "console=ttySC0,38400 ignore_loglevel rw root=/dev/nfs ip=dhcp";
> +		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
>  		stdout-path = &scif2;
>  	};
>  
> -- 
> 2.1.1
> 
