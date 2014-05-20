From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 20 May 2014 09:35:27 +0000
Subject: Re: [PATCH 2/3] usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <537B21DF.4000202@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5379D805.3070002@renesas.com> <5379F5BC.6010204@cogentembedded.com>
In-Reply-To: <5379F5BC.6010204@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "mathias.nyman@intel.com" <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hello,

(2014/05/19 21:14), Sergei Shtylyov wrote:
> Hello.
> 
> On 19-05-2014 14:08, Yoshihiro Shimoda wrote:
< snip >
>>   static int xhci_plat_start(struct usb_hcd *hcd)
>>   {
>> +	struct device_node *of_node = hcd->self.controller->of_node;
>> +
>> +	if (of_device_is_compatible(of_node, "renesas,r8a7790-xhci") ||
>> +	    of_device_is_compatible(of_node, "renesas,r8a7790-xhci"))
> 
>     Perhaps "renesas,r8a7791-xhci"?

Yes. I will correct this.

< snip >
>> +/* FW Download Control & Status */
>> +#define RCAR_USB3_DL_CTRL		0x250
> 
>     Already #define'd.

Thank you for the point! I will remove this.

>> +/* USB3.0 Configuraion */
> 
>     Configuration.

I will correct this.

>> +int xhci_rcar_start(struct usb_hcd *hcd)
>> +{
>> +	if (hcd->regs != NULL) {
>> +		u32 temp;
> 
>     Need empty line here... and should perhaps return error if hcd->regs NULL?

I will add empty line.
If this function returns error and xhci_plat_start() also returns error,
the xhci driver was not able to work.
So, I will change the prototype of this function to "void".

Best regards,
Yoshihiro Shimoda

>> +		/* Interrupt Enable */
>> +		temp = readl(hcd->regs + RCAR_USB3_INT_ENA);
>> +		temp |= RCAR_USB3_INT_ENA_VAL;
>> +		writel(temp, hcd->regs + RCAR_USB3_INT_ENA);
>> +		/* LCLK Select */
>> +		writel(RCAR_USB3_LCLK_ENA_VAL, hcd->regs + RCAR_USB3_LCLK);
>> +		/* USB3.0 Configuration */
>> +		writel(RCAR_USB3_CONF1_VAL, hcd->regs + RCAR_USB3_CONF1);
>> +		writel(RCAR_USB3_CONF2_VAL, hcd->regs + RCAR_USB3_CONF2);
>> +		writel(RCAR_USB3_CONF3_VAL, hcd->regs + RCAR_USB3_CONF3);
>> +		/* USB3.0 Polariy */
>> +		writel(RCAR_USB3_RX_POL_VAL, hcd->regs + RCAR_USB3_RX_POL);
>> +		writel(RCAR_USB3_TX_POL_VAL, hcd->regs + RCAR_USB3_TX_POL);
>> +	}
>> +
>> +	return 0;
>> +}
> [...]
> 
> WBR, Sergei
> 

-- 
Yoshihiro Shimoda
EC No.
