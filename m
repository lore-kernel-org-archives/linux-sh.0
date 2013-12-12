From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Date: Thu, 12 Dec 2013 07:40:39 +0000
Subject: Re: [PATCH] MAINTAINERS: Add DesignWare, i.MX6, Armada, R-Car PCI host maintainers
Message-Id: <52A96877.90902@free-electrons.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131211183237.GI4699@google.com>
In-Reply-To: <20131211183237.GI4699@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Bjorn, ,

On 11/12/2013 19:32, Bjorn Helgaas wrote:
> If this looks reasonable, I'll merge it via the PCI tree for v3.13.
> 
> Bjorn
> 
> 
> MAINTAINERS: Add DesignWare, i.MX6, Armada, R-Car PCI host maintainers
> 
> Add entries for PCI host controller drivers in drivers/pci/host/.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  MAINTAINERS |   31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8285ed4676b6..826c722d92ba 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6449,16 +6449,47 @@ F:	drivers/pci/
>  F:	include/linux/pci*
>  F:	arch/x86/pci/
>  
> +PCI DRIVER FOR DESIGNWARE
> +M:	Jingoo Han <jg1.han@samsung.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Maintained
> +F:	drivers/pci/host/*designware*
> +
> +PCI DRIVER FOR IMX6
> +M:	Shawn Guo <shawn.guo@linaro.org>
> +L:	linux-pci@vger.kernel.org
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/pci/host/*imx6*
> +
> +PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
> +M:	Jason Cooper <jason@lakedaemon.net>
> +L:	linux-pci@vger.kernel.org
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +F:	drivers/pci/host/*mvebu*

I think that Thomas Petazzoni would be more appropriate, he worked
on the mvebu PCIe since 6 moths and now know very well the
subject. Until now all the mvebu PCIe related questions were
managed by Thomas.

Regards,

Gregory



-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
