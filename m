From: Greg Ungerer <gregungerer00@gmail.com>
Date: Tue, 11 Jun 2019 13:07:36 +0000
Subject: Re: [PATCH 04/15] binfmt_flat: remove flat_old_ram_flag
Message-Id: <1aaf5ce2-1e7a-e818-fbeb-42fbe551a108@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20190610212015.9157-1-hch@lst.de>
 <20190610212015.9157-5-hch@lst.de>
 <b1ce6fc6-343c-7686-b4f4-35a305dc2adb@linux-m68k.org>
 <20190611073648.GA21522@lst.de>
In-Reply-To: <20190611073648.GA21522@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org



On 11/6/19 5:36 pm, Christoph Hellwig wrote:
> On Tue, Jun 11, 2019 at 04:04:39PM +1000, Greg Ungerer wrote:
>>> index c0e4535dc1ec..18d82fd5f57c 100644
>>> --- a/fs/binfmt_flat.c
>>> +++ b/fs/binfmt_flat.c
>>> @@ -488,7 +488,8 @@ static int load_flat_file(struct linux_binprm *bprm,
>>>    	 * fix up the flags for the older format,  there were all kinds
>>>    	 * of endian hacks,  this only works for the simple cases
>>>    	 */
>>> -	if (rev = OLD_FLAT_VERSION && flat_old_ram_flag(flags))
>>> +	if (IS_ENABLED(CONFIG_BINFMT_FLAT_OLD_ALWAYS_RAM) &&
>>> +	    rev = OLD_FLAT_VERSION)
>>
>> The flags are from the binary file header here, so this is going to lose
>> that check for most platforms (except h8300 where it would always have
>> been true).
> 
> Indeed.  The old code is:
> 
> 	if (rev = OLD_FLAT_VERSION && flat_old_ram_flag(flags))
> 		flags = FLAT_FLAG_RAM;
> 
> which for !h8300 evaluates to:
> 
> 	if (rev = OLD_FLAT_VERSION && flags)
> 		flags = FLAT_FLAG_RAM;
> 
> so basically if any flag was set it was turned into FLAT_FLAG_RAM.
> Was that really intentional?

Probably not, looking at the flags. For the compressed flag it
makes some sense. But I don't think many of the others need load
to RAM behavior.


>  I guess even if it wasn't the is no
> point in changing this historic behavior now.
> 
> So I guess what we could do it something like:
> 
> 	if (rev = OLD_FLAT_VERSION &&
> 	    (flags || IS_ENABLED(CONFIG_BINFMT_FLAT_OLD_ALWAYS_RAM)))
> 		flags = FLAT_FLAG_RAM;

Yeah, that to looks to preserve the old behavior.

Regards
Greg
