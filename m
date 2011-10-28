From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 28 Oct 2011 20:26:57 +0000
Subject: [PATCH] regulator: provide dummy supply support
Message-Id: <1319833618-25190-1-git-send-email-s.hauer@pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linus Walleij <linus.walleij@linaro.org>, Paul Mundt <lethal@linux-sh.org>, Tony Lindgren <tony@atomide.com>, Mike Frysinger <vapier@gentoo.org>, linux-sh@vger.kernel.org, linux-omap@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

Hi,

The following patch allows it for boards to register a dummy supply for
devices for which no software controllable regulator is available. The
current CONFIG_REGULATOR_DUMMY and (unused) regulator_use_dummy_regulator()
mechanisms only allow to provide a dummy regulator for *all* devices
for which no regulator is found. This would shadow real errors and thus
is not really an option for production kernels.

This patch may eventually superseed the current all-or-nothing approach.

This came to me while looking over Linus' smsc911x regulator support
patch and so I added all people affected by this patch to Cc.

Sascha

