From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 25 Apr 2014 16:55:39 +0000
Subject: Re: [ PATCH v2 00/17] ARM: shmobile: Enable drivers/sh/pm_runtime.c on multi-platform
Message-Id: <CAMuHMdX+Li_8gsrfOexwwT28NP2oTjyG6yzKmw2tm8wbL1HLKg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397565253-22741-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1397565253-22741-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Tue, Apr 15, 2014 at 5:52 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>> As the goal is to remove the setup-*.c files, have you thought about where the
>> sh_pm_runtime_init() calls should move to ?
>
> cpg_mstp_clocks_init() would be nice ;-) Unfortunately it's way too early.

However, I've just got an idea...

> I'm looking for a way to tie this into the connection between devices and
> MSTP gate clocks.

That's "[PATCH/RFC 0/4] of: Register clocks for Runtime PM with PM core"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
