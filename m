From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Jan 2015 08:05:15 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: Correct SDHI clock labels and output-names
Message-Id: <CAMuHMdXktWqe_+HhORN0iWEMLm=y2fS52PFtPK4RzAHQMHLYXw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422496038-3915-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1422496038-3915-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jan 29, 2015 at 2:47 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> There appears to have been some inconsistency and confusion here as on
> the r8a7790 these clocks are referred to as SD(HI)1 and SD(HI)2 while on
> the r8a7791 and r8a7794 they are referred to as SD(HI)2 and SD(HI)3.
>
> Fixes: 59e79895b95892863 ("ARM: shmobile: r8a7791: Add clocks")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
