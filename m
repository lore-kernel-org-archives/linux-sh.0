From: Ralf Baechle <ralf@linux-mips.org>
Date: Fri, 30 May 2014 15:48:59 +0000
Subject: Re: [PATCH 2/2] gpio: gpiolib: set gpiochip_remove retval to void
Message-Id: <20140530154859.GK17197@linux-mips.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20140530094025.3b78301e@canb.auug.org.au>
 <1401449454-30895-1-git-send-email-berthe.ab@gmail.com>
 <1401449454-30895-2-git-send-email-berthe.ab@gmail.com>
 <CAMuHMdV6AtjD2aqO3buzj8Eo7A7xc_+ROYnxEi2sdjMaqFiAuA@mail.gmail.com>
In-Reply-To: <CAMuHMdV6AtjD2aqO3buzj8Eo7A7xc_+ROYnxEi2sdjMaqFiAuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, May 30, 2014 at 01:39:15PM +0200, Geert Uytterhoeven wrote:

> > +               if (test_bit(FLAG_REQUESTED, &chip->desc[id].flags))
> > +                       panic("gpio: removing gpiochip with gpios still requested\n");
> 
> panic?
> 
> Is this likely to happen?

And while we're at it - panic() is going to add a \n itself so don't pass a
string ending in \n to panic().

  Ralf
