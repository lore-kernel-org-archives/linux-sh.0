From: Simon Horman <horms@verge.net.au>
Date: Thu, 22 Aug 2013 06:27:46 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: ape6evm: update MMC0, SDHI0 and SDHI1 with correct regulators
Message-Id: <20130822062745.GP11086@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1375342881-2155-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1375342881-2155-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 22, 2013 at 02:50:04AM +0200, Laurent Pinchart wrote:
> Hi Guennadi,
> 
> Thank you for the patch.
> 
> On Thursday 01 August 2013 09:41:20 Guennadi Liakhovetski wrote:
> > Currently a dummy fixed always-on regulator is used for all 3 SD/MMC
> > interfaces on ape6evm. This patch updates the board to use correct supplies
> > for MMC0, SDHI0 and SDHI1 VDD. SDHI0 VccQ supply regulator should be
> > implemented in a separate patch.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks, I have queued this up in the boards3 branch.
