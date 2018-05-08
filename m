From: Daniel Wagner <wagi@monom.org>
Date: Tue, 08 May 2018 07:18:44 +0000
Subject: Re: [PATCH v2] serial: sh-sci: Use spin_{try}lock_irqsave instead of open coding version
Message-Id: <d37e074d-5e8c-84e8-5833-7ff595e6348c@monom.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20180504163041.28726-1-wagi@monom.org>
 <20180507125146.75crpaj2scav7mql@linutronix.de>
In-Reply-To: <20180507125146.75crpaj2scav7mql@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-rt-users@vger.kernel.org, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org, gregkh@linuxfoundation.org, Daniel Wagner <daniel.wagner@siemens.com>

Hi Sebastian,

On 05/07/2018 02:51 PM, Sebastian Andrzej Siewior wrote:
> On 2018-05-04 18:30:41 [+0200], Daniel Wagner wrote:
>> --- a/drivers/tty/serial/sh-sci.c
>> +++ b/drivers/tty/serial/sh-sci.c
>> @@ -2890,16 +2890,16 @@ static void serial_console_write(struct console *co, const char *s,
>>   	unsigned long flags;
>>   	int locked = 1;
>>   
>> -	local_irq_save(flags);
>>   #if defined(SUPPORT_SYSRQ)
>> -	if (port->sysrq)
>> +	if (port->sysrq) {
>>   		locked = 0;
>> -	else
>> +		local_irq_save(flags);
> 
> how is this helping? You should see a splat after a sysrq request.

You are right, I didn't really think this through.

Should 'echo t > /proc/sysrq' trigger the splat? At least I was so naive 
that think it would be enough.

Thanks,
Daniel
