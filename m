From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Dec 2014 13:58:56 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779: Use MSTP for SCIF clocks
Message-Id: <CAMuHMdW0xmERWGZkGVt-AH8rqww3VM1zMF6svw6TGnv6-pbMuQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141215045608.316.71001.sendpatchset@w520>
In-Reply-To: <20141215045608.316.71001.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 15, 2014 at 5:56 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Hook up MSTP clocks to SCIF devices on r8a7779 to allow
> clock gating to work as expected.
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
