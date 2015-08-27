From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 27 Aug 2015 19:43:31 +0000
Subject: Re: [PATCH/RFC 06/10] arm64: dts: r8a7795: add EthernetAVB device node
Message-Id: <55DF6863.8020509@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-7-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-7-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 08/27/2015 03:52 PM, Sergei Shtylyov wrote:

>>>>>>> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>>>>>> b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>>>>>> index 0b435d8274e4..01502f4d2f5f 100644
>>>>>>> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>>>>>> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>>>>>> @@ -263,6 +263,16 @@
>>>>>>>                           reg = <0 0xe6060000 0 0x50c>;
>>>>>>>                   };
>>>>>>>
>>>>>>> +               avb: ethernet@e6800000 {
>>>>>>> +                       compatible = "renesas,etheravb-r8a7795";
>>>>>>> +                       reg = <0 0xe6800000 0 0x800>, <0 0xe6a00000 0
>>>>>>> 0x10000>;
>>>>>>> +                       interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>,
>>>>>>> <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>
>>>>>>      Two interrupts?
>>>>>
>>>>> There are actually 25, for ch0-ch24.
>>>>> Why does this list the interrupts for ch22 and ch24 only?
>>>>
>>>>     So all these are AVB-DMAC interrupts, not EMAC? I don't have the
>>>> manual...
>>>
>>> The block diagram just shows a line "intreq_avb_p[24:0] (to INTC)", coming
>>> from both AVB-DMAC and E-MAC.
>
>>     Then I'll have to NACK the driver patch.

    Yeah, it seems to be total nonsense now... Unless there's some more recent 
knowledge behind it than Geert's manual has. :-)

>> It's interesting that there's 24

    25 even.

>> IRQs while I remember there were only 15 RX queues on gen2 SoCs.

    Actually, 18.

>> That's the only interpretation of the multiple IRQs that comes to mind.

>     Oops, I meant the descriptor interrupt #s (not used by the driver now),
> not the RX queues.

    After looking thru the gen2 manual, it seems to me that these channels may 
be representing 4 TX and 21 RX queues.

>>> Gr{oetje,eeting}s,
>>>                          Geert

MBR, Sergei

