From: Christoph Hellwig <hch@infradead.org>
Date: Tue, 15 Oct 2019 07:43:54 +0000
Subject: Re: [PATCH] sh: use dma_to_phys() instead of dev->dma_pfn_offset
Message-Id: <20191015074354.GB3464@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20191011165129.29655-1-nsaenzjulienne@suse.de>
In-Reply-To: <20191011165129.29655-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

On Fri, Oct 11, 2019 at 06:51:29PM +0200, Nicolas Saenz Julienne wrote:
> It's more explicit and lets dma-direct handle the specifics of how to
> translate addresses.
> 
> On top of that get rid of warnings as, since the introduction of commit
> 6fa1d28e38c ("sh: use generic dma_noncoherent_ops"), it's impossible for
> the dev to be NULL.

This looks ok, but the real answer is to switch sh to the generic
dma remapping code.  I've been trying to get this included for about
a year now, but never managed to get a reply from the sh maintainers.

Here is the last one:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/sh-dma-remap
