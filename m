From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 11 Jan 2012 08:24:21 +0000
Subject: Re: MMCIF support on sh7757lcr
Message-Id: <Pine.LNX.4.64.1201110920410.1191@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1201101646050.530@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1201101646050.530@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 11 Jan 2012, Shimoda, Yoshihiro wrote:

> Hello Guennadi-san,
> 
> Thank you for your review.
> 
> 2012/01/11 0:55, Guennadi Liakhovetski wrote:
> > Hello Shimoda-san
> > 
> > While reviewing MMCIF platform bindings, I came across your commit
> > 
> > commit 65f63eab38626a79f8a54d13686680a1ea898f72
> > Author: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Date:   Fri Feb 25 07:40:27 2011 +0000
> > 
> >     sh: add platform_device of tmio_mmc and sh_mmcif to sh7757lcr
> > 
> > There you only specify MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA 
> > capabilities for MMCIF. The MMCIF controller does not have any native 
> > support for card hotplug detection, therefore it must either be polled, or 
> > the card has to be marked non-removable. For polling it is also desired to 
> > provide a .get_cd() method. Neither of these is done for sh7757lcr. Is the 
> > MMC card on it removable? If so, is there any way to detect card presence 
> > in the slot?
> 
> This board doesn't have the MMC card slot. A MMC chip is on the board,
> so we cannot remove the chip.
> In the linux-3.2-rc7, the sh7757lcr can detect the MMC chip and
> I can see the "mmcblk" device.

Right, it is detected upon driver initialisation, but id it were a normal 
slot, card ejects and inserts wouldn't be recognised. In this case we have 
to specify MMC_CAP_NONREMOVABLE among controller sapabilities:

static struct sh_mmcif_plat_data sh_mmcif_plat = {
	...
	.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA |
				MMC_CAP_NONREMOVABLE,

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
