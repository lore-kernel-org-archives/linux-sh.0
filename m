From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 Apr 2014 22:32:36 +0000
Subject: Re: [PATCH 4/6] i2c: sh_mobile: add devicetree documentation
Message-Id: <CAMuHMdWP8KH=6OKmBbA5UqixV7mdKZdEhFw8Tq_XZLaJCOQ07w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398896470-24663-1-git-send-email-wsa@the-dreams.de>
	<1398896470-24663-5-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1398896470-24663-5-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Wolfram,

CC devicetree

On Thu, May 1, 2014 at 12:21 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  .../devicetree/bindings/i2c/i2c-sh_mobile.txt      | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
>
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
> new file mode 100644
> index 000000000000..d2153ce36fa8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
> @@ -0,0 +1,26 @@
> +Device tree configuration for Renesas IIC (sh_mobile) driver
> +
> +Required properties:
> +- compatible      : "renesas,iic-<soctype>". "renesas,rmobile-iic" as fallback

Please also list all supported values, so checkpatch can validate DTS compatible
properties against this binding document.

> +- reg             : address start and address range size of device
> +- interrupts      : interrupt of device
> +- clocks          : clock for device
> +- #address-cells  : should be <1>
> +- #size-cells     : should be <0>
> +
> +Optional properties:
> +- clock-frequency : frequency of bus clock in Hz. Default 100kHz if unset.
> +
> +Pinctrl properties might be needed, too. See there.
> +
> +Example:
> +
> +       iic0: i2c@e6500000 {
> +               compatible = "renesas,iic-r8a7790", "renesas,rmobile-iic";
> +               reg = <0 0xe6500000 0 0x425>;
> +               interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&mstp3_clks R8A7790_CLK_IIC0>;
> +               clock-frequency = <400000>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
