From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Date: Tue, 18 Mar 2008 07:31:00 +0000
Subject: Re: [PATCH] Use relative path when creating include/asm/{mach,cpu}
Message-Id: <47DF6FB4.3090802@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <47DEC594.6010502@gmail.com>
In-Reply-To: <47DEC594.6010502@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Mon, Mar 17, 2008 at 08:25:08PM +0100, Franck Bui-Huu wrote:
>> From: Franck Bui-Huu <fbuihuu@gmail.com>
>>
>> Usually relative paths are preferred because they survive directory
>> moves, work across networked file systems/chrooted environments.
>>
> Usually, yes. But in this case, as Stuart noted, they are needed for
> out-of-tree builds.
> 

Yes I've just checked and the patch won't work as is.

> It would be nice to get rid of the symlinks completely, and Sam had some
> ideas on how we could do that by doing a massive header reorganization,
> which is probably the way we'll go in the longer run.

Sure, the patch I sent is just a 'fix' for building a kernel tree across
NFS for example.

> For now we just have to live with the obfuscation. Patches that clean
> it up without breaking existing behaviour are welcome, though.
> 

Well it should be pretty trivial to make this patch works both cases
although it can't be called a "clean up" patch.

Thanks,
		Franck
