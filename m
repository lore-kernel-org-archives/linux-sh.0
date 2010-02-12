From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 12 Feb 2010 03:54:58 +0000
Subject: Re: [PATCH 0/5 v2] sh: dmaengine driver improvements
Message-Id: <20100212035458.GB7229@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1002111647350.4484@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1002111647350.4484@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 11, 2010 at 05:50:00PM +0100, Guennadi Liakhovetski wrote:
> V2 of this patchset addresses comments to v1 - as is easy to guess;) 
> Specific chenges are described in respective patches. One more patch is 
> added, described in (4) below. Here again the description from v1:
> 
> This patch series introduces several improvements to the shdma SH 
> dmaengine driver:
> 
> 1. (v2) fix handling of DMA error interrupts
> 
> 2. better use platform-dvice infrastructures, resources to describe DMAC 
> implementation details, ioremap address ranges, instead of poking at 
> physical addresses directly.
> 
> 3. separate SH headers for the legacy arch/sh/drivers/dma and the 
> dmaengine driver
> 
> 4. add runtime PM support to shdma dmaengine driver
> 
> This series applies on top of my previous ASoC (SIU) and SH / dmaengine 
> patches.
> 
This definitely looks much better than v1, and should give us a pretty
good foundation for killing off the legacy DMA support incrementally.

Given the dependencies on the SIU patches, I'll roll these in for the
second round of updates during the merge window once the ASoC tree has
merged. This leaves plenty of time for Dan or Iwamatsu-san to voice any
objections in the interim.
