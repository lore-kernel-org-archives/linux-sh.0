From: Christoph Hellwig <hch@lst.de>
Date: Mon, 11 Feb 2019 13:35:42 +0000
Subject: dma_declare_coherent spring cleaning
Message-Id: <20190211133554.30055-1-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: iommu@lists.linux-foundation.org
Cc: linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org

Hi all,

this series removes various bits of dead code and refactors the
remaining functionality around dma_declare_coherent to be a somewhat
more coherent code base.
