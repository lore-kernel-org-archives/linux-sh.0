From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Mon, 06 Apr 2009 11:37:15 +0000
Subject: Re: [PATCH] sh7785lcr: Map whole address space to PCI
Message-Id: <49D9E96B.3040708@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090402180330.00319c4f.yoshii.takashi@renesas.com>
In-Reply-To: <20090402180330.00319c4f.yoshii.takashi@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paui,

Paul Mundt wrote:
> On Thu, Apr 02, 2009 at 06:03:30PM +0900, yoshii.takashi@renesas.com wrote:
>> PCI still doesn't work on sh7785lcr 29bit 256M map mode.
>>
>> On SH7785, PCI -> SHwy address translation is not base+offset but somewhat like
>>  base|offset (See HW Manual (rej09b0261) Fig. 13.11).
>> So, you can't export CS2,3,4,5 by 256M at CS2 (results CS0,1,2,3 exported, I guess).
>> There are two candidates.
>> a) 128M@CS2 + 128M@CS4
>> b) 512M@CS0
>>
>> Attached patch is B. It maps 512M Byte at 0 independently of memory size.
>> It results CS0 to CS6 and perhaps some more being accessible from PCI.
>>
> Looks ok for now, some changes might still be necessary for 32-bit mode,
> but we can special-case those if any problems show up with it. Most of
> this code is being reworked for 2.6.31, anyways.

I made a patch for 32-bit mode. This patch tested linux-2.6.git using
sh7785lcr_32bit_defconfig today.

Thanks,
Yoshihiro Shimoda
--

From 41e08aad835cd26698eed1fbc7f2b02bca8d61e1 Mon Sep 17 00:00:00 2001
From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Mon, 6 Apr 2009 20:17:07 +0900
Subject: [PATCH] sh: sh7785lcr: fix PCI address map for 32-bit mode

Fix the problem that cannot work PCI device on 32-bit mode because
influence of the commit 68b42d1b548be1840aff7122fdebeb804daf0fa3
("sh: sh7785lcr: Map whole PCI address space."). So this patch was
implement like a 29-bit mode, map whole physical address space of
DDR-SDRAM.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---
 arch/sh/drivers/pci/ops-sh7785lcr.c |    5 +++++
 arch/sh/drivers/pci/pci-sh7780.h    |    2 ++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/sh/drivers/pci/ops-sh7785lcr.c b/arch/sh/drivers/pci/ops-sh7785lcr.c
index e8b7446..fb0869f 100644
--- a/arch/sh/drivers/pci/ops-sh7785lcr.c
+++ b/arch/sh/drivers/pci/ops-sh7785lcr.c
@@ -48,8 +48,13 @@ EXPORT_SYMBOL(board_pci_channels);

 static struct sh4_pci_address_map sh7785_pci_map = {
 	.window0	= {
+#if defined(CONFIG_32BIT)
+		.base	= SH7780_32BIT_DDR_BASE_ADDR,
+		.size	= 0x40000000,
+#else
 		.base	= SH7780_CS0_BASE_ADDR,
 		.size	= 0x20000000,
+#endif
 	},

 	.flags	= SH4_PCIC_NO_RESET,
diff --git a/arch/sh/drivers/pci/pci-sh7780.h b/arch/sh/drivers/pci/pci-sh7780.h
index 97b2c98..93adc71 100644
--- a/arch/sh/drivers/pci/pci-sh7780.h
+++ b/arch/sh/drivers/pci/pci-sh7780.h
@@ -104,6 +104,8 @@
 #define SH7780_CS5_BASE_ADDR	(SH7780_CS4_BASE_ADDR + SH7780_MEM_REGION_SIZE)
 #define SH7780_CS6_BASE_ADDR	(SH7780_CS5_BASE_ADDR + SH7780_MEM_REGION_SIZE)

+#define SH7780_32BIT_DDR_BASE_ADDR	0x40000000
+
 struct sh4_pci_address_map;

 /* arch/sh/drivers/pci/pci-sh7780.c */
-- 
1.5.5

