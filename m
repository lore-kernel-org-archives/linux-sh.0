From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 24 Oct 2012 10:02:13 +0000
Subject: [Q] CONFIG_INOTIFY_USER doesn't get enabled upon defconfig
Message-Id: <Pine.LNX.4.64.1210241057590.31768@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Robert Love <rlove@rlove.org>

Hi all

CONFIG_INOTIFY_USER is marked default "y" in fs/notify/inotify/Kconfig, 
so, I would expect it to be enabled by any make *_defconfig. However, for 
some reason, this doesn't happen (e.g. with mackerel_defconfig), which 
leads to non-functional udev, among others. Any idea why this could be 
happening?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
