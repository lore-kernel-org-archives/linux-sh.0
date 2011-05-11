From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 11 May 2011 16:51:02 +0000
Subject: [PATCH 0/3] cold card detection on TMIO / SDHI
Message-Id: <Pine.LNX.4.64.1105111843290.5557@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <damm@opensource.se>, Ian Molton <ian@mnementh.co.uk>

This patch series implemnts card detection, when the TMIO SD/SDIO 
controller is powered down. Yes, I know, I have to rebase all my TMIO 
patches, will do and repost this one too, so, this is just FYI / for 
review.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
