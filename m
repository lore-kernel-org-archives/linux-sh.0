From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 18 Jul 2008 01:25:05 +0000
Subject: Re: [PATCH] sh7760mmc: host driver for SH7760 MMC interface
Message-Id: <487FF0F1.4020303@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080717110119.GA14949@roarinelk.homelinux.net>
In-Reply-To: <20080717110119.GA14949@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Manuel.

Manuel Lauss wrote:
> Hello,
> 
> Here is my latest attempt at an MMC host driver for the MMCIF interface
> found on many SH-4 socs, particularly the SH7760, SH778x, and SH7763.
> 
> This is a very basic driver, without DMA support and crippled performance
> due to hardware or driver bugs wrt. multiblock writes.

Oh, I am writing mmc host driver for SH4.......

> 
> The driver has been extensively tested on SH7760 only.  The SH7780 and 7763
> MMCIF should theoretically work with some minor adjustments.
OK, I can test SH7763 and SH7780.

> 
> Patch is against latest linus git.
> 

Best regards,
  Nobuhiro



