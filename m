From: Valentine <valentine.barshak@cogentembedded.com>
Date: Tue, 29 Oct 2013 17:19:09 +0000
Subject: Re: [PATCH] usb: phy: Move R-Car Gen2 driver registration to postcore_inictall
Message-Id: <526FEE0D.3090500@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383063666-4291-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/29/2013 09:00 PM, Laurent Pinchart wrote:
> Hi Valentine,
>
> Thank you for the patch.
>
> On Tuesday 29 October 2013 20:21:06 Valentine Barshak wrote:
>> USB phy controls USB channels 0 and 2 which are shared between
>> PCI USB host controllers and USBHS/USBSS respectively.
>>
>> This Initializes USB phy driver earlier because we need it
>> before PCI USB host controllers are initialized.
>
> Can't you use deferred probing ?

No, unfortunately this doesn't work with PCI.
We need the USB PHY set up before the PCI driver starts.
PCI controllers should be initialized via subsys_initcall and can't be built as a module.
Deferred probing is done at late_initcall and that's far too late in this case.

The MXS USB phy uses the similar approach, initializing the driver via postcore_initcall.
I haven't observed any issues with it on R-Car Gen2 phy as well.

Thanks,
Val.

>
>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>> ---
>>   drivers/usb/phy/phy-rcar-gen2-usb.c | 12 +++++++++++-
>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/phy/phy-rcar-gen2-usb.c
>> b/drivers/usb/phy/phy-rcar-gen2-usb.c index db3ab34..32c8847 100644
>> --- a/drivers/usb/phy/phy-rcar-gen2-usb.c
>> +++ b/drivers/usb/phy/phy-rcar-gen2-usb.c
>> @@ -241,7 +241,17 @@ static struct platform_driver rcar_gen2_usb_phy_driver
>> = { .remove = rcar_gen2_usb_phy_remove,
>>   };
>>
>> -module_platform_driver(rcar_gen2_usb_phy_driver);
>> +static int __init rcar_gen2_usb_phy_mod_init(void)
>> +{
>> +	return platform_driver_register(&rcar_gen2_usb_phy_driver);
>> +}
>> +postcore_initcall(rcar_gen2_usb_phy_mod_init);
>> +
>> +static void __exit rcar_gen2_usb_phy_mod_exit(void)
>> +{
>> +	platform_driver_unregister(&rcar_gen2_usb_phy_driver);
>> +}
>> +module_exit(rcar_gen2_usb_phy_mod_exit);
>>
>>   MODULE_LICENSE("GPL v2");
>>   MODULE_DESCRIPTION("Renesas R-Car Gen2 USB phy");

