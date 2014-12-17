From: Simon Horman <horms@verge.net.au>
Date: Wed, 17 Dec 2014 00:30:36 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a73a4: Remove legacy code
Message-Id: <20141217003036.GG23321@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1418771008-5676-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418771008-5676-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 17, 2014 at 01:03:28AM +0200, Laurent Pinchart wrote:
> All r8a73a4 boards are now used with multiplatform kernels only. We can
> remove all the unused r8a73a4 legacy device and clock registration code.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  arch/arm/mach-shmobile/Makefile        |   1 -
>  arch/arm/mach-shmobile/clock-r8a73a4.c | 659 ---------------------------------
>  arch/arm/mach-shmobile/r8a73a4.h       |  17 -
>  arch/arm/mach-shmobile/setup-r8a73a4.c | 273 +-------------
>  4 files changed, 2 insertions(+), 948 deletions(-)
>  delete mode 100644 arch/arm/mach-shmobile/clock-r8a73a4.c
>  delete mode 100644 arch/arm/mach-shmobile/r8a73a4.h
> 
> Hi Ulrich,
> 
> You might want to consider adding this patch to the end of your series.

Many lines removed. Wonderful!
