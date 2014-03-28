From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 28 Mar 2014 16:53:47 +0000
Subject: Re: [PATCH 2/7] gpio: rcar: Add optional functional clock to bindings
Message-Id: <1522709.FsOoKumPXz@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1395953262-4290-1-git-send-email-geert@linux-m68k.org> <1395953262-4290-3-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1395953262-4290-3-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Thursday 27 March 2014 21:47:37 Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: linux-gpio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> ---
>  .../devicetree/bindings/gpio/renesas,gpio-rcar.txt |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt index
> f61cef74a212..9ccbe50dcec2 100644
> --- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> +++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> @@ -21,6 +21,10 @@ Required Properties:
>      GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW flags are supported.
>    - gpio-ranges: Range of pins managed by the GPIO controller.
> 
> +Optional properties:
> +
> +  - clocks: Must contain a reference to the functional clock.
> +

I would make the property mandatory. Obviously the driver needs to consider it 
as optional in order not to break the DT ABI, but the specification should 
make it mandatory in order to ensure that all future implementations will 
specify the clock.

>  Please refer to gpio.txt in this directory for details of gpio-ranges
> property and the common GPIO bindings used by client devices.

-- 
Regards,

Laurent Pinchart

