From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 12 Feb 2019 07:49:40 +0000
Subject: Re: [PATCH 06/12] dma-mapping: improve selection of dma_declare_coherent availability
Message-Id: <20190212074940.GB5924@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190211133554.30055-1-hch@lst.de>
 <20190211133554.30055-7-hch@lst.de>
In-Reply-To: <20190211133554.30055-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

On Mon, Feb 11, 2019 at 02:35:48PM +0100, Christoph Hellwig wrote:
> This API is primarily used through DT entries, but two architectures
> and two drivers call it directly.  So instead of selecting the config
> symbol for random architectures pull it in implicitly for the actual
> users.  Also rename the Kconfig option to describe the feature better.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
