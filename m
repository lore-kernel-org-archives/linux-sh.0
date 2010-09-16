From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 16 Sep 2010 07:04:42 +0000
Subject: Re: [PATCH 3/5] DMA: reduce the number of memory allocations
Message-Id: <20100916070442.GA19994@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20100819160255.GA3948@suse.de>
	<20100914085206.GP7336@linux-sh.org>
	<Pine.LNX.4.64.1009150919400.31624@axis700.grange>
	<20100916115815W.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20100916115815W.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Sep 16, 2010 at 11:58:15AM +0900, FUJITA Tomonori wrote:
> > to live with a few broken platforms and drivers until 2.6.37, or we'll 
> > have to find another solution, or that NAK has to be reconsidered
> 
> Needs to revert the patch that causes the regression. The patch does
> the right thing but also breaks some working platforms. You need to
> fix "working" platforms that does wrong things before the patch.

Not going to happen.
