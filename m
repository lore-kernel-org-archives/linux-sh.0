From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 11 Dec 2013 09:44:03 +0000
Subject: Re: [PATCH V2] gpio: rcar: Fix level interrupt handling
Message-Id: <CANqRtoQc1XKo8APVTBT4a-O0DBY2VZ=H=+z39YVTZBS+Ewzg-g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385748249-27170-1-git-send-email-valentine.barshak@cogentembedded.com>
	<52A6190C.200@cogentembedded.com>
In-Reply-To: <52A6190C.200@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Valentine <valentine.barshak@cogentembedded.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>

On Tue, Dec 10, 2013 at 4:25 AM, Valentine
<valentine.barshak@cogentembedded.com> wrote:
> On 11/29/2013 10:04 PM, Valentine Barshak wrote:
>>
>> According to the manual, if a port is set for level detection using
>> the corresponding bit in the edge/level select register and an external
>> level interrupt signal is asserted, the corresponding bit in INTDT
>> does not use the FF to hold the input.
>> Thus, writing 1 to the corresponding bits in INTCLR cannot clear the
>> corresponding bits in the INTDT register. Instead, when an external
>> input signal is stopped, the corresponding bit in INTDT is cleared
>> automatically.
>>
>> Since the INTDT bit cannot be cleared for the level interrupts until
>> the interrupt signal is stopped, we end up with the infinite loop
>> when using deferred (threaded) IRQ handling.
>>
>> Since a deferred interrupt is disabled by the low-level handler and
>> re-enabled only when the deferred handler is completed, Fix the issue
>> by dropping disabled interrupts from the pending mask as suggested by
>> Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>> Changes in V2:
>> * Drop disabled interrupts from pending mask altogether instead of
>>    dropping level interrupts one by one once they get handled.
>>
>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>> ---
>>   drivers/gpio/gpio-rcar.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
>> index d3f15ae..fd2d827 100644
>> --- a/drivers/gpio/gpio-rcar.c
>> +++ b/drivers/gpio/gpio-rcar.c
>> @@ -169,7 +169,8 @@ static irqreturn_t gpio_rcar_irq_handler(int irq, void
>> *dev_id)
>>         u32 pending;
>>         unsigned int offset, irqs_handled = 0;
>>
>> -       while ((pending = gpio_rcar_read(p, INTDT))) {
>> +       while ((pending = gpio_rcar_read(p, INTDT) &
>> +                         gpio_rcar_read(p, INTMSK))) {
>>                 offset = __ffs(pending);
>>                 gpio_rcar_write(p, INTCLR, BIT(offset));
>>                 generic_handle_irq(irq_find_mapping(p->irq_domain,
>> offset));
>>
>
> Laurent, Magnus,
> do you have any concerns about fixing the level IRQ's as proposed here?

No concerns here, thanks for your help!

Acked-by: Magnus Damm <damm@opensource.se>
