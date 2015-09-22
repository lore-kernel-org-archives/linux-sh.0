From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 22 Sep 2015 07:12:12 +0000
Subject: Re: [PATCH v2 1/2] pinctrl: sh-pfc: Remove hardcoded IRQ numbers
Message-Id: <CAMuHMdUVQhhGsCtAtBjYW0xVtaiiqXMrBqCztq9fTXX3p03Hdw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442905694-2317-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442905694-2317-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 22, 2015 at 9:08 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Now that all ARM-based Renesas SoCs use multiplatform kernels only the
> hardcoded IRQ numbers can be dropped as they're dynamically allocated.
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
