From: Simon Horman <horms@verge.net.au>
Date: Mon, 12 May 2014 07:10:24 +0000
Subject: Re: [PATCH 00/03] ARM: shmobile: Use shmobile_init_delay() on r8a7791
Message-Id: <20140512071022.GB20505@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20140511232508.20177.11556.sendpatchset@w520>
In-Reply-To: <20140511232508.20177.11556.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, May 12, 2014 at 08:25:08AM +0900, Magnus Damm wrote:
> ARM: shmobile: Use shmobile_init_delay() on r8a7791
> 
> [PATCH 01/03] ARM: shmobile: Use r8a7791 DT CPU Frequency in common case	
> [PATCH 02/03] ARM: shmobile: Use r8a7791 DT CPU Frequency for Koelsch
> [PATCH 03/03] ARM: shmobile: Remove unused r8a7791_init_early()
> 
> Convert r8a7791 to rely on shmobile_init_delay() instead of using a per-SoC
> delay setup function.

Thanks, I will queue this up.
