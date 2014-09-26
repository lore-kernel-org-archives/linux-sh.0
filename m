From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 26 Sep 2014 09:27:26 +0000
Subject: Re: [PATCH 00/13] ARM: shmobile: R-Mobile: DT PM domain support
Message-Id: <CAMuHMdXJPQjRQip+YY0jysR5pzU3hEz-QQ6C-GZQmDKqU1TreA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1411662520-22795-1-git-send-email-geert+renesas@glider.be>
 <3136347.ncZoJtR6MK@vostro.rjw.lan>
In-Reply-To: <3136347.ncZoJtR6MK@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Rafael,

On Thu, Sep 25, 2014 at 10:19 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> Rafael: If you accept "PM / Domains: Add genpd attach/detach callbacks", it
>> would be good to get this patch in v3.18-rc1, as it's the only hard dependency
>> on linux-pm.git for the rest of this series. The other parts have relaxed
>> ordering constraints due to the separation of code and DTS.
>
> OK, this one looks good to me, so I can push it for 3.18.

Thank you very much!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
