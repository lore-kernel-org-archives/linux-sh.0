From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 16 Nov 2011 12:35:39 +0000
Subject: [PATCH 0/3] Switch sh7722, sh7723, and sh7724 to a generic sh-mobile
Message-Id: <Pine.LNX.4.64.1111161012170.1100@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The sh/pm-runtime branch of https://github.com/pmundt/linux-sh begins the 
migration of SuperH platforms from their hwblk runtime PM implementation 
to the common with ARM-based sh-mobile platforms code. These patches 
actually migrate sh7722, sh7723, and sh7724 architectures over.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
