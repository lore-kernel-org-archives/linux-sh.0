From: Tony Lindgren <tony@atomide.com>
Date: Wed, 14 Dec 2011 18:16:25 +0000
Subject: Re: [PATCH v4 REPOST 2/5] ARM: SMP: Refactor Kconfig to be more
Message-Id: <20111214181624.GD32251@atomide.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1323862781-3465-1-git-send-email-dave.martin@linaro.org>
 <1323862781-3465-3-git-send-email-dave.martin@linaro.org>
In-Reply-To: <1323862781-3465-3-git-send-email-dave.martin@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Dave Martin <dave.martin@linaro.org> [111214 03:08]:
> Making SMP depend on (huge list of MACH_ and ARCH_ configs) is
> bothersome to maintain and likely to lead to merge conflicts.
> 
> This patch moves the knowledge of which platforms are SMP-capable
> to the individual machines.  To enable this, a new HAVE_SMP config
> option is introduced to allow machines to indicate that they can
> run in a SMP configuration.

For omap:

Acked-by: Tony Lindgren <tony@atomide.com>
