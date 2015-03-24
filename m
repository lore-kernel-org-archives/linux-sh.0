From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Mar 2015 17:14:57 +0000
Subject: Re: [PATCH 0/3] bockw SD pull-ups
Message-Id: <CAMuHMdWdTkSnVAoQ=m8yH3U7F8BqfovjYPJcoJ1S+pz_N3eusg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426854638-9187-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1426854638-9187-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Fri, Mar 20, 2015 at 1:30 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> This series implements pull-up configuration in the r8a7778 PFC driver
> and sets the SD0_WP and SD0_CD pull-ups on the Bock-W board correctly,
> replacing the hack that is used in the legacy platforms.

Thanks for your series. This is very useful.

We can do a similar thing on the variious R-Car Gen2 SoCs.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
