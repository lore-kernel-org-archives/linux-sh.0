From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 28 Jan 2014 10:06:53 +0000
Subject: PCI fixes for Renesas RCar
Message-Id: <1390903616-8073-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@lists.codethink.co.uk
Cc: linux-sh@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Simon Horman <horms@verge.net.au>, Valentine Barshak <valentine.barshak@cogentembedded.com>, linux-pci@vger.kernel.org

This is a small set of patches that fix a couple of issues with
the rcar-gen2 pci driver and add error interrupt support for
debugging.

Fixes from v1:
	- remove debugging code
	- fix patch title on bridge config accesses

