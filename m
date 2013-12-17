From: Simon Horman <horms@verge.net.au>
Date: Tue, 17 Dec 2013 00:56:30 +0000
Subject: Re: [PATCH 0/4] Fix backlight on Armadillo 800 EVA
Message-Id: <20131217005629.GG27171@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1386730098-26641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1386730098-26641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 17, 2013 at 09:20:04AM +0900, Simon Horman wrote:
> On Mon, Dec 16, 2013 at 04:43:39PM +0100, Laurent Pinchart wrote:
> > Hi Simon,
> > 
> > On Monday 16 December 2013 11:22:04 Simon Horman wrote:
> > > On Wed, Dec 11, 2013 at 03:48:14AM +0100, Laurent Pinchart wrote:
> > > > Hello,
> > > > 
> > > > Commit 22ceeee16eb8f0d04de3ef43a5174fb30ec18af9 ("pwm-backlight: Add power
> > > > supply support") added a mandatory power supply for the PWM backlight,
> > > > resulting in broken backlight on the Armadillo board. This patch set fixes
> > > > the issue by adding power supplies to board code and DT, and adds proper
> > > > handling of the panel enable signal through the PWM backlight enable
> > > > GPIO.
> > > > 
> > > > Patch 1/4 fixes a v3.13 regression. Strictly speaking patch 3/4 is as
> > > > well, but the backlight was broken anyway with DT due to the enable GPIO
> > > > not being handled at all, so there's no need to push it to v3.13.
> > > > 
> > > > Laurent Pinchart (4):
> > > >   ARM: shmobile: armadillo: Add PWM backlight power supply
> > > >   ARM: shmobile: armadillo: Set backlight enable GPIO
> > > >   ARM: shmobile: armadillo: dts: Add PWM backlight power supply
> > > >   ARM: shmobile: armadillo: dts: Add PWM backlight enable GPIO
> > > >  
> > > >  arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 11 +++++++++++
> > > >  arch/arm/mach-shmobile/board-armadillo800eva.c          | 12 ++++++++----
> > > >  2 files changed, 19 insertions(+), 4 deletions(-)
> > > 
> > > Hi Laurent,
> > > 
> > > I am wondering if you could let me know how you exercised this.
> > > I am not having much luck using /dev/fb/0.
> > > 
> > > I have your patches applied on top of renesas-devel-v3.13-rc3-20131214v2
> > > 
> > > Using Legacy-C I see the following:
> > > dmesg | grep fb
> > > sh_mobile_lcdc_fb sh_mobile_lcdc_fb.0: Coherent DMA mask 0xffffffffffffffff
> > > is larger than dma_addr_t allows sh_mobile_lcdc_fb sh_mobile_lcdc_fb.0:
> > > Driver did not use or check the return value from dma_set_coherent_mask()?
> > > sh_mobile_lcdc_fb sh_mobile_lcdc_fb.0: unable to allocate buffer
> > > sh_mobile_lcdc_fb: probe of sh_mobile_lcdc_fb.0 failed with error -12
> > > sh_mobile_lcdc_fb sh_mobile_lcdc_fb.1: Coherent DMA mask 0xffffffffffffffff
> > > is larger than dma_addr_t allows sh_mobile_lcdc_fb sh_mobile_lcdc_fb.1:
> > > Driver did not use or check the return value from dma_set_coherent_mask()?
> > > sh_mobile_lcdc_fb sh_mobile_lcdc_fb.1: unable to allocate buffer
> > > sh_mobile_lcdc_fb: probe of sh_mobile_lcdc_fb.1 failed with error -12
> > > 
> > > And no fb devices in /dev
> > > 
> > > I am using armadillo800eva_defconfig
> > 
> > I've tried that and got the same error. My kernel config has 
> > CONFIG_SHMOBILE_IOMMU enabled which seems to hide the problem. I'll come up 
> > with a patch to get LCDC working without IOMMU.
> 
> Thanks.

I have applied "[PATCH 1/3] ARM: shmobile: armadillo: Fix coherent DMA
mask" and the problems I reported above seem to have been resolved, thanks.

Unfortunately my test of LCDC still seems to fail, so perhaps I need a
different test.

My test is as follows:

bmap /dev/fb0 test.bmp


Where bmap is:

git clone git://github.com/morimoto/bmap.git
cd bmap/
git checkout 6f64f8beee1be0c2f57752265a0568706d77794b
echo "CROSS = arm-linux-gnueabi-" > .config
make

And test.bmp is
http://horms.org/tmp/test.bmp

> 
> > > Using DT-Reference I see nothing relating to fb in dmeg or /dev
> > > 
> > > I am using armadillo800eva_defconfig with:
> > > * CONFIG_MACH_ARMADILLO800EVA disabled
> > > * CONFIG_MACH_ARMADILLO800EVA_REFERENCE enabled
> > > * CONFIG_BLK_DEV_INITRD and friends enabled
> > 
> > The DT-reference board doesn't enable LCDC.
> 
> Understood.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
