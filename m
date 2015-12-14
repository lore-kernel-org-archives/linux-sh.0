From: Joerg Roedel <joro@8bytes.org>
Date: Mon, 14 Dec 2015 14:56:20 +0000
Subject: Re: [PATCH] iommu: Remove unused Renesas IPMMU/IPMMUI driver
Message-Id: <20151214145620.GC11292@8bytes.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1449244736-22949-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449244736-22949-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Dec 04, 2015 at 04:58:56PM +0100, Geert Uytterhoeven wrote:
> As of commit 44d88c754e57a6d9 ("ARM: shmobile: Remove legacy SoC code
> for R-Mobile A1"), the Renesas IPMMU/IPMMUI driver is no longer used.
> In theory it could still be used on SH-Mobile AG5 and R-Mobile A1 SoCs,
> but that requires adding DT support to the driver, which is not
> planned.
> 
> Remove the driver, it can be resurrected from git history when needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/iommu/Kconfig          |  75 --------
>  drivers/iommu/Makefile         |   2 -
>  drivers/iommu/shmobile-iommu.c | 402 -----------------------------------------
>  drivers/iommu/shmobile-ipmmu.c | 129 -------------
>  drivers/iommu/shmobile-ipmmu.h |  34 ----
>  5 files changed, 642 deletions(-)
>  delete mode 100644 drivers/iommu/shmobile-iommu.c
>  delete mode 100644 drivers/iommu/shmobile-ipmmu.c
>  delete mode 100644 drivers/iommu/shmobile-ipmmu.h

Applied, thanks.

