From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 09 Jan 2014 18:32:28 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: add audio clocks
Message-Id: <1832516.GRrDULmxlx@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Wednesday 08 January 2014 01:11:37 Kuninori Morimoto wrote:
> Hi Laurent
> 
> > > >  - add non-DT "audio_clk_xx" support without common clock settings
> > > >  today
> > > >  - merge window
> > > >  - fixup driver/platform/clock as above style
> > > >  - add common clock setting for DT
> > > >  - add sound DT support
> > > 
> > > I can send sound driver support patch
> > > if "audio_clk_xx" patch was accepted.
> > > But it is for non-DT version
> > 
> > I think you can start by fixing the driver for the non-DT case, DT support
> > can come at a later time.
> > 
> > You can first add the following clk_lookup entries to arch/arm/mach-
> > shmobile/clock-r8a7790.c
> > 
> >         CLKDEV_ICK_ID("rcar_sound", "clk_a",    &audio_clk_a),
> >         CLKDEV_ICK_ID("rcar_sound", "clk_b",    &audio_clk_b),
> >         CLKDEV_ICK_ID("rcar_sound", "clk_c",    &audio_clk_c),
> > 
> > and then fix the adg driver with
> > 
> >         adg->clk[CLKA] = clk_get(&pdev->dev, "clk_a");
> >         adg->clk[CLKB] = clk_get(&pdev->dev, "clk_b");
> >         adg->clk[CLKC] = clk_get(&pdev->dev, "clk_c");
> >         adg->clk[CLKI] = clk_get(&pdev->dev, "internal");
> 
> Hmm...
> sorry, but I can't agree.
> ASoC branch is based on ALSA branch,
> and it doesn't include Simon's branch yet.
> OTOH, BockW already has sound support on Simon branch,
> and it has audio_clk_b settings.
> 
> If I used your idea...
> 
>  1) add "rcar_sound" base "clk_x" on Simon branch
>     but, sound driver can't care about it in this timing.
>     => Sound doesn't work on Lager, I can't send sound support patch.
>     => Sound will be supported next-next merge timing
> 
>  2) fixup adg driver needs Simon branch merge.
>     because it should care BockW in same timing.
>     => This fixup will happen after next merge timing
> 
> If you can accept "current style" audio_clk_x...
> 
>  1) I can send sound support patch immediately for Lager
>  2) adg driver fixup happen after next merge,
>     then, BockW/Lager are cared in same patch.
> 
> There is confusable branch merge timing issue here...
> Your idea is nice, but it needs very long time.
> This means Lager sound support will be late.

Right, timing might be affected.

You will have to coordinate the ASoC and shmobile patches. As BockW needs to 
be fixed as well, we have two options. The first one is

1. Add the new style clocks to BockW
2. Modify the ADG driver to use the new style clocks
3. Remove the old style clocks from BockW

while the second one is

1. Add support for the new style clocks to the ADG driver
2. Replace the old style clocks with the new style clocks in BockW
3. Remove support for the old style clocks from the ADG driver

I believe the first option will be easier. Steps 1 and 3 will go through 
Simon's tree, while step 2 will go through the ASoC tree. Given that the arm-
soc tree has been closed for v3.14 we're thus looking at v3.15 for 1 and 2, 
and either v3.15 or v3.16 for 3.

Adding Lager, we could thus do

1. Add the new style clocks to BockW
2. Add the new style clocks to Lager
3. Modify the ADG driver to use the new style clocks
4. Remove the old style clocks from BockW

The first 3 steps would be applied to v3.15 and the last one to either v3.15 
or v3.16.

Starting with the current-style audio clocks for Lager is possible, but I 
don't think it could be applied before v3.15 anyway, unless considered as a 
bug fix. Simon, what's your opinion on that ?

-- 
Regards,

Laurent Pinchart

