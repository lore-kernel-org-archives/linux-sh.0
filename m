From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 11 Sep 2014 07:12:22 +0000
Subject: Re: [PATCH v2] pinctrl: sh-pfc: sh73a0: Remove unnecessary SoC data allocation
Message-Id: <CAMuHMdWz4rfWoPuNsVnPV0Hr9GtX8VgJ==Ho7A0HcO3QZGFXJg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1410386155-3896-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1410386155-3896-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 10, 2014 at 11:55 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The SoC data structure allocated at init time only holds a regulator
> pointer that is only used in the init function. Replace it with a local
> variable and get rid of the SoC data structure allocation altogether.
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
