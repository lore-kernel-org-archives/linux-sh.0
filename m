From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 19 May 2010 18:33:48 +0000
Subject: [PATCH 0/10] add DMA support to tmio_mmc, using dmaengine API, use
Message-Id: <Pine.LNX.4.64.1005191750400.3099@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Molton <ian@mnementh.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, dan.j.williams@intel.com, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, sameo@linux.intel.com, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

Mostly a resend, all patches have already been submitted to lists and 
maintainers, the only change in actual code is the preserved "host->data = 
NULL" line upon Ian's request, which pushed patch #6 version to v6. Apart 
from that acks have been added and numbering streamlined. All patches 
marked with their respective versions.

Andrew, please, apply.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
