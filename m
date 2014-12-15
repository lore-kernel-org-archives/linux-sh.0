From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 15 Dec 2014 00:13:39 +0000
Subject: [PATCH 00/10] Renesas IPMMU-VMSA fixes and DT support
Message-Id: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hello,

This patch fixes several small issues with the Renesas IPMMU-VMSA driver and
then implements DT support.

Patches 01/10 to 04/10 are small bug fixes. Please see the individual patches
for more information.

Patches 05/10 and 06/10 define DT bindings and implement DT support. Patches
07/10 and 08/10 then add support for multiple micro TLBs per device and remove
platform data support. Finally patches 09/10 and 10/10 add the IPMMU DT nodes
for the R-Car H2 and M2.

Joerg, as the patches have all been sent to public mailing lists previously I
will send you a pull request for patches 01/10 to 08/10 for v3.20 when the
v3.19 merge window closes. Patches 09/10 and 10/10 can then be merged
independently through the Renesas tree.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Simon Horman <horms@verge.net.au>

Axel Lin (1):
  iommu/ipmmu-vmsa: Return proper error if devm_request_irq fails

Laurent Pinchart (9):
  iommu/ipmmu-vmsa: Cleanup failures of ARM mapping creation or
    attachment
  iommu/ipmmu-vmsa: Flush P[UM]D entry before freeing the child page
    table
  iommu/ipmmu-vmsa: Invalidate TLB after unmapping
  iommu/ipmmu-vmsa: Add device tree bindings documentation
  iommu/ipmmu-vmsa: Add device tree support
  iommu/ipmmu-vmsa: Support multiple micro TLBs per device
  iommu/ipmmu-vmsa: Remove platform data support
  ARM: shmobile: r8a7790: Add IPMMU DT nodes
  ARM: shmobile: r8a7791: Add IPMMU DT nodes

 .../bindings/iommu/renesas,ipmmu-vmsa.txt          |  37 ++++++
 arch/arm/boot/dts/r8a7790.dtsi                     |  48 ++++++++
 arch/arm/boot/dts/r8a7791.dtsi                     |  56 +++++++++
 drivers/iommu/ipmmu-vmsa.c                         | 137 +++++++++++++++------
 include/linux/platform_data/ipmmu-vmsa.h           |  24 ----
 5 files changed, 239 insertions(+), 63 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
 delete mode 100644 include/linux/platform_data/ipmmu-vmsa.h

-- 
Regards,

Laurent Pinchart

