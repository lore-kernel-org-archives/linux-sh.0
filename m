From: Simon Horman <horms@verge.net.au>
Date: Mon, 06 Oct 2014 02:36:53 +0000
Subject: Re: [PATCH v2 03/13] ARM: shmobile: kzm9d dts: Add chosen/stdout-path
Message-Id: <20141006023650.GA23099@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1412349104-18724-1-git-send-email-geert+renesas@glider.be>
 <1412349104-18724-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1412349104-18724-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

On Fri, Oct 03, 2014 at 05:11:34PM +0200, Geert Uytterhoeven wrote:
> Add a stdout-path property so that automatic console selection works
> in the absence of a "console=" parameter on the kernel command line.
> 
> Remove the now-superfluous "console=" parameter from chosen/bootargs.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

In my environment the bootargs portion of this change results
in no console output. I am guessing that this is because the
console starts with a different terminal speed (though which speed
I am unsure).

If my guess is correct then strictly speaking this is not a bug,
though it is a behavioural change. And as such I think at the very
least it needs some discussion.

> ---
> v2:
>   - No changes
> ---
>  arch/arm/boot/dts/emev2-kzm9d.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
> index a1794cbd23fee319..d01baba9e56f7781 100644
> --- a/arch/arm/boot/dts/emev2-kzm9d.dts
> +++ b/arch/arm/boot/dts/emev2-kzm9d.dts
> @@ -24,7 +24,8 @@
>  	};
>  
>  	chosen {
> -		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp";
> +		bootargs = "ignore_loglevel root=/dev/nfs ip=dhcp";
> +		stdout-path = &uart1;
>  	};
>  
>  	gpio_keys {
> -- 
> 1.9.1
> 
