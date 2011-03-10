From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 10 Mar 2011 07:05:41 +0000
Subject: [PATCH 00/02] virtio: Virtio platform driver
Message-Id: <20110310070541.27327.52089.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org, mst@redhat.com

virtio: Virtio platform driver

[PATCH 01/02] virtio: Break out lguest virtio code to virtio_lguest.c
[PATCH 02/02] virtio: Add virtio platform driver

These patches add a virtio platform driver to the Linux kernel. This
platform driver has the same role as the virtio_pci driver, but instead
of building on top of emulated PCI this driver is making use of the
platform bus together with driver specific callbacks.

The virtio platform driver can be seen as a reusable implementation of
the lguest virtio driver - in fact, most code is just taken directly
from lguest_device.c and reworked to fit the platform device driver
abstraction. The first patch breaks out code that can be shared between
lguest and the virtio platform driver.

This code has been used to implement a mailbox interface between the
two processor cores included in the sh7372 SoC. The sh7372 contains
one ARM Cortex-A8 and one SH4AL-DSP core, and in the prototype two
Linux kernels are running in parallel on the same chip. Virtio serves
as a communication link between the two cores.

Tested on the SH architecture, but should work on any architecture.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/x86/lguest/Kconfig          |    1 
 drivers/lguest/lguest_device.c   |  209 ----------------------------
 drivers/virtio/Kconfig           |   13 +
 drivers/virtio/Makefile          |    2 
 drivers/virtio/virtio_lguest.c   |  205 ++++++++++++++++++++++++++++
 drivers/virtio/virtio_platform.c |  282 +++++++++++++++++++++++++++++++++++++++
 include/linux/lguest.h           |    1 
 include/linux/lguest_device.h    |   46 ++++++
 include/linux/virtio_platform.h  |   12 +
 9 files changed, 564 insertions(+), 207 deletions(-)
