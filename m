From: Valentine <valentine.barshak@cogentembedded.com>
Date: Thu, 03 Oct 2013 13:36:33 +0000
Subject: Re: [PATCH 2/6] arm: shmobile: lager: Add USBHS support
Message-Id: <524D72E1.2080502@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/03/2013 01:47 PM, Laurent Pinchart wrote:
> Hi Morimoto-san,
>
> On Wednesday 02 October 2013 21:53:26 Kuninori Morimoto wrote:
>> Hi Valentine
>>
>>>>> +static int usbhs_hardware_init(struct platform_device *pdev)
>>>>> +{
>>>>> +	struct usbhs_private *priv = usbhs_get_priv(pdev);
>>>>> +	struct clk *clk;
>>>>> +
>>>>> +	clk = clk_get(NULL, "hsusb");
>>>>> +	if (IS_ERR(clk))
>>>>> +		return -ENODEV;
>>>>
>>>> It is automatically enable/disabled by driver
>>>> if MSTP704 clock name was "renesas_usbhs".
>>>
>>> The reason I did not bind usbhs clock to renesas_usbhs device is because
>>> the same clock is also used by the lager_add_usb_devices() function in
>>> the next patches. We need that since the global USB settings that affect
>>> USBHS/USBSS and PCI USB host channel sharing are done in the USBHS
>>> UGCTRL2 register. So we need this clock even if the renesas_usbhs driver
>>> is disabled. IIUC, biding it to "renesas_usbhs" device would make it
>>> impossible to use the clock if renesas_usbhs device is not registered.
>>
>> I understand your situation, but you can use renesas_usbhs binded clock
>> anyway ? As Laurent mentioned, pci-rcar-gen2 care about it in driver ?
>> Maybe callback function is nice solution in this situation ?
>> Like this
>>
>> --- clock --------------
>>    CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP704]),
>>    CLKDEV_ICK_ID("hsusb", "pci-rcar-gen2", &mstp_clks[MSTP704]),
>>
>> --- platform -----------
>> int rcar_pci_hw_init(struct platform_device *pdev)
>> {
>>          clk = clk_get("hsusb", pdev->dev);
>>          if (IS_ERR(clk))
>>                   return -EIO;
>>
>>          clk_enable(clk);
>>          clk_put(clk);
>>
>>          ...
>>
>>          return 0;
>> }
>>
>> --- driver ---
>> static int __init rcar_pci_probe(struct platform_device *pdev)
>> {
>>          ...
>>          if (info->hw_init)
>>               ret = info->hw_init(pdev);
>>          ...
>> }
>
> The problem with such a mechanism is that it only works with platform data, as
> we don't have callback functions in DT.
>

I wouldn't want to put channel fix-up in the PCI driver.
In this case we would need to put it in the XHCI driver later as well.
We could skip channel configuration in the USBHS driver and assume the 
default POR configuration (USBHS enabled).
But in case of PCI/XHCI we must ensure that there's no race conditions
and that both drivers won't attempt to access UGCTRL2 register 
simultaneously. Also we should pass the same UGGTL2 configuration value
to all the drivers.

Having this stuff done by each USB driver may cause the need of custom 
DT bindings. For example, we may need to add a USBHS reference
(phandle) to the PCI and XHCI device nodes.
In addition, both drivers would need to do the same thing: enable USBHS 
and modify UGCTRL2.

I think the channel configuration should be done outside any driver.
Having some sort of a channel fix-up in the platform code seems a bit 
cleaner. Probably a platform bus notifier callback, which enables USBHS 
only when any of the renesas_usbhs, pci-rcar-gen2 or XHCI devices is 
added, and configures the channels once and for all.
When all the devices are removed, the notify callback may disable
the USBHS clock.

Thanks,
Val.

