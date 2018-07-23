From: Richard Kuo <rkuo@codeaurora.org>
Date: Mon, 23 Jul 2018 21:34:27 +0000
Subject: Re: [PATCH] arch/h8300: fix kernel/dma.c build warning
Message-Id: <20180723213427.GB12771@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <b4146df6-93ef-5f4d-9302-2040895d62b0@infradead.org>
 <CAMuHMdVs4y_BeONEWiAqmNSo+U8um1EZ16sfgdnw8rar6ASzxg@mail.gmail.com>
 <24723dd8-9d9f-24b7-6fe9-71a776c5d444@infradead.org>
In-Reply-To: <24723dd8-9d9f-24b7-6fe9-71a776c5d444@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Sun, Jul 22, 2018 at 10:24:58AM -0700, Randy Dunlap wrote:
> On 07/22/2018 02:25 AM, Geert Uytterhoeven wrote:
> > CC hexagon
> > 
> > hexagon != H8/300 != SuperH
> 
> argh.  Thanks.
> 
> > On Sat, Jul 21, 2018 at 5:17 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >>
> >> Fix build warning in arch/hexagon/kernel/dma.c by casting a void *
> >> to unsigned long to match the function parameter type.
> >>
> >> ../arch/hexagon/kernel/dma.c: In function 'arch_dma_alloc':
> >> ../arch/hexagon/kernel/dma.c:51:5: warning: passing argument 2 of 'gen_pool_add' makes integer from pointer without a cast [enabled by default]
> >> ../include/linux/genalloc.h:112:19: note: expected 'long unsigned int' but argument is of type 'void *'
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> >> Cc: Rich Felker <dalias@libc.org>
> >> Cc: linux-sh@vger.kernel.org
> >> ---
> >>  arch/hexagon/kernel/dma.c |    2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>

Thanks all the same!

For Hexagon:


Acked-by: Richard Kuo <rkuo@codeaurora.org>


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
