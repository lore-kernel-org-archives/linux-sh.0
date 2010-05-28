From: Oleg Nesterov <oleg@redhat.com>
Date: Fri, 28 May 2010 19:43:02 +0000
Subject: Re: [PATCH 0/2] blackfin: ptrace mm/sram_list fixes
Message-Id: <20100528194302.GA14140@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100521183512.4477F40476@magilla.sf.frob.com> <20100522165320.GA19573@redhat.com> <25539.1274711817@redhat.com> <20100524151445.GA6393@redhat.com> <17134.1274778852@redhat.com> <20100525102345.GA23574@redhat.com> <AANLkTilT3D8c86LYK2DxcNpM2F3D8iCbgY_sfUg8h58p@mail.gmail.com> <20100526124006.GA28358@redhat.com> <20100527195544.GA25935@redhat.com> <AANLkTik5mWPysArnlyZKdnjUxNzyde8myKCbTvxJIj8G@mail.gmail.com>
In-Reply-To: <AANLkTik5mWPysArnlyZKdnjUxNzyde8myKCbTvxJIj8G@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier.adi@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Roland McGrath <roland@redhat.com>, linux-sh@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linux-kernel@vger.kernel.org

On 05/27, Mike Frysinger wrote:
>
> > BTW. Obviously sys_sram_alloc() can create multiple sram_list_struct
> > nodes with the same ->addr (with or without this patch), I hope this
> > is fine.
>
> how so ?

OOPS. Of course it can't, I was wrong.

> Blackfin is a nommu arch, so there should be no aliasing
> issues.  each of the individual L1 sub-allocators manage a different
> address range, and none of those should return an address that is
> already in use.

Yes, I greatly misunderstood this code, to the point I didn't notice
where this "addr" actually comes from.

Thanks for your explanation,

Oleg.

