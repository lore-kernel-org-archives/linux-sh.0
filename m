From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Aug 2015 21:05:12 +0000
Subject: Re: [PATCH v3 02/04] clk: shmobile: Make MSTP clock-output-names optional
Message-Id: <CAMuHMdUMh9s3-SMb9Y85mRYONo8oO_4SL=K5iG+UuKBRpN9ejw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150828091550.21731.85227.sendpatchset@little-apple>
	<20150828091613.21731.8527.sendpatchset@little-apple>
	<1776985.pyjG3Le2BL@avalon>
In-Reply-To: <1776985.pyjG3Le2BL@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-clk@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Gaku Inami <gaku.inami.xw@bp.renesas.com>, Michael Turquette <mturquette@baylibre.com>, Linux-sh list <linux-sh@vger.kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>

On Fri, Aug 28, 2015 at 9:37 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> @@ -214,12 +211,13 @@ static void __init cpg_mstp_clocks_init(
>>                       break;
>>
>>               if (clkidx >= MSTP_MAX_CLOCKS) {
>> -                     pr_err("%s: invalid clock %s %s index %u)\n",
>> -                            __func__, np->name, name, clkidx);
>> +                     pr_err("%s: invalid clock %s index %u)\n",
>> +                            __func__, np->name, clkidx);
>>                       continue;
>>               }
>>
>> -             clks[clkidx] = cpg_mstp_clock_register(name, parent_name,
>> +             clks[clkidx] = cpg_mstp_clock_register(name ? name : np->name,
>
> This would result in several clocks being registered with the same name. I

Indeed.

> would instead construct the name with sprintf(name, "%s.%u", np->name,
> clkidx).

Not using clock-output-names makes the clock's names and
/sys/kernel/debug/clk/clk_summary a bit harder to understand, though.

>> +                                                    parent_name,
>>                                                      clkidx, group);
>>               if (!IS_ERR(clks[clkidx])) {
>>                       group->data.clk_num = max(group->data.clk_num,
>> @@ -232,7 +230,8 @@ static void __init cpg_mstp_clocks_init(
>>                        * FIXME: Remove this when all devices that require a
>>                        * clock will be instantiated from DT.
>>                        */
>> -                     clk_register_clkdev(clks[clkidx], name, NULL);
>> +                     if (name) /* only if clock-output-names is provided */
>> +                             clk_register_clkdev(clks[clkidx], name, NULL);
>
> Better than that, as all our devices are now instantiated from DT, we can
> remove the clk_register_clkdev() call completely as well as the FIXME comment.

Unfortunately we cannot remove this yet, as board staging (e.g. Armadillo
LCDC) depends on it (been there, done that).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
