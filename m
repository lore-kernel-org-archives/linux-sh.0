From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 14 Jul 2020 12:31:00 +0000
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-Id: <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200714121856.955680-1-hch@lst.de>
In-Reply-To: <20200714121856.955680-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Christoph!

On 7/14/20 2:18 PM, Christoph Hellwig wrote:
> can you take a look and possibly pick up the series below that untangles
> and sorts out minor issues with the sh ioremap and dma code?
> 
> I sent this out a few times, but never got an answer.  If you don't
> want to pick up the series I can also take it through one of my trees
> if I get ACKs.

Rich already said he is fine with most of the changes but we need to test
the DMA changes first to make sure they didn't break anything.

Thanks again for your continued efforts.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
