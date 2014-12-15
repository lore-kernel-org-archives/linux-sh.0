From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Dec 2014 14:00:53 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779: Use R8A7779_CLK_P as SCIF parent clock
Message-Id: <CAMuHMdUs2gri8r6eEJLWCERwz7Q-CFhQkEVpqEwyYcXkUU4uyA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141215050034.357.93456.sendpatchset@w520>
In-Reply-To: <20141215050034.357.93456.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 15, 2014 at 6:00 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Use R8A7779_CLK_P as parent clock for SCIF devices on r8a7779.
> With this change in place the SCIF CCF handling matches the
> legacy clock code. Also, this matches the data sheet.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
