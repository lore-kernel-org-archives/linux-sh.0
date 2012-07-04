From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 04 Jul 2012 10:51:32 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <Pine.LNX.4.64.1207041240570.21042@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 4 Jul 2012, Rafael J. Wysocki wrote:

> On Wednesday, July 04, 2012, Guennadi Liakhovetski wrote:
> > Paul, Magnus, Rafael
> > 
> > What do you think about this? Shall we force the fixed regulator globally 
> > on for sh and sh-mobile, shall we only force it on for affected boards, or 
> > shall we leave it to the user to shoot themselves in the foot? In general 
> > we're not trying to force all Kconfig options on, that a board needs. 
> > There are enough ways to have a non-working configuration. E.g., you can 
> > leave off the sh I2C driver. Arguably, having to enable the fixed voltage 
> > regulator is less obvious, than needing a correct I2C bus driver.
> > 
> > I think I would go with
> > 
> > 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
> > 
> > - ideally on a per-board basis, or arch-wide. Mark doesn't favour at least 
> > the latter of these options, IIUC. So, maybe adding entries to defconfigs 
> > would indeed sufice for now (but no dummy regulator!)
> 
> Well, if arch-wide, then perhaps we don't need REGULATOR_FIXED_VOLTAGE at all
> and we can just make things depending on it depend on REGULATOR directly?

No, we cannot. That's exactly the problem: if REGULATOR is selected and 
REGULATOR_FIXED_VOLTAGE is not, then the regulator driver subsystem is 
enabled, instead of stubs real regulator functions will be used, and 
drivers, using regulators to control power supply to their devices, will 
fail obtaining such a regulator, if the respective driver (fixed in our 
cases) is not built or loaded. So, we need either - no regulator support 
in the kernel at all - then stubs are used and in case of our always-on 
fixed voltage power supplies everything just works, or the fixed regulator 
driver must be available to satisfy client drivers, e.g., smsc911x, 
sh_mmcif, sh_mobile_sdhi.

> The meaning of what you're proposing above is pretty much
> "REGULATOR_FIXED_VOLTAGE should be set whenever REGULATOR is"

Exactly.

> and I guess
> REGULATOR_FIXED_VOLTAGE depends on REGULATOR, so they appear to be equivalent.

No, they are not.

> How much code does really depend on REGULATOR_FIXED_VOLTAGE which is not build
> when REGULATOR is set?

Sorry, not sure what you mean "how much code." So far I've got 3 drivers 
on my radar - see above. As for platforms - about 10 platforms on each of 
sh and arm/mach-shmobile.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
