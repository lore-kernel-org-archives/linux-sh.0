From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 30 Oct 2013 09:56:25 +0000
Subject: Re: [PATCH] usb: phy: Move R-Car Gen2 driver registration to postcore_inictall
Message-Id: <5270D7C9.3010306@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/30/2013 03:57 AM, Greg KH wrote:
> On Tue, Oct 29, 2013 at 09:19:09PM +0400, Valentine wrote:
>> On 10/29/2013 09:00 PM, Laurent Pinchart wrote:
>>> Hi Valentine,
>>>
>>> Thank you for the patch.
>>>
>>> On Tuesday 29 October 2013 20:21:06 Valentine Barshak wrote:
>>>> USB phy controls USB channels 0 and 2 which are shared between
>>>> PCI USB host controllers and USBHS/USBSS respectively.
>>>>
>>>> This Initializes USB phy driver earlier because we need it
>>>> before PCI USB host controllers are initialized.
>>>
>>> Can't you use deferred probing ?
>>
>> No, unfortunately this doesn't work with PCI.
>> We need the USB PHY set up before the PCI driver starts.
>> PCI controllers should be initialized via subsys_initcall and can't be built as a module.
>> Deferred probing is done at late_initcall and that's far too late in this case.
>>
>> The MXS USB phy uses the similar approach, initializing the driver via postcore_initcall.
>
> I _HATE_ this "make this driver later than the others" mess.  I'll not

This is actually "make this driver before the others" mess.

> take patches that move drivers to different initcalls, sorry.  Please
> fix up the link order, or use deferred probing, as that is why it was
> created.
>

This is needed for the PCI EHCI/OHCI drivers to operate correctly on R-Car Gen platform
since it has built-in PCI host controllers that share USB I/O with USBHS/USBSS devices.
The phy has to be configured before the PCI EHCI/OHCI devices are probed.

I'd really appreciate if you could give me a hint on how to fix the PCI EHCI/OHCI driver
to use deferred probing, or fix the link order without creating a bigger mess.

> sorry,
>
> greg k-h
>

Thanks,
Val.
