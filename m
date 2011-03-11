From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 11 Mar 2011 08:24:02 +0000
Subject: [PATCH/RFC 0/2 v2] mmc: tmio: power management and clock gating
Message-Id: <Pine.LNX.4.64.1103110915290.23675@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>

I think, the tmio driver currently misinterprets MMC power modes, which is 
fixed by the first patch in this series. The second one implements 
aggressive clock gating. Both are marked "RFC," because I cannot test them 
on MFD-based hardware.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
