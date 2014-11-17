From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Nov 2014 01:37:51 +0000
Subject: Re: [PATCH 1/2] serial: sh-sci: Add device tree support for r8a7794
Message-Id: <20141117013750.GK11143@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1415980772-13287-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415980772-13287-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

On Fri, Nov 14, 2014 at 04:59:31PM +0100, Geert Uytterhoeven wrote:
> From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> 
> Simply document the new compat string.
> There appears to be no need for a driver update.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> [geert: Reworded to match previous commits]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> index b3556609a06fb8b9..7b87eb2c66be3131 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -20,6 +20,10 @@ Required properties:
>      - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2) SCIFA compatible UART.
>      - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2) SCIFB compatible UART.
>      - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2) HSCIF compatible UART.
> +    - "renesas,scif-r8a7794" for R8A7794 (R-Car E2) SCIF compatible UART.
> +    - "renesas,scifa-r8a7794" for R8A7794 (R-Car E2) SCIFA compatible UART.
> +    - "renesas,scifb-r8a7794" for R8A7794 (R-Car E2) SCIFB compatible UART.
> +    - "renesas,hscif-r8a7794" for R8A7794 (R-Car E2) HSCIF compatible UART.
>      - "renesas,scif" for generic SCIF compatible UART.
>      - "renesas,scifa" for generic SCIFA compatible UART.
>      - "renesas,scifb" for generic SCIFB compatible UART.
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
