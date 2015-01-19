From: Joerg Roedel <joro@8bytes.org>
Date: Mon, 19 Jan 2015 13:44:05 +0000
Subject: Re: [GIT PULL FOR v3.20] Renesas IPMMU driver
Message-Id: <20150119134405.GK6343@8bytes.org>
List-Id: <linux-sh.vger.kernel.org>
References: <17336548.2pFUfTyJuB@avalon>
In-Reply-To: <17336548.2pFUfTyJuB@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: iommu@lists.linux-foundation.org, linux-sh@vger.kernel.org

On Fri, Jan 16, 2015 at 06:08:16PM +0200, Laurent Pinchart wrote:
> ----------------------------------------------------------------
> Laurent Pinchart (7):
>       iommu/ipmmu-vmsa: Cleanup failures of ARM mapping creation or attachment
>       iommu/ipmmu-vmsa: Flush P[UM]D entry before freeing the child page table
>       iommu/ipmmu-vmsa: Invalidate TLB after unmapping
>       iommu/ipmmu-vmsa: Add device tree bindings documentation
>       iommu/ipmmu-vmsa: Add device tree support
>       iommu/ipmmu-vmsa: Support multiple micro TLBs per device
>       iommu/ipmmu-vmsa: Remove platform data support
> 
>  .../devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt    |  41 +++++++
>  drivers/iommu/ipmmu-vmsa.c                              | 151 +++++++++++----
>  include/linux/platform_data/ipmmu-vmsa.h                |  24 ----
>  3 files changed, 154 insertions(+), 62 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iommu/renesas,ipmmu-
> vmsa.txt
>  delete mode 100644 include/linux/platform_data/ipmmu-vmsa.h

Pulled, thanks Laurent.

