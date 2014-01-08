From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 08 Jan 2014 02:39:54 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: add audio clocks
Message-Id: <878uurxklk.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <8738l1jzfv.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi again

> > I believe this should be fixed in the audio driver. Instead of doing
> > 
> >         adg->clk[CLKA] = clk_get(NULL, "audio_clk_a");
> >         adg->clk[CLKB] = clk_get(NULL, "audio_clk_b");
> >         adg->clk[CLKC] = clk_get(NULL, "audio_clk_c");
> >         adg->clk[CLKI] = clk_get(NULL, "audio_clk_internal");
> > 
> > it should do something like
> > 
> >         adg->clk[CLKA] = clk_get(&pdev->dev, "clk_a");
> >         adg->clk[CLKB] = clk_get(&pdev->dev, "clk_b");
> >         adg->clk[CLKC] = clk_get(&pdev->dev, "clk_c");
> >         adg->clk[CLKI] = clk_get(&pdev->dev, "internal");
> 
> Current style was assumed non DT case,
> but I noticed that your style has reasonable.
> 
> I can fixup driver side, but it is impossible now.
> Because there is branch dependency/merge issue between Simon <-> ASoC branch.
> Sound driver DT support is stalling by same reason.
> I'm waiting branch merging (= next merge window ?).
> 
> If you can accept, how about this ?
>  - add non-DT "audio_clk_xx" support without common clock settings today
>  - merge window
>  - fixup driver/platform/clock as above style
>  - add common clock setting for DT
>  - add sound DT support

I can send sound driver support patch
if "audio_clk_xx" patch was accepted.
But it is for non-DT version


Best regards
---
Kuninori Morimoto
