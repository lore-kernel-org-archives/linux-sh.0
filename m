From: Paul Bolle <pebolle@tiscali.nl>
Date: Tue, 18 Nov 2014 10:12:05 +0000
Subject: Re: ARM: shmobile: ARCH_R8A7793?
Message-Id: <1416305525.7024.15.camel@x220>
List-Id: <linux-sh.vger.kernel.org>
References: <1416302641.7024.7.camel@x220>
 <CAMuHMdUFZo+r-N0Ofa1d6PHDtB6dqZfChpLgOz_XtruWD3_a3g@mail.gmail.com>
In-Reply-To: <CAMuHMdUFZo+r-N0Ofa1d6PHDtB6dqZfChpLgOz_XtruWD3_a3g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, 2014-11-18 at 10:36 +0100, Geert Uytterhoeven wrote:
> On Tue, Nov 18, 2014 at 10:24 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> > Your commit 7a2071c58f36 ("ARM: shmobile: Add early debugging support
> > using SCIF(A)") is included in today's linux-next (ie, next-20141118).
> > It adds an (optional) dependency on the Kconfig symbol ARCH_R8A7793. But
> > that symbol isn't part of next-20141118.
> >
> > Is a patch that adds this symbol queued somewhere?
> 
> Not yet. I was just a bit pro-active ;-)

My script will stay silent (as might future, proper, bots) if you don't
add references to Kconfig symbols before adding the symbol itself.
(Whether or not it's worth it to remove this dependency here and add it
to the queue that adds this symbol is up to you, I guess.)

Unless the symbol takes a long time to land I'll try not to bother you
again.

> However, there are already references to r8a7793 in DT binding documentation,
> and in of_device_id arrays in drivers.

I see.


Paul Bolle

