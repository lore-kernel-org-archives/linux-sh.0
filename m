From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Thu, 07 Nov 2013 20:04:00 +0000
Subject: [PATCH V2 0/2] sata_rcar: Add Gen2 PHY support and document existing DT bindings
Message-Id: <1383854642-21660-1-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-ide@vger.kernel.org, devicetree@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kumar Gala <galak@codeaurora.org>, Tejun Heo <tj@kernel.org>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Mark Rutland <mark.rutland@arm.com>

This adds SATA R-Car Gen2 PHY support and documents existing DT bindings.
Changes from the previous version:
* Minor whitespace clean-up to make both array terminators "{ },".

Valentine Barshak (2):
  sata_rcar: Add R-Car Gen2 SATA PHY support
  dt: Document sata_rcar bindings

 .../devicetree/bindings/ata/sata_rcar.txt          |  18 ++++
 drivers/ata/sata_rcar.c                            | 118 ++++++++++++++++++---
 2 files changed, 120 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/sata_rcar.txt

-- 
1.8.3.1

