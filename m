From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Jan 2015 09:18:24 +0000
Subject: Re: [PATCH 1/4] ARM: shmobile: r8a7790: tidyup SDHI register size on DTSI
Message-Id: <CAMuHMdU6pJ8b-PsR-EQ+YgbvF6gmA_1a5PvRR7SxPCgcJL1-KA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbk7y1gh.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbk7y1gh.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 16, 2015 at 2:10 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> r8a7790 SDHI ch0/ch1 has SD_DMACR which is lacated in 0x324.

As you're gonna resend this next week: "located" (also in the r8a7791 patch).

> This patch updates register size

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
