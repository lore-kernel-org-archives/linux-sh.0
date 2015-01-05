From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 05 Jan 2015 13:33:41 +0000
Subject: Re: [PATCH v2] clk-rcar-gen2: RCAN clock support
Message-Id: <CAMuHMdX7Efi1s1bt+X8rbqN4=J9JHWh1cHpvZmnC6NCkF4JVGA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <3007073.i0ghnTEhxV@wasted.cogentembedded.com>
In-Reply-To: <3007073.i0ghnTEhxV@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Mike Turquette <mturquette@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Linux-sh list <linux-sh@vger.kernel.org>, Pavel Kiryukhin <vksavl@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Wed, Dec 24, 2014 at 11:17 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the RCAN clock support to the R-Car generation 2 CPG driver.  This clock
> gets derived from  the USB_EXTAL clock, dividing  it by 6.  The layout of the
> RCANCKCR register is similar to those of the clocks supported by the 'clk-div6'
> driver but has no divider field, and so can't be supported by that driver...
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Sorry, forgot something...

> Index: linux/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
> =================================> --- linux.orig/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
> +++ linux/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
> @@ -16,7 +16,7 @@ Required Properties:
>    - clocks: Reference to the parent clock

If the "rcan" clock is to be used, there should be two parent clocks.

>    - #clock-cells: Must be 1
>    - clock-output-names: The names of the clocks. Supported clocks are "main",
> -    "pll0", "pll1", "pll3", "lb", "qspi", "sdh", "sd0", "sd1" and "z"
> +    "pll0", "pll1", "pll3", "lb", "qspi", "sdh", "sd0", "sd1", "z", and "rcan"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
