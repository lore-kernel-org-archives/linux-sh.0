From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 18 Dec 2013 14:06:02 +0000
Subject: Re: [PATCH 0/4] Fix backlight on Armadillo 800 EVA
Message-Id: <1413448.gNXe1EauE4@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1386730098-26641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1386730098-26641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

(Dropping Thierry from the CC list)

On Wednesday 18 December 2013 10:34:17 Simon Horman wrote:
> On Tue, Dec 17, 2013 at 06:19:57PM +0100, Laurent Pinchart wrote:
> > On Tuesday 17 December 2013 09:56:30 Simon Horman wrote:
> > > On Tue, Dec 17, 2013 at 09:20:04AM +0900, Simon Horman wrote:
> > > > On Mon, Dec 16, 2013 at 04:43:39PM +0100, Laurent Pinchart wrote:
> > > > > On Monday 16 December 2013 11:22:04 Simon Horman wrote:
> > > > > > On Wed, Dec 11, 2013 at 03:48:14AM +0100, Laurent Pinchart wrote:
> > > > > > > Hello,
> > > > > > > 
> > > > > > > Commit 22ceeee16eb8f0d04de3ef43a5174fb30ec18af9 ("pwm-backlight:
> > > > > > > Add power supply support") added a mandatory power supply for
> > > > > > > the PWM backlight, resulting in broken backlight on the
> > > > > > > Armadillo board. This patch set fixes the issue by adding power
> > > > > > > supplies to board code and DT, and adds proper handling of the
> > > > > > > panel enable signal through the PWM backlight enable GPIO.
> > > > > > > 
> > > > > > > Patch 1/4 fixes a v3.13 regression. Strictly speaking patch 3/4
> > > > > > > is as well, but the backlight was broken anyway with DT due to
> > > > > > > the enable GPIO not being handled at all, so there's no need to
> > > > > > > push it to v3.13.
> > > > > > > 
> > > > > > > Laurent Pinchart (4):
> > > > > > >   ARM: shmobile: armadillo: Add PWM backlight power supply
> > > > > > >   ARM: shmobile: armadillo: Set backlight enable GPIO
> > > > > > >   ARM: shmobile: armadillo: dts: Add PWM backlight power supply
> > > > > > >   ARM: shmobile: armadillo: dts: Add PWM backlight enable GPIO
> > > > > > >  
> > > > > > >  arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 11
> > > > > > >  ++++++
> > > > > > >  arch/arm/mach-shmobile/board-armadillo800eva.c          | 12
> > > > > > >  ++++--
> > > > > > >  2 files changed, 19 insertions(+), 4 deletions(-)
> > > > > > 
> > > > > > Hi Laurent,
> > > > > > 
> > > > > > I am wondering if you could let me know how you exercised this.
> > > > > > I am not having much luck using /dev/fb/0.
> > > > > > 
> > > > > > I have your patches applied on top of
> > > > > > renesas-devel-v3.13-rc3-20131214v2
> > > > > > 
> > > > > > Using Legacy-C I see the following:
> > > > > > dmesg | grep fb
> > > > > > sh_mobile_lcdc_fb sh_mobile_lcdc_fb.0: Coherent DMA mask
> > > > > > 0xffffffffffffffff is larger than dma_addr_t allows
> > > > > > sh_mobile_lcdc_fb
> > > > > > sh_mobile_lcdc_fb.0: Driver did not use or check the return value
> > > > > > from
> > > > > > dma_set_coherent_mask()?
> > > > > > sh_mobile_lcdc_fb sh_mobile_lcdc_fb.0: unable to allocate buffer
> > > > > > sh_mobile_lcdc_fb: probe of sh_mobile_lcdc_fb.0 failed with error
> > > > > > -12
> > > > > > sh_mobile_lcdc_fb sh_mobile_lcdc_fb.1: Coherent DMA mask
> > > > > > 0xffffffffffffffff is larger than dma_addr_t allows
> > > > > > sh_mobile_lcdc_fb
> > > > > > sh_mobile_lcdc_fb.1: Driver did not use or check the return value
> > > > > > from
> > > > > > dma_set_coherent_mask()?
> > > > > > sh_mobile_lcdc_fb sh_mobile_lcdc_fb.1: unable to allocate buffer
> > > > > > sh_mobile_lcdc_fb: probe of sh_mobile_lcdc_fb.1 failed with error
> > > > > > -12
> > > > > > 
> > > > > > And no fb devices in /dev
> > > > > > 
> > > > > > I am using armadillo800eva_defconfig
> > > > > 
> > > > > I've tried that and got the same error. My kernel config has
> > > > > CONFIG_SHMOBILE_IOMMU enabled which seems to hide the problem. I'll
> > > > > come
> > > > > up with a patch to get LCDC working without IOMMU.
> > > > 
> > > > Thanks.
> > > 
> > > I have applied "[PATCH 1/3] ARM: shmobile: armadillo: Fix coherent DMA
> > > mask" and the problems I reported above seem to have been resolved,
> > > thanks.
> > > 
> > > Unfortunately my test of LCDC still seems to fail, so perhaps I need a
> > > different test.
> > > 
> > > My test is as follows:
> > > 
> > > bmap /dev/fb0 test.bmp
> > > 
> > > Where bmap is:
> > > 
> > > git clone git://github.com/morimoto/bmap.git
> > > cd bmap/
> > > git checkout 6f64f8beee1be0c2f57752265a0568706d77794b
> > > echo "CROSS = arm-linux-gnueabi-" > .config
> > > make
> > > 
> > > And test.bmp is
> > > http://horms.org/tmp/test.bmp
> > 
> > It looks like th LCDC FB driver doesn't work correctly when IOMMU support
> > is enabled. Given that the IOMMU driver seems to be broken and untested
> > anyway (see the two fixes I've just sent), my recommendation would be to
> > turn IOMMU support off until this can get investigated.
> 
> Thanks, I think that seems sensible.
> 
> But I am a little confused.
> 
> I was under the impression that armadillo800eva_defconfig
> did not enable IOMMU which is why I saw the problems relating
> to the DMA mask that I reported above. And that is the configuration
> I used again with the bmap test I reported immediately above.
> 
> I see this:
> ARCH=arm make armadillo800eva_defconfig
> grep IOMMU .config
> CONFIG_IOMMU_HELPER=y
> CONFIG_IOMMU_SUPPORT=y
> CONFIG_OF_IOMMU=y
> # CONFIG_SHMOBILE_IOMMU is not set

Right, so IOMMU was only an issue for me, not for you. I believe you're just 
missing the RENESAS_TPU and BACKLIGHT_PWM options in your .config. I've sent a 
patch that adds both to armadillo800eva_defconfig, could you please test it ?

-- 
Regards,

Laurent Pinchart

