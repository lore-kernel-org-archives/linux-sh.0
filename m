From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 30 May 2012 15:05:01 +0000
Subject: Re: [PATCH][RFC] ARM: mach-shmobile: setup-sh7372: fixup chclr_offset base
Message-Id: <Pine.LNX.4.64.1205301642220.28640@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <87mx4q2qos.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx4q2qos.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 30 May 2012, Kuninori Morimoto wrote:

> Hi Guennadi
> 
> > > Thanks.
> > > But sorry. I didn't have any problem.
> > > I noticed it from source-code only, not board behavior.
> > 
> > Ok, but did you at least run some tests, where this code-path would be 
> > entered, including (runtime-) suspend and resume? If not yet, I think, it 
> > would be good to at least run a couple of short tests to make sure we're 
> > not causing any obvious regressions. I'll try to find some time later 
> > today or tomorrow for this.
> 
> Yes. of course I tested my patch on FSI DMAEngine.
> In my test, I didn't get any issue with/without this patch.
> 
> I double-checked this issue, but sh7372 has offset bug.
> This is the reason why I added [RFC] on this patch.

I tested a 9-day old next tree with and without your patch with 
runtime-suspend - both when the A3SP domain stays on and when it gets 
switched off - both versions seem to work, so, at least I don't recognise 
any regressions. Unfortunately, I couldn't test system-wide suspend 
because of some NFS problem. So, you can also add a (partially-)

Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
