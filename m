From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 25 Jun 2014 22:16:40 +0000
Subject: Re: [PATCH v4] phy: Renesas R-Car Gen2 PHY driver
Message-Id: <53AB4A48.5030805@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201405240206.04700.sergei.shtylyov@cogentembedded.com> <538F05BC.7000800@ti.com> <538F95A7.8010409@cogentembedded.com> <5396E160.7000707@ti.com>
In-Reply-To: <5396E160.7000707@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kishon Vijay Abraham I <kishon@ti.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, grant.likely@linaro.org, devicetree@vger.kernel.org
Cc: rdunlap@infradead.org, linux-doc@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 06/10/2014 02:43 PM, Kishon Vijay Abraham I wrote:

    Sorry for delayed reply, I was busy with other things. Now it's time to 
revisit the infamous USB PHY driver...

>>>> This PHY, though formally being a part of Renesas USBHS controller, contains
>>>> the
>>>> UGCTRL2 register that controls multiplexing of the USB ports (Renesas calls
>>>> them
>>>> channels) to the different USB controllers: channel 0 can be connected to
>>>> either
>>>> PCI EHCI/OHCI or USBHS controllers, channel 2 can be connected to PCI EHCI/OHCI
>>>> or xHCI controllers.

>>>> This is a new driver for this USB PHY currently already supported under
>>>> drivers/
>>>> usb/phy/. The reason for writing the new driver was the requirement that the
>>>> multiplexing of USB channels to the controller be dynamic, depending on what
>>>> USB drivers are loaded,  rather than static as provided by the old driver.
>>>> The infrastructure provided by drivers/phy/phy-core.c seems to fit that purpose
>>>> ideally. The new driver only supports device tree probing for now.

>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> [...]

>>>> Index: linux-phy/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
>>>> =================================>>>> --- /dev/null
>>>> +++ linux-phy/Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt
>>>> @@ -0,0 +1,60 @@
>>>> +* Renesas R-Car generation 2 USB PHY
>>>> +
>>>> +This file provides information on what the device node for the R-Car
>>>> generation
>>>> +2 USB PHY contains.
>>>> +
>>>> +Required properties:
>>>> +- compatible: "renesas,usb-phy-r8a7790" if the device is a part of R8A7790
>>>> SoC.
>>>> +          "renesas,usb-phy-r8a7791" if the device is a part of R8A7791 SoC.
>>>> +- reg: offset and length of the register block.
>>>> +- #phy-cells: see phy-bindings.txt in the same directory, must be 2.
>>>> +- clocks: clock phandle and specifier pair.
>>>> +- clock-names: string, clock input name, must be "usbhs".
>>>> +
>>>> +The phandle's first argument in the PHY specifier identifies the USB channel,
>>>> +the second one is the USB controller selector and depends on the first:
>>>> +
>>>> ++-----------+---------------+---------------+
>>>> +|\ Selector |               |               |
>>>> ++ --------- +       0       |       1       |
>>>> +| Channel  \|               |               |
>>>> ++-----------+---------------+---------------+
>>>> +| 0         | PCI EHCI/OHCI | HS-USB        |
>>>> +| 1         | PCI EHCI/OHCI | xHCI          |
>>>> ++-----------+---------------+---------------+
>>>> +
>>>> +The USB PHY device tree node should be the subnodes corresponding to the USB
>>>> +channels and the controllers connected to them. These subnodes must contain
>>>> the
>>>> +following properties:
>>>> +- renesas,phy-select: the first cell identifies the USB channel, the second
>>>> cell
>>>> +  is the USB controller selector; see the table above for the values.
>>>> +- renesas,ugctrl2-masks: the first cell is the UGCTRL2 mask corresponding to
>>>> +  the USB channel, the second cell is the UGCTRL2 value corresponding to the
>>>> +  USB controller selected for that channel.
>>>> +
>>>> +Example (Lager board):
>>>> +
>>>> +    usb-phy@e6590100 {
>>>> +        compatible = "renesas,usb-phy-r8a7790";
>>>> +        reg = <0 0xe6590100 0 0x100>;
>>>> +        #phy-cells = <2>;
>>>> +        clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
>>>> +        clock-names = "usbhs";
>>>> +
>>>> +        usb-phy@0,0 {
>>>> +            renesas,phy-select = <0 0>;
>>>> +            renesas,ugctrl2-masks = <0x00000030 0x00000010>;
>>>> +        };
>>>> +        usb-phy@0,1 {
>>>> +            renesas,phy-select = <0 1>;
>>>> +            renesas,ugctrl2-masks = <0x00000030 0x00000030>;
>>>> +        };
>>>> +        usb-phy@1,0 {
>>>> +            renesas,phy-select = <1 0>;
>>>> +            renesas,ugctrl2-masks = <0x80000000 0x00000000>;
>>>> +        };
>>>> +        usb-phy@1,1 {
>>>> +            renesas,phy-select = <1 1>;
>>>> +            renesas,ugctrl2-masks = <0x80000000 0x80000000>;
>>>> +        };
>>>> +    };

>>> IIUC, channel 0 can be configured for either EHCI/OHCI or HS-USB but can't be
>>> used for both.  And channel 1 can be configured for either PCI EHCI/OHCI or
>>> xHCI. right?

