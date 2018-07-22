From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 22 Jul 2018 17:24:58 +0000
Subject: Re: [PATCH] arch/h8300: fix kernel/dma.c build warning
Message-Id: <24723dd8-9d9f-24b7-6fe9-71a776c5d444@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <b4146df6-93ef-5f4d-9302-2040895d62b0@infradead.org>
 <CAMuHMdVs4y_BeONEWiAqmNSo+U8um1EZ16sfgdnw8rar6ASzxg@mail.gmail.com>
In-Reply-To: <CAMuHMdVs4y_BeONEWiAqmNSo+U8um1EZ16sfgdnw8rar6ASzxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Kuo <rkuo@codeaurora.org>, "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>

On 07/22/2018 02:25 AM, Geert Uytterhoeven wrote:
> CC hexagon
> 
> hexagon != H8/300 != SuperH

argh.  Thanks.

> On Sat, Jul 21, 2018 at 5:17 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Fix build warning in arch/hexagon/kernel/dma.c by casting a void *
>> to unsigned long to match the function parameter type.
>>
>> ../arch/hexagon/kernel/dma.c: In function 'arch_dma_alloc':
>> ../arch/hexagon/kernel/dma.c:51:5: warning: passing argument 2 of 'gen_pool_add' makes integer from pointer without a cast [enabled by default]
>> ../include/linux/genalloc.h:112:19: note: expected 'long unsigned int' but argument is of type 'void *'
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: linux-sh@vger.kernel.org
>> ---
>>  arch/hexagon/kernel/dma.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> --- linux-next-20180717.orig/arch/hexagon/kernel/dma.c
>> +++ linux-next-20180717/arch/hexagon/kernel/dma.c
>> @@ -47,7 +47,7 @@ void *arch_dma_alloc(struct device *dev,
>>                         panic("Can't create %s() memory pool!", __func__);
>>                 else
>>                         gen_pool_add(coherent_pool,
>> -                               pfn_to_virt(max_low_pfn),
>> +                               (unsigned long)pfn_to_virt(max_low_pfn),
>>                                 hexagon_coherent_pool_size, -1);
>>         }
>>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 


-- 
~Randy
