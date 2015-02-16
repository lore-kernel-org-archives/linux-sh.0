From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Feb 2015 08:49:55 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: Remove r8a7791 platform_device_id entry
Message-Id: <CAMuHMdUTc16ULoW_daSWS=8ob8eyTXBbNSxK_MMO-ROJ5YVxJw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424016101-10111-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424016101-10111-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Feb 15, 2015 at 5:01 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The r8a7791 platform is now DT-only, the driver doesn't need to match
> platform devices by name anymore. Remove the corresponding
> platform_device_id entry.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
