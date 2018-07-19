From: Christoph Hellwig <hch@lst.de>
Date: Thu, 19 Jul 2018 13:05:11 +0000
Subject: use the generic dma-noncoherent code for sh
Message-Id: <20180719130516.1989-1-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-sh@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org

Hi all,

can you review these patches to switch sh to use the generic
dma-noncoherent code?  All the requirements are in mainline already
and we've switched various architectures over to it already.
