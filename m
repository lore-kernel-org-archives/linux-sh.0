From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 11 May 2010 09:52:26 +0000
Subject: [PATCH 0/3] tmio: let platforms decide upon write-protection
Message-Id: <Pine.LNX.4.64.1005111146330.6810@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org

Some platforms and card-formats do not have a write-protect detection. Let 
tmio_mmc users switch WP-detection off, if desired, switch it off for the 
micro-SD slot on the kfr2r09 SuperH board.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
