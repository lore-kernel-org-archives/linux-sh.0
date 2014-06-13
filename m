From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 13 Jun 2014 18:08:23 +0000
Subject: Re: [PATCH v6 1/1] usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <539B3E17.6050607@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <539AEC8F.4030003@renesas.com> <20140613142525.GE8319@saruman.home>
In-Reply-To: <20140613142525.GE8319-HgARHv6XitL9zxVx7UNMDg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: balbi-l0cyMroinI0@public.gmane.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: "mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <mathias.nyman-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On 13/06/14 15:25, Felipe Balbi wrote:
> Hi,
> 
>> + +#define FIRMWARE_NAME		"r8a779x_usb3_v1.dlmem" 
>> +MODULE_FIRMWARE(FIRMWARE_NAME);

Where can we get this from, it would be nice to test this.

>> +/*** Register Offset ***/ +#define RCAR_USB3_INT_ENA	0x224	/* 
>> Interrupt Enable */ +#define RCAR_USB3_DL_CTRL	0x250	/* FW 
>> Download Control & Status */ +#define RCAR_USB3_FW_DATA0	0x258
>> /* FW Data0 */ + +#define RCAR_USB3_LCLK		0xa44	/* LCLK Select */
>>  +#define RCAR_USB3_CONF1		0xa48	/* USB3.0 Configuration1 */ 
>> +#define RCAR_USB3_CONF2		0xa5c	/* USB3.0 Configuration2 */ 
>> +#define RCAR_USB3_CONF3		0xaa8	/* USB3.0 Configuration3 */ 
>> +#define RCAR_USB3_RX_POL	0xab0	/* USB3.0 RX Polarity */
>> +#define RCAR_USB3_TX_POL	0xab8	/* USB3.0 TX Polarity */ + +/***
>> Register Settings ***/ +/* Interrupt Enable */ +#define 
>> RCAR_USB3_INT_XHC_ENA	0x00000001 +#define RCAR_USB3_INT_PME_ENA 
>> 0x00000002 +#define RCAR_USB3_INT_HSE_ENA	0x00000004 +#define 
>> RCAR_USB3_INT_ENA_VAL	(RCAR_USB3_INT_XHC_ENA | \ + 
>> RCAR_USB3_INT_PME_ENA | RCAR_USB3_INT_HSE_ENA) + +/* FW Download 
>> Control & Status */ +#define RCAR_USB3_DL_CTRL_ENABLE	0x00000001
>>  +#define RCAR_USB3_DL_CTRL_FW_SUCCESS	0x00000010 +#define 
>> RCAR_USB3_DL_CTRL_FW_SET_DATA0	0x00000100 + +/* LCLK Select */ 
>> +#define RCAR_USB3_LCLK_ENA_VAL	0x01030001 + +/* USB3.0 
>> Configuration */ +#define RCAR_USB3_CONF1_VAL	0x00030204
>> +#define RCAR_USB3_CONF2_VAL	0x00030300 +#define
>> RCAR_USB3_CONF3_VAL 0x13802007 + +/* USB3.0 Polarity */ +#define
>> RCAR_USB3_RX_POL_VAL BIT(21) +#define RCAR_USB3_TX_POL_VAL	BIT(4)
>> + +void xhci_rcar_start(struct usb_hcd *hcd) +{ +	u32 temp; + +
>> if (hcd->regs != NULL) { +		/* Interrupt Enable */ +		temp = 
>> readl(hcd->regs + RCAR_USB3_INT_ENA); +		temp |= 
>> RCAR_USB3_INT_ENA_VAL; +		writel(temp, hcd->regs + 
>> RCAR_USB3_INT_ENA); +		/* LCLK Select */ + 
>> writel(RCAR_USB3_LCLK_ENA_VAL, hcd->regs + RCAR_USB3_LCLK); +
>> /* USB3.0 Configuration */ +		writel(RCAR_USB3_CONF1_VAL,
>> hcd->regs + RCAR_USB3_CONF1); +		writel(RCAR_USB3_CONF2_VAL,
>> hcd->regs + RCAR_USB3_CONF2); +		writel(RCAR_USB3_CONF3_VAL,
>> hcd->regs + RCAR_USB3_CONF3); +		/* USB3.0 Polarity */ + 
>> writel(RCAR_USB3_RX_POL_VAL, hcd->regs + RCAR_USB3_RX_POL); + 
>> writel(RCAR_USB3_TX_POL_VAL, hcd->regs + RCAR_USB3_TX_POL); +	} 
>> +} + +static int xhci_rcar_download_firmware(struct device *dev, 
>> void __iomem *regs) +{ +	const struct firmware *fw; +	int
>> retval, index, j, time; +	int timeout = 10000; +	u32 data, val,
>> temp; + + /* request R-Car USB3.0 firmware */ +	retval = 
>> request_firmware(&fw, FIRMWARE_NAME, dev); +	if (retval) + return
>> retval; + +	/* download R-Car USB3.0 firmware */ +	temp = 
>> readl(regs + RCAR_USB3_DL_CTRL); +	temp |= 
>> RCAR_USB3_DL_CTRL_ENABLE; +	writel(temp, regs + 
>> RCAR_USB3_DL_CTRL); + +	for (index = 0; index < fw->size; index 
>> += 4) { +		/* to avoid reading beyond the end of the buffer */ + 
>> for (data = 0, j = 3; j >= 0; j--) { +			if ((j + index) < 
>> fw->size) +				data |= fw->data[index + j] << (8 * j); +		} + 
>> writel(data, regs + RCAR_USB3_FW_DATA0); +		temp = readl(regs + 
>> RCAR_USB3_DL_CTRL); +		temp |= RCAR_USB3_DL_CTRL_FW_SET_DATA0; + 
>> writel(temp, regs + RCAR_USB3_DL_CTRL); + +		for (time = 0; time 
>> < timeout; time++) { +			val = readl(regs + RCAR_USB3_DL_CTRL);
>> + if ((val & RCAR_USB3_DL_CTRL_FW_SET_DATA0) = 0) +				break; + 
>> udelay(1); +		} +		if (time = timeout) { +			retval = 
>> -ETIMEDOUT; +			break; +		} +	} + +	temp = readl(regs + 
>> RCAR_USB3_DL_CTRL); +	temp &= ~RCAR_USB3_DL_CTRL_ENABLE; + 
>> writel(temp, regs + RCAR_USB3_DL_CTRL); + +	for (time = 0; time
>> < timeout; time++) { +		val = readl(regs + RCAR_USB3_DL_CTRL); + 
>> if (val & RCAR_USB3_DL_CTRL_FW_SUCCESS) { +			retval = 0; + 
>> break; +		} +		udelay(1); +	} +	if (time = timeout) +		retval = 
>> -ETIMEDOUT; + +	release_firmware(fw); + +	return retval; +} +
>> +/* This function needs to initialize a "phy" of usb before */
> 
> initializing a PHY looks like something that the PHY layer should 
> do. Why don't you write a PHY driver and teach xhci-core about
> PHYs ? Then, more people would benefit.

The rcar phy code should already do this, so I agree.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
