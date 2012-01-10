From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 10 Jan 2012 15:55:36 +0000
Subject: MMCIF support on sh7757lcr
Message-Id: <Pine.LNX.4.64.1201101646050.530@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Shimoda-san

While reviewing MMCIF platform bindings, I came across your commit

commit 65f63eab38626a79f8a54d13686680a1ea898f72
Author: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date:   Fri Feb 25 07:40:27 2011 +0000

    sh: add platform_device of tmio_mmc and sh_mmcif to sh7757lcr

There you only specify MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA 
capabilities for MMCIF. The MMCIF controller does not have any native 
support for card hotplug detection, therefore it must either be polled, or 
the card has to be marked non-removable. For polling it is also desired to 
provide a .get_cd() method. Neither of these is done for sh7757lcr. Is the 
MMC card on it removable? If so, is there any way to detect card presence 
in the slot?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
