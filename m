From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Sep 2015 00:57:27 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: Remove legacy clock support leftovers
Message-Id: <20150911005726.GB12006@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Aug 29, 2015 at 12:37:17AM +0300, Laurent Pinchart wrote:
> The shmobile_clk_init() function has been removed and the linux/sh_clk.h
> header doesn't need to be included anymore.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks, I have queued this up for v4.4.

N.B: I am not planning to take patch one of this series at this time.
