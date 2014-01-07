From: Joerg Roedel <joro@8bytes.org>
Date: Tue, 07 Jan 2014 14:36:05 +0000
Subject: Re: [PATCH 0/2] SH Mobile IOMMU fixes
Message-Id: <20140107143603.GE2742@8bytes.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1387300730-28783-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387300730-28783-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Nguyen Viet Dung <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>

On Tue, Dec 17, 2013 at 06:18:48PM +0100, Laurent Pinchart wrote:
> Hello,
> 
> These two small patches fix bugs in the SH Mobile IOMMU driver that result in
> crashes at runtime. Given that the bugs have been present in the driver since
> v3.9 there's no urgency to push the fixes to v3.13.
> 
> Laurent Pinchart (2):
>   iommu/shmobile: Allocate archdata with kzalloc()
>   iommu/shmobile: Turn the flush_lock mutex into a spinlock
> 
>  drivers/iommu/shmobile-iommu.c |  3 +--
>  drivers/iommu/shmobile-ipmmu.c | 10 +++++-----
>  drivers/iommu/shmobile-ipmmu.h |  2 +-
>  3 files changed, 7 insertions(+), 8 deletions(-)

Applied both, thanks.

