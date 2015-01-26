From: Simon Horman <horms@verge.net.au>
Date: Mon, 26 Jan 2015 03:57:47 +0000
Subject: Re: [PATCH] ARM: shmobile: salvage lost CONFIG_REGULATOR
Message-Id: <20150126035742.GB1215@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvb2exr7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvb2exr7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jan 26, 2015 at 02:28:26AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > I believe this problem is present in renesas-next-20150122-v3.19-rc1,
> > but not in renesas-devel-20150123-v3.19-rc5 due to the presence there of
> > the following in the latter:
> (snip)
> > It may have been better if the defconfig problem that Morimoto-san
> > mentions below had not gone into next for v3.20 while the change above
> > ended up being deferred for v3.21. But that is how things have
> > played out. And the result seems to be that Morimoto-san's patch
> > will resolve a regression that has been queued up for v3.20.
> > 
> > With the above in mind I plan to queue up the change below
> > as a fix for v3.20.
> 
> Thank you for your help.
> My patch is including below, because "make savedefconfig" did it
> 
> -CONFIG_ARCH_SH73A0=y
> -CONFIG_SIMPLE_PM_BUS=y
> -CONFIG_RCAR_DMAC=y
> 
> But, if these are based on merged branch (= Geert mentioned to it),
> I think I should send v2 (which includes REGURALOR only),
> otherwise, it will create other issues.
> 
> My patch was based on renesas-devel-20150122-v3.19-rc5.
> but, can you show me best branch/tag for this issue ?

renesas-next-20150122-v3.19-rc1

The config items above would probably also be removed by savedefconfig
in renesas-next-20150122-v3.19-rc1 too. However, I think a minimal
approach is best for a fix: just removing REGURALOR as you suggest.

As you (now) know I have sent a patch to do that, which
I suppose crossed in-flight with your email.
