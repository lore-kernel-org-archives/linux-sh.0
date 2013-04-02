From: Simon Horman <horms@verge.net.au>
Date: Tue, 02 Apr 2013 04:33:52 +0000
Subject: Re: [PATCH 00/04 v2] ARM: shmobile: r8a7790 SoC
Message-Id: <20130402043351.GE1696@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130327154925.10876.40575.sendpatchset@w520>
In-Reply-To: <20130327154925.10876.40575.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Mar 28, 2013 at 12:49:25AM +0900, Magnus Damm wrote:
> ARM: shmobile: r8a7790 SoC (V2)
> 
> [PATCH 01/04] ARM: shmobile: Initial r8a7790 SoC support
> [PATCH 02/04] ARM: shmobile: r8a7790 SCIF support
> [PATCH 03/04] ARM: shmobile: r8a7790 IRQC support
> [PATCH 04/04] ARM: shmobile: r8a7790 PFC support
> 
> This series is V2 of initial support for the r8a7790 SoC. The SoC
> is known as r8a7790 which is built around Cortex-A15 and makes use
> of SCIF for serial and IRQC interrupt controller for external IRQs.
> 
> Changes in V2:
> - Added PFC platform device
> 
> Future r8a7790 PFC and Lager board series will depend on this one.

Thanks, queued up for v3.10 in the soc branch.
