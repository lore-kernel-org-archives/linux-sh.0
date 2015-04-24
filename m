From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 24 Apr 2015 20:12:50 +0000
Subject: Re: [PATCH] sh-pfc: handle pin array holes in sh_pfc_map_pins()
Message-Id: <553AA3C2.7090404@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1528110.Mb5xiNU0rc@wasted.cogentembedded.com> <3656925.3GuTRhx1fV@avalon>
In-Reply-To: <3656925.3GuTRhx1fV@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linus.walleij@linaro.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org

Hello.

On 03/03/2015 03:24 AM, Laurent Pinchart wrote:

    Sorry for the belated reply, I was switched to EtherAVB soon after posting 
this patch. :-)

>> The  pin array handled by sh_pfc_map_pins() may contain holes representing
>> non- existing pins. We have to first count the valid pins in order to
>> calculate the size  of the memory to be allocated, then to skip over the
>> non-existing pins when  initializing the allocated arrays, and then to
>> return the number of valid pins  from sh_pfc_map_pins() instead of 0 on
>> success.

>> As we have to touch devm_kzalloc() calls anyway, use more fitting
>> devm_kcalloc() instead which additionally checks the array size. And since
>> PINMUX_TYPE_NONE is #define'd as 0, stop re-initializing already zeroed out
>> 'pmx->configs' array.

> I agree with this optimization, but I think it deserves a comment in the
> source code that explicitly mentions PINMUX_TYPE_NONE, to make sure any later
> rework changing the PINMUX_TYPE_NONE value would catch this.

    OK, will do.

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>> The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git'
>> repo. This patch should be applied before my R8A7794 PFC support patch and
>> before Laurent's patches removing non-existent GPIOs for R8A779[01],
>> otherwise they would cause the kernel  to hang while booting!

>>   drivers/pinctrl/sh-pfc/pinctrl.c |   32 +++++++++++++++++++-------------
>>   1 file changed, 19 insertions(+), 13 deletions(-)

>> Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pinctrl.c
>> =================================>> --- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pinctrl.c
>> +++ linux-pinctrl/drivers/pinctrl/sh-pfc/pinctrl.c
>> @@ -571,33 +571,39 @@ static const struct pinconf_ops sh_pfc_p
>>   /* PFC ranges -> pinctrl pin descs */
>>   static int sh_pfc_map_pins(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
>>   {
>> -	unsigned int i;
>> +	const struct sh_pfc_pin *info;
>> +	struct pinctrl_pin_desc *pin;
>> +	unsigned int i, n;

> Could you please rename n to num_pins, and declare it on its own line to match
> the coding style of the file ?

    Will do.

>> +
>> +	/* Count the valid pins. */
>> +	for (i = 0, info = pfc->info->pins, n = 0;
>> +	     i < pfc->info->nr_pins; i++, info++) {
>> +		if (info->enum_id || info->configs)

> Why do you need to test info->configs as well ? I thought enum_id = 0 is
> always reserved, am I getting it wrong ?

    Look at SH_PFC_PIN_NAMED() and its users.

>> +			n++;
>> +	}
>>
>>   	/* Allocate and initialize the pins and configs arrays. */
>> -	pmx->pins = devm_kzalloc(pfc->dev,
>> -				 sizeof(*pmx->pins) * pfc->info->nr_pins,
>> -				 GFP_KERNEL);
>> +	pmx->pins = devm_kcalloc(pfc->dev, n, sizeof(*pmx->pins), GFP_KERNEL);
>>   	if (unlikely(!pmx->pins))
>>   		return -ENOMEM;
>>
>> -	pmx->configs = devm_kzalloc(pfc->dev,
>> -				    sizeof(*pmx->configs) * pfc->info->nr_pins,
>> +	pmx->configs = devm_kcalloc(pfc->dev, n, sizeof(*pmx->configs),
>>   				    GFP_KERNEL);
>>   	if (unlikely(!pmx->configs))
>>   		return -ENOMEM;
>>
>> -	for (i = 0; i < pfc->info->nr_pins; ++i) {
>> -		const struct sh_pfc_pin *info = &pfc->info->pins[i];
>> -		struct sh_pfc_pin_config *cfg = &pmx->configs[i];
>> -		struct pinctrl_pin_desc *pin = &pmx->pins[i];
>> +	for (i = 0, info = pfc->info->pins, pin = pmx->pins;
>> +	     i < pfc->info->nr_pins; i++, info++) {

> I would keep info as a local variable to avoid splitting the for () on
> multiple lines. Same comment for the counter loop above.

    I don't want to declare the same variable twice, so prefer doing gcc's 
work of optimizing loop induction variable myself in this case. If you insist, 
this can be changed...

[...]
>> @@ -622,7 +628,7 @@ int sh_pfc_register_pinctrl(struct sh_pf
>>   	pmx->pctl_desc.pmxops = &sh_pfc_pinmux_ops;
>>   	pmx->pctl_desc.confops = &sh_pfc_pinconf_ops;
>>   	pmx->pctl_desc.pins = pmx->pins;
>> -	pmx->pctl_desc.npins = pfc->info->nr_pins;
>> +	pmx->pctl_desc.npins = ret;
>>
>>   	pmx->pctl = pinctrl_register(&pmx->pctl_desc, pfc->dev, pmx);
>>   	if (pmx->pctl = NULL)

> Shouldn't you also fix sh_pfc_init_ranges() ? It includes the following code
> that doesn't seem to handle holes properly.

>          for (i = 1, nr_ranges = 1; i < pfc->info->nr_pins; ++i) {
>                  if (pfc->info->pins[i-1].pin != pfc->info->pins[i].pin - 1)
>                          nr_ranges++;
>          }

    Sorry, missed it, will try to deal with this as well...

> Please make sure that sh_pfc_get_pin_index() doesn't start blowing up
> afterwards though.

    Will do.

WBR, Sergei

