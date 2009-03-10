From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 10 Mar 2009 06:56:31 +0000
Subject: Re: [PATCH v2] sh: Add support 32-bit physical addressing by other method
Message-Id: <20090310065631.GF10393@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49AE433A.30503@renesas.com>
In-Reply-To: <49AE433A.30503@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 04, 2009 at 06:00:42PM +0900, Yoshihiro Shimoda wrote:
> There doesn't manage PMB in the kernel. The boot loader should set up PMB.
> P1/P2 area is handled like a 29-bit physical addressing, and local bus
> device are assinged P3 area.
> 
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
> ---
>  changes v2:
>   - clean up arch/sh/boot/Makefile
>   - fix wrong value for CONFIG_32BIT in arch/sh/kernel/vmlinux_32.lds.S
>   - fix typo in arch/sh/mm/Kconfig
> 
A few minor changes, but I've applied the series. Gradually we will have
to unify these two, but this is a reasonable approach for now and a
feature we will want to support when doing dynamic management by the
kernel anyways.
