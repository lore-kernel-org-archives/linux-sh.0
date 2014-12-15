From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Mon, 15 Dec 2014 21:33:06 +0000
Subject: [PATCH RFC 0/5] virtio pci: virtio 1.0 support
Message-Id: <1418679168-1011-1-git-send-email-mst@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux-foundation.org, linux-sh@vger.kernel.org, cornelia.huck@de.ibm.com

This is on top of 3.19 master + my bugfix patches, and adds virtio 1.0 support
to virtio pci.
This is 3.20 material I think.

Would like to get feedback on s390 change as it's untested.

Michael S Tsirkin (2):
  pci: add pci_iomap_range
  s390: add pci_iomap_range

Michael S. Tsirkin (2):
  virtio_pci: modern driver
  virtio_pci: macros for PCI layout offsets.

Rusty Russell (1):
  virtio-pci: define layout for virtio 1.0

 arch/s390/include/asm/pci_io.h     |   1 +
 drivers/virtio/virtio_pci_common.h |  29 +-
 include/asm-generic/pci_iomap.h    |  10 +
 include/uapi/linux/virtio_pci.h    |  92 +++++
 tools/virtio/linux/virtio_config.h |  45 +++
 arch/s390/pci/pci.c                |  34 +-
 drivers/virtio/virtio_pci_common.c |  13 +-
 drivers/virtio/virtio_pci_modern.c | 684 +++++++++++++++++++++++++++++++++++++
 lib/pci_iomap.c                    |  35 +-
 tools/virtio/virtio_test.c         |   1 +
 drivers/virtio/Makefile            |   2 +-
 11 files changed, 929 insertions(+), 17 deletions(-)
 create mode 100644 drivers/virtio/virtio_pci_modern.c

-- 
MST

