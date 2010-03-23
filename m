From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 23 Mar 2010 04:05:13 +0000
Subject: Re: [PATCH] uImage: Allow to specify MKIMAGE
Message-Id: <20100323040513.GB13417@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100320184907.8036.82488.stgit@localhost.localdomain>
In-Reply-To: <20100320184907.8036.82488.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sat, Mar 20, 2010 at 08:49:07PM +0200, Paulius Zaleckas wrote:
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
Acked-by: Paul Mundt <lethal@linux-sh.org>
