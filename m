From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 11 Mar 2011 08:09:28 +0000
Subject: [PATCH 0/4 v2] mmc: tmio: don't access nonexisting registers
Message-Id: <Pine.LNX.4.64.1103110854050.23675@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

Some tmio implementations don't implement registers above 0xff. The driver 
must take care not to access them in such cases.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
