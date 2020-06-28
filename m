From: Rob Landley <rob@landley.net>
Date: Sun, 28 Jun 2020 00:53:49 +0000
Subject: Re: [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
Message-Id: <e908f620-62b8-f106-a1a8-9887f50216fd@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20200626080717.1999041-1-hch@lst.de>
 <20200626080717.1999041-10-hch@lst.de>
In-Reply-To: <20200626080717.1999041-10-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On 6/26/20 3:07 AM, Christoph Hellwig wrote:
> The code handling non-coherent DMA depends on being able to remap code
> as non-cached.  But that can't be done without an MMU, so using this
> option on NOMMU builds is broken.

I'm working on a nommu j-core board that's doing DMA behind the OS's back at the
moment, which I have a todo item to teach the kernel about. The DMA does not go
through the cache, there's currently a cache flush before looking at the result
instead.

How should this be wired up after your patch?

Rob
