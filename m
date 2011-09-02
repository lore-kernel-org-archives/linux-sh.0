From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 02 Sep 2011 08:17:54 +0000
Subject: Ecovec in current sh-latest
Message-Id: <Pine.LNX.4.64.1109020025350.15166@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi

To get ecovec to run with today's sh-latest (pretty much the same with 
Linux' tree) the following patches have to be reverted:

commit 794d78fea51504bad3880d14f354a9847f318f25
Author: Magnus Damm <damm@opensource.se>
Date:   Tue Jun 21 07:55:12 2011 +0000

    drivers: sh: late disabling of clocks V2

commit 3f9b8520b06013939ad247ba08b69529b5f14be1
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Tue May 31 14:38:29 2011 +0900

    sh64: Move from P1SEG to CAC_ADDR for consistent sync.

commit cb3da5b837a410a1fb90019549b18178f3c87258
Author: Magnus Damm <damm@opensource.se>
Date:   Wed Aug 3 12:47:36 2011 +0900

    serial: sh-sci: console Runtime PM support

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
