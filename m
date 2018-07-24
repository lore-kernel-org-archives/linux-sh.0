From: Christoph Hellwig <hch@lst.de>
Date: Tue, 24 Jul 2018 12:01:42 +0000
Subject: use the generic dma-noncoherent code for sh V2
Message-Id: <20180724120147.15096-1-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20180719130516.1989-1-hch@lst.de>
In-Reply-To: <20180719130516.1989-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

Hi all,

can you review these patches to switch sh to use the generic
dma-noncoherent code?  All the requirements are in mainline already
and we've switched various architectures over to it already.

Changes since V1:
 - fixed two stupid compile errors and verified them using a local
   cross toolchain instead of the 0day buildbot
