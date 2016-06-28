From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Jun 2016 07:55:57 +0000
Subject: Re: [PATCH v3 12/19] sh: irqchip: SH7751 IRQCHIP Driver
Message-Id: <CAMuHMdXSm14n+KFLfDtL7nOD8JbkC2GwHKr9HUJz09o6cH70+g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1467095795-5082-1-git-send-email-ysato@users.sourceforge.jp> <1467095795-5082-13-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467095795-5082-13-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Sato-san,

On Tue, Jun 28, 2016 at 8:36 AM, Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
> index 0000000..2bc6f22f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,sh7751-intc.txt
> @@ -0,0 +1,25 @@
> +DT bindings for the SH7751 interrupt controller
> +
> +Required properties:
> +
> +  - compatible: has to be "renesas,sh7751-intc".
> +
> +  - reg: Base address and length of interrupt controller register
> +         and extend register.
> +
> +  - interrupt-controller: Identifies the node as an interrupt controller.
> +
> +  - #interrupt-cells: has to be <2>: an interrupt index and flags, as defined
> +    in interrupts.txt in this directory.
> +
> +Example
> +-------
> +
> +       shintc: interrupt-controller@ffd00000 {
> +               compatible = "renesas,sh7751-intc";
> +               #interrupt-cells = <2>;
> +               #address-cells = <1>;
> +               #size-cells = <1>;

Why do you need #address-cells and #size-cells?

> +               interrupt-controller;
> +               reg = <0xffd00000 14>, <0xfe080000 128>;
> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
