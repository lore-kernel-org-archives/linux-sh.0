From: Christoph Hellwig <hch@lst.de>
Date: Wed, 25 Jul 2018 09:40:38 +0000
Subject: use the generic dma-noncoherent code for sh V3
Message-Id: <20180725094043.32443-1-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20180719130516.1989-1-hch@lst.de>
In-Reply-To: <20180719130516.1989-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi all,

can you review these patches to switch sh to use the generic
dma-noncoherent code?  All the requirements are in mainline already
and we've switched various architectures over to it already.

Changes since V2:
 - drop a now obsolete export

Changes since V1:
 - fixed two stupid compile errors and verified them using a local
   cross toolchain instead of the 0day buildbot
