From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 23 Aug 2011 09:15:46 +0000
Subject: [PATCH] sh: fix the compile error in setup-sh7757.c
Message-Id: <4E536FC2.7090306@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Fix the following build errors:

  CC      arch/sh/kernel/cpu/sh4a/setup-sh7757.o
arch/sh/kernel/cpu/sh4a/setup-sh7757.c:681: error: implicit declaration of =
function =91DMA_BIT_MASK=92
arch/sh/kernel/cpu/sh4a/setup-sh7757.c:681: error: initializer element is n=
ot constant
arch/sh/kernel/cpu/sh4a/setup-sh7757.c:681: error: (near initialization for=
 =91usb_ehci_device.dev.coherent_dma_mask=92)
arch/sh/kernel/cpu/sh4a/setup-sh7757.c:705: error: initializer element is n=
ot constant
arch/sh/kernel/cpu/sh4a/setup-sh7757.c:705: error: (near initialization for=
 =91usb_ohci_device.dev.coherent_dma_mask=92)
make[3]: *** [arch/sh/kernel/cpu/sh4a/setup-sh7757.o] Error 1

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh=
4a/setup-sh7757.c
index e915dea..0555929 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -15,6 +15,7 @@
 #include <linux/serial_sci.h>
 #include <linux/io.h>
 #include <linux/mm.h>
+#include <linux/dma-mapping.h>
 #include <linux/sh_timer.h>
 #include <linux/sh_dma.h>

--=20
1.7.1
