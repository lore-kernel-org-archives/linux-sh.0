From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 30 Oct 2015 13:12:48 +0000
Subject: Re: [PATCH v4 5/5] [RFC] clk: shmobile: r8a7795: Add new CPG/MSSR driver
Message-Id: <27289910.m8I1Q3jp21@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1444999760-15750-1-git-send-email-geert+renesas@glider.be> <1577230.N3FJlP7ehB@avalon> <CAMuHMdU-TpPcdi_H6bwAxipv8rtC7Njos_49hsEmJCcSCHR_Pw@mail.gmail.com>
In-Reply-To: <CAMuHMdU-TpPcdi_H6bwAxipv8rtC7Njos_49hsEmJCcSCHR_Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Geert,

On Monday 26 October 2015 09:03:44 Geert Uytterhoeven wrote:
> On Mon, Oct 26, 2015 at 3:25 AM, Laurent Pinchart wrote:
> > On Saturday 24 October 2015 19:34:03 Geert Uytterhoeven wrote:
> >> On Sat, Oct 24, 2015 at 3:10 AM, Stephen Boyd wrote:
> >> > On 10/22, Geert Uytterhoeven wrote:
> >> >> As I want to have as much clock data/code __init as possible (think
> >> >> multi-platform kernels --- pinmux data is a disaster here), I have to
> >> >> use platform_driver_probe().
> > 
> > That sounds like an __init issue, doesn't it ? The CPG driver will always
> > be builtin and probed during the init process, what's preventing us from
> > using normal driver probing ?
> 
> When using platform_driver_register(), the tables cannot be __init, as that
> would cause a section type mismatch. Remember, the driver core handles
> platform devices appearing later, so .probe() should continue to be
> available.

Of course, my bad.

> Note: in theory it should be possible to compile the CPG/MSSR driver as a
> module, and have the module in your initramfs. But I don't think anyone
> really wants to do that?

I don't think we should allow that, no.

> >> For new SoCs like r8a7795 we can probably just make it a real platform
> >> driver, and make sure the irqc node is located after the cpg node in the
> >> .dtsi.
> > 
> > That's another hack :-) We really shouldn't depend on DT nodes order.
> 
> I agree. But if there's an unfixed bug somewhere else, we cannot introduce
> regressions (for already supported SoCs).

Sure, and I'm fine relying on DT nodes order as a short term hack, but we need 
to design a proper solution for the longer term.

> > I'm all for getting rid of CLK_OF_DECLARE
> 
> Me too.

-- 
Regards,

Laurent Pinchart
