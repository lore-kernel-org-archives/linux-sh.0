From: Takashi Yoshii <yoshii.takashi@renesas.com>
Date: Mon, 09 Mar 2009 09:33:48 +0000
Subject: read/write[bwl] endian conversion for big-endian PCI ?
Message-Id: <49B4E27C.4050108@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

# Attached patch is not to be checked in to the repository.

I found the patch attached is needed to make a NIC on SH7780LCR
 working in big-endian mode.

Reading the source code drivers/nic/r8169.c, 
what I can guess about the system it has been written for, are

1. Data structures transfered by PCI DMA are little endian.
 It users explicit conversion when accessing descriptors.

2. Data read/written by PCI target transfer are big(=cpu) endian.
 MMIO registers are accessed read/write[bwl] without conversion.
 Or perhaps read/write[bwl]() do the conversion.
 I'v found some of powerPC platforms have such code for PCI space.

Because PCI is defined only for little-endian, endian conversion which
PCI bridge on big-endian hardware provides can vary.
I know I can not help conversion tasks depend on each platforms.

But, I think read/write[bwl]() might have a rule about cross-endian access.
Do they provide endian conversion ?

I could not find the answer in
 Documentation/DocBook/deviceiobook
 Documentation/PCI/
.

Does anybody know the document and/or discussion?

Cheers,
/yoshii

diff --git a/arch/sh/drivers/pci/pci-sh7780.c b/arch/sh/drivers/pci/pci-sh7780.c
index 078dc44..7728ccc 100644
--- a/arch/sh/drivers/pci/pci-sh7780.c
+++ b/arch/sh/drivers/pci/pci-sh7780.c
@@ -154,6 +154,9 @@ int __init sh7780_pcic_init(struct sh4_pci_address_map *map)
 	/* SH7780 init done, set central function init complete */
 	/* use round robin mode to stop a device starving/overruning */
 	word = SH4_PCICR_PREFIX | SH4_PCICR_CFIN | SH4_PCICR_FTO;
+#if defined(CONFIG_CPU_BIG_ENDIAN)
+	word |= SH4_PCICR_BSWP;
+#endif
 	pci_write_reg(word, SH4_PCICR);
 
 	return 1;
diff --git a/drivers/net/r8169.c b/drivers/net/r8169.c
index 0771eb6..de9d72b 100644
--- a/drivers/net/r8169.c
+++ b/drivers/net/r8169.c
@@ -87,11 +87,11 @@ static const int multicast_filter_limit = 32;
 
 /* write/read MMIO register */
 #define RTL_W8(reg, val8)	writeb ((val8), ioaddr + (reg))
-#define RTL_W16(reg, val16)	writew ((val16), ioaddr + (reg))
-#define RTL_W32(reg, val32)	writel ((val32), ioaddr + (reg))
+#define RTL_W16(reg, val16)	writew (cpu_to_le16(val16), ioaddr + (reg))
+#define RTL_W32(reg, val32)	writel (cpu_to_le32(val32), ioaddr + (reg))
 #define RTL_R8(reg)		readb (ioaddr + (reg))
-#define RTL_R16(reg)		readw (ioaddr + (reg))
-#define RTL_R32(reg)		((unsigned long) readl (ioaddr + (reg)))
+#define RTL_R16(reg)		le16_to_cpu(readw (ioaddr + (reg)))
+#define RTL_R32(reg)		((unsigned long) le32_to_cpu(readl (ioaddr + (reg))))
 
 enum mac_version {
 	RTL_GIGA_MAC_VER_01 = 0x01, // 8169

