From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 18 Jun 2015 14:19:25 +0000
Subject: Re: [PATCH 1/2] clocksource: sh_cmt: Only perform clocksource suspend/resume if enabled
Message-Id: <CAMuHMdUiDVVY1YE1Pt3gsFfNrTRAHgLdQ_F8CXOKG5aKW1TeFQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1434622954-26747-1-git-send-email-geert+renesas@glider.be>
	<1434622954-26747-2-git-send-email-geert+renesas@glider.be>
	<1829815.c8lIHLtv9K@avalon>
In-Reply-To: <1829815.c8lIHLtv9K@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linux PM list <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <damm@opensource.se>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Laurent,

On Thu, Jun 18, 2015 at 4:14 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 18 June 2015 12:22:33 Geert Uytterhoeven wrote:
>> Currently the sh_cmt clocksource timer is disabled or enabled
>> unconditionally on clocksource suspend resp. resume, even if a better
>> clocksource is present (e.g. arch_sys_counter) and the sh_cmt
>> clocksource is not enabled.

>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Good catch. The patch looks good to me.

While the solution was simple, it was hard to catch (engineers and
lightbulbs... euh timers ;-)

> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

> I've quickly checked the MTU2 and TMU timer drivers and they should be immune
> to the issue, but I'd appreciate if you could confirm that.

I had concluded the same, thanks for verifying!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
