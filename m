From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 15 Jan 2016 10:20:12 +0000
Subject: Re: [PATCH v2] clk: shmobile: r8a7795: Add SDHI clocks
Message-Id: <CAMuHMdWb-mQ=Q53Bzr7wwYtvg6iA2xoVecTTnJj18Sp428r-jw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450951761-3160-1-git-send-email-dirk.behme@gmail.com>
	<5690ABCC.3090909@gmail.com>
	<CAMuHMdXa4qdrqu-RjPuxAHQwBJ5LZ+JsfWH83vcvp6EQ+M1-aA@mail.gmail.com>
	<5698C5E8.4040107@de.bosch.com>
In-Reply-To: <5698C5E8.4040107@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Dirk Behme <dirk.behme@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>, Michael Turquette <mturquette@baylibre.com>, linux-clk <linux-clk@vger.kernel.org>

Hi Dirk,

On Fri, Jan 15, 2016 at 11:11 AM, Dirk Behme <dirk.behme@de.bosch.com> wrot=
e:
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
>>>> __initconst =3D {
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
>> registers may be good enough. But for full support, you need a driver th=
at
>> can program the registers, too.
>
>
>
> Anything like
>
> https://git.kernel.org/cgit/linux/kernel/git/horms/renesas-bsp.git/commit=
/drivers/clk/shmobile/clk-rcar-gen3.c?h=3Dv4.2/rcar-3.0.x&id=CD10385afc15ce=
f6bfbaea4aa5da41193b24fe82
>
> ?

Yes.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
