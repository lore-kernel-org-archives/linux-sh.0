From: Kishon Vijay Abraham I <kishon@ti.com>
Date: Tue, 01 Jul 2014 13:23:27 +0000
Subject: Re: [PATCH v4] phy: Renesas R-Car Gen2 PHY driver
Message-Id: <53B2B37F.6080300@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201405240206.04700.sergei.shtylyov@cogentembedded.com> <538F05BC.7000800@ti.com> <538F95A7.8010409@cogentembedded.com> <5396E160.7000707@ti.com> <53AB4A48.5030805@cogentembedded.com>
In-Reply-To: <53AB4A48.5030805@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, grant.likely@linaro.org, devicetree@vger.kernel.org
Cc: rdunlap@infradead.org, linux-doc@vger.kernel.org, linux-sh@vger.kernel.org

Hi,

On Thursday 26 June 2014 03:46 AM, Sergei Shtylyov wrote:
> Hello.
> 
> On 06/10/2014 02:43 PM, Kishon Vijay Abraham I wrote:
> 
>    Sorry for delayed reply, I was busy with other things. Now it's time to
> revisit the infamous USB PHY driver...
> 
>>>>> This PHY, though formally being a part of Renesas USBHS controller, contains
>>>>> the
>>>>> UGCTRL2 register that controls multiplexing of the USB ports (Renesas calls
>>>>> them
>>>>> channels) to the different USB controllers: channel 0 can be connected to
>>>>> either
>>>>> PCI EHCI/OHCI or USBHS controllers, channel 2 can be connected to PCI
>>>>> EHCI/OHCI
>>>>> or xHCI controllers.
> 
.
.
<snip>
.
.

> 
>>>> IIUC, channel 0 can be configured for either EHCI/OHCI or HS-USB but can't be
>>>> used for both.  And channel 1 can be configured for either PCI EHCI/OHCI or
>>>> xHCI. right?
> 
>>>     Yes. However that depends on the driver load order: if e.g. xHCI driver is
>>> loaded later than PCI USB drivers,
>>> it will override the channel routing.
> 
>> So will the PCI USB drivers will be notified of that?
> 
>    Unfortunately, no. But this is also the case with the other multi-PHY
> drivers...

IIRC, in the case of other existing multi-phy drivers, all the PHYs can
co-exist without actually overriding anything that was configured previously.

Anyway it is a good point and it will indeed create problems in cases where the
PHY is mutually exclusive like in your case where a channel can be configured
for either EHCI or USB but not both. The other driver where this will be a
problem is also floating in the list [1].

[1] -> https://lkml.org/lkml/2014/6/30/324
> 
>>>> So ideally only two sub-nodes should be created for channel '0' and channel
>>>> '1'.
> 
>>>     Hm, but I need to perform a special PHY power up sequence for the USBHS PHY
>>> itself (corresponding to channel #0, selector #1).
> 
>>>> You can configure a channel to a particular mode by passing the mode in
>>>> PHY specifier
> 
>>>     I already have "#phy-cells" prop equal to 2.
> 
>>>> (The channel should be configured to a particualr mode in xlate).
> 
>>>     I have even considered using the of_xlate() method at first but then
>>> abandoned that idea for the phy_init() method...
> 
>> If you want to configure the PHY to a particular mode, xlate should be the best
>> place.
> 
>    I tried to move the code there from the init() method but then I realized
> that I need to prepare/enable the USBHS clock before writing to the UGCTRL2
> register and there's no place I can disable/unprepare this clock if I do the
> channel routing in the xlate() method. So no, I don't agree here.

enabling clock from init() seems correct to me. We need a better way to avoid
overriding the PHY to a particular mode.
> 
>>>> Btw I'm not sure if it is recommended to pass register mask values from dt.
> 
>>>     Neither am I. I did that because you requested the device tree
>>> representation for each of the sub-PHYs under that part of the driver which
>>> initialized the register masks, so that I thought that you wanted those masks
>>> to be represented in the device tree as well...
> 
>> No I didn't mean that. Maybe for now we can have a identifier in the sub-node
>> and select mask and value based on that.
> 
>    Sigh. Yes, having some sort of selecting property in the subnodes is the
> only way...
> 
>>> [...]
.
.
<snip>
.
.

>>>>> +struct rcar_gen2_phy_driver {
>>>>> +    void __iomem *base;
>>>>> +    struct clk *clk;
>>>>> +    spinlock_t lock;
>>>>> +    struct rcar_gen2_phy phys[NUM_USB_CHANNELS][2];
> 
>>>> This can be created dynamically based on the number of sub-nodes. In this case
> 
>    Did you mean that I'll need to use linked list here instead of an array?

Nope. I meant something like below.

struct rcar_gen2_phy_driver {
	.
	.
	struct rcar_gen2_phy **phys;
}

probe()
{
	<snip>
	int i = 0, channel_count;
	struct rcar_gen2_phy **phys;
	channel_count = of_get_child_count(np);
	phys = kzalloc(sizeof(*phys) * channel_count, GFP_KERNEL);
	for_each_child_of_node(dev->of_node, np) {
		struct rcar_gen2_phy *phy;
		.
		.
		phy = kzalloc(sizeof(*phy), GFP_KERNEL);
		.
		.
		phy->phy = devm_phy_create(dev, &rcar_gen2_phy_ops, NULL);
		phys[i++] = phy;
	}
	drv->phys = phys;
	<snip>
}

Then you can access 'phys' just like how you access an array.
> 
>>>     Hm, that sounds to me like another complication of the driver with no
>>> apparent win...
> 
>> dynamic allocation is in no way going to complicate the driver.
> 
>    Since when the dynamic data allocation is as simple as the statically
> allocated data? :-O
> 
>>>> it'll be only rcar_gen2_phy phys[2], one for each channel.
>>>> By this we need not hard code NUM_USB_CHANNELS.
> 
>>>     I don't quite understand what's up with hard-coding it -- this constant is
>>> dictated by the UGCTRL2 register layout anyway.
> 
>> right but you don't want to change the driver a whole lot when they change the
>> no of channels in the next version
> 
>    They have already done so: R8A7790 has 3 USB channels, R8A7791 has only 2.
> However, the number of controllable channels didn't change.

right.. that's where I'd like to have status = "disabled" for that channel in
your dt node.
> 
>> or they use a slightly modified version of
>> this IP in a different SoC. And finding the number of channels dynamically is
>> not complicated anyway IMO.
> 
>    Sorry, but what you're saying here just doesn't make sense to me. I'd need
> to modify the driver for the different number of the controllable channels in
> any case since the UGCTRL2 masks/values have to be hard coded in the driver as
> you said. If they were read from the device tree, that would have made sense
> but you seem to be against that...

R8A7790 has 3 USB channels and R8A7791 has only 2. So what should be the
NUM_CHANNELS in this driver? Modifying the driver _can_ be adding macros for
registers, bit masks etc.. and maybe appropriately modifying of_device data.

Cheers
Kishon
