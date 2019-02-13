From: Christoph Hellwig <hch@lst.de>
Date: Wed, 13 Feb 2019 18:16:41 +0000
Subject: Re: [PATCH 03/12] of: mark early_init_dt_alloc_reserved_memory_arch static
Message-Id: <20190213181641.GA19706@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-4-hch@lst.de>
 <CAL_JsqJ2Qt6=TTD250C9qW7Kv8rZn5PyB_C78FUhWwfgOnjPHg@mail.gmail.com>
In-Reply-To: <CAL_JsqJ2Qt6=TTD250C9qW7Kv8rZn5PyB_C78FUhWwfgOnjPHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh@kernel.org>
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, SH-Linux <linux-sh@vger.kernel.org>, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-mips@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux IOMMU <iommu@lists.linux-foundation.org>, linux-riscv@lists.infradead.org, arcml <linux-snps-arc@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>, Christoph Hellwig <hch@lst.de>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>

On Tue, Feb 12, 2019 at 02:24:19PM -0600, Rob Herring wrote:
> Looks like this one isn't a dependency, so I can take it if you want.

Sure, please go ahead.
