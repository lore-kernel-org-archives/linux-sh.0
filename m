From: Joerg Roedel <joro@8bytes.org>
Date: Fri, 30 Jan 2015 12:48:23 +0000
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Fix IOMMU lookup when multiple IOMMUs are registered
Message-Id: <20150130124822.GA14551@8bytes.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1422134030-11121-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1422134030-11121-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org

On Sat, Jan 24, 2015 at 11:13:50PM +0200, Laurent Pinchart wrote:
> When adding a new device the driver loops over all registered IOMMUs and
> calls the ipmmu_find_utlbs() function to parse the DT iommus attribute.
> The function returns an error when the IOMMU referenced in DT doesn't
> match the current IOMMU. The caller incorrectly breaks from the loop
> immediately when the error is reported, resulting in only the first
> IOMMU being considered.
> 
> Fix this, and while at it move code that isn't specific to an IOMMU
> instance out of the loop.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/iommu/ipmmu-vmsa.c | 49 ++++++++++++++++++++--------------------------
>  1 file changed, 21 insertions(+), 28 deletions(-)

Applied, thanks.

