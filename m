From: Simon Horman <horms@verge.net.au>
Date: Fri, 13 Nov 2015 01:14:16 +0000
Subject: Re: [PATCH v2] ARM: shmobile: Introduce ARCH_RENESAS
Message-Id: <20151113011416.GJ20462@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1447114001-7731-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1447114001-7731-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Nov 10, 2015 at 09:06:41AM +0900, Simon Horman wrote:
> The purpose of this patch is to start the process of replacing both
> ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI with ARCH_RENESAS.
> 
> RENESAS seems to be a more appropriate name than SHMOBILE for the majority
> of Renesas 32-bit ARM based SoCs. The name is conveniently also (newer)
> ARM64 based SoCs.
> 
> This patches only addresses 32-bit ARM based SoCs.  Proposed support for
> the ARM64 based r8a7795 SoC already uses ARCH_RENESAS which selects
> ARCH_SHMOBILE.
> 
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

For the record: I have queued this up for v4.5.
