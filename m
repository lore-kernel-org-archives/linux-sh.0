From: Simon Horman <horms@verge.net.au>
Date: Wed, 02 Oct 2013 00:14:01 +0000
Subject: Re: [PATCH 0/6] arm: shmobile: Add USBHS and PCI OHCI/EHCI to RCAR H2 Lager
Message-Id: <20131002001400.GD5483@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1380652251-8143-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380652251-8143-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

On Tue, Oct 01, 2013 at 10:30:45PM +0400, Valentine Barshak wrote:
> The following patches have been made on top of devel branch of
> linux-sh git repo. They add USBHS function and USB OHCI/EHCI
> support to RCAR H2 Lager board.

If you are making changes against arch/arm/mach-shmobile/ then
please make then against the latest devel tag of my renesas tree
on kernel.org.

Sorry for the confusion, there have been a few changes to
the maintenance of arch/arm/mach-shmobile/ over the past year or so.

> 
> The first two patches add USBHS support to Lager board.
> 
> The next two patches add Internal PCI support to RCAR Gen2 SoC.
> There are three Internal PCI controllers available with a single
> EHCI/OHCI device present on each one.
> This provides three USB channels. Channels 0/2 are shared
> with USBHS/USBSS respectively.
> 
> The last two patches add Internal PCI support to Lager
> and allow to configure the USB channels that are shared
> between PCI USB controller and USBHS/USBSS.
> The configuration is done in the USBHS UGCTRL2 register.
> In addition, the following switches have to be set correctly
> for the USB channel 0 configuration:
> SW5: pin1; SW6: pin1    -> PCI USB Host
> SW5: neutral; SW6: pin2 -> USB Function (VBUS always connected)
> SW5: pin3: SW6: pin2    -> USB Function (VBUS is connected only
> if GP5_18 pin is high)
> 
> Valentine Barshak (6):
>   arm: shmobile: r8a7790: Add USBHS clock support
>   arm: shmobile: lager: Add USBHS support
>   arm: shmobile: Add internal PCI support to RCAR Gen2
>   arm: shmobile: r8a7790: Add PCI/USB host clock support
>   arm: shmobile: lager: Add internal PCI support
>   arm: shmobile: lager: Disable unused PCI/USB channels
> 
>  arch/arm/mach-shmobile/Kconfig         |   1 +
>  arch/arm/mach-shmobile/Makefile        |   4 +
>  arch/arm/mach-shmobile/board-lager.c   | 277 +++++++++++++++++++++++++++
>  arch/arm/mach-shmobile/clock-r8a7790.c |   5 +
>  arch/arm/mach-shmobile/pci-rcar-gen2.c | 339 +++++++++++++++++++++++++++++++++
>  5 files changed, 626 insertions(+)
>  create mode 100644 arch/arm/mach-shmobile/pci-rcar-gen2.c
> 
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
