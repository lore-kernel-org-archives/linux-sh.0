From: =?UTF-8?B?44Kr44Kq44CA44Of44Oz44CA44OS44Kn44OD44OX?=  <cm-hiep@jinso.co.jp>
Date: Tue, 09 Sep 2014 10:16:54 +0000
Subject: Re: [PATCH 0/3] Add USBHS support to Lager
Message-Id: <540ED396.6070601@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

Sorry for bother you!

We are testing USB host 2.0 on Lager(R8a7790 SoC),
We realize that there is only a master USB HOST configured on default 
config.
Slave devices is not configured on default config.
Could you please enable these CONFIGs?
For Hub:
CONFIG_USB_EHCI_ROOT_HUB_TT=y
For Usb memory:
CONFIG_USB_STORAGE=y
For: Keyboard, mouse:
CONFIG_INPUT_EVDEV=y


Best Regards,
Jinso/Cao Minh Hiep.


On 10/08/2013 08:27 AM, Valentine Barshak wrote:
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
>
> Valentine Barshak (3):
>    usb: phy: Add RCAR Gen2 USB phy
>    arm: shmobile: r8a7790: Add USBHS clock support
>    arm: shmobile: lager: Add USBHS support
>
>   arch/arm/mach-shmobile/board-lager.c            | 106 +++++++++
>   arch/arm/mach-shmobile/clock-r8a7790.c          |   4 +
>   drivers/usb/phy/Kconfig                         |  14 ++
>   drivers/usb/phy/Makefile                        |   1 +
>   drivers/usb/phy/phy-rcar-gen2-usb.c             | 271 ++++++++++++++++++++++++
>   include/linux/platform_data/usb-rcar-gen2-phy.h |  22 ++
>   6 files changed, 418 insertions(+)
>   create mode 100644 drivers/usb/phy/phy-rcar-gen2-usb.c
>   create mode 100644 include/linux/platform_data/usb-rcar-gen2-phy.h
>

