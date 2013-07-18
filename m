From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 18 Jul 2013 20:28:29 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7740: Fix ethernet device name in clock definition
Message-Id: <51E84FED.8060203@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1373966374-15716-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1373966374-15716-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 07/17/2013 06:48 PM, Laurent Pinchart wrote:

>>>>>>>>>> The ethernet device is named r8a7740-gether, fix the clock
>>>>>>>>>> definition
>>>>>>>>>> accordingly.

>>>>>>>>>> Signed-off-by: Laurent Pinchart
>>>>>>>>>> <laurent.pinchart+renesas@ideasonboard.com>
>>>>>>>>>> ---

>>>>>>>>>>       arch/arm/mach-shmobile/clock-r8a7740.c | 2 +-
>>>>>>>>>>       1 file changed, 1 insertion(+), 1 deletion(-)

>>>>>>>>>> diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c
>>>>>>>>>> b/arch/arm/mach-shmobile/clock-r8a7740.c
>>>>>>>>>> index de10fd7..e1e8710 100644
>>>>>>>>>> --- a/arch/arm/mach-shmobile/clock-r8a7740.c
>>>>>>>>>> +++ b/arch/arm/mach-shmobile/clock-r8a7740.c
>>>>>>>>>> @@ -595,7 +595,7 @@ static struct clk_lookup lookups[] = {
>>>>>>>>>>
>>>>>>>>>>           CLKDEV_DEV_ID("sh_mmcif",        &mstp_clks[MSTP312]),
>>>>>>>>>>           CLKDEV_DEV_ID("e6bd0000.mmcif",
>>>>>>>>>>           &mstp_clks[MSTP312]),
>>>>>>>>>>           CLKDEV_DEV_ID("r8a7740-gether",
>>>>>>>>>>           &mstp_clks[MSTP309]),
>>>>>>>>>>
>>>>>>>>>> -    CLKDEV_DEV_ID("e9a00000.sh-eth",    &mstp_clks[MSTP309]),
>>>>>>>>>> +    CLKDEV_DEV_ID("e9a00000.r8a7740-gether", &mstp_clks[MSTP309]),

>>>>>>>>> Al Ethernet devices should be named "ethernet", according to ePAPR
>>>>>>>>> spec.

>>>>>>>> BTW, I'm not seeing a patch to r8a7740.dtsi, describing this device.

>>>>>>> Let's delay this patch until the device gets added to r8a7740.dtsi
>>>>>>> then.

>>>>>> I don't see a use for this line even then. sh-eth.c can't be converted
>>>>>> to device tree due to procedural platform data, so I'm planning to use
>>>>>> OF_DEV_AUXDATA() for it which doesn't require defining an extra clock.

>>>>> The usage of OF_DEV_AUXDATA() is discouraged. A quick grep shows that
>>>>> the only

>>>> We have the case where it's the only resort. And the other platforms use
>>>> it quite often, even if only to support [devm_]clk_get() in the drivers.

>>>>> board code callback in sh_eth_plat_data (.set_mdio_gate) isn't used on
>>>>> ARM platforms, so the driver should support pure DT bindings without
>>>>> auxiliary data.

>>>> Maybe it isn't used on ARM but it exists. IMO that's enough reason not to
>>>> convert the platform data to the DT properties.

>>> I don't agree. The proper fix would be to fix the SuperH platform that
>>> uses that callback (there's one only) to replace the callback function
>>> with a proper kernel framework.

>> At least suggest such framework first.

> I would first need to understand what the board code implementes in the
> set_mdio_gate() callback. The callback is used by the SH7757LCR board only, do
> you have access to the board schematics and SH7757 datasheet ?

    No, only for SH7751 manual by coincidence. This SoC doesn't have Ether.
Maybe the original commit (sh: add GETHER's platform_device in 
board-sh7757lcr) author, Shimoda-san, could help us here? I've CC'ed him.

>>> As arch/sh/ has seen very little activity lately I don't think that will
>>> happen soon,

>> I can take this in my own hands, if you get any ideas.

> That would be great.

    We have an obligation to convert sh_eth to DT anyway.

>>> so we'll need to keep support for the .set_mdio_gate() callback in the sh-
>>> eth driver, but new platforms should not use it, and it shouldn't be a
>>> reason not to implement proper DT bindings.

>> What if they have to use it again?

> Then we'll need to use a proper abstraction in the kernel, and possibly create
> one if none exists. We've created many abstractions layers in the past (GPIO,
> regulators, CCF, ...) to get rid of platform callbacks, a new one can be added
> if needed.

    I'd like to share your optimism here...

>> Besides, it's not the only obstacle on this way: the platform data includes
>> some fields which should really be inside the driver's data structures, as
>> they're SoC, not board specific...

> Those should then be moved to the sh_eth_cpu_data structure, referenced from
> the data field of both the struct platform_device_id and struct of_device_id
> arrays.

    Yes.
    The problem is some old arch/sh/ SoCs have platform code inadequate to the 
modern state of the sh_eth platform data, e.g. they pass the PHY address as 
the platform data pointer (!). We should either fix them first (or maybe 
remove their support, as the Renesas management suggested).

WBR, Sergei

