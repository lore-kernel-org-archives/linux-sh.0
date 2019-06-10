From: Christoph Hellwig <hch@lst.de>
Date: Mon, 10 Jun 2019 21:20:15 +0000
Subject: [PATCH 15/15] riscv: add binfmt_flat support
Message-Id: <20190610212015.9157-16-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190610212015.9157-1-hch@lst.de>
In-Reply-To: <20190610212015.9157-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Use the generic support with arguments are on the stack.  Same as arm
and m68k.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/Kconfig            | 2 ++
 arch/riscv/include/asm/Kbuild | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 0c4b12205632..2e3b60cdeef4 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -17,7 +17,9 @@ config RISCV
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_IRQ
+	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_WANT_FRAME_POINTERS
+	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
 	select CLONE_BACKWARDS
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 5ee646619cc3..1efaeddf1e4b 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -5,6 +5,7 @@ generic-y += compat.h
 generic-y += device.h
 generic-y += div64.h
 generic-y += extable.h
+generic-y += flat.h
 generic-y += dma.h
 generic-y += dma-contiguous.h
 generic-y += dma-mapping.h
-- 
2.20.1
