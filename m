From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 12 Dec 2011 08:18:27 +0000
Subject: [NEXT] mach-shmobile and sh compilation broken
Message-Id: <Pine.LNX.4.64.1112120912380.10378@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all

Current next fails to compile for mach-shmobile:

arch/arm/include/asm/pgtable.h:47: warning: #warning "SH-Mobile's consistent DMA size conflicts with VMALLOC_END by 144MB"
In file included from /opt/src/linux-2.6/arch/arm/kernel/process.c:64:
arch/arm/mach-shmobile/include/mach/system.h:9: error: #error Fix me up
make[2]: *** [arch/arm/kernel/process.o] Error 1

(the first line is an unrelated warning, it's actually repeated multiple 
times throughout compilation), and arch/sh:

mm/pgtable-generic.c: In function 'pmdp_clear_flush_young':
mm/pgtable-generic.c:76: error: call to '__build_bug_failed' declared with attribute error: BUILD_BUG failed
make[2]: *** [mm/pgtable-generic.o] Error 1

The latter has been there since a few days already, possibly longer than 
a week.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
