From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 25 Mar 2011 07:45:17 +0000
Subject: build breakage sh in next
Message-Id: <Pine.LNX.4.64.1103250844300.22824@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

/opt/src/linux-2.6/arch/sh/kernel/process.c: In function 'alloc_thread_info':
/opt/src/linux-2.6/arch/sh/kernel/process.c:67: error: 'node' undeclared (first use in this function)
/opt/src/linux-2.6/arch/sh/kernel/process.c:67: error: (Each undeclared identifier is reported only once
/opt/src/linux-2.6/arch/sh/kernel/process.c:67: error: for each function it appears in.)
make[2]: *** [arch/sh/kernel/process.o] Error 1
make[1]: *** [arch/sh/kernel] Error 2
make: *** [sub-make] Error 2

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
