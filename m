From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 22 Feb 2011 09:57:35 +0000
Subject: [PATCH 0/3] soc_camera_platform: dynamically manage device instances
Message-Id: <Pine.LNX.4.64.1102221049240.1380@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Media Mailing List <linux-media@vger.kernel.org>
Cc: linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch series switches soc_camera_platform users to manage their 
camera device instances dynamically instead of re-using static objects. 
Since I don't have any of affected platforms at hand, this is only 
compile-tested. Please, test!

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
