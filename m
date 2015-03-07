From: Simon Horman <horms@verge.net.au>
Date: Sat, 07 Mar 2015 00:07:06 +0000
Subject: Re: [PATCH 09/11] serial: sh-sci: Add device tree bindings for r8a7793
Message-Id: <20150307000706.GF19866@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-10-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-10-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 06, 2015 at 06:09:56PM +0100, Ulrich Hecht wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> index ae73bb0..6b879b5 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -19,6 +19,10 @@ Required properties:
>      - "renesas,scifa-r8a7791" for R8A7791 (R-Car M2) SCIFA compatible UART.
>      - "renesas,scifb-r8a7791" for R8A7791 (R-Car M2) SCIFB compatible UART.
>      - "renesas,hscif-r8a7791" for R8A7791 (R-Car M2) HSCIF compatible UART.

Not appropriate for this patch, but
I wonder if M2 should be updated to M2W throughout
Documentation/devicetree/bindings/

> +    - "renesas,scif-r8a7793" for R8A7793 (R-Car M2N) SCIF compatible UART.
> +    - "renesas,scifa-r8a7793" for R8A7793 (R-Car M2N) SCIFA compatible UART.
> +    - "renesas,scifb-r8a7793" for R8A7793 (R-Car M2N) SCIFB compatible UART.
> +    - "renesas,hscif-r8a7793" for R8A7793 (R-Car M2N) HSCIF compatible UART.
>      - "renesas,scif-r8a7794" for R8A7794 (R-Car E2) SCIF compatible UART.
>      - "renesas,scifa-r8a7794" for R8A7794 (R-Car E2) SCIFA compatible UART.
>      - "renesas,scifb-r8a7794" for R8A7794 (R-Car E2) SCIFB compatible UART.
> -- 
> 2.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
