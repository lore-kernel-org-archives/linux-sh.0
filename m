From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 30 Oct 2015 13:57:14 +0000
Subject: Re: [PATCH v5 2/5] clk: shmobile: div6: Make clock-output-names optional
Message-Id: <CAMuHMdWkxzCommSv1UNY=LesAER_uFfkPfbuG3JLHYUtf2-mwg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446117664-6037-1-git-send-email-geert+renesas@glider.be>
	<1446117664-6037-3-git-send-email-geert+renesas@glider.be>
	<5167960.XIHmLIjGds@avalon>
In-Reply-To: <5167960.XIHmLIjGds@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, linux-clk <linux-clk@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Oct 30, 2015 at 2:47 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 29 October 2015 12:21:01 Geert Uytterhoeven wrote:
>> Renesas DIV6 clocks provide a single clock output.  Hence make the
>> "clock-output-names" DT property optional instead of mandatory. In case
>> the DT property is omitted the DT node name will be used.
>>
>> Rename the variable "name" to "clk_name" to make the code more similar
>> with fixed-factor-clock.c, and to avoid a conflict with a nested local
>> variable while we're at it.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> v5:
>>   - Integrated in this series as a dependency.
>
> The patch looks sane, by why is it a dependency ?

Sorry, the cover letter is clearer about this: "contextual dependency".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
