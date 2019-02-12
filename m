From: Rob Herring <robh@kernel.org>
Date: Tue, 12 Feb 2019 20:11:25 +0000
Subject: Re: [PATCH 04/12] of: select OF_RESERVED_MEM automatically
Message-Id: <CAL_JsqJFGhTa+izRTeUxjtbyOek-zynZofOJGDK+xZbD4r5H0Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-5-hch@lst.de>
In-Reply-To: <20190211133554.30055-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-xtensa@linux-xtensa.org, Lee Jones <lee.jones@linaro.org>, SH-Linux <linux-sh@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-mips@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-riscv@lists.infradead.org, arcml <linux-snps-arc@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, devicetree@vger.kernel.org

On Mon, Feb 11, 2019 at 7:37 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The OF_RESERVED_MEM can be used if we have either CMA or the generic
> declare coherent code built and we support the early flattened DT.
>
> So don't bother making it a user visible options that is selected
> by most configs that fit the above category, but just select it when
> the requirements are met.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arc/Kconfig     | 1 -
>  arch/arm/Kconfig     | 1 -
>  arch/arm64/Kconfig   | 1 -
>  arch/csky/Kconfig    | 1 -
>  arch/powerpc/Kconfig | 1 -
>  arch/xtensa/Kconfig  | 1 -
>  drivers/of/Kconfig   | 5 ++---
>  7 files changed, 2 insertions(+), 9 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
