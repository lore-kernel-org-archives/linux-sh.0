From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Tue, 14 Jul 2020 16:10:21 +0000
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-Id: <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200714121856.955680-1-hch@lst.de>
 <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx>
In-Reply-To: <20200714155914.GA24404@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On 7/14/20 5:59 PM, Rich Felker wrote:
> I'd like to have a way to test the DMA changes or testing feedback
> from someone using an affected configuration just because they're
> sufficiently nontrivial (Adrian might be able to do this? If so that'd
> be great; if not let me know if it's testable in qemu), but the rest
> look good to go.

I'll try to build and boot a test kernel on my SH7785LCR tonight or tomorrow (CEST).

> Big thanks for your efforts to clean all this up!

Agreed. Much appreciated.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
