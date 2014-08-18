From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Aug 2014 23:41:39 +0000
Subject: Re: [PATCH 7/8] ARM: shmobile: r8a7794: document SCIF clock support
Message-Id: <20140818234139.GH1623@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1408377107-3822-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1408377107-3822-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1408377107-3822-8-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-sh@vger.kernel.org, mturquette@linaro.org, magnus.damm@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

On Mon, Aug 18, 2014 at 05:51:46PM +0200, Ulrich Hecht wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 4 ++++
>  1 file changed, 4 insertions(+)


Acked-by: Simon Horman <horms+renesas@verge.net.au>

Serial patches need to go through Greg KH and the linux-serial ML (both CCed).
Please consider reposting this patch with them CCed.

> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> index b355660..7b87eb2 100644
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
> 1.8.4.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
