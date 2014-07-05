From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sat, 05 Jul 2014 22:26:19 +0000
Subject: rcar-vin & soc-camera device tree updates
Message-Id: <1404599185-12353-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org, linux-sh@vger.kernel.org
Cc: magnus.damm@opensource.se, horms@verge.net.au, g.liakhovetski@gmx.de, linux-kernel@lists.codethink.co.uk

This is a new patch, with most of the issues from the previous
reviews now fixed. If there is anything that I have missed then
please let me know.

The only issues remaining is what to do about multiple subdevices
and/or multiple ports on drivers. I have yet to do either of erroring
out or supporting them. Feedback on this issue is welcome.

