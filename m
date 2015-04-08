From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 08 Apr 2015 07:43:22 +0000
Subject: Re: [PATCH v2 2/2] ARM: shmobile: r8a7791: Enable DMA for HSUSB
Message-Id: <CAMuHMdUvkt4LrSkJhCT1k-YF-FUS4f2QByTJeCsVGqmjSXYB-A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1428393231-5272-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1428393231-5272-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<CAMuHMdXu46NK37gcweCz_XTABUJw6kN0fnyxmmGeL9cGRWdJdg@mail.gmail.com>
	<HKNPR06MB32242AD4C51E1F939E780ACD8FC0@HKNPR06MB322.apcprd06.prod.outlook.com>
In-Reply-To: <HKNPR06MB32242AD4C51E1F939E780ACD8FC0@HKNPR06MB322.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@vger.kernel.org" <linux-arm-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Shimoda-san,

On Wed, Apr 8, 2015 at 4:20 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>> On Tue, Apr 7, 2015 at 9:53 AM, Yoshihiro Shimoda
>> <yoshihiro.shimoda.uh@renesas.com> wrote:
>> > diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
>> > index db3772e..5f20ad4 100644
>> > --- a/arch/arm/boot/dts/r8a7791.dtsi
>> > +++ b/arch/arm/boot/dts/r8a7791.dtsi
>> > @@ -722,6 +722,9 @@
>> >                 renesas,buswait = <4>;
>> >                 phys = <&usb0 1>;
>> >                 phy-names = "usb";
>> > +               dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
>> > +                      <&usb_dmac1 0>, <&usb_dmac1 1>;
>> > +               dma-names = "rx0", "tx1", "rx2", "tx3";
>>
>> The numbering looks a bit strange, given the code looks up both tx and rx
>> DMA channels for each channel index. Is it correct?
>>
>> The binding documentation (which lacks on example) states:
>>
>>   - dma-names : Must contain a list of DMA names:
>>    - tx0 ... tx<n>
>>    - rx0 ... rx<n>
>>     - This <n> means DnFIFO in USBHS module.
>>
>> As there are 4 DnFIFOs, I'd expect tx0..tx3 and rx0..rx3.
>>
>> Can you please clarify?
>
> I wrote some information below.
> But, since it is complex hardware, I don't know I can explain this as well...
>
> At first, R-Car Gen2 has 2 USB-DMACs and 4 channels:
>  USB-DMAC 0: ch0
>  USB-DMAC 0: ch1
>  USB-DMAC 1: ch0
>  USB-DMAC 1: ch1
> Remarks: I don't know why but performance of USB-DMAC 0 is good than USB-DMAC 1.
>           (Please refer to the Table 64.1 of the datasheet.)
>
> So, I wrote dmas parameter in hsusb as the following:
>
>> > +               dmas = <&usb_dmac0 0>, <&usb_dmac0 1>,
>> > +                      <&usb_dmac1 0>, <&usb_dmac1 1>;
>
> And, R-Car Gen2 has 4 DnFIFOs in HSUSB. to avoid complex handling for DnFIFOs,
> the renesas_usbhs driver uses each DnFIFO as TX or RX direction (not bi-direction).
> So, I wrote dma-names parameter as the following:
>
>> > +               dma-names = "rx0", "tx1", "rx2", "tx3";
>
> - D0FIFO as RX (Also it is connected to USB-DMAC 0: ch0)
> - D1FIFO as TX (Also it is connected to USB-DMAC 0: ch1)
> - D2FIFO as RX (Also it is connected to USB-DMAC 1: ch0)
> - D3FIFO as TX (Also it is connected to USB-DMAC 1: ch1)

Thanks for the explanation!

Hence the "strange" numbering is a limitation of the driver, not of the
hardware?

In that case I think the DT should describe the hardware, not the driver
limitation. As the FIFOs are bidirectional, there's just a one-to-one mapping
of 4 DnFIFOs to 4 (2 channels x 2 DMACs) DMA channels.
Which DnFIFO/channel is used for TX and which is used for RX is to be chosen
by the driver, and can be fixed (e.g. use even channels for RX, odd for
TX, like the current situation).

What do you (and other people) think?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
