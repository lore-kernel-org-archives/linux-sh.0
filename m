From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 13 Jan 2014 09:35:41 +0000
Subject: Re: [PATCH] ARM: shmobile: compile drivers/sh for CONFIG_ARCH_SHMOBILE_MULTI
Message-Id: <52D3B36D.8040902@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1389367095-7760-1-git-send-email-ben.dooks@codethink.co.uk> <CAMuHMdU+SfjNJC_b_7ovT9Uf5p5MwB0iULjorzthcLJxYJ-00g@mail.gmail.com>
In-Reply-To: <CAMuHMdU+SfjNJC_b_7ovT9Uf5p5MwB0iULjorzthcLJxYJ-00g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@lists.codethink.co.uk, Linux Kernel list <linux-kernel@vger.kernel.org>, Linus SH list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 13/01/14 09:28, Geert Uytterhoeven wrote:
> On Fri, Jan 10, 2014 at 4:18 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> --- a/drivers/sh/Makefile
>> +++ b/drivers/sh/Makefile
>> @@ -3,7 +3,10 @@
>>   #
>>   obj-y  := intc/
>>
>> +ifeq ($(CONFIG_COMMON_CLK),n)
>>   obj-$(CONFIG_HAVE_CLK)         += clk/
>> +endif
>> +
>
> This part breaks my Koelsch legacy (non-reference) build:
>
> arch/arm/kernel/built-in.o: In function `twd_local_timer_common_register':
> io.c:(.init.text+0x1804): undefined reference to `clk_enable'
> io.c:(.init.text+0x1828): undefined reference to `clk_get_rate'
...
>
> Both of my Koelsch legacy and reference configs have CONFIG_HAVE_CLK=y,
> but only the reference once has CONFIG_COMMON_CLK=y.

Hmm, thought undefined symbols got set to 'n'.

I can either fix this by

ifneq ($(CONFIG_COMMON_CLK),y)
endif

or adding an extra Kconfig for SH specific legacy clock code.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
