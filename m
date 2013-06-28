From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 28 Jun 2013 12:26:07 +0000
Subject: [sh] A possible problem in start_secondary()
Message-Id: <799851372422367@web4d.yandex.ru>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Paul,

I found out a possible wrong order of local_irq_enable/set_cpu_online at start_secondary().

If irqs are enabled then cpu can receive a timer interrupt, which can cause softirq action.

If we are waking softirq thread on offline cpu, select_task_rq() chooses any active cpu and changes
affinity. So, possible bound softirq thread will change his affinity.

I had this problem on old kernel version on sparc. Maybe, it will be useful for you.

Regards,
Kirill
