From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 04 Dec 2014 16:19:53 +0000
Subject: Re: [PATCH v2] power: reset: Add reset driver for R-Mobile platforms
Message-Id: <20141204161953.GB7385@roeck-us.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1417707201-589-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1417707201-589-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Simon Horman <horms@verge.net.au>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, Dec 04, 2014 at 04:33:21PM +0100, Geert Uytterhoeven wrote:
> Add a reset driver for Renesas R-Mobile and SH-Mobile SoCs. It registers
> a restart handler to trigger a soft power-on reset through the R-Mobile
> System Controller.
> The priority of this restart handler is 192, to allow a watchdog driver
> to use priority 128.
> 
Also because it is conreolled by devicetree and thus by definition should have
higher priority.

> Note that we do not use syscon-reboot, as the HPB (Peripheral Bus
> Bridge) semaphore should be acquired on systems where both the ARM and
> SH core are in use. The driver can be extended later to support this,
> when needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Looks good to me (except for the dual empty lines ;-).

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
