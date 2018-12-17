From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Dec 2018 13:27:47 +0000
Subject: Re: [PATCH v4 2/4] serial: sh-sci: Fix crash in rx_timer_fn() on PIO fallback
Message-Id: <CAMuHMdUHUUEd0KQ3NP4M_hiYuwcyYRMiET3BamC4Qmrc3oEBBA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213184444.21904-1-geert+renesas@glider.be>
 <20181213184444.21904-3-geert+renesas@glider.be> <20181217132241.4lbaeshn2rnlhjqe@verge.net.au>
In-Reply-To: <20181217132241.4lbaeshn2rnlhjqe@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ulrich Hecht <uli+renesas@fpond.eu>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>

Hi Simon,

On Mon, Dec 17, 2018 at 2:22 PM Simon Horman <horms@verge.net.au> wrote:
> On Thu, Dec 13, 2018 at 07:44:42PM +0100, Geert Uytterhoeven wrote:
> > When falling back to PIO, active_rx must be set to a different value
> > than cookie_rx[i], else sci_dma_rx_find_active() will incorrectly find a
> > match, leading to a NULL pointer dereference in rx_timer_fn() later.
> >
> > Use zero instead, which is the same value as after driver
> > initialization.
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> This looks good so to me long as dmaengine_submit() doesn't return 0.
> Is that the case?

include/linux/dmaengine.h:

/**
 * typedef dma_cookie_t - an opaque DMA cookie
 *
 * if dma_cookie_t is >0 it's a DMA request cookie, <0 it's an error code
 */
typedef s32 dma_cookie_t;
#define DMA_MIN_COOKIE  1

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
