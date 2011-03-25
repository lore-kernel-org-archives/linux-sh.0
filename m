From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 25 Mar 2011 07:37:57 +0000
Subject: migor compile breakage in Linus' tree
Message-Id: <Pine.LNX.4.64.1103250836510.22824@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Getting the following errors, when building for migor (sh7722 - no FPU):

arch/sh/kernel/built-in.o: In function `arch_ptrace':
(.text+0x1874): undefined reference to `init_fpu'
arch/sh/kernel/built-in.o: In function `arch_ptrace':
(.text+0x190c): undefined reference to `init_fpu'
make[1]: *** [.tmp_vmlinux1] Error 1
make: *** [sub-make] Error 2

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
