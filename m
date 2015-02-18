From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Feb 2015 09:10:21 +0000
Subject: Re: [PATCH 03/05] ARM: shmobile: r8a7779: Generic SoC SMP support
Message-Id: <CAMuHMdUjUimt9DD8xqbWxFhcvBO-4XUvF8QSJ5kPSu9zf8tkpw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150218023842.12588.17833.sendpatchset@little-apple>
In-Reply-To: <20150218023842.12588.17833.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 18, 2015 at 3:38 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Add a r8a7779-specific SMP operation pointer to support
> all 4 CPU cores through SMP on r8a7779 without C board code.
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
