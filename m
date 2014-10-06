From: Simon Horman <horms@verge.net.au>
Date: Mon, 06 Oct 2014 23:53:39 +0000
Subject: Re: [PATCH v3] ARM: shmobile: kzm9d dts: Add chosen/stdout-path
Message-Id: <20141006235338.GA8379@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1412596753-20734-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1412596753-20734-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org

On Mon, Oct 06, 2014 at 01:59:13PM +0200, Geert Uytterhoeven wrote:
> Add a stdout-path property so that automatic console selection works
> in the absence of a "console=" parameter on the kernel command line.
> 
> Note that we have to keep the "console=ttyS1,115200n81" parameter in
> chosen/bootargs, else the console will use the default setting of 9600
> baud.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Geert, I have queued this up.

> ---
> v3:
>   - Keep "console="
> v2:
>   - No changes
> ---
>  arch/arm/boot/dts/emev2-kzm9d.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
> index a1794cbd23fee319..667d323e80a3e176 100644
> --- a/arch/arm/boot/dts/emev2-kzm9d.dts
> +++ b/arch/arm/boot/dts/emev2-kzm9d.dts
> @@ -25,6 +25,7 @@
>  
>  	chosen {
>  		bootargs = "console=ttyS1,115200n81 ignore_loglevel root=/dev/nfs ip=dhcp";
> +		stdout-path = &uart1;
>  	};
>  
>  	gpio_keys {
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
