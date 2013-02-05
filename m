From: Simon Horman <horms@verge.net.au>
Date: Tue, 05 Feb 2013 08:15:39 +0000
Subject: Re: [PATCH] ARM: shmobile: Register ARM architected timer
Message-Id: <20130205081538.GA14681@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130205073049.7576.51324.sendpatchset@w520>
In-Reply-To: <20130205073049.7576.51324.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Feb 05, 2013 at 04:30:49PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Register ARM architected timer by default for all mach-shmobile
> systems using late timer.

Thanks, applied to a new soc4 branch and merged into next.
