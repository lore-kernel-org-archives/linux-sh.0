From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 09 Sep 2013 15:11:10 +0000
Subject: "cpufreq: fix serialization issues with freq change notifiers" breaks cpufreq too
Message-Id: <Pine.LNX.4.64.1309091656200.6602@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Sorry guys, I'm trying my best to stop this patch from propagating to 
stable and to get it fixed asap, so, the CC list might be a bit excessive. 
Also trying to fix the originally spare cc list, which makes it impossible 
for me to reply to the original thread, instead have to start a new one.

Commit

commit dceff5ce18801dddc220d6238628619c93bc3cb6
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Sun Sep 1 22:19:37 2013 +0530

    cpufreq: fix serialization issues with freq change notifiers

breaks .transition_ongoing counting. This leads to cpufreq-cpu0 not 
working any more. In particular switching the governor from performance to 
powersave directly after boot doesn't result in a frequency switch any 
more. Reverting this patch fixes the problem again. Tested with today's 
-next.

Please, refrain from including into "stable" until clarified!

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
