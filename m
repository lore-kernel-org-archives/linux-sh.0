From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 17 Nov 2011 13:55:42 +0000
Subject: [PATCH 0/3 v2] Switch sh7722, sh7723, and sh7724 to a generic
Message-Id: <Pine.LNX.4.64.1111171446150.2650@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The sh/pm-runtime branch of https://github.com/pmundt/linux-sh begins the 
migration of SuperH platforms from their hwblk runtime PM implementation 
to the common with ARM-based sh-mobile platforms code. These patches 
actually migrate sh7722, sh7723, and sh7724 architectures over.

v2 is functionally identical to v1, it only removes the MSTP() wrapper, as 
requested by Paul.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
