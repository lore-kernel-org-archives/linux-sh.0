From: Christoph Hellwig <hch@lst.de>
Date: Tue, 11 Jun 2019 07:38:02 +0000
Subject: Re: binfmt_flat cleanups and RISC-V support
Message-Id: <20190611073802.GB21522@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20190610212015.9157-1-hch@lst.de>
 <6e5fb7db-1d6f-7d49-553c-edc18f14f641@linux-m68k.org>
In-Reply-To: <6e5fb7db-1d6f-7d49-553c-edc18f14f641@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Ungerer <gerg@linux-m68k.org>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org

On Tue, Jun 11, 2019 at 04:51:02PM +1000, Greg Ungerer wrote:
> Hi Christoph,
>
> On 11/6/19 7:20 am, Christoph Hellwig wrote:
>> below is a larger stash of cleanups for the binfmt_misc code,
>> preparing for the last patch that now trivially adds RISC-V
>> support, which will be used for the RISC-V nommu series I am
>> about to post.
>
> Whole series looks pretty good. Just the one comment I made.
>
> I normally take these through the m68knommu git tree,
> if you have no problem with that I'll push it in there.
> It will hit linux-next from there.

Yes, that's fine.  We'll need it to bring up riscv nommu support,
but there is no actual dependency on the patches for it to compile,
just for it to actually be useful.

Btw, it seems like the uclinux-dev list is dead, is there a replacement
for it?
