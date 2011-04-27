From: Simon Horman <horms@verge.net.au>
Date: Wed, 27 Apr 2011 07:43:56 +0000
Subject: [PATCH 0/2] Allow SDHI MMC to use multiple IRQ vectors
Message-Id: <1303890238-8372-1-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SDHI blocks may have up to 4 IRQ vectors.

This series allows multiple vectors to be used if supplied in the platform
data. It supplies the platform data for the mackerel and ap4evb boards and
removes the irq multi-plexing hack that has been in use on those boards
up to now.

