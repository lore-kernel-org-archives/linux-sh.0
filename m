From: Simon Horman <horms@verge.net.au>
Date: Wed, 18 Sep 2013 00:34:54 +0000
Subject: Re: [PATCH 00/05] ARM: shmobile: Use CPU notifiers for SCU boot vector code
Message-Id: <20130918003453.GA4330@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20130914134616.19258.27110.sendpatchset@w520>
In-Reply-To: <20130914134616.19258.27110.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, Sep 14, 2013 at 10:46:16PM +0900, Magnus Damm wrote:
> ARM: shmobile: Use CPU notifiers for SCU boot vector code
> 
> [PATCH 01/05] ARM: shmobile: Add CPU notifier based SCU boot vector code
> [PATCH 02/05] ARM: shmobile: Let sh73a0 rely on SCU CPU notifier
> [PATCH 03/05] ARM: shmobile: Let EMEV2 rely on SCU CPU notifier
> [PATCH 04/05] ARM: shmobile: Let r8a7779 rely on SCU CPU notifier
> [PATCH 05/05] ARM: shmobile: Remove shmobile_smp_scu_boot_secondary()
> 
> This series converts mach-shmobile to use CPU notifiers for boot vector
> setup for SCU based SoCs such as sh73a0, EMEV2 and r8a7779. This
> allows us to remove the shmobile_smp_scu_boot_secondary() function,
> and it is also ground work for the CPUIdle resume path.

Thanks Magnus, I have queued these up for v3.12.
