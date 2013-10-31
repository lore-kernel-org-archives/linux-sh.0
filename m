From: Valentine <valentine.barshak@cogentembedded.com>
Date: Thu, 31 Oct 2013 11:43:18 +0000
Subject: Re: [PATCH] usb: phy: Move R-Car Gen2 driver registration to postcore_inictall
Message-Id: <52724256.4000000@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/31/2013 03:36 AM, Valentine wrote:
> On 10/30/2013 06:12 PM, Greg KH wrote:
>> On Wed, Oct 30, 2013 at 01:56:25PM +0400, Valentine wrote:
>>> On 10/30/2013 03:57 AM, Greg KH wrote:
>>>> On Tue, Oct 29, 2013 at 09:19:09PM +0400, Valentine wrote:
>>>>> On 10/29/2013 09:00 PM, Laurent Pinchart wrote:
>>>>>> Hi Valentine,
>>>>>>
>>>>>> Thank you for the patch.
>>>>>>
>>>>>> On Tuesday 29 October 2013 20:21:06 Valentine Barshak wrote:
>>>>>>> USB phy controls USB channels 0 and 2 which are shared between
>>>>>>> PCI USB host controllers and USBHS/USBSS respectively.
>>>>>>>
>>>>>>> This Initializes USB phy driver earlier because we need it
>>>>>>> before PCI USB host controllers are initialized.
>>>>>>
>>>>>> Can't you use deferred probing ?
>>>>>
>>>>> No, unfortunately this doesn't work with PCI.
>>>>> We need the USB PHY set up before the PCI driver starts.
>>>>> PCI controllers should be initialized via subsys_initcall and can't be built as a module.
>>>>> Deferred probing is done at late_initcall and that's far too late in this case.
>>>>>
>>>>> The MXS USB phy uses the similar approach, initializing the driver via postcore_initcall.
>>>>
>>>> I _HATE_ this "make this driver later than the others" mess.  I'll not
>>>
>>> This is actually "make this driver before the others" mess.
>>>
>>>> take patches that move drivers to different initcalls, sorry.  Please
>>>> fix up the link order, or use deferred probing, as that is why it was
>>>> created.
>>>>
>>>
>>> This is needed for the PCI EHCI/OHCI drivers to operate correctly on R-Car Gen platform
>>> since it has built-in PCI host controllers that share USB I/O with USBHS/USBSS devices.
>>> The phy has to be configured before the PCI EHCI/OHCI devices are probed.
>>>
>>> I'd really appreciate if you could give me a hint on how to fix the PCI EHCI/OHCI driver
>>> to use deferred probing, or fix the link order without creating a bigger mess.
>>
>> Just change the PCI driver to use deferred probing, it isn't that hard
>> to do so.
>>
>
> Do you mean to change usb_hcd_pci_probe() to return -EPROBE_DEFER if the phy is not ready?
> Or should I defer the whole PCI subsystem initialization (pci_common_int)?

Greg,
the reason I ask is that it doesn't seem that simple to me.

Here's some details:
The h/w is an ARM SoC that has 3 internal PCI controllers with a single EHCI/OHCI on each one.
This gives us 3 USB channels as this is called in the h/w manual.
Channel 0 is shared with USBHS (USB function) device.
Channel 2 is shared with USBSS (USB3.0 host).
Both channels are configured by a single USB phy.
USB PHY is a platform device, while EHCI/OCHI are located on the PCI busses.

If PCI USB host is probed before USB phy, the EHCI/OHCI device is detected, but nothing works.

We could change the USB HDC PCI driver and make usb_hcd_pci_probe() return -EPROBE_DEFER,
but I'm not sure how the condition for that should be phrased.
We could check the PCI vendor/device id, but there's no guarantee the same PCI device
is not used on other Renesas h/w which do not require any PHY setup. More over we only need
to setup the phy for the USB hosts connected to PCI controller 0/2.

We could try to defer the PCI driver and call pci_common_init() after the USB phy is initialized.
However, it seems that it's gonna be a bigger mess.

1. We need to add custom PCI bus scan callback to the hw_pci structure.
We can't use default (pci_scan_root_bus) because it will try to probe/enable pci devices before
their resources are fixed up when called late (after the PCI USB host drivers are registered).

2. All of the internal PCI controllers are initialized using a single call to the pci_common_init_dev().
So we can't easily defer just PCI controller 0/2. Even if we try to defer the whole PCI subsystem
initialization, we probably need some sort of a dummy device that will defer pci_common_init_dev call
untill USB phy is initialized.

3. The data structures and functions that are used to setup PCI are called at subsys_init() and
marked __initdata/__init, so that we can easily get rid of them once the PCI is registered.
Using deferred probe we'd need to keep them forever.

Using late_initcall() instead of subsys_initcall() for the PCI registration might work
if we implement custom PCI bus scan callback,
But that's just doing the same thing that I've tried to do with USB phy here
with additional PCI bus scan quirk.

On the other hand, postcore_initcall is used in drivers/usb/phy/phy-mxs-usb.c which is in your tree.
I agree that it's not that pretty, but it doesn't seem that bad considering other options we have.

>
>> good luck,
>
> Thanks,
> Val.
>

Please, let me know if you see better options.
Thanks,
Val.

>>
>> greg k-h
>>
>

