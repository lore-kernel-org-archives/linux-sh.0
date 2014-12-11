From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Dec 2014 14:15:39 +0000
Subject: Re: [PATCH v7 1/6] clk: shmobile: sh73a0 common clock framework implementation
Message-Id: <CAMuHMdUeJF5sR4=Jntgq7ns=y_AgvwvUDCuSVirynWW18gTQMA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418222727-19888-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1418222727-19888-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Wed, Dec 10, 2014 at 5:53 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
>>> +static const struct clk_div_table z_div_table[] = {
>>> +     /* ZSEL = 0 */
>>> +     { 0, 1 }, { 1, 1 }, { 2, 1 }, { 3, 1 }, { 4, 1 }, { 5, 1 },
>>> +     { 6, 1 }, { 7, 1 }, { 8, 1 }, { 9, 1 }, { 10, 1 }, { 11, 1 },
>>> +     { 12, 1 }, { 13, 1 }, { 14, 1 }, { 15, 1 },
>>
>> Do we have to list all entries, or could a single one be enough ?
>
> Hmm... u-boot initializes to all zeros, so just the first one might do.

>>> +     /* Set SDHI clocks to a known state */
>>> +     clk_writel(0x108, cpg->reg + CPG_SD0CKCR);
>>> +     clk_writel(0x108, cpg->reg + CPG_SD1CKCR);
>>> +     clk_writel(0x108, cpg->reg + CPG_SD2CKCR);
>>
>> Why is this needed ?
>
> Cargo cult programming, it's what the legacy driver does.  It
> essentially just stops the clock (which u-boot leaves on), so it's
> possible that it is not really necessary.
>
> Geert, could I ask you to to occasionally check if this works without
> the three SD clock initialization lines and without the "{ 1, 1 }" to
> "{ 15, 1 }" entries in z_div_table?

Kzm9g still boots after
  1) Setting z_div_table[1..15] to { 0, 0 }
  2) Removing the lines that initialize CPG_SD[012]CKCR.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
