From: Ian Molton <ian.molton@codethink.co.uk>
Date: Tue, 08 Jul 2014 09:41:10 +0000
Subject: Resend: [PATCH 0/4] rcar_vin: fix soc_camera WARN_ON() issues.
Message-Id: <1404812474-7627-1-git-send-email-ian.molton@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk, ian.molton@codethink.co.uk, g.liakhovetski@gmx.de, m.chehab@samsung.com, vladimir.barinov@cogentembedded.com, magnus.damm@gmail.com, horms@verge.net.au, linux-sh@vger.kernel.org

Resent to include the author and a couple of other interested parties :)

This patch series provides fixes that allow the rcar_vin driver to function
without triggering dozens of warnings from the videobuf2 and soc_camera layers.

Patches 2/3 should probably be merged into a single, atomic change, although
patch 2 does not make the existing situation /worse/ in and of itself.

Patch 4 does not change the code logic, but is cleaner and less prone to
breakage caused by furtutre modification. Also, more consistent with the use of
vb pointers elsewhere in the driver.

Comments welcome!

-Ian

