From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 21 May 2014 07:54:18 +0000
Subject: Re: [PATCH 2/3] usb: host: xhci-plat: add support for the R-Car H2 and M2 xHCI controllers
Message-Id: <537C5BAA.2090302@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5379D805.3070002@renesas.com>	<CAMuHMdUMGc_SNLWruEF=91v0Z+w6pnEpYhb4MeU+NEk=Dfi5Xg@mail.gmail.com>	<537B21CA.6080702@renesas.com> <CAMuHMdX8LzgPGnh83Y3oo_s08DfE8UbRH+kHGKyFndH5E_4RkQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX8LzgPGnh83Y3oo_s08DfE8UbRH+kHGKyFndH5E_4RkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "mathias.nyman@intel.com" <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Geert-san,

Thank you for the reply again.

(2014/05/20 19:14), Geert Uytterhoeven wrote:
> Hi Shimoda-san,
> 
> On Tue, May 20, 2014 at 11:35 AM, Yoshihiro Shimoda
> <yoshihiro.shimoda.uh@renesas.com> wrote:
>> (2014/05/19 20:58), Geert Uytterhoeven wrote:
>>> On Mon, May 19, 2014 at 12:08 PM, Yoshihiro Shimoda
>>> <yoshihiro.shimoda.uh@renesas.com> wrote:
>> < snip >
>>>> +config USB_XHCI_RCAR
>>>> +       tristate "xHCI support for Renesas R-Car SoCs"
>>>> +       select USB_XHCI_PLATFORM
>>>> +       depends on ARCH_SHMOBILE || COMPILE_TEST
>>>> +       ---help---
>>>> +         Say 'Y' to enable the support for the xHCI host controller
>>>> +         found in Renesas R-Car ARM SoCs.
>>>
>>> Does R-Car Gen1 also have xHCI, and is it compatible?
>>> If not, you may want to call this driver USB_XHCI_RCAR2.
>>
>> R-Car Gen1 doesn't have xHCI.
>> However, next generation of R-Car may have xHCI. (But, I don't know it is compatible.)
>> If we call this driver "USB_XHCI_RCAR2", should we also change filename to "xhci-rcar2.[ch]"?
> 
> Iff you change the config symbol, please also change the filename.
> 
> But given the uncertainty about future version, you can leave it like it is.

I got it. I will leave the "USB_XHCI_RCAR".

< snip >
>>> Is there some way to just use get_unaligned_le32()?
>>
>> Yes, I will remove the custom get_unaligned_le32() and add the following code.
>> Do you think that this code is good?
>>
>>         int i;
>>         u32 data;
>>         u8 buf[4];
>> < snip >
>>         for (i = 0; i < fw->size; i += 4) {
>>                 memset(buf, 0, sizeof(buf));
>>                 memcpy(buf, &fw->data[i], min(sizeof(buf), fw->size - i));
>>                 data = get_unaligned_le32(buf);
> 
> I'm sorry, but IMHO this looks worse.

Thank you for the review. :)
So, I will keep the following code with an additional comment.

              for (data = 0, j = 3; j >= 0; j--) {
                      if ((j + index) < fw->size)
                              data |= fw->data[index + j] << (8 * j);
              }

Best regards,
Yoshihiro Shimoda

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 
Yoshihiro Shimoda
EC No.
