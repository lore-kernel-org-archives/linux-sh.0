From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Oct 2015 14:03:51 +0000
Subject: Re: [PATCH v4 5/5] [RFC] clk: shmobile: r8a7795: Add new CPG/MSSR driver
Message-Id: <CAMuHMdX1AeBJdF1RBeByHKPVonXmdZiE-ZumphR2RLmJ+4wUzg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444999760-15750-1-git-send-email-geert+renesas@glider.be>
	<1444999760-15750-6-git-send-email-geert+renesas@glider.be>
	<20151020122448.20687.11926@quantum>
	<CAMuHMdUT=fZKCOCdkn+=grZ0wYATghQhmbX-Y6WJ9+ViZ0cidA@mail.gmail.com>
	<20151020130004.20687.91058@quantum>
	<CAMuHMdU8TqCpOskWXGPvwrejfEWSw8Fu4FjkWAKyTc0f_MuWzw@mail.gmail.com>
	<CAMuHMdW4wo0VR2GKeeXhcqwzDF7udkXapFF9fGfEQuh_vSsyoQ@mail.gmail.com>
In-Reply-To: <CAMuHMdW4wo0VR2GKeeXhcqwzDF7udkXapFF9fGfEQuh_vSsyoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Stephen Boyd <sboyd@codeaurora.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Thu, Oct 22, 2015 at 2:58 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>   - Calling platform_driver_probe() from arch_initcall() is too late, as the
>     IRQC is initialized first (it's located before the CPG in .dtsi).
>     Hence the IRQC can't find it's Clock Domain, and its probe is deferred.
>     IRQC will be reprobed later, but in the mean time the Ethernet PHY can't
>     find its IRQ, as the of_mdio code uses irq_of_parse_and_map(), which
>     plainly ignores EPROBE_DEFER :-(
>     Nevertheless, Ethernet works...

To correct myself: renesas-irqc is initialized first because it uses
postcore_initcall().

The of_mdio issue on R-Car Gen2 boards can be worked around by changing that
to device_initcall(). That would cause a few more probe deferrals on R-Mobile
APE6 (r8a73a4), where IRQC is not only the external interrupt controller,
but also the parent interrupt controller of the PFC/GPIO combo.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
