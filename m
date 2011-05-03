From: Simon Horman <horms@verge.net.au>
Date: Tue, 03 May 2011 05:26:31 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: add DMA for MMCIF and fix its
Message-Id: <20110503052631.GA20328@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 29, 2011 at 07:11:59PM +0200, Guennadi Liakhovetski wrote:
> Add DMA mode support for the MMCIF controller on mackerel, check not
> only for statically built MMCIF driver, but also for modular.

Hi Guennadi,

is it possible to split this into two separate patches?
The DMA an moldule changes do not seem strongly related to each other.

