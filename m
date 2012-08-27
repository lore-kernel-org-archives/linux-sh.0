From: Simon Horman <horms@verge.net.au>
Date: Mon, 27 Aug 2012 08:39:11 +0000
Subject: Re: [PATCH] sh: dma: fix request_irq usage
Message-Id: <20120827083911.GE29274@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1344131645-10813-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1344131645-10813-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 27, 2012 at 05:38:06PM +0900, Simon Horman wrote:
> On Sat, Aug 04, 2012 at 09:54:05PM -0400, Mike Frysinger wrote:
> > When calling request_irq with IRQF_SHARED, the dev cookie must be set
> > (i.e. non-NULL), otherwise the code rejects it immediately with -EINVAL.
> > So restore the logic here where we'd pass a pointer to the name as a
> > dummy unique val.
> > 
> > Otherwise, booting up on my LANDISK system would fail with:
> > 	DMAC Address Error0 request_irq fail
> > 
> > This was introduced in commit 7f47c7189b3e8f19a589f77a3ad169d7b691b582.
> > 
> > Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> 
> This seems reasonable to me.
> 
> Paul, do you have any plans to merge this change?
> I can pull it into my tree if that makes your life easier.

Scratch that, I see that you have already merged this change.
