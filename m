From: Stephen Boyd <sboyd@codeaurora.org>
Date: Sat, 24 Oct 2015 01:10:03 +0000
Subject: Re: [PATCH v4 5/5] [RFC] clk: shmobile: r8a7795: Add new CPG/MSSR driver
Message-Id: <20151024011003.GE19782@codeaurora.org>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-clk <linux-clk@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On 10/22, Geert Uytterhoeven wrote:
> Hi Mike,
> 
> On Tue, Oct 20, 2015 at 3:07 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Tue, Oct 20, 2015 at 3:00 PM, Michael Turquette
> > <mturquette@baylibre.com> wrote:
> >> Quoting Geert Uytterhoeven (2015-10-20 05:31:12)
> >>> On Tue, Oct 20, 2015 at 2:24 PM, Michael Turquette
> >>> <mturquette@baylibre.com> wrote:
> >
> >> The bindings should go in for 4.4, but if the driver is slated for 4.5
> >> then can you investigate this some more? Stephen and I are on a mission
> >> to have _real_ clk drivers.
> >
> > Sure, I'll have a deeper look.
> 
> And so I did (on r8a7791/koelsch).
> 
> As I want to have as much clock data/code __init as possible (think
> multi-platform kernels --- pinmux data is a disaster here), I have to use
> platform_driver_probe().
> 
>   - Calling platform_driver_probe() from core_initcall() or postcore_initcall()
>     is too early, as the platform device for the CPG hasn't been created yet.
>     Hence the CPG Clock Domain isn't registered, and all devices fail to probe
>     as they can't be attached to their Clock Domain.
>       -> This is where the -ENOENT came from (I incorrectly assumed it came
>          from the clock code; sorry for that), and it's converted into
>          -EPROBE_DEFER by genpd_dev_pm_attach().
> 
>   - Calling platform_driver_probe() from arch_initcall() is too late, as the
>     IRQC is initialized first (it's located before the CPG in .dtsi).
>     Hence the IRQC can't find it's Clock Domain, and its probe is deferred.
>     IRQC will be reprobed later, but in the mean time the Ethernet PHY can't
>     find its IRQ, as the of_mdio code uses irq_of_parse_and_map(), which
>     plainly ignores EPROBE_DEFER :-(
>     Nevertheless, Ethernet works...
> 
>   - Using subsys_initcall() and later causes even more probe deferral.
> 
> So that's why I went with CLK_OF_DECLARE() again...
> 

Understandable for the few clocks that are used by the interrupt
controller, but for the other clocks, could those be registered
from a real platform device driver probe path? I've been
considering making some API that lets devices associate with the
clocks that the file had to register with CLK_OF_DECLARE(). The
driver would have to be builtin then (no modules) but otherwise
we would be able to benefit from the device driver model for most
other clocks.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
