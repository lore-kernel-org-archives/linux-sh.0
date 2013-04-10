From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Apr 2013 01:12:01 +0000
Subject: Re: [PATCH v2] ARM: shmobile: marzen-reference: use irqpin for lan
Message-Id: <20130410011201.GC11105@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1365556213-11827-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1365556213-11827-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Apr 10, 2013 at 10:10:13AM +0900, Simon Horman wrote:
> This corrects the configuration of the SMSC lan controller
> to use the newly added irqpin as its IRQ source.
> 
> Previously the lan controller did not work. Now it does.
> 
> Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Queued up in the marzen-boards branch.
