From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 08 May 2013 18:51:38 +0000
Subject: Re: [PATCH] irqchip: Add irqchip_init dummy function
Message-Id: <518A9EBA.6070609@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368019204-24448-1-git-send-email-hechtb+renesas@gmail.com>
 <518A6C05.9030303@cogentembedded.com> <201305081833.03716.arnd@arndb.de>
In-Reply-To: <201305081833.03716.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 05/08/2013 08:33 PM, Arnd Bergmann wrote:

>
>>> --- a/include/linux/irqchip.h
>>> +++ b/include/linux/irqchip.h
>>> @@ -11,6 +11,10 @@
>>>    #ifndef _LINUX_IRQCHIP_H
>>>    #define _LINUX_IRQCHIP_H
>>>
>>> +#ifdef CONFIG_IRQCHIP
>>>    void irqchip_init(void);
>>> +#else
>>> +void irqchip_init(void) {};
>>      Semicolon not needed here.
>>
>>> +#endif
> More importantly, the function should be marked as "static inline", otherwise
> you get a link error if this header is included in more than one place.

     Right, I should have noticed that too. :-)

> 	Arnd

WBR, Sergei

