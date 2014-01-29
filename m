From: Simon Horman <horms@verge.net.au>
Date: Wed, 29 Jan 2014 06:45:21 +0000
Subject: Re: [PATCH RFC 0/2] ARM: shmobile: lager: Enable DMA bounce for PCI
Message-Id: <20140129064521.GI23833@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1390935213-12896-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1390935213-12896-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 28, 2014 at 10:53:31PM +0400, Valentine Barshak wrote:
> This enables DMA bounce for PCI since the controller does
> not support more than 2G PCI-AHB memory window.
> The problems with DMA transfers can be observed when
> setting 2G/2G user/kernel memory split model
> (CONFIG_VMSPLIT_2G=y)
> These patches help to avoid it.

Are these patches compatible with other user/kernel splits?

> 
> The patches should be applied on top of the 
> "[PATCH V3 0/3] ARM: shmobile: lager: Add USB support" series at
> http://marc.info/?l=linux-sh&m9060253506760&w=2
> 
> Valentine Barshak (2):
>   ARM: shmobile: lager: Use DMA bounce for PCI devices
>   ARM: shmobile: lager: Increase the size of ARM corehent DMA pool
> 
>  arch/arm/boot/dts/r8a7790-lager.dts  |  2 +-
>  arch/arm/mach-shmobile/Kconfig       |  2 ++
>  arch/arm/mach-shmobile/board-lager.c | 38 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+), 1 deletion(-)
> 
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
