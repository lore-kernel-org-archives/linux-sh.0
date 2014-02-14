From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 14 Feb 2014 13:47:45 +0000
Subject: Re: [PATCH 27/27] ARM: shmobile: koelsch-reference: Enable CMT0 in device tree
Message-Id: <52FE1E81.2040101@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1392339605-20691-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1392339605-20691-28-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1392339605-20691-28-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 14-02-2014 5:00, Laurent Pinchart wrote:

> Enable the CMT0 device and configure channel 0 as a clock event
> provider.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   arch/arm/boot/dts/r8a7791-koelsch.dts            |  9 +++++++++
>   arch/arm/mach-shmobile/board-koelsch-reference.c | 15 +--------------
>   arch/arm/mach-shmobile/include/mach/r8a7791.h    |  1 -
>   arch/arm/mach-shmobile/setup-r8a7791.c           |  7 +------

    The latter 2 files are worth splitting into a separate patch as well...

>   4 files changed, 11 insertions(+), 21 deletions(-)

WBR, Sergei

