From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 16 Dec 2013 15:43:39 +0000
Subject: Re: [PATCH 0/4] Fix backlight on Armadillo 800 EVA
Message-Id: <1526243.AJkb6c2GXk@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1386730098-26641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1386730098-26641-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Monday 16 December 2013 11:22:04 Simon Horman wrote:
> On Wed, Dec 11, 2013 at 03:48:14AM +0100, Laurent Pinchart wrote:
> > Hello,
> > 
> > Commit 22ceeee16eb8f0d04de3ef43a5174fb30ec18af9 ("pwm-backlight: Add power
> > supply support") added a mandatory power supply for the PWM backlight,
> > resulting in broken backlight on the Armadillo board. This patch set fixes
> > the issue by adding power supplies to board code and DT, and adds proper
> > handling of the panel enable signal through the PWM backlight enable
> > GPIO.
> > 
> > Patch 1/4 fixes a v3.13 regression. Strictly speaking patch 3/4 is as
> > well, but the backlight was broken anyway with DT due to the enable GPIO
> > not being handled at all, so there's no need to push it to v3.13.
> > 
> > Laurent Pinchart (4):
> >   ARM: shmobile: armadillo: Add PWM backlight power supply
> >   ARM: shmobile: armadillo: Set backlight enable GPIO
> >   ARM: shmobile: armadillo: dts: Add PWM backlight power supply
> >   ARM: shmobile: armadillo: dts: Add PWM backlight enable GPIO
> >  
> >  arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 11 +++++++++++
> >  arch/arm/mach-shmobile/board-armadillo800eva.c          | 12 ++++++++----
> >  2 files changed, 19 insertions(+), 4 deletions(-)
> 
> Hi Laurent,
> 
> I am wondering if you could let me know how you exercised this.
> I am not having much luck using /dev/fb/0.
> 
> I have your patches applied on top of renesas-devel-v3.13-rc3-20131214v2
> 
> Using Legacy-C I see the following:
> dmesg | grep fb
> sh_mobile_lcdc_fb sh_mobile_lcdc_fb.0: Coherent DMA mask 0xffffffffffffffff
> is larger than dma_addr_t allows sh_mobile_lcdc_fb sh_mobile_lcdc_fb.0:
> Driver did not use or check the return value from dma_set_coherent_mask()?
> sh_mobile_lcdc_fb sh_mobile_lcdc_fb.0: unable to allocate buffer
> sh_mobile_lcdc_fb: probe of sh_mobile_lcdc_fb.0 failed with error -12
> sh_mobile_lcdc_fb sh_mobile_lcdc_fb.1: Coherent DMA mask 0xffffffffffffffff
> is larger than dma_addr_t allows sh_mobile_lcdc_fb sh_mobile_lcdc_fb.1:
> Driver did not use or check the return value from dma_set_coherent_mask()?
> sh_mobile_lcdc_fb sh_mobile_lcdc_fb.1: unable to allocate buffer
> sh_mobile_lcdc_fb: probe of sh_mobile_lcdc_fb.1 failed with error -12
> 
> And no fb devices in /dev
> 
> I am using armadillo800eva_defconfig

I've tried that and got the same error. My kernel config has 
CONFIG_SHMOBILE_IOMMU enabled which seems to hide the problem. I'll come up 
with a patch to get LCDC working without IOMMU.

> Using DT-Reference I see nothing relating to fb in dmeg or /dev
> 
> I am using armadillo800eva_defconfig with:
> * CONFIG_MACH_ARMADILLO800EVA disabled
> * CONFIG_MACH_ARMADILLO800EVA_REFERENCE enabled
> * CONFIG_BLK_DEV_INITRD and friends enabled

The DT-reference board doesn't enable LCDC.

-- 
Regards,

Laurent Pinchart

