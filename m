From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Fri, 16 Nov 2012 05:46:08 +0000
Subject: [PATCH 0/4] UIO platform device fixes
Message-Id: <1353044772-18803-1-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hjk@hansjkoch.de, gregkh@linuxfoundation.org, magnus.damm@gmail.com, horms@verge.net.au
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Damian Hobson-Garcia <dhobsong@igel.co.jp>

Here are a few fixes for the uio_dmem_genirq driver which allows for
dynamic allocation/deallocation of UIO memory resources via the
DMA-mapping API.


Damian Hobson-Garcia (4):
  drivers: uio_dmem_genirq: Don't mix address spaces for dynamic region
    vaddr
  drivers: uio_dmem_genirq: Don't use DMA_ERROR_CODE to indicate
    unmapped regions
  drivers: uio_dmem_genirq: Allow partial success when opening device
  drivers: uio: Only allocate new private data when probing device tree
    node

 Documentation/DocBook/uio-howto.tmpl |    2 +-
 drivers/uio/uio_dmem_genirq.c        |   25 +++++++++++++++----------
 drivers/uio/uio_pdrv_genirq.c        |    2 +-
 3 files changed, 17 insertions(+), 12 deletions(-)

-- 
1.7.5.4

