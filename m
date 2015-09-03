From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 03 Sep 2015 07:41:27 +0000
Subject: Re: [PATCH v8 04/07] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
Message-Id: <CANqRtoQM3oQeayhG5q4S9u-YKB2bAkJX4J0ctjtvNL0NXU4+KA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831062952.24004.17072.sendpatchset@little-apple>
In-Reply-To: <20150831062952.24004.17072.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Mon, Aug 31, 2015 at 10:08 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Mon, Aug 31, 2015 at 2:59 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> On Mon, Aug 31, 2015 at 9:47 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> Hi Magnus,
>>>
>>> On Mon, Aug 31, 2015 at 8:29 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>>>> --- 0014/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>>> +++ work/arch/arm64/boot/dts/renesas/r8a7795.dtsi       2015-08-29 18:25:06.922366518 +0900
>>>> @@ -241,6 +246,34 @@
>>>>                                         R8A7795_CLK_PLL3 R8A7795_CLK_PLL4
>>>>                                 >;
>>>>                                 #power-domain-cells = <0>;
>>>> +
>>>> +                               mstp2_clks: mstp2_clks@e6150138 {
>>>
>>> With the "clock-output-names" dropped, I think the node should be called
>>> "mstp2" (without "_clks") suffix.
>>
>> Makes sense!
>>
>>>> +                                       compatible >>>> +                                               "renesas,r8a7795-mstp-clocks",
>>>> +                                               "renesas,cpg-mstp-clocks";
>>>> +                                       reg = <0 0xe6150138 0 4>,
>>>> +                                             <0 0xe6150040 0 4>;
>>>> +                                       clocks = <&s3d4_clk>, <&s3d4_clk>,
>>>> +                                                <&s3d4_clk>, <&s3d4_clk>,
>>>> +                                                <&s3d4_clk>;
>>>> +                                       #clock-cells = <1>;
>>>> +                                       clock-indices = <
>>>> +                                               R8A7795_CLK_SCIF5
>>>> +                                               R8A7795_CLK_SCIF4
>>>> +                                               R8A7795_CLK_SCIF3
>>>> +                                               R8A7795_CLK_SCIF1
>>>> +                                               R8A7795_CLK_SCIF0
>>>> +                                       >;
>>>> +                               };
>>>> +
>>>> +                               mstp3_clks: mstp3_clks@e615013c {
>>>
>>> Likewise.
>>
>> Sure...
>>
>>>> +                                       compatible = "renesas,r8a7795-mstp-clocks",
>>>> +                                                    "renesas,cpg-mstp-clocks";
>>
>> But if we're going down that route then may I ask why we have
>> "-clocks" suffix for the MSTP/CPG compat strings? I'd rather make them
>> shorter and more similar to the rest of the compat strings on the SoC.
>
> It uses plural because CPG and MSTP nodes provide more than one clock.
>
> Cfr. DIV6, which provides a single clock, and uses e.g.
> "renesas,r8a7791-div6-clock", "renesas,cpg-div6-clock" (singular).

Ok, thanks but my concern was not about singular vs plural.
Why do we need the "-clocks" suffix?

It's a detail, but for me the shorter "renesas,r8a7795-mstp" makes
more sense than "renesas,r8a7795-mstp-clocks"

>>>> +                                       reg = <0 0xe615013c 0 4>, <0 0xe6150048 0 4>;
>>>> +                                       clocks =  <&s3d4_clk>;
>>>> +                                       #clock-cells = <1>;
>>>> +                                       clock-indices = <R8A7795_CLK_SCIF2>;
>>>
>>> Sample (part of) /sys/kernel/debug/clk/clk_summary output:
>>>
>>>  s3                                       1            1           0
>>>        0 0
>>>     s3d4                                  1            2           0
>>>        0 0
>>>        mstp3_clks.10                      2            2           0
>>>        0 0
>>>
>>> I think "mstp3.10" looks nicer than "mstp3_clks.10".
>>> Note that before we had "scif2".
>>
>> It is still possible to add extended information in clock-output-names
>> to the DTS for debugging purpose, right?
>
> Sure, but we can no longer rely on its existence if it's declared optional.

Right, and we should not have to rely on it either I think!

Cheers,

/ magnus
