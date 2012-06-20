From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 20 Jun 2012 10:35:57 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: Fix build when SMP is enabled and EMEV2 is not enabled
Message-Id: <201206201235.57898.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <1339033256-12415-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1339033256-12415-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Wednesday, June 20, 2012, Simon Horman wrote:
> On Thu, Jun 07, 2012 at 12:25:48PM +0900, Nobuhiro Iwamatsu wrote:
> > Hi,
> > 
> > Simon Horman さんは書きました:
> > >Hi Iwamatsu-san,
> > >
> > >On Thu, Jun 07, 2012 at 10:40:55AM +0900, Nobuhiro Iwamatsu wrote:
> > >>Build failed, when SMP is enabled and EMEV2 is not enabled.
> > >>
> > >>-----
> > >>arch/arm/mach-shmobile/built-in.o: In function `shmobile_platform_cpu_kill':
> > >>/home/iwamatsu/work/kernel/sh-2.6-devel/arch/arm/mach-shmobile/platsmp.c:62: undefined reference to `emev2_platform_cpu_kill'
> > >>arch/arm/mach-shmobile/built-in.o: In function `shmobile_smp_get_core_count':
> > >>/home/iwamatsu/work/kernel/sh-2.6-devel/arch/arm/mach-shmobile/platsmp.c:39: undefined reference to `emev2_get_core_count'
> > >>arch/arm/mach-shmobile/built-in.o: In function `shmobile_smp_prepare_cpus':
> > >>/home/iwamatsu/work/kernel/sh-2.6-devel/arch/arm/mach-shmobile/platsmp.c:53: undefined reference to `emev2_smp_prepare_cpus'
> > >>arch/arm/mach-shmobile/built-in.o: In function `platform_secondary_init':
> > >>/home/iwamatsu/work/kernel/sh-2.6-devel/arch/arm/mach-shmobile/platsmp.c:78: undefined reference to `emev2_secondary_init'
> > >>arch/arm/mach-shmobile/built-in.o: In function `boot_secondary':
> > >>/home/iwamatsu/work/kernel/sh-2.6-devel/arch/arm/mach-shmobile/platsmp.c:90: undefined reference to `emev2_boot_secondary
> > >>-----
> > >>
> > >>This is the cause by when EMEV2 is disabled, that the check by OF of EMEV2 is
> > >>performed in platsmp.c.
> > >>This patch revise what the function about EMEV2 may not be used in this file,
> > >>when EMEV2 is not enabled.
> > >
> > >I am curious to know why, for example, sh73a0_smp_prepare_cpus() and
> > >r8a7779_smp_prepare_cpus() do not have similar problems. Is it because
> > >they are guarded by machine_if_* rather than of_machine_is_compatible() ?
> > 
> > Yes. for example, If machine_is_marzen() was set to (0), if line of is_r8a7779()
> > was deleted by cpp.
> > 
> > >
> > >>Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> > >>---
> > >> arch/arm/mach-shmobile/platsmp.c |    5 +++++
> > >> 1 file changed, 5 insertions(+)
> > >>
> > >>diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
> > >>index bacdd66..e859fcd 100644
> > >>--- a/arch/arm/mach-shmobile/platsmp.c
> > >>+++ b/arch/arm/mach-shmobile/platsmp.c
> > >>@@ -25,7 +25,12 @@
> > >> #define is_sh73a0() (machine_is_ag5evm() || machine_is_kota2() || \
> > >> 			of_machine_is_compatible("renesas,sh73a0"))
> > >> #define is_r8a7779() machine_is_marzen()
> > >
> > >Which tree does this version of platsmp.c appear in?
> > >The use of of_machine_is_compatible() is new to me.
> > 
> > I confirmed by linus/HEAD and next branch/HEAD of rafael's.
> > >
> > >>+
> > >>+#ifdef CONFIG_ARCH_EMEV2
> > >> #define is_emev2() of_machine_is_compatible("renesas,emev2")
> > >>+#else
> > >>+#define is_emev2() (0)
> > >>+#endif
> > >
> > >It would be nice to avoid a journey to ifdef hell :)
> > >
> > 
> > I think too.
> > But currentry, mechanism in which we judge CPU seems not to spread on CONFIG.
> 
> Ok, reluctantly I think we should add your patch as we are already
> at 3.5-rc3 and it would be nice for the board's default config to actually
> built in 3.5.
> 
> Acked-by: Simon Horman <horms@verge.net.au>

Applied to the fixes branch of the renesas.git tree.

Thanks,
Rafael
