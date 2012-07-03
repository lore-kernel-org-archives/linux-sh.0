From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 03 Jul 2012 15:05:46 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <Pine.LNX.4.64.1207031704300.29890@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, 3 Jul 2012, Mark Brown wrote:

> On Tue, Jul 03, 2012 at 03:44:32PM +0200, Guennadi Liakhovetski wrote:
> > On Tue, 3 Jul 2012, Mark Brown wrote:
> 
> > > This doesn't seem right.  If this is useful we should just remove the
> > > configuration for the fixed voltage regulator entirely as there's
> > > nothing platform specific about this, and we probably ought to be going
> > > through all the boards using "real" regulators adding selects for their
> > > drivers too.
> 
> > Hm, why? Let's take smsc911x. The driver needs "some" regulators for its 
> > two power pins. On different systems different regulators are used for 
> > those supplies. It just happens to be the case, that many sh and 
> > arm/mach-shmobile platform use the fixed voltage regulator for smsc911x 
> 
> What I'm saying is that that statement is equally true if you replace
> "sh and arm/mach-shmobile platform" with "systems".

So, you think, each board should select all required regulators 
individually?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
