From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 02 Jun 2014 11:26:39 +0000
Subject: Re: [kbuild] [slave-dma:for-linus 55/57] drivers/dma/sh/rcar-hpbdma.c:627:10-15: ERROR: iterator var
Message-Id: <20140602112639.GV17724@mwanda>
List-Id: <linux-sh.vger.kernel.org>
References: <2296161.9WoPSnLurk@avalon>
In-Reply-To: <2296161.9WoPSnLurk@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jun 02, 2014 at 01:09:32PM +0200, Laurent Pinchart wrote:
> Hi,
> 
> On Monday 02 June 2014 10:33:42 Dan Carpenter wrote:
> > tree:   git://git.infradead.org/users/vkoul/slave-dma.git for-linus
> > head:   654fa24965aafcb4bb8a1a14400c5ecea3be76b6
> > commit: ebc6d2d9c8cd48c351da84dd467c0edddc149ded [55/57] dmaengine: shdma:
> > Enable driver compilation with COMPILE_TEST
> > >> drivers/dma/sh/rcar-hpbdma.c:627:10-15: ERROR: iterator variable bound on
> > >> line 626 cannot be NULL
> > --
> > >> drivers/dma/sh/shdma-base.c:812:7-12: ERROR: iterator variable bound on
> > >> line 808 cannot be NULL
> > --
> > >> drivers/dma/sh/shdmac.c:581:10-15: ERROR: iterator variable bound on line
> > >> 580 cannot be NULL
> > --
> > >> drivers/dma/sh/sudmac.c:303:10-15: ERROR: iterator variable bound on line
> > >> 302 cannot be NULL
> >
> > Please consider folding the attached diff :-)
> 
> The shdma_for_each_chan iterator can in theory iterate over NULL elements. 
> I'll need to check whether it can happen in practice before applying the 
> proposed fixes.

Oh...  You're right.  I didn't understand how the
scripts/coccinelle/iterators/itnull.cocci check worked so I wasn't
expecting this false positive.  I will be more careful next time.

These all seem like false positives.

Also really the attached patches are probably not the right thing
because they blame Fengguang for everything when it was my fault.  I
should have editted them.

Sorry for this.

regards,
dan carpenter

