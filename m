From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 30 Oct 2013 11:40:12 +0000
Subject: Re: [PATCH v3] iommu: shmobile: Enable the driver on all ARM platforms
Message-Id: <1652955.Gs3XDiEUHO@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1383132043-5190-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131030112625.GZ16735@n2100.arm.linux.org.uk>
In-Reply-To: <20131030112625.GZ16735@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Russell,

[CC'ing Mark Brown]

On Wednesday 30 October 2013 11:26:25 Russell King - ARM Linux wrote:
> On Wed, Oct 30, 2013 at 12:20:43PM +0100, Laurent Pinchart wrote:
> > Renesas ARM platforms are transitioning from single-platform to
> > multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> > driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> > and ARCH_SHMOBILE_MULTI and increase build testing coverage.
> > 
> > Don't enable COMPILE_TEST support as the driver doesn't compile on
> > non-ARM platforms due to usage of the ARM DMA IOMMU API.
> 
> For similar reasons as x86, can we please think about using:
> 
> 	depends on ARM
> 	depends on ARCH_SHMOBILE || ARCH_SHMOBILE_MULTI || COMPILE_TEST
> 
> This way we don't end up polluting the configuration for non-shmobile
> platforms.  Same goes for other ARM stuff... the number of options is
> getting rather large and we need to think about keeping that in check
> where its easily possible to do so.

I've been asked to move from depends ARM to no dependency at all, and have 
thus settled for ARM || COMPILE_TEST in most cases, and just ARM where the 
driver couldn't be compiled on other platforms.

I'm fine with your proposed option. As I don't want to respin the series 
dozens of time let's first agree on the course of action, I will then repost 
the patches. Mark, you've pushed towards as few platform dependencies as 
possible, what's your opinion on this ?

-- 
Regards,

Laurent Pinchart

