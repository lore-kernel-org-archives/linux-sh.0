From: Valentine <valentine.barshak@cogentembedded.com>
Date: Wed, 06 Nov 2013 16:47:36 +0000
Subject: Re: [RFC PATCH 2/2] usb: hcd: Introduce CONFIG_USB_HCD_EXTERNAL_PHY option
Message-Id: <527A72A8.4020607@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383683607-28119-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383683607-28119-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 11/06/2013 08:39 PM, Alan Stern wrote:
> On Wed, 6 Nov 2013, Felipe Balbi wrote:
>
>> Hi,
>>
>> On Wed, Nov 06, 2013 at 12:33:27AM +0400, Valentine Barshak wrote:
>>> This adds external USB phy support to USB HCD driver that
>>> allows to find and initialize external USB phy, bound to
>>> the HCD when the HCD is added.
>>> The usb_add_hcd function returns -EPROBE_DEFER if the USB
>>> phy, bound to the HCD, is not ready.
>>> If no USB phy is bound, the HCD is initialized as usual.
>>>
>>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>>> ---
>>>   drivers/usb/core/hcd.c   | 20 ++++++++++++++++++++
>>>   drivers/usb/host/Kconfig | 11 +++++++++++
>>>   2 files changed, 31 insertions(+)
>>>
>>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>>> index d939521..da9c4ba 100644
>>> --- a/drivers/usb/core/hcd.c
>>> +++ b/drivers/usb/core/hcd.c
>>> @@ -2597,6 +2597,26 @@ int usb_add_hcd(struct usb_hcd *hcd,
>>>   	int retval;
>>>   	struct usb_device *rhdev;
>>>
>>> +#ifdef CONFIG_USB_HCD_EXTERNAL_PHY
>
> I don't see any reason to add a new Kconfig symbol.  Just use "#ifdef
> USB_PHY" instead.

I just thought that most of the drivers would not need this code,
so I added a config option which can be enabled only if necessary.
I'll remove and use USB_PHY instead. Thanks.

>
>> I think here would be a nicer location for a flag:
>>
>> if (hcd->has_external_phy) {
>> 	phy = usb_get_phy_dev();
>>
>> 	....
>> }
>>
>> that flag would get set by the glue driver (ehci-omap, ehci-msm,
>> ohci-omap, etc), where necessary.
>
> The problem Valentine is facing is that the glue driver doesn't know
> whether or not to set the flag.  The way he set it up, the decision is
> pushed down into usb_get_phy_dev, which ought to have enough
> information.

Exactly.

>
> Alan Stern
>

Thanks,
Val.
