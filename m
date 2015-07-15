From: Simon Horman <horms@verge.net.au>
Date: Wed, 15 Jul 2015 00:25:01 +0000
Subject: Re: [PATCH v3 00/04] ARM: shmobile: r8a7779 Marzen multiplatform cleanup V3
Message-Id: <20150715002501.GF30642@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150713061450.25534.96315.sendpatchset@little-apple>
In-Reply-To: <20150713061450.25534.96315.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Mon, Jul 13, 2015 at 03:14:50PM +0900, Magnus Damm wrote:
> ARM: shmobile: r8a7779 Marzen multiplatform cleanup V3
> 
> [PATCH v3 01/04] ARM: shmobile: r8a7779: Generic SMP ops
> [PATCH v3 02/04] ARM: shmobile: marzen-reference: Remove C board code
> [PATCH v3 03/04] ARM: shmobile: Remove Marzen from shmobile_defconfig
> [PATCH v3 04/04] ARM: shmobile: r8a7779: Cleanup header file
> 
> This series is simply resending the remaining r8a7779 multiplatform
> cleanup patches. The code has not changed since V2:
> 
> [PATCH v2 00/06] ARM: shmobile: r8a7779 IRQ update and Marzen cleanup V2
> 
> With these patches applied the r8a7779 SoC gets DT-only multiplatform
> support and old C board code for multiplatform gets removed.
> 
> The legacy r8a7779 Marzen code is not touched by this series, but
> with these patches applied basic r8a7779 multiplatform SoC support
> is done and only a few I/O devices are legacy-only.

Thanks, I have queued these up.

Please send a follow-up patch to address Geert's observation that
CONFIG_MACH_MARZEN should be removed from multi_v7_defconfig.
