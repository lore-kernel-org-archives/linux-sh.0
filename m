From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 04 Jul 2012 06:39:09 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <Pine.LNX.4.64.1207040829230.21042@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul, Magnus, Rafael

What do you think about this? Shall we force the fixed regulator globally 
on for sh and sh-mobile, shall we only force it on for affected boards, or 
shall we leave it to the user to shoot themselves in the foot? In general 
we're not trying to force all Kconfig options on, that a board needs. 
There are enough ways to have a non-working configuration. E.g., you can 
leave off the sh I2C driver. Arguably, having to enable the fixed voltage 
regulator is less obvious, than needing a correct I2C bus driver.

I think I would go with

	select REGULATOR_FIXED_VOLTAGE if REGULATOR

- ideally on a per-board basis, or arch-wide. Mark doesn't favour at least 
the latter of these options, IIUC. So, maybe adding entries to defconfigs 
would indeed sufice for now (but no dummy regulator!)

Thanks
Guennadi

On Tue, 3 Jul 2012, Mark Brown wrote:

> On Tue, Jul 03, 2012 at 05:35:34PM +0200, Guennadi Liakhovetski wrote:
> > On Tue, 3 Jul 2012, Mark Brown wrote:
> 
> > > But in general I'm not sure we're requiring that .configs
> > > that people can generate do more than build.
> 
> > Well, you could have a kernel configuration with REGULATOR=y for some 
> > reason with fixed regulator disabled. It would work with earlier kernels. 
> > Now it would begin to fail... Do we want to allow that?
> 
> Well, it does happen from time to time; for example when moving from
> forcing some GPIOs on to making them software managed.  It's only going
> to affect boards which were previously using regulators but not the
> fixed one, I'm not sure if that is common for these systems...
> 
> > Well, I suspect, other boards must have had the same exact problem, as 
> > they added regulator support. It seems some boards to that, but not all...
> 
> Handling this really needs some kind of "set on upgrade" thing but I'm
> not sure that's worth the trouble, especially since it's not that common.
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
