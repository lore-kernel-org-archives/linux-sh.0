From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 21 Feb 2011 09:50:31 +0000
Subject: [BUG] Serial driver broken on migor
Message-Id: <Pine.LNX.4.64.1102211046270.26977@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

As earlier reported on IRC, commit 
906b17dc089f7fa87e37a9cfe6ee185efc90e0da locks up migor hard without any 
output on the serial console. I haven't re-tested the very latest kernel 
versions, but I don't see any fixes being committed either.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
