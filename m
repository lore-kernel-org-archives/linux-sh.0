From: Rob Herring <robh@kernel.org>
Date: Mon, 21 Sep 2015 14:01:22 +0000
Subject: Re: [PATCH] phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver
Message-Id: <56000DB2.5010004@kernel.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1440493835-6732-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <55FBAA4D.3000704@ti.com>
In-Reply-To: <55FBAA4D.3000704@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On 09/18/2015 01:08 AM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On Tuesday 25 August 2015 02:40 PM, Yoshihiro Shimoda wrote:
>> This patch adds support for R-Car generation 3 USB2 PHY driver.
>> This SoC has 3 EHCI/OHCI channels, and the channel 0 is shared
>> with the HSUSB (USB2.0 peripheral) device.
> 
> From the description it looks like it's a single PHY with multiple
> channels. In that case you should have a singe dt node for the PHY
> provider and each channel should be modelled as the child node of the
> PHY provider dt node.

You only need sub-nodes if you need per channel properties. Otherwise,
#phy-cells can be 1 and the cell value can be the channel number.

>>
>> So, the purpose of this driver is:
>>  1) initializes some registers of SoC specific to use the
>>     {ehci,ohci}-platform driver.
>>
>>  2) detects id pin to select host or peripheral on the channel 0.
>>
>> For now, this driver only supports 1) above.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>>  This patch is based on the latest linux-phy / next branch.
>>  (commit id = cfd093bbb5fe84ec8c7bb069fe618159a8b601f5)
>>
>>  Changes from v1:
>>   - Revise some typos.
>>   - Remove using clk API to enable/disable the clocks.
>>     (In other words, this driver expects to enable/disable the clocks by
>>      Runtime PM API by the phy-core driver.)
>>   - Remove an unnecessary header file (asm/cmpxchg.h).
>>
>>  .../devicetree/bindings/phy/rcar-gen3-phy-usb2.txt |  35 +++
>>  drivers/phy/Kconfig                                |   6 +
>>  drivers/phy/Makefile                               |   1 +
>>  drivers/phy/phy-rcar-gen3-usb2.c                   | 240 +++++++++++++++++++++
>>  4 files changed, 282 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
>>  create mode 100644 drivers/phy/phy-rcar-gen3-usb2.c
>>
>> diff --git a/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
>> new file mode 100644
>> index 0000000..1d57766
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
>> @@ -0,0 +1,35 @@
>> +* Renesas R-Car generation 3 USB 2.0 PHY
>> +
>> +This file provides information on what the device node for the R-Car generation
>> +3 USB 2.0 PHY contains.
>> +
>> +Required properties:
>> +- compatible: "renesas,usb2-phy-r8a7795" if the device is a part of an R8A7795
>> +	      SoC.
>> +- reg: offset and length of the USB2.0 host register block.

host register block? You mean phy register block?

>> +- reg-names: must be "usb2".
>> +- clocks: clock phandle and specifier pair(s).
>> +- #phy-cells: see phy-bindings.txt in the same directory, must be <0>.
>> +
>> +Optional properties:
>> +To use a USB channel where EHCI/OHCI and HSUSB are combined, the device tree
>> +node should set HSUSB properties to reg and reg-names properties:
>> +- reg: offset and length of the HSUSB register block.
>> +- reg-names: must be "hsusb".
>> +
>> +Example (R-Car H3):
>> +
>> +	usb-phy@ee080200 {
>> +		compatible = "renesas,usb2-phy-r8a7795";
>> +		reg = <0 0xee080200 0 0x6ff>, <0 0xe6590100 0 0x100>;
>> +		reg-names = "usb2", "hsusb";
> 
> hsusb is missing in Documentation.

usb2 is the host controller? It is questionable that these should be
combined. Does this appear under another node? If so, don't overlap
resources in the DT.

>> +		clocks = <&mstp7_clks R8A7795_CLK_EHCI0>,
>> +			 <&mstp7_clks R8A7795_CLK_HSUSB>;
>> +	};
>> +
>> +	usb-phy@ee0a0200 {
>> +		compatible = "renesas,usb2-phy-r8a7795";
>> +		reg = <0 0xee0a0200 0 0x6ff>;
>> +		reg-names = "usb2";
>> +		clocks = <&mstp7_clks R8A7795_CLK_EHCI0>;
>> +	};
>> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
>> index 0fe9bff..406dc43 100644
>> --- a/drivers/phy/Kconfig
>> +++ b/drivers/phy/Kconfig
>> @@ -116,6 +116,12 @@ config PHY_RCAR_GEN2
>>  	help
>>  	  Support for USB PHY found on Renesas R-Car generation 2 SoCs.
>>  
>> +config PHY_RCAR_GEN3_USB2
>> +	tristate "Renesas R-Car generation 3 USB 2.0 PHY driver"
>> +	depends on GENERIC_PHY
> 
> depends on OF?
> 
> Thanks
> Kishon
> 

