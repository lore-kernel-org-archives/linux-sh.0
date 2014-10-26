From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 26 Oct 2014 19:31:47 +0000
Subject: Re: [PATCH] ARM: shmobile: Remove FSF address from copyright headers
Message-Id: <CAMuHMdUBMo-v0B-fF1yNeMfW8NLJV__Zs-s3eQi-yY6B-iQw2Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414333227-15674-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414333227-15674-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Oct 26, 2014 at 3:20 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The information is already included in the COPYING file in the kernel
> sources root directory, we don't want to modify all source files when
> the FSF will move to a new address, and I'm tired of seeing the related
> checkpatch.pl warnings.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> The fun part will be to merge this while minimizing the risk of conflicts :-)

Simon can just ask Linus to pull all of this at once after v3.18-rc2?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
