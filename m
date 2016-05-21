From: Rob Landley <rob@landley.net>
Date: Sat, 21 May 2016 15:55:43 +0000
Subject: Re: [PATCH v2 09/12] clocksource: add J-Core PIT/RTC driver
Message-Id: <574084FF.1070901@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
 <e8d3578861cfe2362e65f3f92d80ccae001c6b16.1463708766.git.dalias@libc.org>
 <20160520140156.GC6863@linaro.org>
 <20160521031515.GZ21636@brightrain.aerifal.cx>
In-Reply-To: <20160521031515.GZ21636@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>

On 05/20/2016 10:15 PM, Rich Felker wrote:
> On Fri, May 20, 2016 at 04:01:56PM +0200, Daniel Lezcano wrote:
>>> +	return ((u64)sechi << 32 | seclo) * 1000000000 + nsec;
>>
>> s/1000000000/NSEC_PER_SEC/
...
>>> +	hwirq = irq_get_irq_data(pit_irq)->hwirq;
>>> +	enable_val = (1<<26) | ((hwirq&0x3c)<<18) | (hwirq<<12);
>>
>> Can you explain? (and replace litterals by macros).

  "Hiding numbers that are used just once into defines to put them
   out of sight does not really help readability." - Pavel Machek

  http://lkml.iu.edu/hypermail/linux/kernel/1407.1/00299.html

Rob
