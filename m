From: Simon Horman <horms@verge.net.au>
Date: Mon, 26 Jan 2015 01:24:04 +0000
Subject: Re: [PATCH] ARM: shmobile: salvage lost CONFIG_REGULATOR
Message-Id: <20150126012401.GA8229@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvb2exr7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvb2exr7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert, Hi Morimoto-san,

I believe this problem is present in renesas-next-20150122-v3.19-rc1,
but not in renesas-devel-20150123-v3.19-rc5 due to the presence there of
the following in the latter:

From Magnus Damm <damm+renesas@opensource.se>

ARM: shmobile: sh73a0: Add Multiplatform support

Enable sh73a0 Multiplatform support for the generic sh73a0
machine vector. No board support is enabled, and the board
code for KZM9G DT Reference is left by itself.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 2f36c85..8ee2f28 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -78,6 +78,11 @@ config ARCH_R8A7794
 	bool "R-Car E2 (R8A77940)"
 	select ARCH_RCAR_GEN2
 
+config ARCH_SH73A0
+	bool "SH-Mobile AG5 (R8A73A00)"
+	select ARCH_RMOBILE
+	select RENESAS_INTC_IRQPIN
+
 comment "Renesas ARM SoCs Board Type"
 
 config MACH_MARZEN
[patch truncated]


It may have been better if the defconfig problem that Morimoto-san
mentions below had not gone into next for v3.20 while the change above
ended up being deferred for v3.21. But that is how things have
played out. And the result seems to be that Morimoto-san's patch
will resolve a regression that has been queued up for v3.20.

With the above in mind I plan to queue up the change below
as a fix for v3.20.


On Fri, Jan 23, 2015 at 10:34:41AM +0100, Geert Uytterhoeven wrote:
> Hi Morimoto-san,
> 
> On Fri, Jan 23, 2015 at 8:55 AM, Kuninori Morimoto
> <kuninori.morimoto.gx@renesas.com> wrote:
> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > eb4513482d1c4882e3633528ccc48d77581b7bb1
> > (ARM: shmobile: Enable kzm9g board in multiplatform defconfig)
> > dropped CONFIG_REGULATOR from shmobile_defconfig.
> > So, we lost CONFIG_REGULATOR_GPIO or others REGULATORs
> > Let's salvage these
> 
> On which version did you see this problem?
> I still have CONFIG_REGULATOR_GPIO=y in the generated .config.
> 
> My first guess was that there's a select in -next (and thus in renesas-drivers,
> where I generated the patch), that's not yet in renesas-devel (selects are evil,
> and cause havoc when combined with savedefconfig).
> 
> However, I can't reproduce it on
> renesas-devel-20150119-v3.19-rc5 (which still has kzm9g multiplatform),
> renesas-drivers-2015-01-19-v3.19-rc5 (which still has kzm9g multiplatform),
> renesas-devel-20150123-v3.19-rc5 (which lost kzm9g multiplatform)
> 
> Note that you remove:
>   - CONFIG_ARCH_SH73A0 and CONFIG_SIMPLE_PM_BUS
>     (which indicates your local repo no longer has kzm9g multiplatform)
>   - CONFIG_RCAR_DMAC (which is in -next and renesas-drivers,
>     but not in renesas-devel).
> 
> > This patch is using "make savedefconfig"
> 
> Hence that removes everything which is not (yet) in your tree, while I think
> we do want to enable features that will only appear in -next, as Simon has
> to send pull requests for the defconfigs before the features arrive in Linus'
> tree.
> 
> > Reported-by: Magnus Damm <damm+renesas@opensource.se>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > Geert, Magnus
> >
> > Can you check this patch ?
> >
> >  arch/arm/configs/shmobile_defconfig |    4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
> > index 6512c41..46c6623 100644
> > --- a/arch/arm/configs/shmobile_defconfig
> > +++ b/arch/arm/configs/shmobile_defconfig
> > @@ -18,7 +18,6 @@ CONFIG_ARCH_R8A7779=y
> >  CONFIG_ARCH_R8A7790=y
> >  CONFIG_ARCH_R8A7791=y
> >  CONFIG_ARCH_R8A7794=y
> > -CONFIG_ARCH_SH73A0=y
> >  CONFIG_MACH_MARZEN=y
> >  CONFIG_CPU_BPREDICT_DISABLE=y
> >  CONFIG_PL310_ERRATA_588369=y
> > @@ -55,7 +54,6 @@ CONFIG_IP_PNP_DHCP=y
> >  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
> >  CONFIG_DEVTMPFS=y
> >  CONFIG_DEVTMPFS_MOUNT=y
> > -CONFIG_SIMPLE_PM_BUS=y
> >  CONFIG_MTD=y
> >  CONFIG_MTD_BLOCK=y
> >  CONFIG_MTD_M25P80=y
> > @@ -118,6 +116,7 @@ CONFIG_WATCHDOG=y
> >  CONFIG_DA9063_WATCHDOG=y
> >  CONFIG_MFD_AS3711=y
> >  CONFIG_MFD_DA9063=y
> > +CONFIG_REGULATOR=y
> >  CONFIG_REGULATOR_AS3711=y
> >  CONFIG_REGULATOR_DA9210=y
> >  CONFIG_REGULATOR_GPIO=y
> > @@ -170,7 +169,6 @@ CONFIG_RTC_DRV_RS5C372=y
> >  CONFIG_RTC_DRV_S35390A=y
> >  CONFIG_DMADEVICES=y
> >  CONFIG_SH_DMAE=y
> > -CONFIG_RCAR_DMAC=y
> >  # CONFIG_IOMMU_SUPPORT is not set
> >  CONFIG_IIO=y
> >  CONFIG_AK8975=y
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
