From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 07 Jul 2015 08:41:37 +0000
Subject: Re: [PATCH 2/5] i2c: emev2: add binding documentation
Message-Id: <CAMuHMdU1iEn+38FY2ncDL_L_k2ytJFWH+Ek=kF42pC4pdsuAzQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1436219188-4325-1-git-send-email-wsa@the-dreams.de>
	<1436219188-4325-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1436219188-4325-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Wolfram,

On Mon, Jul 6, 2015 at 11:46 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-emev2.txt b/Documentation/devicetree/bindings/i2c/i2c-emev2.txt
> new file mode 100644
> index 00000000000000..a6740066835056
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-emev2.txt
> @@ -0,0 +1,22 @@
> +Device tree configuration for Renesas EMEV2 IIC driver
> +
> +Required properties:
> +- compatible      : "renesas,iic-<soctype>". "renesas,iic-emev2" as fallback

What's the "<soctype>"? Isn't that "emev2"?

> +- reg             : address start and address range size of device
> +- interrupts      : 1 interrupt
> +- clocks          : phandle to the IP core SCLK
> +- clock-names     : must be "sclk"
> +- #address-cells  : should be <1>
> +- #size-cells     : should be <0>
> +
> +Example:
> +
> +       iic0: i2c@e0070000 {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               compatible = "renesas,iic-emev2";
> +               reg = <0xe0070000 0x28>;
> +               interrupts = <0 32 IRQ_TYPE_EDGE_RISING>;

Are you sure about rising edge? All other emev2 interrupts are
IRQ_TYPE_LEVEL_HIGH.

> +               clocks = <&iic0_sclk>;
> +               clock-names = "sclk";
> +       };


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
