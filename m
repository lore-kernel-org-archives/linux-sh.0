From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Nov 2014 11:04:01 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: r8a7740 dtsi: Correct IIC0 parent clock
Message-Id: <CAMuHMdU0OhpbyKqNx811_N0HMT2dK+qRVA4ae+=L-OqXg2psNA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415181874-21549-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415181874-21549-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Nov 12, 2014 at 10:09 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>>>   I am not aware of any run-time effect of this problem.
>
> Indeed. Both clocks run at the same frequency, and TTBOMK the HPP clock
> cannot be disabled (is that correct?), so the IIC0 clock cannot be inadvertently
> be disabled because the common part is disabled through another clock.

I have to correct myself: this patch does fix something visible.
With CONFIG_DEBUG_LL=y, there's no longer a periof of garbage output
on the serial console, when the i2c driver disables the IIC0 clock.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
