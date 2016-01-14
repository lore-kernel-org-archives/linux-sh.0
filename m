From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Jan 2016 19:06:10 +0000
Subject: Re: [PATCH v2] clk: shmobile: r8a7795: Add SDHI clocks
Message-Id: <CAMuHMdXwdi_cbR14ejLkYyu2SH0P=14o9opQAKqbo7vUbHBwYQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450951761-3160-1-git-send-email-dirk.behme@gmail.com>
In-Reply-To: <1450951761-3160-1-git-send-email-dirk.behme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Dirk,

On Thu, Jan 14, 2016 at 8:02 PM, Dirk Behme <dirk.behme@gmail.com> wrote:
> On 14.01.2016 19:24, Geert Uytterhoeven wrote:
>> On Sat, Jan 9, 2016 at 7:42 AM, Dirk Behme <dirk.behme@gmail.com> wrote:
>>> On 24.12.2015 11:09, Dirk Behme wrote:
>>>> Add R8A7795 SDHI clocks.
>>>> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
>>>> ---
>>>> Changes in v2: Add the missing *H clocks and correct the dividers.
>>>>
>>>> This replaces v1
>>>>
>>>> http://www.spinics.net/lists/linux-sh/msg47464.html
>>>>
>>>>    drivers/clk/shmobile/r8a7795-cpg-mssr.c | 13 ++++++++++++-
>>>>    1 file changed, 12 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/clk/shmobile/r8a7795-cpg-mssr.c
>>>> b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
>>>> index 05479e6..f30ed32 100644
>>>> --- a/drivers/clk/shmobile/r8a7795-cpg-mssr.c
>>>> +++ b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
>>>> @@ -100,8 +100,15 @@ static const struct cpg_core_clk
>>>> r8a7795_core_clks[]
>>>> __initconst = {
>>>>          DEF_FIXED("s3d2",       R8A7795_CLK_S3D2,  CLK_S3,         2,
>>>> 1),
>>>>          DEF_FIXED("s3d4",       R8A7795_CLK_S3D4,  CLK_S3,         4,
>>>> 1),
>>>>          DEF_FIXED("cl",         R8A7795_CLK_CL,    CLK_PLL1_DIV2, 48,
>>>> 1),
>>>> +       DEF_FIXED("sd0h",       R8A7795_CLK_SD0H,  CLK_PLL1_DIV2,  2,
>>>> 1),
>>>> +       DEF_FIXED("sd0",        R8A7795_CLK_SD0,   CLK_PLL1_DIV2,  8,
>>>> 1),
>>>> +       DEF_FIXED("sd1h",       R8A7795_CLK_SD1H,  CLK_PLL1_DIV2,  2,
>>>> 1),
>>>> +       DEF_FIXED("sd1",        R8A7795_CLK_SD1,   CLK_PLL1_DIV2,  8,
>>>> 1),
>>>> +       DEF_FIXED("sd2h",       R8A7795_CLK_SD2H,  CLK_PLL1_DIV2,  2,
>>>> 1),
>>>> +       DEF_FIXED("sd2",        R8A7795_CLK_SD2,   CLK_PLL1_DIV2,  8,
>>>> 1),
>>>> +       DEF_FIXED("sd3h",       R8A7795_CLK_SD3H,  CLK_PLL1_DIV2,  2,
>>>> 1),
>>>> +       DEF_FIXED("sd3",        R8A7795_CLK_SD3,   CLK_PLL1_DIV2,  8,
>>>> 1),
>>
>>
>> The dividers for these clocks are not fixed, they are controlled by the
>> SDnCKCR registers.
>>
>> Unfortunately the register layout is more complicated than on R-Car Gen2,
>> so
>> you can no longer use clk_register_divider_table(), but have to write a
>> custom
>> clock driver.
>>
>> For an initial version, a simple "read-only" version that just calls
>> clk_register_fixed_factor() with divider values read from the hardware
>> registers may be good enough. But for full support, you need a driver that
>> can program the registers, too.
>>
>> Just using fixed dividers like you did won't work, as the boot
>> loader/reset
>> state may be different.
>> E.g. on my board, which has a 16.66666 MHz crystal, the initial state
>> according
>> to the register values is:
>>    - sd[0-2]h are stopped,
>>    - sd[0-2] run at 25 MHz,
>>    - sd3h runs at 400 MHz,
>>    - sd3 runs at 100 MHz.
>
> Hmm, why do I get
>
> sh_mobile_sdhi ee140000.mmc: mmc0 base at 0xee140000 clock rate 99 MHz
>
> (or 199MHz considering the clock workaround) and for the other SDx with this
> patch, then?

Because your patch hardcodes them to PLL1_DIV2 / 8, and thus the driver will
report the hardcoded values.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
