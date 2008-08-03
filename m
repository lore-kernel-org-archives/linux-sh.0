From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 03 Aug 2008 23:52:47 +0000
Subject: Re: [RFT PATCH] SuperH HSPI controller driver.
Message-Id: <20080803235247.GA6682@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080721090744.GA16714@roarinelk.homelinux.net>
In-Reply-To: <20080721090744.GA16714-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, spi-devel-general-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, Jul 21, 2008 at 11:07:44AM +0200, Manuel Lauss wrote:
> Here is a very simple driver for the HSPI block on many SuperH processors.
> I could only subject it to limited testings, as my sole SPI device here is
> a write-only 8bit digital poti.  It seems to do the right thing as far as
> I could see on an oscilloscope.
> 
> The driver doesn't do DMA and pushes/pops bytes one-at-a-time from/to fifos
> (I'm going to fix that at a later time).
> 
> Please test and comment!
> 
> Thanks,
> 	Manuel Lauss
> 
> ---
> 
> A simple driver for the HSPI block found on many SuperH processors.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

I have no outstanding issues with this, though I did just break it with
the header reorg. If David is fine with it and wants to Ack it, I can
take it through my tree.
