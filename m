From: Christoph Hellwig <hch@infradead.org>
Date: Tue, 15 Oct 2019 09:49:32 +0000
Subject: Re: [PATCH] sh: use dma_to_phys() instead of dev->dma_pfn_offset
Message-Id: <20191015094932.GA20762@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20191011165129.29655-1-nsaenzjulienne@suse.de>
 <20191015074354.GB3464@infradead.org>
 <453a9a954f4967a68a7023c8c79a39fdcb69254a.camel@suse.de>
In-Reply-To: <453a9a954f4967a68a7023c8c79a39fdcb69254a.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

On Tue, Oct 15, 2019 at 10:05:52AM +0200, Nicolas Saenz Julienne wrote:
> I see, well I guess this one will get ignored too :)
> 
> > Here is the last one:
> > 
> > http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/sh-dma-remap
> 
> I'd be happy with your series too.

Let's see if we can make any progress this merge window..

> In case you're wondering why I want this: I'm interested in supporting multiple
> dma-ranges in DT. So I was looking at the amount of work needed to centralize
> usage of dev->dma_pfn_offset. This one patch seemed trivial enough to send
> right away.

Sounds useful, thanks!
