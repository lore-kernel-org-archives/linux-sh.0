From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 11 Jan 2012 00:55:04 +0000
Subject: Re: MMCIF support on sh7757lcr
Message-Id: <4F0CDDE8.3040207@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1201101646050.530@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1201101646050.530@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Guennadi-san,

Thank you for your review.

2012/01/11 0:55, Guennadi Liakhovetski wrote:
> Hello Shimoda-san
> 
> While reviewing MMCIF platform bindings, I came across your commit
> 
> commit 65f63eab38626a79f8a54d13686680a1ea898f72
> Author: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Date:   Fri Feb 25 07:40:27 2011 +0000
> 
>     sh: add platform_device of tmio_mmc and sh_mmcif to sh7757lcr
> 
> There you only specify MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA 
> capabilities for MMCIF. The MMCIF controller does not have any native 
> support for card hotplug detection, therefore it must either be polled, or 
> the card has to be marked non-removable. For polling it is also desired to 
> provide a .get_cd() method. Neither of these is done for sh7757lcr. Is the 
> MMC card on it removable? If so, is there any way to detect card presence 
> in the slot?

This board doesn't have the MMC card slot. A MMC chip is on the board,
so we cannot remove the chip.
In the linux-3.2-rc7, the sh7757lcr can detect the MMC chip and
I can see the "mmcblk" device.

Best regards,
Yoshihiro Shimoda

> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 


-- 
Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
EC No.
