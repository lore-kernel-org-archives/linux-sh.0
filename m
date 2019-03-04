From: <Raveendra.Reddy.P@dell.com>
Date: Mon, 04 Mar 2019 13:01:00 +0000
Subject: Kernel compilation for SH4 arch fails with poky 2.5.2
Message-Id: <8beaba914a6a423ba3acef4adfd34179@BLRX13MDC425.AMER.DELL.COM>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Team,

When we configure poky-2.5.2 with sh4 (SuperH) arch and Linux kernel 4.9.161, it fails with following error message. 
From our observations, the below issue seems to be due to toolchain/gcc not the kernel.

#bitbake linux-yocto

   CC      drivers/mmc/core/sd.o
| {standard input}: Assembler messages:
| {standard input}: Error: unaligned opcodes detected in executable segment
| make[5]: *** [drivers/mmc/core/sd.o] Error 1
| make[4]: *** [drivers/mmc/core] Error 2
| make[3]: *** [drivers/mmc] Error 2
| make[2]: *** [drivers] Error 2
| make[2]: *** Waiting for unfinished jobs....
| make[1]: *** [sub-make] Error 2
| make: *** [__sub-make] Error 2
| ERROR: oe_runmake failed

Apart from configuring the sh4 machine and kernel version, we have not altered the default settings of poky. The machine config, kernel .config file and log files are attached. Could you please help us with the kernel compilation for sh4 architecture. 

Note: This issue was not observed with GCC version 4.9.0. Poky 2.5 has GCC Version 7.3.0. Expectation is to compile kernel with GCC 7.3.

--Raveendra Reddy P
