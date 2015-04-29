From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 29 Apr 2015 22:38:58 +0000
Subject: Re: [PATCH] sh-pfc: handle pin array holes in sh_pfc_map_pins()
Message-Id: <55415D82.2020407@cogentembedded.com>
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

>> The  pin array handled by sh_pfc_map_pins() may contain holes representing
>> non- existing pins. We have to first count the valid pins in order to
>> calculate the size  of the memory to be allocated, then to skip over the
>> non-existing pins when  initializing the allocated arrays, and then to
>> return the number of valid pins  from sh_pfc_map_pins() instead of 0 on
>> success.
>>
>> As we have to touch devm_kzalloc() calls anyway, use more fitting
>> devm_kcalloc() instead which additionally checks the array size. And since
>> PINMUX_TYPE_NONE is #define'd as 0, stop re-initializing already zeroed out
>> 'pmx->configs' array.

> I agree with this optimization, but I think it deserves a comment in the
> source code that explicitly mentions PINMUX_TYPE_NONE, to make sure any later
> rework changing the PINMUX_TYPE_NONE value would catch this.

    Note that this is not just "drove by" optimization, I was trying to avoid
the very need to explicitly initialize 'pmx->configs' array to PINMUX_TYPE_NONE...

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

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

> Please make sure that sh_pfc_get_pin_index() doesn't start blowing up
> afterwards though.

    I think I'm seeing a problem with this function (and it's not due to my 
changes). Its result is often used to index 'pfc->info->pins' array. While 
this is working now, when the holes are not yet allowed, it's going to break 
when we start supporting the holes since that array couldn't be indexed this 
way anymore (via ranges). This function is good only for 'pmx->configs' and 
the like where we have already removed the holes. It looks like this holes 
thing is going to be too complex, so how about leaving things as they are? :-)

WBR, Sergei

