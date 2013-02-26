From: Simon Horman <horms@verge.net.au>
Date: Tue, 26 Feb 2013 12:25:15 +0000
Subject: Re: [PATCH/RFC 0/4] CPUFreq for kzm9g
Message-Id: <20130226122515.GD17704@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1361553474-27022-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1361553474-27022-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 26, 2013 at 08:19:34AM +0100, Guennadi Liakhovetski wrote:
> (reduced cc-list)
> 
> On Mon, 25 Feb 2013, Simon Horman wrote:
> 
> > On Fri, Feb 22, 2013 at 06:17:50PM +0100, Guennadi Liakhovetski wrote:
> > > The first of these patches is a bug-fix, whereas the latter three patches
> > > are experimental and might want to be discussed. This patch set is based
> > > on an earlier Simon's topic/all+next branch snapshot.
> > 
> > Could you let me know the commit id of the working branch?
> 
> It's an older snapshot (of 11.02), so, it doesn't exist on git.kernel.org 
> anymore, its top commit ID is 89e9dbd.

Thanks. I have it locally and I'll see if I can use it to
shed some light on the problem.

> > > Attempts to use
> > > todays checkout failed - I couldn't even boot.
> > 
> > Thanks, I thought that I had tested that but clearly I was mistaken.
> > 
> > The problem appears to be caused by "ARM: shmobile: kzm9g: Populate
> > platform devices from device tree" which is present in topic/pinmux.
> > 
> > I will remove that branch from topic/all+next until the problem is resolved.
> > I have also removed the topic/eth_sh and topic/intc-of branches from
> > topic/all+next as they depend on topic/pinmux.
> > 
> > > Obviously, I'm also using 
> > > my AS3711 patches and a number of other (not directly related) patches, 
> > > that I'll be posting separately.
> > 
> > It is not obvious to me why you are using other patches.
> 
> As I said, they are not directly related to r-/sh-mobile. Some of them are 
> for cpufreq etc. Others are related, but might not be critical.
> 
> My current problem is, that the newest all+next snapshots (including the 
> one from a couple of minutes ago) don't work on kzm9g either in "legacy" 
> (.c-based) or in "reference" (dt-based) build. So, I am not sure against 
> which tree I should be building and submitting my work. I'll try to 
> identify the problem source and will let you know, unless you already know 
> it. Currently kernels built from all+next typically have problems around 
> bringing up the second CPU core, and even with just one core I've got a 
> pinctrl-related panic later during boot.

Understood, I'm working on stabilising the branches.
I realise that an unstable base is difficult to work with.

> 
> Thanks
> Guennadi
> 
> > > Guennadi Liakhovetski (4):
> > >   ARM: shmobile: sh73a0: fix Z and ZG clock hierarchy
> > >   ARM: shmobile: sh73a0: add support for adjusting CPU frequency
> > >   ARM: shmobile: sh73a0: run sh73a0_clock_init() only once
> > >   ARM: shmobile: kzm9g-reference: add CPUFreq support
> > > 
> > >  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |   19 ++-
> > >  arch/arm/mach-shmobile/Kconfig               |    2 +
> > >  arch/arm/mach-shmobile/clock-sh73a0.c        |  224 +++++++++++++++++++++++++-
> > >  3 files changed, 236 insertions(+), 9 deletions(-)
> > 
> 
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
