From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Mon, 24 Nov 2014 12:31:19 +0000
Subject: Re: [PATCH v2 4/6] ARM: shmobile: r8a73a4: Common clock framework DT description
Message-Id: <CAO3366ypZVE6JEKx1iVeVpahrmmnGrpaRiq28NFb=ep6FMhjgw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1416500496-21024-5-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1416500496-21024-5-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Nov 24, 2014 at 12:34 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, Nov 20, 2014 at 5:21 PM, Ulrich Hecht
> <ulrich.hecht+renesas@gmail.com> wrote:
>> --- a/arch/arm/boot/dts/r8a73a4.dtsi
>> +++ b/arch/arm/boot/dts/r8a73a4.dtsi
>
>> +               /* Variable factor clocks (DIV6) */
>> +               zb_clk: zb_clk@e6150010 {
>> +                       compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
>> +                       reg = <0 0xe6150010 0 4>;
>> +                       clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
>> +                                <0>, <0>;
>
> The order of the parent clocks for the zb clock is wrong.
> The EXSRC field in the BSC Clock Frequency Control Register (ZBCKCR)
> only covers bit 7, not bit 6 (This clock used to have src-shift = <7> and
> src-width = <1>, not <6> resp. <2> like most other clocks).
> Hence the odd indices in the array should contain the invalid (<0>) parent
> clock. I.e.
>
>                       clocks = <&pll1_div2_clk>, <0>,
>                                <&cpg_clocks R8A73A4_CLK_PLL2S>, <0>;
>
> Note that I actually made the same mistake in my version for sh73a0
> (http://www.spinics.net/lists/linux-sh/msg37265.html).
> On sh73a0, this affects the zb, flctl, msu, mfg1, mfg2, and dsit clocks.
>
> I haven't checked yet which other clocks are affected on r8a73a4.

Looks like it's the only one. Thanks for spotting this, I'll respin the patch...

CU
Uli
