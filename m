From: Kevin Hilman <khilman@ti.com>
Date: Mon, 05 Mar 2012 21:33:20 +0000
Subject: Re: [PATCH v7 0/9] Consolidate cpuidle functionality
Message-Id: <87y5reivhb.fsf@ti.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
In-Reply-To: <1330562578-3410-1-git-send-email-rob.lee@linaro.org> (Robert
 Lee's message of "Wed, 29 Feb 2012 18:42:49 -0600")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Robert Lee <rob.lee@linaro.org> writes:

> This patch series moves various functionality duplicated in platform 
> cpuidle drivers to the core cpuidle driver. Also, the platform irq
> disabling was removed as it appears that all calls into 
> cpuidle_call_idle will have already called local_irq_disable().

Reviewed-by: Kevin Hilman <khilman@ti.com>

