From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 30 Aug 2011 16:26:34 +0000
Subject: [PATCH 0/2] mmc: sh_mmcif: simplify platform DMA configuration
Message-Id: <Pine.LNX.4.64.1108301819150.19151@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

A simple cosmetic clean-up, no functional changes. Patch 2/2 depends on 
patch 1/2 and can wait until 3.3. Paul, would you be able to put it under 
the carpet somewhere until then or shall I resend it after 3.2-rc1 is out? 
After both these patches have been applied, we can remove struct 
sh_mmcif_plat_data::dma around 3.4 or 4.0 or whatever;-)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
