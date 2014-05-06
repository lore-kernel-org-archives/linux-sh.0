From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 06 May 2014 21:15:48 +0000
Subject: Re: [PATCH] drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI
Message-Id: <CAMuHMdUQBJsQXYeerYOagU+kyRfHvnszyQKRnPg41wsbGQKP2g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398906582-29888-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1398906582-29888-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Sat, May 3, 2014 at 9:29 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> According to Magnus, emev2 doesn't rely on Runtime PM, so it can be
>> removed from the list.
>
> Correct, but let me clarify a bit. At this point we are not using
> Runtime PM in any driver used by EMEV2. At some point it would however
> be good to use Runtime PM, so I don't think it would hurt enabling it.

OK, so let's keep it.

> Actually, I think we should enable it for all our SoCs, so matching on
> "renesas," may make even more sense.

Is there an easy way to match on "renesas,"? I haven't found one yet.

Anyway, I'm a bit reluctant to do that. The final fix may be SoC-dependent,
so having all SoCs listed explicitly allows to selectively remove lines when
needed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
