From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 24 Sep 2008 04:54:26 +0000
Subject: Re: about dma-sh driver
Message-Id: <20080924045425.GA6516@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <29ab51dc0809232129j2a54662bg1e5ac50161f6cc94@mail.gmail.com>
In-Reply-To: <29ab51dc0809232129j2a54662bg1e5ac50161f6cc94@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Sep 24, 2008 at 01:29:56PM +0900, Nobuhiro Iwamatsu wrote:
> I'm making  driver who used dma-sh.
> I use a dma-sh driver and want to use another interrupt handler.
> I want to use request, get_residue and other dma_ops functions
> and  change only dma_tei function.
> 
> Dma-sh has a function for IRQ interrupts in dma-sh driver.
> For an IRQ interrupt, we cannot register another interrupt handler.
> 
> Is this right?
> 
> I think about three suggestion.
> 
> 1. Add interrupt handler override function to dma-sh and dma-api.
>     I wrote quick hack this suggestion.
> 
> 2. Create SuperH driver of dma engine and shift dma engine.
>     I hear that dma-sh shifts to dma-engine.
>     But I don't know schedule about dma engine.
> 
> 3. Do both 1 and 2 in parallelism.
> 
#3 is probably the easiest. #1 shouldn't take more than 10 minutes to
hack together, and if you're going to have in-tree stuff making use of
that, it doesn't make any sense to hold that off while the dmaengine work
is happening. We can easily accomodate #1 in 2.6.28.

#2 is on my todo list, but it will likely be at least 2.6.29 or 2.6.30
before I even start looking at it. If you want to start on it before
that, please do. :-)
