From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 May 2014 07:28:22 +0000
Subject: Re: [PATCH v4] phy: Renesas R-Car Gen2 PHY driver
Message-Id: <CAMuHMdUrYmoYzcD__HkHMN4UzTpBcGbjTwhuSdNHXa6QXq6dsg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201405240206.04700.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201405240206.04700.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, kishon@ti.com, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Sat, May 24, 2014 at 12:06 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> --- /dev/null
> +++ linux-phy/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
> @@ -0,0 +1,60 @@
> +* Renesas R-Car generation 2 USB PHY
> +
> +This file provides information on what the device node for the R-Car generation
> +2 USB PHY contains.
> +
> +Required properties:
> +- compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A7790 SoC.
> +             "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.

As this is a new driver, I think you should switch to the recommended
vendor/soc/device ordering, which is also supported by checkpatch (incl.
wildcard matching!), i.e. "renesas,r8a7790-usb-phy" etc.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
