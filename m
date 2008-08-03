From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 03 Aug 2008 23:57:02 +0000
Subject: Re: [RFT PATCH] SuperH HSPI controller driver.
Message-Id: <20080803235702.GB6682@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080721090744.GA16714@roarinelk.homelinux.net>
In-Reply-To: <20080721090744.GA16714@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 04, 2008 at 08:52:47AM +0900, Paul Mundt wrote:
> On Mon, Jul 21, 2008 at 11:07:44AM +0200, Manuel Lauss wrote:
> > Here is a very simple driver for the HSPI block on many SuperH processors.
> > I could only subject it to limited testings, as my sole SPI device here is
> > a write-only 8bit digital poti.  It seems to do the right thing as far as
> > I could see on an oscilloscope.
> > 
> > The driver doesn't do DMA and pushes/pops bytes one-at-a-time from/to fifos
> > (I'm going to fix that at a later time).
> > 
> > Please test and comment!
> > 
> > Thanks,
> > 	Manuel Lauss
> > 
> > ---
> > 
> > A simple driver for the HSPI block found on many SuperH processors.
> > 
> > Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> 
> I have no outstanding issues with this, though I did just break it with
> the header reorg. If David is fine with it and wants to Ack it, I can
> take it through my tree.

Taking a quick look at it again, I think you should be able to reuse
arch/sh/include/asm/spi.h as-is, and just drop the header you have now.
