From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 22 Mar 2013 13:24:22 +0000
Subject: [PATCH/RFC 0/2] wait for MSTP clocks to start
Message-Id: <Pine.LNX.4.64.1303221415490.12375@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi

These patches add an ability to wait for MSTP clocks to start by reading 
back their status registers repeatedly, until they update. This assumes, 
that *MSTPCR and respective MSTPSR registers use the same bits for the 
same clocks. Patches are marked "RFC," because I think at least one ack 
is required ;-)

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
