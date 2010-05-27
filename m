From: Mike Frysinger <vapier.adi@gmail.com>
Date: Thu, 27 May 2010 20:21:04 +0000
Subject: Re: [PATCH 0/2] blackfin: ptrace mm/sram_list fixes
Message-Id: <AANLkTik5mWPysArnlyZKdnjUxNzyde8myKCbTvxJIj8G@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1274431345-22366-1-git-send-email-vapier@gentoo.org> 
	<20100521162659.GA16193@redhat.com> <20100521183512.4477F40476@magilla.sf.frob.com> 
	<20100522165320.GA19573@redhat.com> <25539.1274711817@redhat.com> 
	<20100524151445.GA6393@redhat.com> <17134.1274778852@redhat.com> 
	<20100525102345.GA23574@redhat.com> <AANLkTilT3D8c86LYK2DxcNpM2F3D8iCbgY_sfUg8h58p@mail.gmail.com> 
	<20100526124006.GA28358@redhat.com> <20100527195544.GA25935@redhat.com>
In-Reply-To: <20100527195544.GA25935@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-sh@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org

On Thu, May 27, 2010 at 15:55, Oleg Nesterov wrote:
> On 05/26, Oleg Nesterov wrote:
>> On 05/25, Mike Frysinger wrote:
>> > we probably should add proper locking to this
>> > structure though.
>>
>> Agreed. I'll try to make the trivial patch tomorrow. I think we
>> can just use mm->mmap_sem, is_user_addr_valid() needs this lock
>> for find_vma() anyway.
>
> please see the patches.

awesome !  wasnt expecting someone to do the work for us :).

> UNTESTED! the second one certainly needs the review from someone
> who knows what this code does ;)

np.  after i look them over, i'll suck them into the Blackfin tree and
let them settle for a release for our test suites to shake out
problems.

> BTW. Obviously sys_sram_alloc() can create multiple sram_list_struct
> nodes with the same ->addr (with or without this patch), I hope this
> is fine.

how so ?  Blackfin is a nommu arch, so there should be no aliasing
issues.  each of the individual L1 sub-allocators manage a different
address range, and none of those should return an address that is
already in use.  it could happen that the code calling these funcs
calls a free func directly instead of going through the lsl free, but
that's a bug in the usage, not this code.
-mike
