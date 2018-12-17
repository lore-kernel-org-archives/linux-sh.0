From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Dec 2018 14:50:44 +0000
Subject: Re: [PATCH v4 2/4] serial: sh-sci: Fix crash in rx_timer_fn() on PIO fallback
Message-Id: <20181217145043.ygw2lwtw2v5i4lpm@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213184444.21904-1-geert+renesas@glider.be>
 <20181213184444.21904-3-geert+renesas@glider.be>
 <20181217132241.4lbaeshn2rnlhjqe@verge.net.au>
 <CAMuHMdUHUUEd0KQ3NP4M_hiYuwcyYRMiET3BamC4Qmrc3oEBBA@mail.gmail.com>
In-Reply-To: <CAMuHMdUHUUEd0KQ3NP4M_hiYuwcyYRMiET3BamC4Qmrc3oEBBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ulrich Hecht <uli+renesas@fpond.eu>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>

On Mon, Dec 17, 2018 at 02:27:47PM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Dec 17, 2018 at 2:22 PM Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Dec 13, 2018 at 07:44:42PM +0100, Geert Uytterhoeven wrote:
> > > When falling back to PIO, active_rx must be set to a different value
> > > than cookie_rx[i], else sci_dma_rx_find_active() will incorrectly find a
> > > match, leading to a NULL pointer dereference in rx_timer_fn() later.
> > >
> > > Use zero instead, which is the same value as after driver
> > > initialization.
> > >
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > This looks good so to me long as dmaengine_submit() doesn't return 0.
> > Is that the case?
> 
> include/linux/dmaengine.h:
> 
> /**
>  * typedef dma_cookie_t - an opaque DMA cookie
>  *
>  * if dma_cookie_t is >0 it's a DMA request cookie, <0 it's an error code
>  */
> typedef s32 dma_cookie_t;
> #define DMA_MIN_COOKIE  1

In that case I have no objections.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
