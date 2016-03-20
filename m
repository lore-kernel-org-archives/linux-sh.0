From: Rob Herring <robh@kernel.org>
Date: Sun, 20 Mar 2016 00:04:59 +0000
Subject: Re: [PATCH/RFC 1/5] serial: sh-sci: Update DT binding documentation for GPIO modem lines
Message-Id: <20160320000459.GA18995@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1458222449-12324-1-git-send-email-geert+renesas@glider.be>
 <1458222449-12324-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1458222449-12324-2-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Mar 17, 2016 at 02:47:25PM +0100, Geert Uytterhoeven wrote:
> Amend the DT bindings for the Renesas SCI driver to allow describing
> optional GPIO-controlled modem lines, which can be used where dedicated
> modem lines are not available.
> 
> The property naming is dictated by the SERIAL_MCTRL_GPIO helpers.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> index 528c3b90f23cb04b..f8d7b36742967163 100644
> --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> @@ -76,6 +76,9 @@ Optional properties:
>    - dmas: Must contain a list of two references to DMA specifiers, one for
>  	  transmission, and one for reception.
>    - dma-names: Must contain a list of two DMA names, "tx" and "rx".
> +  - {cts,dsr,dcd,rng,rts,dtr,out1,out2}-gpios: Must contain a GPIO specifier,
> +    referring to the GPIO pin to be used as the UART's CTS, DSR, DCD, RNG, RTS,
> +    DTR, OUT1, or OUT2 line.

It would be good to document these in a common location as at least some 
are already in use. Otherwise,

Acked-by: Rob Herring <robh@kernel.org>

Rob
