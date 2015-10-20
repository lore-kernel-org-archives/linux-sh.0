From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 Oct 2015 12:16:34 +0000
Subject: Re: [PATCH v4 1/5] [RFC] clk: shmobile: Add new Renesas CPG/MSSR DT bindings
Message-Id: <CAMuHMdVhBipbf13o0jb3H6qmcewh6CCtq3=Hj-9nvgar+AYdFg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444999760-15750-1-git-send-email-geert+renesas@glider.be>
	<1444999760-15750-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444999760-15750-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Fri, Oct 16, 2015 at 2:49 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
> @@ -0,0 +1,71 @@
> +* Renesas Clock Pulse Generator / Module Standby and Software Reset
> +
> +On Renesas ARM SoCs (SH/R-Mobile, R-Car, RZ), the CPG (Clock Pulse Generator)
> +and MSSR (Module Standby and Software Reset) blocks are intimately connected,
> +and share the same register block.
> +
> +They provide the following functionalities:
> +  - The CPG block generates various core clocks,
> +  - The MSSR block provides two functions:
> +      1. Module Standby, providing a Clock Domain to control the clock supply
> +        to individual SoC devices,
> +      2. Reset Control, to perform a software reset of individual SoC devices.
> +
> +Required Properties:
> +  - compatible: Must be one of:
> +      - "renesas,r8a7791-cpg-mssr" for the r8a7791 SoC

I'll drop the reference to "r8a7791", as we won't convert r8a7791 (yet).

> +      - "renesas,r8a7795-cpg-mssr" for the r8a7795 SoC
> +
> +  - reg: Base address and length of the memory resource used by the CPG/MSSR
> +    block
> +
> +  - clocks: References to external parent clocks, one entry for each entry in
> +    clock-names
> +  - clock-names: List of external parent clock names. Valid names are:
> +      - "extal" (r8a7791, r8a7795)
> +      - "extalr" (r8a7795)
> +      - "usb_extal" (r8a7791)

Likewise.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
