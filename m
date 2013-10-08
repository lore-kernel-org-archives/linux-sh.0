From: Simon Horman <horms@verge.net.au>
Date: Tue, 08 Oct 2013 01:21:48 +0000
Subject: Re: [PATCH 0/3] Add USBHS support to Lager
Message-Id: <20131008012148.GA11179@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Oct 08, 2013 at 03:27:00AM +0400, Valentine Barshak wrote:
> This patch set adds internal USB PHY support to RCAR Gen2 SoC, and
> also enables USBHS for the Lager board.
> 
> The patches apply fine to the renesas-devel-20131004 tag of the renesas.git.
> 
> The first patch also applies fine to the usb.git at kernel.org.
> It adds RCAR Gen2 phy driver, which is used to configure the shared USB
> channels 0/2 and to control USBHS internal PHY.
> All the drivers that use the shared USB channels (USBHS/USBSS/PCI USB host)
> should acquire the USB phy first to set proper channel configuration.
> 
> The other two patches add USBHS support to Lager board, which requires
> RCAR Gen2 phy driver.

Hi Morimoto-san,

I could you review this series?

My assumption is that in the current form the first patch will
go through the USB tree while the latter patches will subsequently
go through (my) renesas tree.

> Valentine Barshak (3):
>   usb: phy: Add RCAR Gen2 USB phy
>   arm: shmobile: r8a7790: Add USBHS clock support
>   arm: shmobile: lager: Add USBHS support
> 
>  arch/arm/mach-shmobile/board-lager.c            | 106 +++++++++
>  arch/arm/mach-shmobile/clock-r8a7790.c          |   4 +
>  drivers/usb/phy/Kconfig                         |  14 ++
>  drivers/usb/phy/Makefile                        |   1 +
>  drivers/usb/phy/phy-rcar-gen2-usb.c             | 271 ++++++++++++++++++++++++
>  include/linux/platform_data/usb-rcar-gen2-phy.h |  22 ++
>  6 files changed, 418 insertions(+)
>  create mode 100644 drivers/usb/phy/phy-rcar-gen2-usb.c
>  create mode 100644 include/linux/platform_data/usb-rcar-gen2-phy.h
> 
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
