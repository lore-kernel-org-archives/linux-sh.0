From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 Jan 2016 20:47:03 +0000
Subject: Re: [RFC 0/6] mmc: sdhi: add basic r8a7795 support
Message-Id: <CAMuHMdVDjLiKD6xe+dehjs_iEyQswbk=2Xk8biB2eu=HaJcJhQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1453220461-2598-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1453220461-2598-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Dirk,

On Mon, Jan 25, 2016 at 5:25 PM, Dirk Behme <dirk.behme@gmail.com> wrote:
>> I've been thinking about implementing a "delay callback", which waits
>> for bit 13 on previous SoCs and for bit 14 for r8a7795.
>
> Thinking about this, is there a runtime detection of r8a7795 vs. previous
> SoCs? Anything like a function or macro e.g. is_system_gen3() or similar?

The proper way to handle this is to make the driver match against
"renesas,sdhi-r8a7795", cfr. sh_mobile_sdhi_of_match[].

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
