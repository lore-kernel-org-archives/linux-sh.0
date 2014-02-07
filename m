From: Simon Horman <horms@verge.net.au>
Date: Fri, 07 Feb 2014 00:24:37 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: Correct SYS DMAC clock defines
Message-Id: <20140207002436.GC30874@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1391646301-20197-1-git-send-email-horms+renesas@verge.net.au>
 <1910899.86Rh9nDz51@avalon>
In-Reply-To: <1910899.86Rh9nDz51@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Feb 06, 2014 at 11:28:52AM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> Thank you for the patch.
> 
> On Thursday 06 February 2014 09:25:01 Simon Horman wrote:
> > This brings the implementation into line with the documentation.
> > 
> > This problem was introduced when SYS DMAC clock defines were added by
> > ac991dce6498b5fc ("ARM: shmobile: r8a7790: Add clock index macros for DT
> > sources") in v3.13-rc2. I do not believe this results in any problems as
> > these defines do not appear to be used anywhere yet.
> > 
> > Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, I have queued this up.
