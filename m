From: Stephen Warren <swarren@wwwdotorg.org>
Date: Mon, 28 Apr 2014 20:04:45 +0000
Subject: Re: [PATCH 51/97] ARM: l2c: remove platforms/SoCs setting early BRESP
Message-Id: <535EB45D.4010406@wwwdotorg.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20140428192419.GV26756@n2100.arm.linux.org.uk>
 <E1WerG4-0001X4-Ic@rmk-PC.arm.linux.org.uk>
In-Reply-To: <E1WerG4-0001X4-Ic@rmk-PC.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 04/28/2014 01:30 PM, Russell King wrote:
> Since we now automatically enable early BRESP in core L2C-310 code when
> we detect a Cortex-A9, we don't need platforms/SoCs to set this bit
> explicitly.  Instead, they should seek to preserve the value of bit 30
> in the auxiliary control register.

Acked-by: Stephen Warren <swarren@nvidia.com>
