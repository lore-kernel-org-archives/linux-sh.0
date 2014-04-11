From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 11 Apr 2014 12:10:28 +0000
Subject: Re: [PATCH v2] phy: Renesas R-Car Gen2 PHY driver
Message-Id: <5347DBB4.3070401@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201404090144.26769.sergei.shtylyov@cogentembedded.com> <53466C07.4080409@ti.com> <5346F6B6.8000901@cogentembedded.com>
In-Reply-To: <5346F6B6.8000901@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kishon Vijay Abraham I <kishon@ti.com>, devicetree@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-sh@vger.kernel.org, magnus.damm@gmail.com, linux-doc@vger.kernel.org, rdunlap@infradead.org, grant.likely@linaro.org

Hello.

On 10-04-2014 23:53, Sergei Shtylyov wrote:

>> On Wednesday 09 April 2014 03:14 AM, Sergei Shtylyov wrote:
>>> This PHY, though formally being a part of Renesas USBHS controller,
>>> contains the
>>> UGCTRL2 register that controls multiplexing of the USB ports (Renesas calls
>>> them
>>> channels) to the different USB controllers: channel 0 can be connected to
>>> either
>>> PCI EHCI/OHCI or USBHS controllers, channel 2 can be connected to PCI
>>> EHCI/OHCI
>>> or xHCI controllers.

>>> This is a new driver for this USB PHY currently already supported under
>>> drivers/
>>> usb/phy/. The reason for writing the new driver was the requirement that the
>>> multiplexing of USB channels to the controller be dynamic, depending on what
>>> USB drivers are loaded,  rather than static as provided by the old driver.

[...]

>>> The infrastructure provided by drivers/phy/phy-core.c seems to fit that
>>> purpose
>>> ideally. The new driver only supports device tree probing for now.

>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]

>>> Index: linux-phy/drivers/phy/phy-rcar-gen2.c
>>> =================================>>> --- /dev/null
>>> +++ linux-phy/drivers/phy/phy-rcar-gen2.c
>>> @@ -0,0 +1,287 @@

[...]

>>> +static struct phy_ops rcar_gen2_phy_ops = {
>>> +    .init        = rcar_gen2_phy_init,
>>> +    .exit        = rcar_gen2_phy_exit,
>>> +    .owner        = THIS_MODULE,
>>> +};
>>> +
>>> +static struct phy_ops rcar_gen2_usbhs_phy_ops = {
>>> +    .init        = rcar_gen2_phy_init,
>>> +    .exit        = rcar_gen2_phy_exit,
>>> +    .power_on    = rcar_gen2_usbhs_phy_power_on,
>>> +    .power_off    = rcar_gen2_usbhs_phy_power_off,
>>> +    .owner        = THIS_MODULE,
>>> +};

>> Let's not create multiple phy_ops for a single driver.

>     Unfortunately, I have to because not all PHYs are equal.

    OK, actually I can do without extra 'struct phy_ops'. I just figured that 
out a bit late...

WBR, Sergei

