From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Fri, 27 Jun 2014 16:55:53 +0000
Subject: [PATCH 0/2] PCI: host: pcie-rcar: minor clean ups
Message-Id: <1403888155-9709-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pci@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Simon Horman <horms@verge.net.au>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Phil Edworthy <phil.edworthy@renesas.com>

A couple of relatively minor clean up patches for the pcie-rcar driver. These
are on top of Sergei's recent patch "pcie-rcar: kill duplicate checks".

Thanks to Sergei for point these out.

Phil Edworthy (2):
  PCI: host: pcie-rcar: Use correct initial HW settings
  PCI: host: pcie-rcar: Style and formatting changes.

 drivers/pci/host/pcie-rcar.c | 146 +++++++++++++++++++++----------------------
 1 file changed, 71 insertions(+), 75 deletions(-)

-- 
2.0.0

