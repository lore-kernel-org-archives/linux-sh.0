From: Rob Landley <rob@landley.net>
Date: Mon, 15 May 2017 02:03:49 +0000
Subject: Superh warnings in -rc1
Message-Id: <3b1f45ec-f816-d810-5321-3c78937155db@landley.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

These seem specific to arch/sh:

  CALL    scripts/checksyscalls.sh
<stdin>:1317:2: warning: #warning syscall pkey_mprotect not implemented
[-Wcpp]
<stdin>:1320:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
<stdin>:1323:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
<stdin>:1326:2: warning: #warning syscall statx not implemented [-Wcpp]


  AS      arch/sh/kernel/cpu/sh4/../sh3/entry.o
arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S: Assembler messages:
arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:389: Warning:
overflow in branch to syscall_exit_work; converted into longer
instruction sequence
arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:392: Warning:
overflow in branch to syscall_exit_work; converted into longer
instruction sequence

  CC      drivers/sh/clk/cpg.o
drivers/sh/clk/cpg.c: In function 'r8':
drivers/sh/clk/cpg.c:41:17: warning: passing argument 1 of 'ioread8'
discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  return ioread8(addr);
                 ^~~~
In file included from ./arch/sh/include/asm/io.h:20:0,
                 from ./include/linux/io.h:25,
                 from drivers/sh/clk/cpg.c:14:
./include/asm-generic/iomap.h:28:21: note: expected 'void *' but
argument is of type 'const void *'
 extern unsigned int ioread8(void __iomem *);
                     ^~~~~~~
drivers/sh/clk/cpg.c: In function 'r16':
drivers/sh/clk/cpg.c:46:18: warning: passing argument 1 of 'ioread16'
discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  return ioread16(addr);
                  ^~~~
In file included from ./arch/sh/include/asm/io.h:20:0,
                 from ./include/linux/io.h:25,
                 from drivers/sh/clk/cpg.c:14:
./include/asm-generic/iomap.h:29:21: note: expected 'void *' but
argument is of type 'const void *'
 extern unsigned int ioread16(void __iomem *);
                     ^~~~~~~~
drivers/sh/clk/cpg.c: In function 'r32':
drivers/sh/clk/cpg.c:51:18: warning: passing argument 1 of 'ioread32'
discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
  return ioread32(addr);
                  ^~~~
In file included from ./arch/sh/include/asm/io.h:20:0,
                 from ./include/linux/io.h:25,
                 from drivers/sh/clk/cpg.c:14:
./include/asm-generic/iomap.h:31:21: note: expected 'void *' but
argument is of type 'const void *'
 extern unsigned int ioread32(void __iomem *);
                     ^~~~~~~~

Rob
