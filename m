From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 03 Jul 2012 15:35:34 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <Pine.LNX.4.64.1207031720390.29890@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, 3 Jul 2012, Mark Brown wrote:

> On Tue, Jul 03, 2012 at 05:05:46PM +0200, Guennadi Liakhovetski wrote:
> > On Tue, 3 Jul 2012, Mark Brown wrote:
> > > On Tue, Jul 03, 2012 at 03:44:32PM +0200, Guennadi Liakhovetski wrote:
> > > > On Tue, 3 Jul 2012, Mark Brown wrote:
> 
> > > > > This doesn't seem right.  If this is useful we should just remove the
> > > > > configuration for the fixed voltage regulator entirely as there's
> > > > > nothing platform specific about this, and we probably ought to be going
> > > > > through all the boards using "real" regulators adding selects for their
> > > > > drivers too.
> 
> > > > Hm, why? Let's take smsc911x. The driver needs "some" regulators for its 
> > > > two power pins. On different systems different regulators are used for 
> > > > those supplies. It just happens to be the case, that many sh and 
> > > > arm/mach-shmobile platform use the fixed voltage regulator for smsc911x 
> 
> > > What I'm saying is that that statement is equally true if you replace
> > > "sh and arm/mach-shmobile platform" with "systems".
> 
> > So, you think, each board should select all required regulators 
> > individually?
> 
> That's not what I wrote above (at least not for the fixed voltage
> regulator).

No, sorry, that was my interpretation, because I didn't think that we 
wanted to treat the fixed regulator any differently than others.

> But in general I'm not sure we're requiring that .configs
> that people can generate do more than build.

Well, you could have a kernel configuration with REGULATOR=y for some 
reason with fixed regulator disabled. It would work with earlier kernels. 
Now it would begin to fail... Do we want to allow that?

Well, I suspect, other boards must have had the same exact problem, as 
they added regulator support. It seems some boards to that, but not all...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
