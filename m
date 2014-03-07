From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 07 Mar 2014 13:01:34 +0000
Subject: soc_camera rcar_vin support for device-tree binding
Message-Id: <1394197299-17528-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Mauro Carvalho Chehab <m.chehab@samsung.com>, linux-kernel@vger.kernel.org, magnus.damm@opensource.se, linux-sh@vger.kernel.org, linux-kernel@lists.codethink.co.uk

This is a series of patches to get towards the point the renesas
rcar_vin driver can be bound via device-tree. Patches 1 and 2 add
the device tree nodes, patch 3 is one which has been in my tree
for a while and the last two modify the rcar_vin driver.

