From: Michal Simek <monstr@monstr.eu>
Date: Tue, 23 Mar 2010 07:22:15 +0000
Subject: Re: [PATCH] uImage: Allow to specify MKIMAGE
Message-Id: <4BA86C27.60101@monstr.eu>
List-Id: <linux-sh.vger.kernel.org>
References: <20100320184907.8036.82488.stgit@localhost.localdomain>
In-Reply-To: <20100320184907.8036.82488.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Paulius Zaleckas wrote:
> Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
> ---
> 
>  arch/arm/boot/Makefile          |    4 ++--
>  arch/avr32/boot/images/Makefile |    4 ++--
>  arch/blackfin/boot/Makefile     |    4 ++--
>  arch/microblaze/boot/Makefile   |    4 ++--
>  arch/sh/boot/Makefile           |    4 ++--
>  scripts/mkuboot.sh              |    1 +
>  6 files changed, 11 insertions(+), 10 deletions(-)
> 
Acked-by: Michal Simek <monstr@monstr.eu>


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
