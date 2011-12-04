From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Sun, 04 Dec 2011 23:42:09 +0000
Subject: cpuidle broken on sh7724 since 2.6.33-rc1 - bisected
Message-Id: <Pine.LNX.4.64.1112050036100.16831@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi

cpuidle was introduced on sh7724 with 2.6.32-rc1, with 2.6.33-rc1 it got 
broken and it still remains that way, at least I'm unaware of a way to 
boot a current cpuidle-enabled kernel on sh7724 (ecovec). git bisect 
(after multiple manual adjustments) pointed out at this commit:

commit f533c3d340536198a4889a42a68d6c0d79a504e7
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Fri Oct 16 17:20:58 2009 +0900

    sh: Idle loop chainsawing for SMP-based light sleep.

A manual verification confirmed, that it is exactly the breakage point. 
I'm afraid, at 00:30 Monday "morning" I'm not very much inclined to look 
for a fix;-)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
