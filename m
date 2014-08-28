From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 28 Aug 2014 12:49:52 +0000
Subject: Re: [PATCH] ARM: shmobile: Enable Armadillo 800 EVA board in multiplatform defconfig
Message-Id: <3285079.8x1UeyRQTp@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <1409229622-11566-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1409229622-11566-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thursday 28 August 2014 14:40:22 Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/configs/shmobile_defconfig | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

No objections to the patch, but I wonder if you could send another
patch to enable all the machines working in ARCH_SHMOBILE_MULTI
as part of multi_v7_defconfig as well.

	Arnd
