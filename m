From: Randy Dunlap <rdunlap@infradead.org>
Date: Fri, 02 Nov 2018 16:07:01 +0000
Subject: Re: [PATCH resend] arch/sh: mach-kfr2r09: fix struct mtd_oob_ops build warning
Message-Id: <bcd90d69-7487-a927-d5c1-d77c422665a8@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <702f0a25-c63e-6912-4640-6ab0f00afbc7@infradead.org>
 <20181102075245.GR15991@w540>
In-Reply-To: <20181102075245.GR15991@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jacopo mondi <jacopo@jmondi.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Jacopo Mondi <jacopo+renesas@jmondi.org>, Magnus Damm <magnus.damm@gmail.com>, linux-mtd@lists.infradead.org, linux-sh@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On 11/2/18 12:52 AM, jacopo mondi wrote:
> Hi Randy,
>    thanks for the patch.
> 
> On Thu, Nov 01, 2018 at 04:38:30PM -0700, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> arch/sh/boards/mach-kfr2r09/setup.c does not need to #include
>> <mtd/onenand.h>, and doing so causes a build warning, so drop
>> that header file.
>>
>> In file included from ../arch/sh/boards/mach-kfr2r09/setup.c:28:
>> ../include/linux/mtd/onenand.h:225:12: warning: 'struct mtd_oob_ops' declared inside parameter list will not be visible outside of this definition or declaration
>>      struct mtd_oob_ops *ops);
>>
>> Fixes: f3590dc32974 ("media: arch: sh: kfr2r09: Use new renesas-ceu camera driver")
> 
> Not sure if this is worth pointing out, but this commit only resorts
> headers. The one introducing the warning is actually 33893d7aa.
> 
> I felt like reporting this, as introducing a "Fixes" line for that
> commit too would help backporting maybe?

Oops, thanks, I'll fix that and send a v2 with your Ack.

> In any case:
> Acked-by: Jacopo Mondi <jacopo@jmondi.org>
> 
> Thanks
>    j
> 
>>
>> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>> Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> Cc: Magnus Damm <magnus.damm@gmail.com>
>> Cc: linux-mtd@lists.infradead.org
>> Cc: linux-sh@vger.kernel.org
>> ---
>>  arch/sh/boards/mach-kfr2r09/setup.c |    1 -
>>  1 file changed, 1 deletion(-)
>>
>> --- linux-next-20181101.orig/arch/sh/boards/mach-kfr2r09/setup.c
>> +++ linux-next-20181101/arch/sh/boards/mach-kfr2r09/setup.c
>> @@ -25,7 +25,6 @@
>>  #include <linux/memblock.h>
>>  #include <linux/mfd/tmio.h>
>>  #include <linux/mmc/host.h>
>> -#include <linux/mtd/onenand.h>
>>  #include <linux/mtd/physmap.h>
>>  #include <linux/platform_data/lv5207lp.h>
>>  #include <linux/platform_device.h>
>>
>>


-- 
~Randy
