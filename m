From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Jul 2015 09:08:58 +0000
Subject: Re: [PATCH] drm: rcar-du: Add dependency to OF
Message-Id: <CAMuHMdUTTkSqSZx1Gmvp7hznyecy7SV625b2by=VR-KUipUA7w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1437036247-30168-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1437036247-30168-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>

On Thu, Jul 16, 2015 at 10:44 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The driver requires OF support, add a dependency in Kconfig and remove
> the platform_device_id table that isn't used anymore.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Once Simon has queued up the removal of board-marzen.c:

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
