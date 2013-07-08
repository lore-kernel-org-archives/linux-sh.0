From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 08 Jul 2013 04:48:35 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790 SMP prototype v2
Message-Id: <CANqRtoTEVVBTr+8cnF-X9Ep=9POjiCQSFEEwy3T=dCB_4p62YA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130626235837.11576.86389.sendpatchset@w520>
 <20130627084358.GA4283@n2100.arm.linux.org.uk>
In-Reply-To: <20130627084358.GA4283@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jun 27, 2013 at 5:43 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Jun 27, 2013 at 08:58:37AM +0900, Magnus Damm wrote:
>> +#include <linux/smp.h>
>> +#include <linux/irqchip/arm-gic.h>
>> +#include <asm/cacheflush.h>
>> +#include <asm/io.h>
>
> Please always use linux/io.h

Will do, thanks!

/ magnus
