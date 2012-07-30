From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 30 Jul 2012 19:28:18 +0000
Subject: [PATCH 0/2] serial: sh-sci: fix compilation breakage (3.6)
Message-Id: <Pine.LNX.4.64.1207302114440.28003@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org

Hi all

as has been reported in this

http://thread.gmane.org/gmane.linux.kernel/1294256/focus001

thread, currently sh-sci doesn't comiple in the mainline and in -next if 
CONFIG_SERIAL_SH_SCI_DMA is enabled. This patch series fixes this 
breakage.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
