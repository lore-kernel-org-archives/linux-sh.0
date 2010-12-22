From: Simon Horman <horms@verge.net.au>
Date: Wed, 22 Dec 2010 22:49:01 +0000
Subject: Re: [PATCH] rfc v3: ARM: mach-shmobile: mackerel: Add zboot support
Message-Id: <20101222224901.GA16187@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1291855635-30882-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1291855635-30882-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Dec 09, 2010 at 09:47:15AM +0900, Simon Horman wrote:
> When CONFIG_ZBOOT_ROM is selected, the resulting zImage file will be small
> boot loader and may be burned to rom or flash.
> 
> Compile tested only.

I now have access to a Mackerel board and have verified that
this patch works.

My verification method was to usa a hack; I removed the
SDRAM initialisation portion of head-mackerel.txt and
then booting the resulting zImage from uboot using:

=> bootp
=> go 0x42000000

This is the same method that I used to test the AP4 variant of this change.

Morimoto-san, could you test this by burning an image (without the above
hack) to Flash? I can provide an image or tree if that helps.

> This patch assumes that head-mackerel.txt will be the same as head-ap4evb.txt.
> I am waiting for verification of this.
> 
> This patch depends on
> * ARM: 6515/1: Add zboot support for SuperH Mobile ARM
>   (merged into the devel branch of Russel King's linux-2.6-arm tree)
> * ARM: 6514/1: mach-shmobile: Add zboot support for SuperH Mobile ARM
>   (merged into the devel branch of Russel King's linux-2.6-arm tree)
> * MACH_MACKEREL (3211) being present in arch/arm/tools/mach-types
> 
> v2:
> * Use head-mackerel.txt for Mackerel.
>   head-ap4evb.txt was used by mistake.
> 
> v3:
> * Actually make the change to use head-mackerel.txt
> 
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../mach-shmobile/include/mach/head-mackerel.txt   |   87 ++++++++++++++++++++
>  arch/arm/mach-shmobile/include/mach/zboot.h        |    3 +
>  2 files changed, 90 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-shmobile/include/mach/head-mackerel.txt
> 
