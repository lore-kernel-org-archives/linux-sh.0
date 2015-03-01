From: Simon Horman <horms@verge.net.au>
Date: Sun, 01 Mar 2015 02:15:03 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7794: alt: Fix ethernet controller PHY IRQ line
Message-Id: <20150301021503.GB31918@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 26, 2015 at 04:08:33PM +0200, Laurent Pinchart wrote:
> The PHY IRQ line is connected to external IRQ8, not IRQ0. Fix DT
> accordingly.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, I have queued this up.
