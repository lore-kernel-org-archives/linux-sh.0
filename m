From: Valentine <valentine.barshak@cogentembedded.com>
Date: Fri, 17 Jan 2014 18:31:16 +0000
Subject: Re: [PATCH 1/3] arm: shmobile: lager: Add USBHS support
Message-Id: <52D976F4.5080600@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387548804-20829-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387548804-20829-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/15/2014 04:39 PM, Magnus Damm wrote:
> On Fri, Dec 20, 2013 at 11:13 PM, Valentine Barshak
> <valentine.barshak@cogentembedded.com> wrote:
>> This adds USBHS PHY and registers USBHS device if the driver is enabled.
>>
>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>> ---
>>   arch/arm/mach-shmobile/board-lager.c | 117 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 117 insertions(+)
>
> Hi Valentine,

Magnus, Simon,

>
> Thanks for this USB function patch. I'd like to switch focus to USB
> function soon.
>
> By the way, I'm happy to see that SATA platform device support is
> picked up by Simon. I intend to give your SATA DTS patches a go later
> this week, they should be ready to queue up rather soon I believe.
>
> Would it be possible for you to update your USB function platform
> device patches for Lager and Koelsch? I'd like to merge those after
> SATA, and the platform device files shouldn't change now so USB can go
> next now unless I'm mistaken. Please send a complete per-board series
> for USB function so patch pick up and testing gets easy - same style
> as SATA would be great.

Just respinned the USB series for Lager and Koelsch.
I did not include defconfig changes yet.
I think we need to enable kernel modules in the defconfig first,
so that multiple USB gadgets can be selected as modules.
Besides, I think that the USBHS device should be disabled in the defconfigs
since the boards have USB channel 0 configured as PCI USB host by default.

Please, let me know your thoughts regarding defconfig changes and I'll prepare the patches then.

Currently, the following options should be enabled if you want to test USB:
* USB device and USB host
CONFIG_USB=y
CONFIG_USB_RCAR_GEN2_PHY=y
* USB device
CONFIG_USB_RENESAS_USBHS=y
CONFIG_USB_GADGET=y
CONFIG_USB_RENESAS_USBHS_UDC=y
* USB Host
CONFIG_PCI=y
CONFIG_PCI_RCAR_GEN2=y
CONFIG_USB_EHCI_HCD=y
CONFIG_USB_OHCI_HCD=y

>
> I suppose we need to control MSTP bits via Runtime PM for USBHS, so
> some patch for clock control may be needed as well.

Works for me without any additional clock control changes.

>
> Thanks,
>
> / magnus
>

Thanks,
Val.
