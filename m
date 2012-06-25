From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 25 Jun 2012 21:24:28 +0000
Subject: Re: [PATCH 01/11] ARM: mach-shmobile: add a temporary macro to define fixed voltage regulators
Message-Id: <Pine.LNX.4.64.1206252322350.31660@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1340179300-16452-2-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1340179300-16452-2-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rafael

On Mon, 25 Jun 2012, Rafael J. Wysocki wrote:

> On Thursday, June 21, 2012, Rafael J. Wysocki wrote:
> > On Wednesday, June 20, 2012, Mark Brown wrote:
> > > On Wed, Jun 20, 2012 at 10:01:30AM +0200, Guennadi Liakhovetski wrote:
> > > > Providing fixed voltage permanently "on" regulators with different voltages
> > > > shares a lot of identical code. It will be eliminated, once the
> > > > regulator_register_fixed_volt() function becomes available. Until then we
> > > > introduce a macro to define such regulators. This helps reduce the amount
> > > > of added code in each platform file and keeps copy-paste errors to the
> > > > minumum.
> > > 
> > > Or you could just pull in the topic branch I created for the purpose of
> > > allowing other trees to pick this up:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/topic/fixed
> > > 
> > > which should save everyone work all round.  Just don't rebase.
> > 
> > Arnd, Olof,
> > 
> > Would it be fine with you if we merged the topic branch above into
> > our soc branch?
> 
> Guennadi,
> 
> Since Olof says it's not a problem to pull the Mark's topic branch into
> our soc tree, can you please rework the patchset on top of that branch?

Sure, will do.

> Or do you need me to combine it with the commits already in the next
> branch of the renesas.git tree for this purpose?

No, don't think it should be necessary - patches in that branch only touch 
regulator internals, so, I don't think any merging with the sh-mobile 
branches would be required.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
