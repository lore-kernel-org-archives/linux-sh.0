From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 08 Jan 2014 00:40:01 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: add audio clocks
Message-Id: <3406611.oXWTaphSN4@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tuesday 07 January 2014 16:22:27 Kuninori Morimoto wrote:
> Hi Laurent
> 
> Thank you for your review

You're welcome.

> > > +		audio_clk_a: audio_clk_a {
> > > +			compatible = "fixed-clock";
> > > +			#clock-cells = <0>;
> > > +			/* This value can be overriden by the board if exist */
> > > +			clock-frequency = <0>;
> > > +			clock-output-names = "audio_clk_a";
> > > +		};
> > > +		audio_clk_b: audio_clk_b {
> > > +			compatible = "fixed-clock";
> > > +			#clock-cells = <0>;
> > > +			/* This value can be overriden by the board if exist */
> > > +			clock-frequency = <0>;
> > > +			clock-output-names = "audio_clk_b";
> > > +		};
> > > +		audio_clk_c: audio_clk_c {
> > > +			compatible = "fixed-clock";
> > > +			#clock-cells = <0>;
> > > +			/* This value can be overriden by the board if exist */
> > > +			clock-frequency = <0>;
> > > +			clock-output-names = "audio_clk_c";
> > > +		};
> > 
> > There three clocks could be provided by an external clock generator, so
> > "fixed-clock" might not be the right compatible string and might need to
> > be overriden by the board as well. I would thus replace the three comments
> > by a single one on top of the audio_clk_* nodes that goes like
> > 
> > "The external audio clocks are configured as 0 Hz fixed frequency clocks
> > by default. Boards that provide audio clocks should override them."
> 
> I see. will fix in v2
> 
> > > +		audio_clk_internal: audio_clk_internal {
> > > +			compatible = "fixed-factor-clock";
> > > +			clocks = <&m2_clk>;
> > > +			#clock-cells = <0>;
> > > +			clock-div = <1>;
> > > +			clock-mult = <1>;
> > > +			clock-output-names = "audio_clk_internal";
> > > +		};
> > 
> > Do you really need an internal clock, can't you reference m2_clk directly
> > instead ?
> 
> Unfortunately, it is impossible.
> "audio_clk_internal = m2_clk" is only R-car H2 or Gen2.
> It is "clks1" in Gen1 case.
> So, sound driver is assuming that
> it can get internal clock as "audio_clk_internal"

I believe this should be fixed in the audio driver. Instead of doing

        adg->clk[CLKA] = clk_get(NULL, "audio_clk_a");
        adg->clk[CLKB] = clk_get(NULL, "audio_clk_b");
        adg->clk[CLKC] = clk_get(NULL, "audio_clk_c");
        adg->clk[CLKI] = clk_get(NULL, "audio_clk_internal");

it should do something like

        adg->clk[CLKA] = clk_get(&pdev->dev, "clk_a");
        adg->clk[CLKB] = clk_get(&pdev->dev, "clk_b");
        adg->clk[CLKC] = clk_get(&pdev->dev, "clk_c");
        adg->clk[CLKI] = clk_get(&pdev->dev, "internal");

The audio device DT node should then reference the clocks

        clocks = <&audio_clk_a &audio_clk_b &audio_clk_c &m2_clk>;
        clock-names = "clk_a", "clk_b", "clk_c", "internal";

On Gen1 that would become

        clocks = <&audio_clk_a &audio_clk_b &audio_clk_c &clks1>;
        clock-names = "clk_a", "clk_b", "clk_c", "internal";

Of course this will require DT bindings for the audio driver. Until you get 
that you can create clock aliases as done for the CMT and SCI devices on Lager 
and Koelsch. See the lager_add_standard_devices() function in arch/arm/mach-
shmobile/board-lager-reference.c for instance.

-- 
Regards,

Laurent Pinchart

