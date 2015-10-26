From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Oct 2015 08:03:44 +0000
Subject: Re: [PATCH v4 5/5] [RFC] clk: shmobile: r8a7795: Add new CPG/MSSR driver
Message-Id: <CAMuHMdU-TpPcdi_H6bwAxipv8rtC7Njos_49hsEmJCcSCHR_Pw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444999760-15750-1-git-send-email-geert+renesas@glider.be>
	<20151024011003.GE19782@codeaurora.org>
	<CAMuHMdUyu6w0LAoH78H2+VHczrWwozDKMX2j8_A4V=jgz0snwA@mail.gmail.com>
	<1577230.N3FJlP7ehB@avalon>
In-Reply-To: <1577230.N3FJlP7ehB@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Laurent,

On Mon, Oct 26, 2015 at 3:25 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Saturday 24 October 2015 19:34:03 Geert Uytterhoeven wrote:
>> On Sat, Oct 24, 2015 at 3:10 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>> > On 10/22, Geert Uytterhoeven wrote:
>> >> As I want to have as much clock data/code __init as possible (think
>> >> multi-platform kernels --- pinmux data is a disaster here), I have to use
>> >> platform_driver_probe().
>
> That sounds like an __init issue, doesn't it ? The CPG driver will always be
> builtin and probed during the init process, what's preventing us from using
> normal driver probing ?

When using platform_driver_register(), the tables cannot be __init, as that
would cause a section type mismatch. Remember, the driver core handles
platform devices appearing later, so .probe() should continue to be available.

Note: in theory it should be possible to compile the CPG/MSSR driver as a
module, and have the module in your initramfs. But I don't think anyone
really wants to do that?

>> For new SoCs like r8a7795 we can probably just make it a real platform
>> driver, and make sure the irqc node is located after the cpg node in the
>> .dtsi.
>
> That's another hack :-) We really shouldn't depend on DT nodes order.

I agree. But if there's an unfixed bug somewhere else, we cannot introduce
regressions (for already supported SoCs).

> I'm all for getting rid of CLK_OF_DECLARE

Me too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
