From: Greg Ungerer <gregungerer00@gmail.com>
Date: Tue, 11 Jun 2019 13:02:24 +0000
Subject: Re: binfmt_flat cleanups and RISC-V support
Message-Id: <87039cee-925b-3f50-f29f-94e55ef6e985@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20190610212015.9157-1-hch@lst.de>
 <6e5fb7db-1d6f-7d49-553c-edc18f14f641@linux-m68k.org>
 <20190611073802.GB21522@lst.de>
In-Reply-To: <20190611073802.GB21522@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org


On 11/6/19 5:38 pm, Christoph Hellwig wrote:
> On Tue, Jun 11, 2019 at 04:51:02PM +1000, Greg Ungerer wrote:
>> Hi Christoph,
>>
>> On 11/6/19 7:20 am, Christoph Hellwig wrote:
>>> below is a larger stash of cleanups for the binfmt_misc code,
>>> preparing for the last patch that now trivially adds RISC-V
>>> support, which will be used for the RISC-V nommu series I am
>>> about to post.
>>
>> Whole series looks pretty good. Just the one comment I made.
>>
>> I normally take these through the m68knommu git tree,
>> if you have no problem with that I'll push it in there.
>> It will hit linux-next from there.
> 
> Yes, that's fine.  We'll need it to bring up riscv nommu support,
> but there is no actual dependency on the patches for it to compile,
> just for it to actually be useful.
> 
> Btw, it seems like the uclinux-dev list is dead, is there a replacement
> for it?

No, unfortunately no replacement. Generally I think anything that comes
up goes to the architecture list that issues come up on. Probably not
ideal, especially for things like this that are across all arches.

Regards
Greg
