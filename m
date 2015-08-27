From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 27 Aug 2015 11:44:45 +0000
Subject: Re: [PATCH/RFC 06/10] arm64: dts: r8a7795: add EthernetAVB device node
Message-Id: <CAMuHMdVwNM_4JWBH5c3e1kiq2ixSnZ6vg96sD3qOF4g_rE23hQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-7-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-7-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Thu, Aug 27, 2015 at 1:38 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 8/27/2015 2:00 PM, Geert Uytterhoeven wrote:
>>>> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>>> b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>>> index 0b435d8274e4..01502f4d2f5f 100644
>>>> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>>> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>>> @@ -263,6 +263,16 @@
>>>>                          reg = <0 0xe6060000 0 0x50c>;
>>>>                  };
>>>>
>>>> +               avb: ethernet@e6800000 {
>>>> +                       compatible = "renesas,etheravb-r8a7795";
>>>> +                       reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0
>>>> 0x10000>;
>>>> +                       interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
>>>> <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
>>>
>>>     Two interrupts?
>>
>> There are actually 25, for ch0-ch24.
>> Why does this list the interrupts for ch22 and ch24 only?
>
>    So all these are AVB-DMAC interrupts, not EMAC? I don't have the
> manual...

The block diagram just shows a line "intreq_avb_p[24:0] (to INTC)", coming
from both AVB-DMAC and E-MAC.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
