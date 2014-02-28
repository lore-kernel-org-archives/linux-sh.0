From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Feb 2014 14:54:11 +0000
Subject: Re: [RFC 0/4] ARM: shmobile: Add CPUFreq support for r8a7790-lager platform
Message-Id: <CAMuHMdUDsw9_7HMtYbWLAv6=eGXp3gB4oa-O0ksFN2kK=4r1JA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1393456190-7870-1-git-send-email-bcousson@baylibre.com>
In-Reply-To: <1393456190-7870-1-git-send-email-bcousson@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 28, 2014 at 3:15 PM, Benoit Cousson <bcousson@baylibre.com> wrote:
> For the voltage, it should be similar, but I do not have any information and
> I'm not sure that the regulator used on the Koelsh board is the same
> (da9210).

Koelsch also has a DA9210 regulator. At first sight, the wiring seems similar.
It's connected to i2c6 instead of i2c3, though.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
