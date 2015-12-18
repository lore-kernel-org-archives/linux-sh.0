From: Chanwoo Choi <cw00.choi@samsung.com>
Date: Fri, 18 Dec 2015 01:14:37 +0000
Subject: Re: [PATCH v4] extcon: add Maxim MAX3355 driver
Message-Id: <56735DFD.1070608@samsung.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1767472.2Rx4LOCrWY@wasted.cogentembedded.com>
In-Reply-To: <1767472.2Rx4LOCrWY@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, myungjoo.ham@samsung.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, linux-usb@vger.kernel.org

Hi Sergei,

Except for just one comment below, Looks good to me.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

I'll wait for a few days to get the review from DT maintainer
before applying it on extcon-next branch.

On 2015년 12월 18일 07:47, Sergei Shtylyov wrote:
> Maxim Integrated MAX3355E chip integrates a charge pump and comparators to
> enable a system with an integrated USB OTG dual-role transceiver to
> function as an USB OTG dual-role device. In addition to sensing/controlling
> Vbus, the chip also passes thru the ID signal from the USB OTG connector.
> On some Renesas boards, this signal is just fed into the SoC thru a GPIO
> pin -- there's no real OTG controller, only host and gadget USB controllers
> sharing the same USB bus; however, we'd like to allow host or gadget
> drivers to be loaded depending on the cable type, hence the need for the
> MAX3355 extcon driver. The Vbus status signals are also wired to GPIOs
> (however, we aren't currently interested in them), the OFFVBUS# signal is
> controlled by the host controllers, there's also the SHDN# signal wired to
> a GPIO, it should be driven high for the normal operation.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against the 'extcon-next' branch of the 'extcon.git' repo.
> 
> Changes in version 4:
> - stopped calling kstrdup() for the device name;
> - removed unneeded 'owner' field initializer;
> - moved devm_extcon_allocate() call further down in the probe() method;
> - extended the driver copyright;
> - indented the continuation lines in the binding document.
> 
> Changes in version 3:
> - reformatted the change log.
> 
> Changes in version 2:
> - added the USB gadget cable support;
> - added the remove() driver method which drives SHDN# GPIO low to save power;
> - dropped vendor prefix from the ID GPIO property name;
> - changed the GPIO property name suffix to "-gpios";
> - switched to usign extcon_set_cable_state_() API;
> - switched to using the gpiod/sleeping 'gpiolib' APIs;
> - addded error messages to max3355_probe();
> - added IRQF_NO_SUSPEND flasg to the devm_request_threaded_irq() call;
> - renamed 'ret' variable to 'err' in max3355_probe();
> - expanded the Kconfig entry help text;
> - added vendor name to the patch summary, the bindings document, the Kconfig
>   entry, the driver heading comment, the module description, and the change log;
> - fixed up and reformatted the change log.
> 
>  Documentation/devicetree/bindings/extcon/extcon-max3355.txt |   21 +
>  drivers/extcon/Kconfig                                      |    8 
>  drivers/extcon/Makefile                                     |    1 
>  drivers/extcon/extcon-max3355.c                             |  151 ++++++++++++
>  4 files changed, 181 insertions(+)
> 
> Index: extcon/Documentation/devicetree/bindings/extcon/extcon-max3355.txt
> =================================> --- /dev/null
> +++ extcon/Documentation/devicetree/bindings/extcon/extcon-max3355.txt
> @@ -0,0 +1,21 @@
> +Maxim Integrated MAX3355 USB OTG chip
> +-------------------------------------
> +
> +MAX3355 integrates a charge pump and comparators to enable a system with an
> +integrated USB OTG dual-role transceiver to function as a USB OTG dual-role
> +device.
> +
> +Required properties:
> +- compatible: should be "maxim,max3355";
> +- maxim,shdn-gpios: should contain a phandle and GPIO specifier for the GPIO pin
> +		    connected to the MAX3355's SHDN# pin;
> +- id-gpios: should contain a phandle and GPIO specifier for the GPIO pin
> +	    connected to the MAX3355's ID_OUT pin.
> +
> +Example (Koelsch board):

You mean that "koelsch" board might be arch/arm/boot/dts/r8a7791-koelsch.dts.
But, the max3355 dt node isn't really included in r8a7791-koelsch.dts.

I recommend that you add the accurate information because the wrong
info causes the confusion. So, I'd like you to change it as following:

	"Example (Koelsch board):" -> "Example:"

After adding the max3355 dt node to Koelsch board on separate patch,
you modify this documentation for real usage case of max3355 dt node.

> +
> +	usb-otg {
> +		compatible = "maxim,max3355";
> +		maxim,shdn-gpios = <&gpio2 4 GPIO_ACTIVE_LOW>;
> +		id-gpios = <&gpio5 31 GPIO_ACTIVE_HIGH>;
> +	};
> Index: extcon/drivers/extcon/Kconfig
> =================================> --- extcon.orig/drivers/extcon/Kconfig
> +++ extcon/drivers/extcon/Kconfig
> @@ -52,6 +52,14 @@ config EXTCON_MAX14577
>  	  Maxim MAX14577/77836. The MAX14577/77836 MUIC is a USB port accessory
>  	  detector and switch.

[snip]

Thanks,
Chanwoo Choi

