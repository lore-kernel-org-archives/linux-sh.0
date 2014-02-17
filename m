From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 17 Feb 2014 13:08:03 +0000
Subject: RFC: add init-regs for phy nodes
Message-Id: <1392642484-19938-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-sh@vger.kernel.org

I have run into an issue where the KSZ8041 does not get
initialised properly on the Renesas R8A7790 lager board.

This patch adds the ability to set arbitrary registers
on initialisation of a phy from informaiton in the fdt.

Feedback welcome.
