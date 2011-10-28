From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Fri, 28 Oct 2011 21:57:03 +0000
Subject: Re: [PATCH] regulator: provide dummy supply support
Message-Id: <20111028215703.GB30339@opensource.wolfsonmicro.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1319833618-25190-1-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1319833618-25190-1-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>, Paul Mundt <lethal@linux-sh.org>, Tony Lindgren <tony@atomide.com>, Mike Frysinger <vapier@gentoo.org>, linux-sh@vger.kernel.org, linux-omap@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org

On Fri, Oct 28, 2011 at 10:26:57PM +0200, Sascha Hauer wrote:

> The following patch allows it for boards to register a dummy supply for
> devices for which no software controllable regulator is available. The
> current CONFIG_REGULATOR_DUMMY and (unused) regulator_use_dummy_regulator()

Please don't send cover letters for single patch serieses, if there's
content it should probably be in the changelog...
