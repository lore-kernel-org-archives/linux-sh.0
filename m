From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 30 Nov 2009 02:16:26 +0000
Subject: Re: [PATCH 1/2] sh: mach-ecovec24: modify memory area calculation
Message-Id: <20091130021626.GA7217@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <u8wdto9qh.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <u8wdto9qh.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 26, 2009 at 11:46:29AM +0000, Matt Fleming wrote:
> On Thu, Nov 26, 2009 at 08:08:17PM +0900, Kuninori Morimoto wrote:
> > 
> > Dear Matt
> > 
> > Thank you for checking patch !!
> > 
> 
> No problem.
> 
> > > I think both of these patches should be using the variable
> > > "cached_to_uncached", rather than hard coding the value 0x20000000.
> > 
> > I didn't know cached_to_uncached.
> > But I wonder can I use this variable here (romImage) ?
> > I think we can use macro here, but can not variable.
> > 
> 
> Ah, sorry, I forgot that this is a romImage thing. Yeah, including
> system_32.h causes lots of assembler errors to appear so I'm guessing it
> was never intended to be included by assembly code.

It was never intended to be used in assembly code, no, but assembly code
was not intended to make cached<->uncached transitions on its own either.
Applying the 0x20000000 shift here works fine for legacy mode, but will
obviously completely blow up on 32-bit mode when legacy mappings don't
exist.

As it stands now this cached<->uncached thing is completely bogus and
doesn't deserve to live, there is no way to make this transition safely
from a fixed macro given the differing boot options available. EcoVec
presumably also supports a 32-bit boot mode that will be broken by this.

Basically any new code referencing P1SEG or P2SEG definitions is broken
by design and is grounds for an immediate NAK. The sooner we can kill
those macros off in their entirety the better.
