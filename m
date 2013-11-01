From: Valentine <valentine.barshak@cogentembedded.com>
Date: Fri, 01 Nov 2013 13:59:40 +0000
Subject: Re: [PATCH] usb: phy: Move R-Car Gen2 driver registration to postcore_inictall
Message-Id: <5273B3CC.8080008@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/31/2013 08:54 PM, Alan Stern wrote:
> On Thu, 31 Oct 2013, Valentine wrote:
>
>>> Do you mean to change usb_hcd_pci_probe() to return -EPROBE_DEFER if the phy is not ready?
>>> Or should I defer the whole PCI subsystem initialization (pci_common_int)?
>>
>> Greg,
>> the reason I ask is that it doesn't seem that simple to me.
>>
>> Here's some details:
>> The h/w is an ARM SoC that has 3 internal PCI controllers with a single EHCI/OHCI on each one.
>> This gives us 3 USB channels as this is called in the h/w manual.
>> Channel 0 is shared with USBHS (USB function) device.
>> Channel 2 is shared with USBSS (USB3.0 host).
>> Both channels are configured by a single USB phy.
>> USB PHY is a platform device, while EHCI/OCHI are located on the PCI busses.
>>
>> If PCI USB host is probed before USB phy, the EHCI/OHCI device is
>> detected, but nothing works.
>>
>> We could change the USB HDC PCI driver and make usb_hcd_pci_probe() return -EPROBE_DEFER,
>> but I'm not sure how the condition for that should be phrased.
>
> You need to tell usb_hcd_pci_probe() to wait for the PHY.  That seems
> to be the proper solution to your problem.
>
> The difficulty is that you have a discoverable device (the PCI EHCI
> controller) which needs to wait for a platform device (the PHY).  The
> kernel doesn't have a good way to describe such a constraint between
> two different kinds of device like that, as far as I know.

Thanks, unfortunately this doesn't help.
I'm not sure how this problem should be addressed using USB HCD PCI deferred probing.
However, at the same time I see that six usb phy drivers use subsys_initcall and one
uses postcore_initcall to adjust the initialization order.

The same approach is used with other drivers quite often. Take I2C, for example.
I'm not sure why we can't use it here with the R-Car Gen2 phy.
This driver is used only with R-Car SoC and the approach is trivial and  working fine.

Why can't we use it instead of trying to create a bigger mess in the USB HCD PCI driver,
which is used on quite a number of platforms, to workaround the PHY initialization order
that is only relevant to R-Car Gen2 SoC?

>
> This is similar to the problems facing Runtime Interpreted Power
> Sequences, although not quite the same.
>
> Alan Stern
>

Thanks,
Val.
