From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 18 Dec 2008 15:23:53 +0000
Subject: A patch got applied to v4l bypassing v4l lists
Message-Id: <Pine.LNX.4.64.0812181613050.5510@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <damm@igel.co.jp>
Cc: video4linux-list@redhat.com, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org

Hi Magnus, Paul,

just stumbled upon a patch

sh: sh_mobile ceu clock framework support

http://marc.info/?l=linux-sh&m2545217725877&w=2

with diffstat

 arch/sh/boards/board-ap325rxa.c            |    2 +-
 arch/sh/boards/mach-migor/setup.c          |    2 +-
 drivers/media/video/sh_mobile_ceu_camera.c |   20 +++++++++++++++++++-
 3 files changed, 21 insertions(+), 3 deletions(-)

that has been pulled through linux-sh ML and the sh tree without even 
being cc-ed to the v4l list, which wasn't a very good idea IMHO. Now this 
patch has to be manually "back-ported" to v4l hg repos using the 
"kernel-sync:" tag and only in part, because arch/sh directory is not in 
hg at all. Can we please avoid this in the future?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
