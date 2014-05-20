From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 20 May 2014 09:35:06 +0000
Subject: Re: [PATCH 2/3] usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <537B21CA.6080702@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5379D805.3070002@renesas.com> <CAMuHMdUMGc_SNLWruEF=91v0Z+w6pnEpYhb4MeU+NEk=Dfi5Xg@mail.gmail.com>
In-Reply-To: <CAMuHMdUMGc_SNLWruEF=91v0Z+w6pnEpYhb4MeU+NEk=Dfi5Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "mathias.nyman@intel.com" <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Geert-san,

(2014/05/19 20:58), Geert Uytterhoeven wrote:
> Hi Shimoda-san,
> 
> On Mon, May 19, 2014 at 12:08 PM, Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
< snip >
>> +config USB_XHCI_RCAR
>> +       tristate "xHCI support for Renesas R-Car SoCs"
>> +       select USB_XHCI_PLATFORM
>> +       depends on ARCH_SHMOBILE || COMPILE_TEST
>> +       ---help---
>> +         Say 'Y' to enable the support for the xHCI host controller
>> +         found in Renesas R-Car ARM SoCs.
> 
> Does R-Car Gen1 also have xHCI, and is it compatible?
> If not, you may want to call this driver USB_XHCI_RCAR2.

R-Car Gen1 doesn't have xHCI.
However, next generation of R-Car may have xHCI. (But, I don't know it is compatible.)
If we call this driver "USB_XHCI_RCAR2", should we also change filename to "xhci-rcar2.[ch]"?

< snip >
>>  static int xhci_plat_start(struct usb_hcd *hcd)
>>  {
>> +       struct device_node *of_node = hcd->self.controller->of_node;
>> +
>> +       if (of_device_is_compatible(of_node, "renesas,r8a7790-xhci") ||
>> +           of_device_is_compatible(of_node, "renesas,r8a7790-xhci"))
> 
> r8a7791, as Magnus already pointed out.

Yes, I will correct this.

>> +               xhci_rcar_start(hcd);
> 
> If CONFIG_USB_XHCI_RCAR is not defined, xhci_rcar_start() is a dummy
> function, but the of_device_is_compatible() checks will still be compiled in.
> 
> Hence perhaps an #ifdef CONFIG_USB_XHCI_RCAR is warranted here,
> possibly combined with inclusion of a C-source file, like is done in
> drivers/usb/host/ohci-hcd.c? It's up to the USB maintainer to decide this,
> though.

This implementation is similar with the following patch. And the patch already got
"Acked-by" from Mathias Nyman of USB XHCI DRIVER's maintainer.

	http://marc.info/?l=linux-usb&m0014933101775&w=2

< snip >
>> @@ -165,6 +172,15 @@ static int xhci_plat_probe(struct platform_device *pdev)
>>                         goto unmap_registers;
>>         }
>>
>> +       if (of_device_is_compatible(pdev->dev.of_node,
>> +                                   "renesas,r8a7790-xhci") ||
>> +           of_device_is_compatible(pdev->dev.of_node,
>> +                                   "renesas,r8a7791-xhci")) {
>> +               ret = xhci_rcar_init_quirk(pdev);
> 
> Same here.
> 

Same above.

< snip >
>> --- /dev/null
>> +++ b/drivers/usb/host/xhci-rcar.c
> 
>> +/* USB3.0 Configuraion */
> 
> Configuration

I ran the "aspell -c" command, and I found other 2 typos. ("Initilization" and "Porariy")
So, I will correct these typos.

< snip >
>> +       for (index = 0; index < fw->size; index += 4) {
>> +               for (data = 0, j = 3; j >= 0; j--) {
>> +                       if ((j + index) >= fw->size)
>> +                               continue;
>> +                       data |= fw->data[index + j] << (8 * j);
>> +               }
> 
> This is your custom get_unaligned_le32(), to avoid reading beyond the end
> of the buffer if its size is not a multiple of 4 bytes?

Yes, I would like to avoid it.

> Is there some way to just use get_unaligned_le32()?

Yes, I will remove the custom get_unaligned_le32() and add the following code.
Do you think that this code is good?

	int i;
	u32 data;
	u8 buf[4];
< snip >
	for (i = 0; i < fw->size; i += 4) {
		memset(buf, 0, sizeof(buf));
		memcpy(buf, &fw->data[i], min(sizeof(buf), fw->size - i));
		data = get_unaligned_le32(buf);

Best regards,
Yoshihiro Shimoda

> If you want to keep it, I would rewrite it as
> 
>               for (data = 0, j = 3; j >= 0; j--) {
>                       if ((j + index) < fw->size)
>                               data |= fw->data[index + j] << (8 * j);
>               }
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torval
> 

-- 
Yoshihiro Shimoda
EC No.
