From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 11 May 2010 09:35:04 +0000
Subject: [PATCH 00/15] SuperH clkdev rework round 4
Message-Id: <20100511093504.28210.25670.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SuperH clkdev rework round 4

[PATCH 01/15] sh: switch legacy clocks to clkdev
[PATCH 02/15] sh: switch sh7724 to clkdev 
[PATCH 03/15] sh: switch sh7723 to clkdev 
[PATCH 04/15] sh: switch sh7722 to clkdev 
[PATCH 05/15] sh: switch sh7343 to clkdev 
[PATCH 06/15] sh: switch sh7366 to clkdev 
[PATCH 07/15] sh: switch sh7785 to clkdev 
[PATCH 08/15] sh: switch sh7786 to clkdev 
[PATCH 09/15] sh: switch sh7780 to clkdev 
[PATCH 10/15] sh: switch sh7763 to clkdev 
[PATCH 11/15] sh: switch sh7757 to clkdev 
[PATCH 12/15] sh: switch shx3 to clkdev 
[PATCH 13/15] sh: switch sh4-202 to clkdev 
[PATCH 14/15] sh: switch boards to clkdev 
[PATCH 15/15] sh: remove unused clock lookup

These patches contain the fourth and final part of the clkdev
rework for SH. In this round the remaining part of the clocks
are converted.

Signed-off-by: Magnus Damm <damm@opensource.se>
---
