From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 08 Jan 2014 08:04:26 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: add audio clocks
Message-Id: <2951294.N77dkua35k@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tuesday 07 January 2014 18:39:54 Kuninori Morimoto wrote:
> Hi again
> 
> > > I believe this should be fixed in the audio driver. Instead of doing
> > > 
> > >         adg->clk[CLKA] = clk_get(NULL, "audio_clk_a");
> > >         adg->clk[CLKB] = clk_get(NULL, "audio_clk_b");
> > >         adg->clk[CLKC] = clk_get(NULL, "audio_clk_c");
> > >         adg->clk[CLKI] = clk_get(NULL, "audio_clk_internal");
> > > 
> > > it should do something like
> > > 
> > >         adg->clk[CLKA] = clk_get(&pdev->dev, "clk_a");
> > >         adg->clk[CLKB] = clk_get(&pdev->dev, "clk_b");
> > >         adg->clk[CLKC] = clk_get(&pdev->dev, "clk_c");
> > >         adg->clk[CLKI] = clk_get(&pdev->dev, "internal");
> > 
> > Current style was assumed non DT case,
> > but I noticed that your style has reasonable.
> > 
> > I can fixup driver side, but it is impossible now.
> > Because there is branch dependency/merge issue between Simon <-> ASoC
> > branch. Sound driver DT support is stalling by same reason.
> > I'm waiting branch merging (= next merge window ?).
> > 
> > If you can accept, how about this ?
> > 
> >  - add non-DT "audio_clk_xx" support without common clock settings today
> >  - merge window
> >  - fixup driver/platform/clock as above style
> >  - add common clock setting for DT
> >  - add sound DT support
> 
> I can send sound driver support patch
> if "audio_clk_xx" patch was accepted.
> But it is for non-DT version

I think you can start by fixing the driver for the non-DT case, DT support can 
come at a later time.

You can first add the following clk_lookup entries to arch/arm/mach-
shmobile/clock-r8a7790.c

        CLKDEV_ICK_ID("rcar_sound", "clk_a",    &audio_clk_a),
        CLKDEV_ICK_ID("rcar_sound", "clk_b",    &audio_clk_b),
        CLKDEV_ICK_ID("rcar_sound", "clk_c",    &audio_clk_c),

and then fix the adg driver with

        adg->clk[CLKA] = clk_get(&pdev->dev, "clk_a");
        adg->clk[CLKB] = clk_get(&pdev->dev, "clk_b");
        adg->clk[CLKC] = clk_get(&pdev->dev, "clk_c");
        adg->clk[CLKI] = clk_get(&pdev->dev, "internal");

-- 
Regards,

Laurent Pinchart

