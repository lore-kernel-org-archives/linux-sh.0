From: Vinod Koul <vinod.koul@linux.intel.com>
Date: Fri, 20 Jul 2012 06:12:28 +0000
Subject: Re: [PATCH 0/7 v2] dma: sh: stop using .private
Message-Id: <1342764028.1726.195.camel@vkoul-udesk3>
List-Id: <linux-sh.vger.kernel.org>
References: <1341484183-10757-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1341484183-10757-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 2012-07-05 at 12:29 +0200, Guennadi Liakhovetski wrote:
> This patch series supersedes the one from yesterday with the same title. 
> The 4 patches from v1 are all unchanged, v2 just prepends them with 3 more 
> preparatory patches. From the original series description:
> 
> Here's an attempt to convert the shdma driver to a new method, whereby a 
> centrally provided filter function is used and the DMA_SLAVE_CONFIG command 
> is enabled for slave operation. The last patch is an illustration of how 
> this new method shall be used. If this approach is acceptable, I'll also 
> convert the remaining shdma user drivers. This patch series goes on top of 
> my earlier patches to split shdma.c.
Applied thanks.

Fixed one checkpatch issue though!!

ERROR: "(foo*)" should be "(foo *)"
#996: FILE: drivers/dma/sh/shdma-base.c:662:
+		config = (struct dma_slave_config*)arg;

Please *always* run checkpatch on the patches you send

-- 
~Vinod

