From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 16 Jul 2015 09:22:29 +0000
Subject: Re: [PATCH] dmaengine: use phys_addr_t for slave configuration
Message-Id: <CACRpkdbwyDHe21pk95w4OMxKN4Ns8w-V-qb+nqSbpEh4UD=7vA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1366967214-20776-1-git-send-email-linus.walleij@linaro.org>
	<CAMuHMdUTzTBT8DyRb5WN048U5DbVsFnhJB0c5tjHBnA4rfetJg@mail.gmail.com>
In-Reply-To: <CAMuHMdUTzTBT8DyRb5WN048U5DbVsFnhJB0c5tjHBnA4rfetJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee.jones@linaro.org>, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>

On Wed, Jul 8, 2015 at 12:12 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Apr 26, 2013 at 11:06 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> The documentation already says these are physical addresses, and
>> we have concluded that any translation into the DMA address space
>> needs to reside in the dmaengine driver, so change the type of
>> the passed arguments.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Lee Jones <lee.jones@linaro.org>
>> Cc: Vinod Koul <vinod.koul@intel.com>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> What's the status of this one, which has been acked by Lee and Arnd?

I don't even remember writing this patch anymore, haha :D

Yours,
Linus Walleij
