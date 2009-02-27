From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 27 Feb 2009 07:53:00 +0000
Subject: Re: [PATCH 04/04] sh: prefetch early exception data on sh3/sh4/sh4a
Message-Id: <aec7e5c30902262353n5d0f85aap37c3402c3121de25@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090223071931.12300.72669.sendpatchset@rx1.opensource.se>
In-Reply-To: <20090223071931.12300.72669.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 27, 2009 at 4:22 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Mon, Feb 23, 2009 at 04:19:31PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@igel.co.jp>
>>
>> Prefetch early exception data. There is unused space in our
>> exception handler cache line anyway, so this is almost free.
>>
> Hmm, this won't work, 'pref' doesn't exist on SH-3. The binutils opcode
> table defines it as arch_sh2a_nofpu_or_sh4_nommu_nofpu_up, which excludes
> SH-3. mova is ok, though.
>
> This does show how often SH-3 gets tested though, as asm/processor_32.h
> happily defines prefetch() for SH-3 when it shouldn't. I'll tidy this up
> and drop in a PREF() macro.

Right, I do recall building for hp6xx at some point. Thanks for fixing it up.

/ magnus
