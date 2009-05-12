From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 12 May 2009 15:13:26 +0000
Subject: [PATCH 0/3] Convert SuperH camera-enabled platforms to soc-camera
Message-Id: <Pine.LNX.4.64.0905121649420.5087@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Media Mailing List <linux-media@vger.kernel.org>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Now that soc-camera compatibility patch is in the mainline, we can convert 
all platforms to the new scheme. This patch series converts SuperH boards. 
Unfortunately, the first patch has to also (slightly) modify two camera 
drivers, but that looks like a minor inconvenience to me, at least when 
compared to my original convert-all-at-once mega-patch.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
