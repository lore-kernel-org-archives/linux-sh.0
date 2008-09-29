From: "Magnus Damm" <magnus.damm@gmail.com>
Date: Mon, 29 Sep 2008 03:34:04 +0000
Subject: Re: [PATCH 01/05] sh: Add GPIO and pinmux base code
Message-Id: <aec7e5c30809282034gf45920ewa9dbff659eef54f1@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20080927181016.11246.72087.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080927181016.11246.72087.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Sep 28, 2008 at 3:39 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Sun, Sep 28, 2008 at 03:10:16AM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@igel.co.jp>
>>
>> This patch adds the pinmux table parser and gpiolib glue.
>> The old SH3 header code is removed.
>>
>> Signed-off-by: Magnus Damm <damm@igel.co.jp>
>
> For starters, I don't know why you decided to kill off the SH-3 gpio
> header. It's still in active use by the magicpanelr2 board. Once 7720 and
> mpr2 are converted over, then we can kill off the header, but not before
> that. Although I suppose we can just fix up the board header to use
> cpu-sh3/cpu/gpio.h explicitly.

I suspected the SH3 register definitions would be in use somewhere,
but I couldn't find any references to that header file. Now I do. =) I
must have forgot searching the asm include directory.

I'll fix that up.

>> --- 0001/arch/sh/include/asm/gpio.h
>> +++ work/arch/sh/include/asm/gpio.h   2008-09-28 02:03:40.000000000 +0900
>> @@ -1,19 +1,119 @@
>>  /*
>> - *  include/asm-sh/gpio.h
>> + * Generic GPIO API using gpiolib and pinmux table support for SuperH.
>>   *
>> - *  Copyright (C) 2007 Markus Brunner, Mark Jonas
>> + * Copyright (c) 2008 Magnus Damm
>>   *
>> - *  Addresses for the Pin Function Controller
>> + * Generic GPIO derived from x86 version:
>> + * Copyright (c) 2007-2008  MontaVista Software, Inc.
>> + * Author: Anton Vorontsov <avorontsov@ru.mvista.com>
>>   *
>> - * This file is subject to the terms and conditions of the GNU General Public
>> - * License.  See the file "COPYING" in the main directory of this archive
>> - * for more details.
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>>   */
>>  #ifndef __ASM_SH_GPIO_H
>>  #define __ASM_SH_GPIO_H
>>
> I wouldn't bother with the header comments at all, there's nothing
> profound here and it's almost all pinmux stuff anyways.

Yeah.

>> +static int read_write_reg(unsigned long reg, unsigned long reg_width,
>> +                       unsigned long field_width, unsigned long in_pos,
>> +                       unsigned long value, int do_write)
>> +{
>> +     unsigned long flags, data, mask, pos;
>> +
>> +     flags = 0; /* kill silly warning */
>> +     data = 0;
>> +     mask = (1 << field_width) - 1;
>> +     pos = reg_width - ((in_pos + 1) * field_width);
>> +
>> +#ifdef DEBUG
>> +     pr_info("sh pinmux: %s, addr = %lx, value = %ld, pos = %ld, "
>> +             "r_width = %ld, f_width = %ld\n",
>> +             do_write ? "write" : "read", reg, value, pos,
>> +             reg_width, field_width);
>> +#endif
>> +
>> +     if (do_write)
>> +             spin_lock_irqsave(&gpio_register_lock, flags);
>> +
> The locking here is a bit non-obvious, and should be commented. I had to
> read through this a couple of times to figure out what it was supposed to
> be doing. You seem to be trying to use a spinlock as a rwlock, which is a
> bit error prone to say the least.

Sorry about the unclear code. This function is used for reading and
writing bit fields in registers. The spinlock is protecting the
read-modify-write register operation in the write case. No locking is
done for the read case.

/ magnus
