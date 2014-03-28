From: Tony Lindgren <tony@atomide.com>
Date: Fri, 28 Mar 2014 16:02:30 +0000
Subject: Re: [PATCH 51/75] ARM: l2c: remove platforms/SoCs setting early BRESP
Message-Id: <20140328160229.GF24308@atomide.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140328151249.GJ7528@n2100.arm.linux.org.uk>
 <E1WTYYR-0007GJ-Ai@rmk-PC.arm.linux.org.uk>
In-Reply-To: <E1WTYYR-0007GJ-Ai@rmk-PC.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Russell King <rmk+kernel@arm.linux.org.uk> [140328 08:22]:
> Since we now automatically enable early BRESP in core L2C-310 code when
> we detect a Cortex-A9, we don't need platforms/SoCs to set this bit
> explicitly.  Instead, they should seek to preserve the value of bit 30
> in the auxiliary control register.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
