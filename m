From: Shin-ichiro KAWASAKI <kawasaki@juno.dti.ne.jp>
Date: Sun, 11 Jan 2009 03:58:12 +0000
Subject: Re: [Qemu-devel] sh: dcache flush breaks text region?
Message-Id: <49696E54.9030102@juno.dti.ne.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <4968DD28.3030709@juno.dti.ne.jp>
	<20090110195332.GD26952@edgar.se.axis.com>
In-Reply-To: <20090110195332.GD26952@edgar.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: qemu-devel@nongnu.org
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Edgar E. Iglesias wrote:
> On Sun, Jan 11, 2009 at 02:38:48AM +0900, Shin-ichiro KAWASAKI wrote:
>> Hi, all.
>>
>> I'm now working on to expand qemu-sh to emulate
>> "Solution Engine 7750", and found one odd thing.
>> Could you give me some advice?
>>
>> My SH7750 emulation environment fails to boot up.
>> I made some investigation and found that,
>>  - the linux kernel for SE7750(se7750_defconfig) flushes
>>    dcache on its boot sequence.
>>  - SH7750's dcache is 16KB and direct-map.
>>    Then 16KB memory region are touched and modified to flush it.
>>  - empty_zero_page is used for this flush, but it only has
>>    4KB.  The text region after it has got broken and causes
>>    boot failure.
>>
>> I added a patch against linux kernel to this mail for a reference.
>> It only reduces the flush region size to 4KB=PAGE_SIZE, but avoids
>> the problem and let the kernel boot up cleanly.
>> Of course it is not a good solution, because it does not flush all
>> caches.
>>
>> I wonder two points.
>>  - Does this problem happen on real SE7750 board?
> 
> Hello,
> 
> I'm not very familiar with sh arch so please take this with a grain
> of salt :)
> 
> It's not entirely clear to me if the bug will show up on silicon, but my
> guess is that it wont.
> 
>>From my understating of the docs, the movca store will for misses in the
> cache be processed with a write-validate write-miss policy. That means that
> the movca store will allocate the line (flushing any previous content if
> needed) but not fetch any data corresponding to the movca store address.
> The sh7750 does not have multiple dirty bits per line so that kind of
> treatment leaves the unwritten parts of the line with unpredictable results.
> 
> Such insns can be very useful for fast block copies through writeback caches
> that otherwise do a line fetch for write-misses.
> 
> So, when the ocbi insn invalidates the line, no write back is done and the
> downstream busses never see the movca store.

Thanks a lot!  This explains the situation.
I haven't understood what movca does.

> I'm not sure how to handle this in qemu without adding cache models.
That seems a too big work and might have performance drawback.

> One way to handle this particular cacheflush sequence might be to delay all
> movca stores until there's another load/store or cache control insn being
> issued to help you figure out if you can ignore previous movca. That will
> not by any means cover all cases though.
It seems a good way to avoid this problem.
My current modification plan is as follows.
 - On executing 'movca', just record the store task which movca
   should do into CPUStatus.
 - On executing 'ocbi', delete the store task.
 - Let TCG produce 'delayed_movca' instruction for
   the first 'memory touching insn' or 'exception producing insn'
   after movca.
 - On executing 'delayed_movca', do the store tasks. 

> Another solution might be for linux to use a ocpb followed by a ocpi insn
> on the line. IIUC that should achieve the same results net results.
I'm not sure about it.  But I think we should not modify linux,
because now I guess that the current linux works on real silicon. 

Thanks again!

Regards,
Shin-ichiro KAWASAKI
