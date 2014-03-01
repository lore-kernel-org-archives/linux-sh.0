From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 01 Mar 2014 17:52:00 +0000
Subject: Re: [PATCH v2 14/40] clocksource: sh_cmt: Set cpumask to cpu_possible_mask
Message-Id: <CAMuHMdXMcZa_P10qhQAYkz59fnJpv4JjTwqyksKauaHc+=W8rw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1393603090-23144-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1393603090-23144-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Fri, Feb 28, 2014 at 4:57 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> On UP systems no dummy timer is instantiated. The CMT timer has a rating
> of 125 on those systems and is used directly a clock event device for

as clock event device.

> CPU0 without broadcasting.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
