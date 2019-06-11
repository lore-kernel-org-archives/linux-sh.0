From: Vladimir Murzin <vladimir.murzin@arm.com>
Date: Tue, 11 Jun 2019 08:05:45 +0000
Subject: Re: binfmt_flat cleanups and RISC-V support
Message-Id: <4f000219-4baf-b03e-9003-26482640d3de@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190610212015.9157-1-hch@lst.de>
In-Reply-To: <20190610212015.9157-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>, Greg Ungerer <gerg@linux-m68k.org>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org

Hi Christoph,

On 6/10/19 10:20 PM, Christoph Hellwig wrote:
> Hi Greg,
> 
> below is a larger stash of cleanups for the binfmt_misc code,
> preparing for the last patch that now trivially adds RISC-V
> support, which will be used for the RISC-V nommu series I am
> about to post.


I'm wondering if you have a branch with these changes so I can give
it a try on ARM NOMMU platforms?

Cheers
Vladimir

> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
