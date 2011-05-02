From: Simon Horman <horms@verge.net.au>
Date: Mon, 02 May 2011 11:35:22 +0000
Subject: Re: [PATCH 2/2] ARM: arch-shmobile: Use multiple irq vectors for
Message-Id: <20110502113522.GE32576@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1303890238-8372-3-git-send-email-horms@verge.net.au>
In-Reply-To: <1303890238-8372-3-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 02, 2011 at 12:17:27PM +0200, Guennadi Liakhovetski wrote:
> On Wed, 27 Apr 2011, Simon Horman wrote:
> 
> > This patch reverts "ARM: mach-shmobile: sh7372 SDHI vector merge" and
> > supplies 3 IRQ resources for each SDHI block.
> > 
> > Some blocks have a 4th IRQ, but this is used for DRM feathres
> > that I do not have access tot he documentation for and are almost
> > certainly tainted by licensing issues. So the 4th IRQ is not
> > hooked-up even if it exists.
> 
> No technical objections, but - could you maybe explain briefly why we want 
> multiple IRQ sources? Since there are implementations, that use one IRQ 
> for all sources, this mode has to be supported anyway, so, we will have to 
> be able to demux IRQs in software. Adding a multiple IRQ mode adds 
> complexity to the driver, because now both modes will have to be 
> supported, and you'll need more thorough locking to handle possible 
> concurrency, especially on SMP. What advantages does this multiple IRQ 
> mode bring?

Hi Guennadi,

sorry for not explaining the motivation earlier.

As I understand things, on the mackerel/ap4evb/sh7372 the current
multiplexing situation is actually fine.  There may be some slight gains to
be had from a locking point of view in having separate IRQ handles.  And
there may be an argument that breaking things out is more aesthetically
pleasing. But there are know correctness issues as far as I know.

The real point of this work is that its needed for the ag5evm/sh73a0.
Currently there is an IRQ multiplexing mechanism for the ag4evm out of
tree.  And as I understand things it is most likely racy as the all the
relevant IRQs can't be disabled by the multiplexing mechanism (I believe it
is because they don't share a clock. Magnus, can you fill in some details
here?).

So while the current solution has been satisfactory up to date, moving
forwards there will be hardware that needs this multiple IRQ handlers.

And the reason that I am developing this on mackerel/ap4evb/sh7372
is that it should work correctly there and it is a platform that
I have access to for development purposes.

