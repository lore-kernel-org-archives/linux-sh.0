From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sun, 15 Jun 2014 19:56:25 +0000
Subject: RFC: new soc_camera/rcar_vin patch series
Message-Id: <1402862194-17743-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@lists.codethink.co.uk, linux-sh@vger.kernel.org, linux-media@vger.kernel.org
Cc: robert.jarzmik@free.fr, g.liakhovetski@gmx.de, magnus.damm@opensource.se, horms@verge.net.au, ian.molton@codethink.co.uk, william.towle@codethink.co.uk

This is a new series for the rcar_vin and soc_camera layer
to support using OF.

It should incorporate most of the feedback from the previous
series, but please let me know if there's anything missed. As
a note, we have skipped over multiple eps for this release as
there are few scenarios for the driver.

Testing/feedback welcome.