>>     Yes. However that depends on the driver load order: if e.g. xHCI driver is
>> loaded later than PCI USB drivers,
>> it will override the channel routing.

> So will the PCI USB drivers will be notified of that?

    Unfortunately, no. But this is also the case with the other multi-PHY 
drivers...

>>> So ideally only two sub-nodes should be created for channel '0' and channel
>>> '1'.

>>     Hm, but I need to perform a special PHY power up sequence for the USBHS PHY
>> itself (corresponding to channel #0, selector #1).

>>> You can configure a channel to a particular mode by passing the mode in
>>> PHY specifier

>>     I already have "#phy-cells" prop equal to 2.

>>> (The channel should be configured to a particualr mode in xlate).

>>     I have even considered using the of_xlate() method at first but then
>> abandoned that idea for the phy_init() method...

> If you want to configure the PHY to a particular mode, xlate should be the best
> place.

    I tried to move the code there from the init() method but then I realized 
that I need to prepare/enable the USBHS clock before writing to the UGCTRL2 
register and there's no place I can disable/unprepare this clock if I do the 
channel routing in the xlate() method. So no, I don't agree here.

>>> Btw I'm not sure if it is recommended to pass register mask values from dt.

>>     Neither am I. I did that because you requested the device tree
>> representation for each of the sub-PHYs under that part of the driver which
>> initialized the register masks, so that I thought that you wanted those masks
>> to be represented in the device tree as well...

> No I didn't mean that. Maybe for now we can have a identifier in the sub-node
> and select mask and value based on that.

    Sigh. Yes, having some sort of selecting property in the subnodes is the 
only way...

>> [...]
>>>> Index: linux-phy/drivers/phy/phy-rcar-gen2.c
>>>> =================================>>>> --- /dev/null
>>>> +++ linux-phy/drivers/phy/phy-rcar-gen2.c
>>>> @@ -0,0 +1,288 @@
>> [...]
>>>> +#define USBHS_LPSTS            0x02
>>>> +#define USBHS_UGCTRL            0x80
>>>> +#define USBHS_UGCTRL2            0x84
>>>> +#define USBHS_UGSTS            0x88
>>>> +
>>>> +/* Low Power Status register (LPSTS) */
>>>> +#define USBHS_LPSTS_SUSPM        0x4000
>>>> +
>>>> +/* USB General control register (UGCTRL) */
>>>> +#define USBHS_UGCTRL_CONNECT        0x00000004
>>>> +#define USBHS_UGCTRL_PLLRESET        0x00000001
>>>> +
>>>> +/* USB General control register 2 (UGCTRL2) */
>>>> +#define USBHS_UGCTRL2_USB2SEL        0x80000000
>>>> +#define USBHS_UGCTRL2_USB2SEL_PCI    0x00000000
>>>> +#define USBHS_UGCTRL2_USB2SEL_USB30    0x80000000
>>>> +#define USBHS_UGCTRL2_USB0SEL        0x00000030
>>>> +#define USBHS_UGCTRL2_USB0SEL_PCI    0x00000010
>>>> +#define USBHS_UGCTRL2_USB0SEL_HS_USB    0x00000030
>>>> +
>>>> +/* USB General status register (UGSTS) */
>>>> +#define USBHS_UGSTS_LOCK        0x00000300
>>>> +
>>>> +#define    NUM_USB_CHANNELS    2
>>>> +
>>>> +struct rcar_gen2_phy {
>>>> +    struct phy *phy;
>>>> +    struct rcar_gen2_phy_driver *drv;
>>>> +    u32 select_mask;
>>>> +    u32 select_value;
>>>> +};
>>>> +
>>>> +struct rcar_gen2_phy_driver {
>>>> +    void __iomem *base;
>>>> +    struct clk *clk;
>>>> +    spinlock_t lock;
>>>> +    struct rcar_gen2_phy phys[NUM_USB_CHANNELS][2];

>>> This can be created dynamically based on the number of sub-nodes. In this case

    Did you mean that I'll need to use linked list here instead of an array?

>>     Hm, that sounds to me like another complication of the driver with no
>> apparent win...

> dynamic allocation is in no way going to complicate the driver.

    Since when the dynamic data allocation is as simple as the statically 
allocated data? :-O

>>> it'll be only rcar_gen2_phy phys[2], one for each channel.
>>> By this we need not hard code NUM_USB_CHANNELS.

>>     I don't quite understand what's up with hard-coding it -- this constant is
>> dictated by the UGCTRL2 register layout anyway.

> right but you don't want to change the driver a whole lot when they change the
> no of channels in the next version

    They have already done so: R8A7790 has 3 USB channels, R8A7791 has only 2.
However, the number of controllable channels didn't change.

> or they use a slightly modified version of
> this IP in a different SoC. And finding the number of channels dynamically is
> not complicated anyway IMO.

    Sorry, but what you're saying here just doesn't make sense to me. I'd need 
to modify the driver for the different number of the controllable channels in 
any case since the UGCTRL2 masks/values have to be hard coded in the driver as 
you said. If they were read from the device tree, that would have made sense 
but you seem to be against that...

> Thanks
> Kishon

WBR, Sergei

