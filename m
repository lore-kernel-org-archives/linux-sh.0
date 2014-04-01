From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 01 Apr 2014 12:01:40 +0000
Subject: sh mmcif cleanups
Message-Id: <1396353706-31864-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, magnus.damm@opensource.se, linux-kernel@lists.codethink.co.uk

This is a second round of the mmcif cleanups

Changes since v1:

	- fix issues with devm_ioremap return, and error printing
	- change the initial print
	- fix issue with disabling clock

