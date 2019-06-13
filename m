From: Greg Ungerer <gerg@linux-m68k.org>
Date: Thu, 13 Jun 2019 23:38:06 +0000
Subject: Re: binfmt_flat cleanups and RISC-V support v2
Message-Id: <9a7c0892-21f3-23fb-590d-011d66f97320@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20190613070903.17214-1-hch@lst.de>
In-Reply-To: <20190613070903.17214-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Christoph,

On 13/6/19 5:08 pm, Christoph Hellwig wrote:
> below is a larger stash of cleanups for the binfmt_misc code,
> preparing for the last patch that now trivially adds RISC-V
> support, which will be used for the RISC-V nommu series I am
> about to post.
> 
> Changes since v2:
>   - fix the handling of old format flags
>   - don't pass arguments on stack for RISC-V
>   - small cleanups for flat_v2_reloc_t

Thanks for doing this work. Tested and works for me on
m68k/Coldfire too.

I have pushed these onto the for-next branch of the
m68knommu git tree.

Regards
Greg
