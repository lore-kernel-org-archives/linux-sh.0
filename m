From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Feb 2015 19:47:53 +0000
Subject: Re: [PATCH 2/2] pinctrl: sh-pfc: r8a7791: Remove non existing GPIO pins
Message-Id: <CAMuHMdWAO_ANytCaViQOpjK=N1mk69iHvRRKCzPUstbLdFANYQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424115661-21928-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1424115661-21928-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1424115661-21928-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>

On Mon, Feb 16, 2015 at 8:41 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> GPIO banks 1 and 7 are missing pins 26 to 31. Remove them.
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
