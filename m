From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sun, 25 Sep 2011 14:19:26 +0000
Subject: Re: [PATCH] dma: shdma: transfer based runtime PM
Message-Id: <Pine.LNX.4.64.1109251612320.11831@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1108181650530.5245@axis700.grange> 
 <1314282386.1606.42.camel@vkoul-udesk3>  <Pine.LNX.4.64.1108251636190.17190@axis700.grange>
  <1314283286.1606.52.camel@vkoul-udesk3>  <Pine.LNX.4.64.1108251648100.17190@axis700.grange>
  <1314292850.1606.88.camel@vkoul-udesk3>  <Pine.LNX.4.64.1108260107550.17190@axis700.grange>
  <1314619909.1606.130.camel@vkoul-udesk3>  <Pine.LNX.4.64.1108291419410.31184@axis700.grange>
  <1314622113.1606.134.camel@vkoul-udesk3>  <Pine.LNX.4.64.1108300906590.19151@axis700.grange>
  <1314698257.1606.159.camel@vkoul-udesk3>  <Pine.LNX.4.64.1108301321500.19151@axis700.grange>
  <Pine.LNX.4.64.1109051007230.1112@axis700.grange>  <1315227964.26251.68.camel@vkoul-udesk3>
 <1315235596.26251.201.camel@vkoul-udesk3>
In-Reply-To: <1315235596.26251.201.camel@vkoul-udesk3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Paul Mundt <lethal@linux-sh.org>

Hi Vinod

On Mon, 5 Sep 2011, Vinod Koul wrote:

[snip]

> This patch fails to apply for me, can you please rebase it to me tree
> and resend, I will apply it later this week

Sorry, it didn't apply, because I apparently forgot to send out this 
patch:

http://marc.info/?l=linux-kernel&m1695995404173&w=2

which I've also cc'ed to you a couple of minutes ago. With that patch 
applied first, the patch in question

http://marc.info/?l=linux-kernel&m1386369726846&w=2

still applies cleanly on top of the "next" branch of your slave-dma tree.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
