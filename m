From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 23 Oct 2014 17:51:14 +0000
Subject: Re: [PATCH 4/4] mm: cma: Use %pa to print physical addresses
Message-Id: <CAMuHMdWA7WvbzV-Na2tuTkSWFykrKU3RXCPKqWkW2rpyqPzGWA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414074828-4488-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1414074828-4488-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414074828-4488-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Oct 23, 2014 at 4:33 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Casting physical addresses to unsigned long and using %lu truncates the
> values on systems where physical addresses are larger than 32 bits. Use
> %pa and get rid of the cast instead.
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
