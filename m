From: Christoph Hellwig <hch@lst.de>
Date: Tue, 11 Jun 2019 09:20:07 +0000
Subject: Re: [PATCH 15/15] riscv: add binfmt_flat support
Message-Id: <20190611092007.GA23387@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190610212015.9157-1-hch@lst.de>
 <20190610212015.9157-16-hch@lst.de>
 <d8d81820-8f0d-d5d0-fa3d-3376ddcc5358@arm.com>
In-Reply-To: <d8d81820-8f0d-d5d0-fa3d-3376ddcc5358@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vladimir Murzin <vladimir.murzin@arm.com>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org

On Tue, Jun 11, 2019 at 09:16:43AM +0100, Vladimir Murzin wrote:
> On 6/10/19 10:20 PM, Christoph Hellwig wrote:
> > Use the generic support with arguments are on the stack.  Same as arm
> > and m68k.
> 
> Out of curiosity, what is reason for keeping arguments on the stack?
> 
> ARM port of uClibc has following comment around manipulating of argv/argc:
> 
>         /*
>          * uClinux/arm stacks look a little different from normal
>          * MMU-full Linux/arm stacks (for no good reason)
>          */
> 
> So I though it is kind of legacy.

I just copied m68k and arm.  But dropping this makes the uclinux
crt1 code simpler, so I'll drop the flag for the next version.
