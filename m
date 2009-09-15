From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 15 Sep 2009 13:39:03 +0000
Subject: Re: User mode address error problems on 7763
Message-Id: <20090915133903.GB23923@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
In-Reply-To: <6e6aa1a80909111106l6dbcfccag4e9e7a3abb922688@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 15, 2009 at 08:29:21AM -0500, Dale Larson wrote:
> >> > page size. That will bring up a menu where you can cycle through the
> >> > available page sizes. I don't recommend 1MB for a system page size, as it
> >> > tends to interact badly with some of the slab allocators. 64k will give
> >> > you an idea of whether there are indeed any aliasing bugs lurking about.
> 
> When I turned on 64K pages I got the following panic:
> 
> [   18.596000] Freeing unused kernel memory: 192k freed
> /sbin/init:572: can't map '/lib/libm.so.0'
> /sbin/init:572: can't map '/lib/libm.so.0'
> /sbin/init: can't load library 'libm.so.0'
> [   18.828000] Kernel panic - not syncing: Attempted to kill init!
> [   18.832000] Stack: (0x8c12ff1c to 0x8c130000)
> [   18.836000] ff00:
>              8817176a
> [   18.852000] ff20: 8c12ff2c 8c113400 881b5570 881717c0 8c12ff34
> 8c12ff58 88033390 8c12ff64
> [   18.868000] ff40: 29563718 29574008 8c113400 00001000 8c113400
> 000000bc 8c1133f8 fffffefd
> [   18.888000] ff60: 8c12ff3c 8804319a 00000001 7be6fb84 29574008
> 8c12ff74 8c12ff74 880338d0
> [   18.904000] ff80: 8c12ff9c 29563718 29574008 00000000 00000071
> 00000100 880338c0 88025226
> [   18.920000] ffa0: 7be6fbb4 00000001 ffffff82 2959001a 00000001
> 00000010 00010000 00000002
> [   18.936000] ffc0: 29590019 00000000 00402109 29580028 0048149c
> 29574008 29563718 7be6fbb4
> [   18.956000] ffe0: 7be6fbb4 29562c66 29562c5e 00008100 00000000
> 00000004 00000001 00000044
> [   18.972000]
> [   18.972000] Call trace:
> [   18.976000]  [<8817176a>] dump_stack+0xe/0x1c
> [   18.980000]  [<881717c0>] panic+0x48/0x104
> [   18.984000]  [<88033390>] do_exit+0x40/0x4bc
> [   18.988000]  [<8804319a>] up_write+0xa/0x18
> [   18.992000]  [<880338d0>] sys_exit+0x10/0x18
> [   18.996000]  [<880338c0>] sys_exit+0x0/0x18
> [   19.000000]  [<88025226>] syscall_call+0xc/0x10
> [   19.004000]
> 
Great, your libc doesn't handle variable page sizes. You're either going
to have to update and rebuild your libc, or go back to the write-through
caching on 4k pages thing. The latter should be fine in the current tree,
as I've tested it on a number of boards. If you run in to issues with
that, please post a full boot log for that also.
