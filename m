From: Dirk Behme <dirk.behme@gmail.com>
Date: Sun, 17 Jan 2016 09:47:07 +0000
Subject: Re: [PATCH v2] clk: shmobile: r8a7795: Add SDHI clocks
Message-Id: <569B631B.80708@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450951761-3160-1-git-send-email-dirk.behme@gmail.com>
 <5690ABCC.3090909@gmail.com>
 <CAMuHMdXa4qdrqu-RjPuxAHQwBJ5LZ+JsfWH83vcvp6EQ+M1-aA@mail.gmail.com>
 <5698C5E8.4040107@de.bosch.com>
 <CAMuHMdWb-mQ=Q53Bzr7wwYtvg6iA2xoVecTTnJj18Sp428r-jw@mail.gmail.com>
In-Reply-To: <CAMuHMdWb-mQ=Q53Bzr7wwYtvg6iA2xoVecTTnJj18Sp428r-jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, Linux-sh list <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms+renesas@verge.net.au>, Michael Turquette <mturquette@baylibre.com>, linux-clk <linux-clk@vger.kernel.org>

Hi Geert,

On 15.01.2016 11:20, Geert Uytterhoeven wrote:
> Hi Dirk,
>
> On Fri, Jan 15, 2016 at 11:11 AM, Dirk Behme <dirk.behme@de.bosch.com> wr=
ote:
>> On 14.01.2016 19:24, Geert Uytterhoeven wrote:
>>> On Sat, Jan 9, 2016 at 7:42 AM, Dirk Behme <dirk.behme@gmail.com> wrote:
>>>> On 24.12.2015 11:09, Dirk Behme wrote:
>>>>> Add R8A7795 SDHI clocks.
>>>>> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
>>>>> ---
>>>>> Changes in v2: Add the missing *H clocks and correct the dividers.
>>>>>
>>>>> This replaces v1
>>>>>
>>>>> http://www.spinics.net/lists/linux-sh/msg47464.html
>>>>>
>>>>>     drivers/clk/shmobile/r8a7795-cpg-mssr.c | 13 ++++++++++++-
>>>>>     1 file changed, 12 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/clk/shmobile/r8a7795-cpg-mssr.c
>>>>> b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
>>>>> index 05479e6..f30ed32 100644
>>>>> --- a/drivers/clk/shmobile/r8a7795-cpg-mssr.c
>>>>> +++ b/drivers/clk/shmobile/r8a7795-cpg-mssr.c
>>>>> @@ -100,8 +100,15 @@ static const struct cpg_core_clk
>>>>> r8a7795_core_clks[]
>>>>> __initconst =3D {
>>>>>           DEF_FIXED("s3d2",       R8A7795_CLK_S3D2,  CLK_S3,         =
2,
>>>>> 1),
>>>>>           DEF_FIXED("s3d4",       R8A7795_CLK_S3D4,  CLK_S3,         =
4,
>>>>> 1),
>>>>>           DEF_FIXED("cl",         R8A7795_CLK_CL,    CLK_PLL1_DIV2, 4=
8,
>>>>> 1),
>>>>> +       DEF_FIXED("sd0h",       R8A7795_CLK_SD0H,  CLK_PLL1_DIV2,  2,
>>>>> 1),
>>>>> +       DEF_FIXED("sd0",        R8A7795_CLK_SD0,   CLK_PLL1_DIV2,  8,
>>>>> 1),
>>>>> +       DEF_FIXED("sd1h",       R8A7795_CLK_SD1H,  CLK_PLL1_DIV2,  2,
>>>>> 1),
>>>>> +       DEF_FIXED("sd1",        R8A7795_CLK_SD1,   CLK_PLL1_DIV2,  8,
>>>>> 1),
>>>>> +       DEF_FIXED("sd2h",       R8A7795_CLK_SD2H,  CLK_PLL1_DIV2,  2,
>>>>> 1),
>>>>> +       DEF_FIXED("sd2",        R8A7795_CLK_SD2,   CLK_PLL1_DIV2,  8,
>>>>> 1),
>>>>> +       DEF_FIXED("sd3h",       R8A7795_CLK_SD3H,  CLK_PLL1_DIV2,  2,
>>>>> 1),
>>>>> +       DEF_FIXED("sd3",        R8A7795_CLK_SD3,   CLK_PLL1_DIV2,  8,
>>>>> 1),
>>>
>>>
>>> The dividers for these clocks are not fixed, they are controlled by the
>>> SDnCKCR registers.
>>>
>>> Unfortunately the register layout is more complicated than on R-Car Gen=
2,
>>> so
>>> you can no longer use clk_register_divider_table(), but have to write a
>>> custom
>>> clock driver.
>>>
>>> For an initial version, a simple "read-only" version that just calls
>>> clk_register_fixed_factor() with divider values read from the hardware
>>> registers may be good enough. But for full support, you need a driver t=
hat
>>> can program the registers, too.
>>
>>
>>
>> Anything like
>>
>> https://git.kernel.org/cgit/linux/kernel/git/horms/renesas-bsp.git/commi=
t/drivers/clk/shmobile/clk-rcar-gen3.c?h=3Dv4.2/rcar-3.0.x&id=CD10385afc15c=
ef6bfbaea4aa5da41193b24fe82


I've had a look to that.

I think we can pick all the functions

+static const struct clk_ops cpg_sd_clock_ops =3D {
+	.enable =3D cpg_sd_clock_enable,
+	.disable =3D cpg_sd_clock_disable,
+	.is_enabled =3D cpg_sd_clock_is_enabled,
+	.recalc_rate =3D cpg_sd_clock_recalc_rate,
+	.round_rate =3D cpg_sd_clock_round_rate,
+	.set_rate =3D cpg_sd_clock_set_rate,
+};

unchanged from that patch.

However, I'm not sure how to interface this to cpg_mssr_probe()? It's=20
similar to cpg_mssr_register_mod_clk(), but not identical so that this=20
could be reused.

We could extend r8a7795_cpg_mssr_info by anything like an additional

/* Dynamic clocks */
.dyn_clks =3D /* Add an array allowing to pass various clk_ops structs */
...

?

Or we could hard code it like

https://git.kernel.org/cgit/linux/kernel/git/horms/renesas-bsp.git/commit/d=
rivers/clk/shmobile/clk-rcar-gen3.c?h=3Dv4.2/rcar-3.0.x&id=CD10385afc15cef6=
bfbaea4aa5da41193b24fe82

is doing it with

+	} else if (!strcmp(name, "sd0")) {
+		return cpg_sd_clk_register(name, cpg->reg + CPG_SD0CKCR, np);
+	} else if (!strcmp(name, "sd1")) {
+		return cpg_sd_clk_register(name, cpg->reg + CPG_SD1CKCR, np);
+	} else if (!strcmp(name, "sd2")) {
+		return cpg_sd_clk_register(name, cpg->reg + CPG_SD2CKCR, np);
+	} else if (!strcmp(name, "sd3")) {
+		return cpg_sd_clk_register(name, cpg->reg + CPG_SD3CKCR, np);

and add this to e.g. r8a7795_cpg_clk_register(). But, hmm.


What do you think? Opinions? Examples?


Best regards

Dirk
