From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 23 Jan 2008 06:58:26 +0000
Subject: [PATCH][0/2] usb: sm501 ohci controller patches V4/V2
Message-Id: <20080123065826.488.14168.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

usb: sm501 ohci controller patches V4/V2

 [1/2] usb: dma bounce buffer support V4
 [2/2] usb: ohci-sm501 driver V2

The sm501 usb host controller is a regular ohci implementation but with the
exception that it can only do dma to a certain area of memory. This memory is
sm501 specific and the mfd driver for sm501 currently divides this memory
between the framebuffer and the usb host controller.

To support the sm501 usb host controller we need to allocate all usb data from
this sm501 memory. The function dma_declare_coherent_memory() helps us with
that - all dma_alloc_coherent() calls will end up allocating such memory.

The USB core does however allocate data using kmalloc, so to fully support
such a behaviour we need dma bounce buffer support. These bounce buffers
can be requested using the flag HCD_LOCAL_MEM.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/usb/core/buffer.c     |    9 -
 drivers/usb/core/hcd.c        |  176 ++++++++++++++++++++++++---
 drivers/usb/core/hcd.h        |    1 
 drivers/usb/host/ohci-hcd.c   |    5 
 drivers/usb/host/ohci-sm501.c |  264 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 432 insertions(+), 23 deletions(-)
