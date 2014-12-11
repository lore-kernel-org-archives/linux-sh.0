From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Dec 2014 08:56:20 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7794: Add QSPI clock to device tree
Message-Id: <CAMuHMdXqHYxJbt=e8WKooJ5621eEOaxG3JkU4uAX9ZwG538UMw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418259561-27862-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1418259561-27862-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Dec 11, 2014 at 1:59 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> [horms: omitted device node and alias; only add clock]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.a, not device nodes:u>

(After fixing renesas,clock-indices, as reported by Morimoto-san)

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
