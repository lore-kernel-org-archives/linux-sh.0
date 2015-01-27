From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 27 Jan 2015 08:53:25 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: r8a7794: alt: Enable ethernet controller
Message-Id: <CAMuHMdXQJFts__Ee0g8DocbL868jQM5EHHx5sSzcPXfZLaRGaQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422348356-18675-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1422348356-18675-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 27, 2015 at 9:45 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Enable the ethernet controller for the Alt board. Pin muxing entries are
> currently left out as r8a7794 pin control support isn't available yet.
> We thus rely on the boot loader to configure ethernet pins for now.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Looks OK (I don't have an Alt, nor schematics).

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
