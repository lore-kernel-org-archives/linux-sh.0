From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 24 Jan 2014 04:40:52 +0000
Subject: Re: [PATCH 1/3] arm: shmobile: lager: Add USBHS support
Message-Id: <CANqRtoRsbikc8Nc=_W--9A+2Smq6bvuKq931uOUBE9-L7=NT7w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387548804-20829-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387548804-20829-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Valentine,

On Sat, Jan 18, 2014 at 3:31 AM, Valentine
<valentine.barshak@cogentembedded.com> wrote:
> On 01/15/2014 04:39 PM, Magnus Damm wrote:
>>
>> On Fri, Dec 20, 2013 at 11:13 PM, Valentine Barshak
>> <valentine.barshak@cogentembedded.com> wrote:
>>>
>>> This adds USBHS PHY and registers USBHS device if the driver is enabled.
>>>
>>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>>> ---
>>>   arch/arm/mach-shmobile/board-lager.c | 117
>>> +++++++++++++++++++++++++++++++++++
>>>   1 file changed, 117 insertions(+)
>>
>>
>> Hi Valentine,
>
>
> Magnus, Simon,
>
>
>>
>> Thanks for this USB function patch. I'd like to switch focus to USB
>> function soon.
>>
>> By the way, I'm happy to see that SATA platform device support is
>> picked up by Simon. I intend to give your SATA DTS patches a go later
>> this week, they should be ready to queue up rather soon I believe.
>>
>> Would it be possible for you to update your USB function platform
>> device patches for Lager and Koelsch? I'd like to merge those after
>> SATA, and the platform device files shouldn't change now so USB can go
>> next now unless I'm mistaken. Please send a complete per-board series
>> for USB function so patch pick up and testing gets easy - same style
>> as SATA would be great.
>
>
> Just respinned the USB series for Lager and Koelsch.
> I did not include defconfig changes yet.

Thanks!

> I think we need to enable kernel modules in the defconfig first,
> so that multiple USB gadgets can be selected as modules.

I agree that for testing something is needed., but perhaps a simple
composite device is enough?

In general I think the USB gadget kernel configuration is something
that it is left for the distributions to select since it depends on
each use case. Also, using modules is fine but I also think there is
some configfs interface that can be used to configure the USB gadget
during run time.

> Besides, I think that the USBHS device should be disabled in the defconfigs
> since the boards have USB channel 0 configured as PCI USB host by default.

That I disagree about. =)

I know the default dip switch setting for Lager USB0 is USB Host, but
I disagree that enabling it as USB Host makes sense. This because
there is no proper cable detection and VBUS short circuit may happen
in case of USB Host.

I propose that we only use USB0 as USB Gadget on Lager. I have some
incremental patches for that, so please wait for them instead of
hacking up something by yourself.

> Please, let me know your thoughts regarding defconfig changes and I'll
> prepare the patches then.

Ok!

> Currently, the following options should be enabled if you want to test USB:
> * USB device and USB host
> CONFIG_USB=y
> CONFIG_USB_RCAR_GEN2_PHY=y
> * USB device
> CONFIG_USB_RENESAS_USBHS=y
> CONFIG_USB_GADGET=y
> CONFIG_USB_RENESAS_USBHS_UDC=y
> * USB Host
> CONFIG_PCI=y
> CONFIG_PCI_RCAR_GEN2=y
> CONFIG_USB_EHCI_HCD=y
> CONFIG_USB_OHCI_HCD=y

Thanks for this. It seems that CONFIG_USB_RENESAS_USBHS_UDC requires
USB_HOST for some reason.

If you have a cycle to spare, can you try to fix it up so it is
possible to use USBHS for Gadget-only?

I think some Kconfig changes are needed for USBHS.

>> I suppose we need to control MSTP bits via Runtime PM for USBHS, so
>> some patch for clock control may be needed as well.
>
>
> Works for me without any additional clock control changes.

That's because you have Runtime PM disabled. =)

Please try with using CONFIG_PM_RUNTIME=y. In that case I believe you
will need to control MSTP704.

Thanks,

/ magnus
