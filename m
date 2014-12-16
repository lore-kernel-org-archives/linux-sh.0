From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 16 Dec 2014 23:02:55 +0000
Subject: Re: [PATCH v2 7/7] ARM: shmobile: r8a73a4: ape6evm: remove legacy platform
Message-Id: <2549064.NsHtKnGJZ8@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1418747163-21729-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1418747163-21729-8-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Tuesday 16 December 2014 17:26:03 Ulrich Hecht wrote:
> This removes the remains of the legacy ape6evm platform.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  arch/arm/boot/dts/Makefile             |   1 -
>  arch/arm/mach-shmobile/Kconfig         |  13 --
>  arch/arm/mach-shmobile/Makefile        |   1 -
>  arch/arm/mach-shmobile/Makefile.boot   |   1 -
>  arch/arm/mach-shmobile/board-ape6evm.c | 286 ------------------------------

You should also remove arch/arm/configs/ape6evm_defconfig (and its mention in 
MAINTAINERS). With that change,

Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

>  5 files changed, 302 deletions(-)
>  delete mode 100644 arch/arm/mach-shmobile/board-ape6evm.c

-- 
Regards,

Laurent Pinchart

