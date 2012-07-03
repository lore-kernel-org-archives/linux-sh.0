From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 03 Jul 2012 12:44:33 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <Pine.LNX.4.64.1207031428500.29890@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, 3 Jul 2012, Tetsuyuki Kobayashi wrote:

> Hello, Guennadi
> 
> (2012/07/03 19:12), Guennadi Liakhovetski wrote:
> > Hello
> > 
> > On Tue, 3 Jul 2012, Tetsuyuki Kobayashi wrote:
> > 
> > > Add REGULATOR settings to kernel config file of kzm9g.
> > > 
> > > Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> > > ---
> > > Hello,
> > > 
> > > I found Guennadi's
> > > "ARM: mach-shmobile: add fixed voltage regulators to kzm9g"
> > > requires REGULATOR setting in kernel config.
> > > Without this, it causes these errors at boot time.
> > 
> > Thanks for the patch. However, I think, this error will only appear if you
> > enable REGULATOR in the kernel, but both REGULATOR_FIXED_VOLTAGE and
> > REGULATOR_DUMMY are disabled. To fix this fixing the defconfig is good,
> 
> Oh yes, you are right. I made bad combination as you said.
> if CONFIG_REGULATOR is not set, it goes well as before.
> 
> > but not sufficient, I think. How about adding something like
> > 
> > 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
> > 
> > to either the CPU or the arch section in respective Kconfig? I would
> > actually propose to add these to both arm/mach-shmobile and sh. Any
> > objections?
> > 
> 
> Thank you.
> I withdraw my config patch and wait for your proposal to Kconfig.

Well, I'm not sure what approach would be the preferred by the 
maintainers, how about the diff below. If it is acceptable, I'll split it 
into 2 patches and submit properly.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 84449dd..295ce8e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -720,6 +720,7 @@ config ARCH_SHMOBILE
 	select MULTI_IRQ_HANDLER
 	select PM_GENERIC_DOMAINS if PM
 	select NEED_MACH_MEMORY_H
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  Support for Renesas's SH-Mobile and R-Mobile ARM platforms.
 
diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 31d9db7..dd8f7a7 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -34,6 +34,7 @@ config SUPERH
 	select GENERIC_CMOS_UPDATE if SH_SH03 || SH_DREAMCAST
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 	help
 	  The SuperH is a RISC processor targeted for use in embedded systems
 	  and consumer electronics; it was also used in the Sega Dreamcast
