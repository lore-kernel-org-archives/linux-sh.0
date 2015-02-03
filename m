From: Wim Van Sebroeck <wim@iguana.be>
Date: Tue, 03 Feb 2015 00:08:11 +0000
Subject: Re: [PATCH v2] watchdog: da9063: Add restart handler support
Message-Id: <20150203000810.GA18245@spo001.leaseweb.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <1422541565-19792-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1422541565-19792-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Support Opensource <support.opensource@diasemi.com>, linux-watchdog@vger.kernel.org, linux-sh@vger.kernel.org

Hello Geert,

> Register a restart handler for the da9063 watchdog.  System restart is
> triggered by sending the shutdown command to the PMIC.
> As more-suitable restart handlers may exist, the priority of the
> watchdog restart handler is set to 128.
> 
> The actual restart method was inspired by a platform-specific patch from
> the BSP by Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Added to linux-watchdog-next.

Kind regards,
Wim.

