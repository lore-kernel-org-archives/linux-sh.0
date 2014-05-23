From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 23 May 2014 23:30:26 +0000
Subject: Re: [PATCH v3] phy: Renesas R-Car Gen2 PHY driver
Message-Id: <537FDA12.2070308@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201404120415.43761.sergei.shtylyov@cogentembedded.com> <534B77E2.8060901@ti.com> <53557BFE.5020908@cogentembedded.com> <53578FA8.6040607@ti.com> <537D2770.2040605@cogentembedded.com> <537F221C.10700@ti.com>
In-Reply-To: <537F221C.10700@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, grant.likely@linaro.org
Cc: linux-sh@vger.kernel.org, magnus.damm@gmail.com, linux-doc@vger.kernel.org, rdunlap@infradead.org

Hello.

On 05/23/2014 02:25 PM, Kishon Vijay Abraham I wrote:

>>>>>> This PHY, though formally being a part of Renesas USBHS controller, contains
>>>>>> the
>>>>>> UGCTRL2 register that controls multiplexing of the USB ports (Renesas calls
>>>>>> them
>>>>>> channels) to the different USB controllers: channel 0 can be connected to
>>>>>> either
>>>>>> PCI EHCI/OHCI or USBHS controllers, channel 2 can be connected to PCI
>>>>>> EHCI/OHCI
>>>>>> or xHCI controllers.

>>>>>> This is a new driver for this USB PHY currently already supported under
>>>>>> drivers/
>>>>>> usb/phy/. The reason for writing the new driver was the requirement that the
>>>>>> multiplexing of USB channels to the controller be dynamic, depending on what
>>>>>> USB drivers are loaded,  rather than static as provided by the old driver.
>>>>>> The infrastructure provided by drivers/phy/phy-core.c seems to fit that
>>>>>> purpose
>>>>>> ideally. The new driver only supports device tree probing for now.

>>>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>>>> [...]

>>>>>> Index: linux-phy/drivers/phy/phy-rcar-gen2.c
>>>>>> =================================>>>>>> --- /dev/null
>>>>>> +++ linux-phy/drivers/phy/phy-rcar-gen2.c
>>>>>> @@ -0,0 +1,283 @@

>>>> [...]

>>>>>> +static int rcar_gen2_phy_probe(struct platform_device *pdev)
>>>>>> +{

>>>> [...]

>>>>>> +    drv->phys[0][0].select_mask  = USBHS_UGCTRL2_USB0SEL;
>>>>>> +    drv->phys[0][0].select_value = USBHS_UGCTRL2_USB0SEL_PCI;
>>>>>> +    drv->phys[0][1].select_mask  = USBHS_UGCTRL2_USB0SEL;
>>>>>> +    drv->phys[0][1].select_value = USBHS_UGCTRL2_USB0SEL_HS_USB;
>>>>>> +    drv->phys[2][0].select_mask  = USBHS_UGCTRL2_USB2SEL;
>>>>>> +    drv->phys[2][0].select_value = USBHS_UGCTRL2_USB2SEL_PCI;
>>>>>> +    drv->phys[2][1].select_mask  = USBHS_UGCTRL2_USB2SEL;
>>>>>> +    drv->phys[2][1].select_value = USBHS_UGCTRL2_USB2SEL_USB30;
>>>>>> +
>>>>>> +    for (i = 0; i < NUM_USB_CHANNELS; i++) {

>>>>> Instead of hard coding the number of channels,

>>>>      It's hard coded in the hardware. We can even decrease that number to 2 as

>>> right, that's why thought dt should have that information.

>>     So you want a dedicated property for that or you meant something else?

>>>> for the channel #1 we have nothing to do, regardless of whether it's present or
>>>> not...

>>>>> we can model the channels (PHYs) as sub-nodes of the main PHY

>>>>      Hm, I don't think such representation would be adequate: the channels
>>>> themselves do not usually correspond to any particular PHY, that's why I used
>>>> #phy-cells = <2>.

>>>>> in dt and use it to create individual PHYs.

>>>>      Well, we probably can... however, I fail to see any immediate gain from
>>>> it here...
>>>>      I have to ask why you've selected this particular driver for such DT
>>>> representation experiments, despite it not being the first one supporting
>>>> multiple PHYs?

>>> just that it didn't strike before.. but I think all multiple PHYs should be
>>> modelled this way.

>>     I've basically reimplemented the driver to parse the info from the subnodes
>> and it's now became larger in size, not smaller. :-/ Overall, I'm not content
>> with the changes, nor do I think such a change in the DT representation was a
>> great idea...

> I've seen someone posted a patch with subnodes and that wasn't looking too bad.

    It was treating subnodes as PHY providers IIRC. Not what anyone could have 
expected, I guess...

> Do you mind posting your patch in the list?

    Posted now.

> Cheers
> Kishon

WBR, Sergei

