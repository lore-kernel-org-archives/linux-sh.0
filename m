From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 15 Dec 2015 11:21:16 +0000
Subject: Re: [PATCH 2/6] arm64: dts: r8a7795: Add SATA controller node
Message-Id: <CAO3366xq1cbhXE8oYGDFyQ_RGneZTfy_fpCOc_=CsWTswwD8=A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450107758-2544-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1450107758-2544-3-git-send-email-ulrich.hecht+renesas@gmail.com>
 <CAMuHMdXq1uT69w6bnqJM49vgoDzax=hte+OM3MDahcBuUfD9Ng@mail.gmail.com>
In-Reply-To: <CAMuHMdXq1uT69w6bnqJM49vgoDzax=hte+OM3MDahcBuUfD9Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Dec 15, 2015 at 11:44 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Mon, Dec 14, 2015 at 4:42 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
>> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> index c018423..7d4707e 100644
>> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>> @@ -972,5 +972,13 @@
>>                                 };
>>                         };
>>                 };
>> +
>> +               sata: sata@ee300000 {
>> +                       compatible = "renesas,sata-r8a7795";
>> +                       reg = <0 0xee300000 0 0x1fff>;
>> +                       interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
>> +                       clocks = <&cpg CPG_MOD 915>;
>
> My datasheet says 815.

So does the BSP, I must have misread that.

Simon, should I send an incremental patch for this one with v2?

CU
Uli
