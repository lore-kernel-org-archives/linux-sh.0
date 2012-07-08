From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sun, 08 Jul 2012 09:05:23 +0000
Subject: ARM: mach-shmobile: recent next build failure
Message-Id: <Pine.LNX.4.64.1207081101110.31002@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi

Got this build failure with Friday's next:

linux/arch/arm/mach-shmobile/pm-sh7372.c: In function 'sh7372_pm_init':
linux/arch/arm/mach-shmobile/pm-sh7372.c:598: error: implicit declaration of function 'sh7372_suspend_init'
linux/arch/arm/mach-shmobile/pm-sh7372.c:599: error: implicit declaration of function 'sh7372_cpuidle_init'
make[2]: *** [arch/arm/mach-shmobile/pm-sh7372.o] Error 1

.config available on request.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
