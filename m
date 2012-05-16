From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 16 May 2012 13:36:10 +0000
Subject: ap4 (sh7372) regression in 3.3 / 3.4 with serial console - boot failures
Message-Id: <Pine.LNX.4.64.1205161431380.30283@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all

I'm observing a regression with 3.3 and 3.4 kernels, 3.2 seems to be ok. 
The system (confirmed with mackerel and ap4evb) hangs during boot at 
random times. This can be directly after "freeing init memory," or some 
time during the OS start up, or immediately after the start up has 
completed. But if it managed to boot, it continues to run, I've never seen 
it hanging after I ssh onto the system. It also seems, that the 
probability to hang increases with time after the initial system power on. 
A simple short power off doesn't solve the problem.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
