From: Marc Zyngier <marc.zyngier@arm.com>
Date: Wed, 07 Oct 2015 12:46:29 +0000
Subject: Re: [PATCH 0/2] irqchip/renesas-intc-irqpin: Remove obsolete platform data support
Message-Id: <56151425.8030501@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444215094-27159-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444215094-27159-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On 07/10/15 11:51, Geert Uytterhoeven wrote:
> 	Hi Thomas, Jason, Marc,
> 
> Since commit 4baadb9e05c68962 ("ARM: shmobile: r8a7778: remove obsolete
> setup code"), which is now in arm-soc/for-next, all Renesas SoCs with a
> renesas-intc-irqpin module are only supported in generic DT-only ARM
> multi-platform builds.  The driver doesn't need to use platform data
> anymore, hence this series removes platform data configuration, and does
> a small cleanup.

Looks OK to me. For the series:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
