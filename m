From: Simon Horman <horms@verge.net.au>
Date: Tue, 02 Apr 2013 04:33:05 +0000
Subject: Re: [PATCH v3 0/5] ARM: shmobile: mackerel: streamline SD and MMC devices
Message-Id: <20130402043305.GC1696@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1364591152-4780-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1364591152-4780-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 29, 2013 at 10:05:47PM +0100, Guennadi Liakhovetski wrote:
> This patch series is a split of a previous monolithic patch with no changes
> of the content.
> 
> Guennadi Liakhovetski (5):
>   ARM: shmobile: mackerel: SDHI resources do not have to be numbered
>   ARM: shmobile: mackerel: remove OCR masks, where regulators are used
>   ARM: shmobile: mackerel: switch SDHI and MMCIF interfaces to
>     slot-gpio
>   ARM: shmobile: mackerel: add interrupt names for SDHI0
>   ARM: shmobile: mackerel: clean up MMCIF vs. SDHI1 selection
> 
>  arch/arm/mach-shmobile/board-mackerel.c |  111 +++++++++++--------------------

Thanks Guennadi,

queued up for v3.10 in the boards branch.
