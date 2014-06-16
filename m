From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 16 Jun 2014 12:19:35 +0000
Subject: Re: [PATCH v6 1/1] usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <539EE0D7.8000103@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <539AEC8F.4030003@renesas.com> <20140613142525.GE8319@saruman.home> <539B3E17.6050607@codethink.co.uk>
In-Reply-To: <539B3E17.6050607@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: "balbi@ti.com" <balbi@ti.com>, "mathias.nyman@intel.com" <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi,

(2014/06/14 3:08), Ben Dooks wrote:
> On 13/06/14 15:25, Felipe Balbi wrote:
>> Hi,
>>
>>> + +#define FIRMWARE_NAME		"r8a779x_usb3_v1.dlmem" 
>>> +MODULE_FIRMWARE(FIRMWARE_NAME);
> 
> Where can we get this from, it would be nice to test this.

I am submitting the firmware to upstream. It is not merged to linux-firmware.git yet,
but you can get it from the marc.info / linux-usb ML:
http://marc.info/?l=linux-usb&m0263419006318&w=2

>>> +/*** Register Offset ***/ +#define RCAR_USB3_INT_ENA	0x224	/* 
>>> Interrupt Enable */ +#define RCAR_USB3_DL_CTRL	0x250	/* FW 
>>> Download Control & Status */ +#define RCAR_USB3_FW_DATA0	0x258
>>> /* FW Data0 */ + +#define RCAR_USB3_LCLK		0xa44	/* LCLK Select */
>>>  +#define RCAR_USB3_CONF1		0xa48	/* USB3.0 Configuration1 */ 
>>> +#define RCAR_USB3_CONF2		0xa5c	/* USB3.0 Configuration2 */ 
>>> +#define RCAR_USB3_CONF3		0xaa8	/* USB3.0 Configuration3 */ 
>>> +#define RCAR_USB3_RX_POL	0xab0	/* USB3.0 RX Polarity */
>>> +#define RCAR_USB3_TX_POL	0xab8	/* USB3.0 TX Polarity */ + +/***
>>> Register Settings ***/ +/* Interrupt Enable */ +#define 
>>> RCAR_USB3_INT_XHC_ENA	0x00000001 +#define RCAR_USB3_INT_PME_ENA 
>>> 0x00000002 +#define RCAR_USB3_INT_HSE_ENA	0x00000004 +#define 
>>> RCAR_USB3_INT_ENA_VAL	(RCAR_USB3_INT_XHC_ENA | \ + 
>>> RCAR_USB3_INT_PME_ENA | RCAR_USB3_INT_HSE_ENA) + +/* FW Download 
>>> Control & Status */ +#define RCAR_USB3_DL_CTRL_ENABLE	0x00000001
>>>  +#define RCAR_USB3_DL_CTRL_FW_SUCCESS	0x00000010 +#define 
>>> RCAR_USB3_DL_CTRL_FW_SET_DATA0	0x00000100 + +/* LCLK Select */ 
>>> +#define RCAR_USB3_LCLK_ENA_VAL	0x01030001 + +/* USB3.0 
>>> Configuration */ +#define RCAR_USB3_CONF1_VAL	0x00030204
>>> +#define RCAR_USB3_CONF2_VAL	0x00030300 +#define
>>> RCAR_USB3_CONF3_VAL 0x13802007 + +/* USB3.0 Polarity */ +#define
>>> RCAR_USB3_RX_POL_VAL BIT(21) +#define RCAR_USB3_TX_POL_VAL	BIT(4)
>>> + +void xhci_rcar_start(struct usb_hcd *hcd) +{ +	u32 temp; + +
>>> if (hcd->regs != NULL) { +		/* Interrupt Enable */ +		temp = 
>>> readl(hcd->regs + RCAR_USB3_INT_ENA); +		temp |= 
>>> RCAR_USB3_INT_ENA_VAL; +		writel(temp, hcd->regs + 
>>> RCAR_USB3_INT_ENA); +		/* LCLK Select */ + 
>>> writel(RCAR_USB3_LCLK_ENA_VAL, hcd->regs + RCAR_USB3_LCLK); +
>>> /* USB3.0 Configuration */ +		writel(RCAR_USB3_CONF1_VAL,
>>> hcd->regs + RCAR_USB3_CONF1); +		writel(RCAR_USB3_CONF2_VAL,
>>> hcd->regs + RCAR_USB3_CONF2); +		writel(RCAR_USB3_CONF3_VAL,
>>> hcd->regs + RCAR_USB3_CONF3); +		/* USB3.0 Polarity */ + 
>>> writel(RCAR_USB3_RX_POL_VAL, hcd->regs + RCAR_USB3_RX_POL); + 
>>> writel(RCAR_USB3_TX_POL_VAL, hcd->regs + RCAR_USB3_TX_POL); +	} 
>>> +} + +static int xhci_rcar_download_firmware(struct device *dev, 
>>> void __iomem *regs) +{ +	const struct firmware *fw; +	int
>>> retval, index, j, time; +	int timeout = 10000; +	u32 data, val,
>>> temp; + + /* request R-Car USB3.0 firmware */ +	retval = 
>>> request_firmware(&fw, FIRMWARE_NAME, dev); +	if (retval) + return
>>> retval; + +	/* download R-Car USB3.0 firmware */ +	temp = 
>>> readl(regs + RCAR_USB3_DL_CTRL); +	temp |= 
>>> RCAR_USB3_DL_CTRL_ENABLE; +	writel(temp, regs + 
>>> RCAR_USB3_DL_CTRL); + +	for (index = 0; index < fw->size; index 
>>> += 4) { +		/* to avoid reading beyond the end of the buffer */ + 
>>> for (data = 0, j = 3; j >= 0; j--) { +			if ((j + index) < 
>>> fw->size) +				data |= fw->data[index + j] << (8 * j); +		} + 
>>> writel(data, regs + RCAR_USB3_FW_DATA0); +		temp = readl(regs + 
>>> RCAR_USB3_DL_CTRL); +		temp |= RCAR_USB3_DL_CTRL_FW_SET_DATA0; + 
>>> writel(temp, regs + RCAR_USB3_DL_CTRL); + +		for (time = 0; time 
>>> < timeout; time++) { +			val = readl(regs + RCAR_USB3_DL_CTRL);
>>> + if ((val & RCAR_USB3_DL_CTRL_FW_SET_DATA0) = 0) +				break; + 
>>> udelay(1); +		} +		if (time = timeout) { +			retval = 
>>> -ETIMEDOUT; +			break; +		} +	} + +	temp = readl(regs + 
>>> RCAR_USB3_DL_CTRL); +	temp &= ~RCAR_USB3_DL_CTRL_ENABLE; + 
>>> writel(temp, regs + RCAR_USB3_DL_CTRL); + +	for (time = 0; time
>>> < timeout; time++) { +		val = readl(regs + RCAR_USB3_DL_CTRL); + 
>>> if (val & RCAR_USB3_DL_CTRL_FW_SUCCESS) { +			retval = 0; + 
>>> break; +		} +		udelay(1); +	} +	if (time = timeout) +		retval = 
>>> -ETIMEDOUT; + +	release_firmware(fw); + +	return retval; +} +
>>> +/* This function needs to initialize a "phy" of usb before */
>>
>> initializing a PHY looks like something that the PHY layer should 
>> do. Why don't you write a PHY driver and teach xhci-core about
>> PHYs ? Then, more people would benefit.
> 
> The rcar phy code should already do this, so I agree.
> 

I wrote my comment to Balbi.

Best regards,
Yoshihiro Shimoda
