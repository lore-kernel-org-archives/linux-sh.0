From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 04 Jun 2014 15:54:41 +0000
Subject: Re: [PATCH v2 1/9] ARM: shmobile: r8a7790: add dmac0,dmac1 clocks
Message-Id: <538F4141.2020007@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1397511312-4845-1-git-send-email-ben.dooks@codethink.co.uk>	<1397511312-4845-2-git-send-email-ben.dooks@codethink.co.uk> <CAMuHMdVn84FcQCpn6k8caPJGV9wDAi3m0_jwUARDem-Y05+NnQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVn84FcQCpn6k8caPJGV9wDAi3m0_jwUARDem-Y05+NnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linux-sh list <linux-sh@vger.kernel.org>, magnus.damm@opensource.se, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 13/05/14 10:23, Geert Uytterhoeven wrote:
> Hi Ben,
> 
> On Mon, Apr 14, 2014 at 11:35 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> --- a/arch/arm/boot/dts/r8a7790.dtsi
>> +++ b/arch/arm/boot/dts/r8a7790.dtsi
>> @@ -671,16 +671,17 @@
>>                         compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
>>                         reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
>>                         clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
>> -                                <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>;
>> +                                <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>, <&hp_clk>, <&hp_clk>;
> 
> According to the docs, the parent clock of SYS-DMAC[01] is the ZS clock
> (at 260 MHz), not the HP clock (at 130 MHz).
> 
>>                         #clock-cells = <1>;
>>                         renesas,clock-indices = <
>>                                 R8A7790_CLK_SCIFA2 R8A7790_CLK_SCIFA1 R8A7790_CLK_SCIFA0
>>                                 R8A7790_CLK_MSIOF2 R8A7790_CLK_SCIFB0 R8A7790_CLK_SCIFB1
>>                                 R8A7790_CLK_MSIOF1 R8A7790_CLK_MSIOF3 R8A7790_CLK_SCIFB2
>> +                               R8A7790_CLK_SYS_DMAC0 R8A7790_CLK_SYS_DMAC1
> 
> I know order doesn't really matter, but all other members are sorted by
> value, so R8A7790_CLK_SYS_DMAC1 should come before
> R8A7790_CLK_SYS_DMAC0.
> 
>>                         >;
>>                         clock-output-names >>                                 "scifa2", "scifa1", "scifa0", "msiof2", "scifb0",
>> -                               "scifb1", "msiof1", "msiof3", "scifb2";
>> +                               "scifb1", "msiof1", "msiof3", "scifb2", "dmac0", "dmac1";
> 
> "sys-dmac0", "sys-dmac1" (and order changes, cfr. my comment above),
> to match the documentation?

ok, thanks.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
