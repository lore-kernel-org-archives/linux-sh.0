From: Simon Horman <horms@verge.net.au>
Date: Fri, 01 May 2015 00:41:37 +0000
Subject: Re: [PATCH v2 13/15] serial: sh-sci: Add device tree bindings for r8a7793
Message-Id: <20150501004137.GD13754@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1430403544-26742-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1430403544-26742-14-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1430403544-26742-14-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: geert@linux-m68k.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart+renesas@ideasonboard.com, kuninori.morimoto.gx@renesas.com, linus.walleij@linaro.org, devicetree@vger.kernel.org

On Thu, Apr 30, 2015 at 04:19:02PM +0200, Ulrich Hecht wrote:
> Also replaces "R-Car M2" with "R-Car M2-W" to avoid confusion.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Cc: devicetree@vger.kernel.org

Acked-by: Simon Horman <horms+renesas@verge.net.au>

Most likely this needs to go to the SERIAL DRIVERS maintainers.

> ---
>  .../devicetree/bindings/serial/renesas,sci-serial.txt        | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> index ae73bb0..78419eb 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -15,10 +15,14 @@ Required properties:
>      - "renesas,scifa-r8a7790" for R8A7790 (R-Car H2) SCIFA compatible UART.
>      - "renesas,scifb-r8a7790" for R8A7790 (R-Car H2) SCIFB compatible UART.
>      - "renesas,hscif-r8a7790" for R8A7790 (R-Car H2) HSCIF compatible UART.
> -    - "renesas,scif-r8a7791" for R8A7791 (R-Car M2) SCIF compatible UART.
> -    - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2) SCIFA compatible UART.
> -    - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2) SCIFB compatible UART.
> -    - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2) HSCIF compatible UART.
> +    - "renesas,scif-r8a7791" for R8A7791 (R-Car M2-W) SCIF compatible UART.
> +    - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2-W) SCIFA compatible UART.
> +    - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2-W) SCIFB compatible UART.
> +    - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2-W) HSCIF compatible UART.
> +    - "renesas,scif-r8a7793" for R8A7793 (R-Car M2-N) SCIF compatible UART.
> +    - "renesas,scifa-r8a7793" for R8A7793 (R-Car M2-N) SCIFA compatible UART.
> +    - "renesas,scifb-r8a7793" for R8A7793 (R-Car M2-N) SCIFB compatible UART.
> +    - "renesas,hscif-r8a7793" for R8A7793 (R-Car M2-N) HSCIF compatible UART.
>      - "renesas,scif-r8a7794" for R8A7794 (R-Car E2) SCIF compatible UART.
>      - "renesas,scifa-r8a7794" for R8A7794 (R-Car E2) SCIFA compatible UART.
>      - "renesas,scifb-r8a7794" for R8A7794 (R-Car E2) SCIFB compatible UART.
> -- 
> 2.3.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
