From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 04 Aug 2010 07:37:20 +0000
Subject: Re: [PATCH] sh: Remove memset from coherent memory allocator (for comments)
Message-Id: <20100804073719.GB15098@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTi=0=kR49SHE8mistKJ0hPpjwUk=xXSMw=K_i9Ne@mail.gmail.com>
In-Reply-To: <AANLkTi=0=kR49SHE8mistKJ0hPpjwUk=xXSMw=K_i9Ne@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 29, 2010 at 03:03:20PM +0100, Andrew Murray wrote:
> > -----Original Message-----
> > From: Matt Fleming [mailto:matt@console-pimps.org]
> > Your mail client has word wrapped this patch. Check out
> > Documentation/email-clients.txt to see if there are any tips for your
> > client.
> >
> > This patch seems OK in principal but I think there's a safer way to get
> > the results you want. With your patch, you've changed the semantics of
> > dma_generic_alloc_coherent().  Previously it was guaranteed to return a
> > chunk of zero'd memory, now you're relying on the caller passing
> > __GFP_ZERO to indicate whether they want zero'd memory or not. Which
> > means that if there's a bit of code that expects zero'd memory but
> > doesn't pass __GFP_ZERO, it'll now be broken.
> >
> > (You could argue that this hypothetical caller of dma_alloc_coherent()
> > is already broken if it doesn't pass __GFP_ZERO but my point is that it
> > could be a lot of work to track down all the callers and figure out
> > exactly what guarantees they expect).
> >
> > The safest approach is to follow what x86 does in its
> > dma_generic_alloc_coherent() implementation; it adds the __GFP_ZERO
> > flag
> > unconditionally before allocating pages.
> 
> I share your concern (and also make the broken caller argument). New
> patch...
> 
> From: Andrew Murray <amurray@mpc-data.co.uk>
> 
> This patch reduces the time taken to allocate coherent dma memory.
> 
> Signed-off-by: Andrew Murray <amurray@mpc-data.co.uk>

Looks ok to me. What sort of numbers are we looking at, precisely? It's
been awhile since I profiled our page clearing code, and it would be nice
to see how that compares against a flat memset() on variable page sizes.
