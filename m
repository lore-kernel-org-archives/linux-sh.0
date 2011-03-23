From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 23 Mar 2011 13:48:59 +0000
Subject: [PATCH 0/4 v3] mmc: tmio: don't access nonexisting registers
Message-Id: <Pine.LNX.4.64.1103231445070.6836@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

v3: fix wrong chip name in 2 out of 4 commit messages, patches themselves 
are unchanged.

Some tmio implementations don't implement registers above 0xff. The driver 
must take care not to access them in such cases.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
