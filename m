From: Simon Horman <horms@verge.net.au>
Date: Tue, 28 Apr 2015 02:07:02 +0000
Subject: Re: [PATCH] clk: emev2: Use generic names for device nodes
Message-Id: <20150428020701.GA26051@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1430139093-14769-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430139093-14769-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mike Turquette <mturquette@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Mon, Apr 27, 2015 at 02:51:33PM +0200, Geert Uytterhoeven wrote:
> uart -> serial
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/clock/emev2-clock.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/emev2-clock.txt b/Documentation/devicetree/bindings/clock/emev2-clock.txt
> index 60bbb1a8c69a3852..268ca615459e7549 100644
> --- a/Documentation/devicetree/bindings/clock/emev2-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/emev2-clock.txt
> @@ -52,7 +52,7 @@ usia_u0_sclk: usia_u0_sclk {
>  
>  Example of consumer:
>  
> -uart@e1020000 {
> +serial@e1020000 {
>  	compatible = "renesas,em-uart";
>  	reg = <0xe1020000 0x38>;
>  	interrupts = <0 8 0>;
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
