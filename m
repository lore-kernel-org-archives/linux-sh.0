From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 07 May 2014 14:57:13 +0000
Subject: Re: [PATCH 4/4] clk: shmobile: Add R8A7740-specific clock support
Message-Id: <CAMuHMdXgncN421x4KmLkVw8WoYkK336rpoyGRoHrDi6UuZgXnA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398172752-30567-5-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1398172752-30567-5-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 22, 2014 at 3:19 PM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
> +struct div4_clk {
> +       const char *name;
> +       unsigned int reg;
> +       unsigned int shift;
> +       unsigned int mask;
> +       int flags;

mask and flags are unused.

> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
