From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 15 Mar 2010 16:48:07 +0000
Subject: commit 8a77b8d07 break serial console output on sh7724
Message-Id: <Pine.LNX.4.64.1003151744020.6938@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Commit "serial: sh-sci: Support ARM-based SH-Mobile CPUs." plays badly 
with the sci driver on 7724, wants to be fixed... Tested with today's 
Linus' head (34-rc1-ish) on ms7724se.

Thanks
Guennadi
---
Guennadi Liakhovetski
