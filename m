From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 30 Jun 2014 07:54:21 +0000
Subject: [PATCH v2 0/3] PCI: host: pcie-rcar: minor clean ups
Message-Id: <1404114864-17330-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Simon Horman <horms@verge.net.au>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Phil Edworthy <phil.edworthy@renesas.com>

Relatively minor clean up patches for the pcie-rcar driver. These
are on top of Sergei's recent patch "pcie-rcar: kill duplicate checks".

Thanks to Sergei for point these out.

v2:
 - break out replacing function arg with local var into separate patch

Phil Edworthy (3):
  PCI: host: pcie-rcar: Use correct initial HW settings
  PCI: host: pcie-rcar: Style and formatting changes.
  PCI: host: pcie-rcar: Replace arg passed into a func with local var

 drivers/pci/host/pcie-rcar.c | 146 +++++++++++++++++++++----------------------
 1 file changed, 71 insertions(+), 75 deletions(-)

-- 
2.0.0

