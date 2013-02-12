From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 12 Feb 2013 14:55:29 +0000
Subject: [PATCH 0/2] ARM: shmobile: fixes for topic/all+next
Message-Id: <Pine.LNX.4.64.1302121519300.7059@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon

These are 2 fixes for your topic/all+next branch. Since the branch is 
experimental, you'll probably want to just merge them with respective 
broken commits, at least the first of them. #2 might be used as is before 
respective macros are removed, which causes the breakage, addressed there. 
I'll shortly send you a few more patches, showing a possible way to 
implement sparse GPIO / pin numbers. Laurent said he'd prefer a different 
approach, so, they wouldn't be for upstream, I guess, but maybe someone 
will find them useful for their work.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
