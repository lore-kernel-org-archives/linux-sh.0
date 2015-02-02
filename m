From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 02 Feb 2015 10:01:54 +0000
Subject: Re: [RFC 5/5] watchdog: sh_mobile: add driver
Message-Id: <CAMuHMdV6Pwt4BQkUJ9p4feVQOBokAcMqB-fRymt-=F2hePb8_A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422802074-1921-6-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1422802074-1921-6-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 2, 2015 at 10:54 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> How about PM (system and runtime) support ? How does the watchdog behave
> during system suspend ? You could then replace the clk_prepare_enable() and
> clk_disable_unprepare() calls with pm_runtime_get_sync() and pm_runtime_put().

That's a good question.

If the RWDT MSTP clock is disabled, it can't count, and thus can't trigger.
But I don't know what's the maximum time interval you can have in the system
between enabling the MSTP clock during system resume, and the first call
of watchdog_ops.sh_wdt_ping.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
