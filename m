From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Sep 2018 11:55:02 +0000
Subject: Re: [PATCH] clocksource: sh_cmt: fix clocksource width for 32-bit machines
Message-Id: <CAMuHMdX16YNs=2AWnne7y4KYLagXkXtRbxsZUXa+cP1s6vg43w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <749e6480-aed6-041c-0209-8dc74c07f344@cogentembedded.com>
In-Reply-To: <749e6480-aed6-041c-0209-8dc74c07f344@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, andrey.gusakov@cogentembedded.com, Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>, Linux-sh list <linux-sh@vger.kernel.org>

On Mon, Sep 10, 2018 at 10:23 PM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> The driver seems to abuse *unsigned long* not only for the (32-bit)
> register values but also for the 'sh_cmt_channel::total_cycles' which
> needs to always be 64-bit -- as a result, the clocksource's mask is
> needlessly clamped down to 32-bits on the 32-bit machines...
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
