From: Khiem Nguyen <khiem.nguyen.xt@rvc.renesas.com>
Date: Thu, 15 Oct 2015 07:56:39 +0000
Subject: Re: [PATCH/RFC 2/6] boot-mode-reg: Add R-Car Gen2 driver
Message-Id: <561F5C37.2030700@rvc.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/15/2015 2:34 PM, Khiem Nguyen wrote:
> Hi Simon,
>
> Thanks for your patch.
>
> On 10/15/2015 1:59 PM, Simon Horman wrote:
>> Boot mode register driver for R-Car Gen2.
>>
>> If running on a supported platform it reads the boot mode register and
>> records it using the boot mode register infrastructure established by an
>> earlier patch.
>>
>> rcar_gen2_init_boot_mode() is exported allow it to be explicitly called in
>> cases where the boot mode register is needed before init calls are made.
>>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

[snip]

>> +int __init rcar_gen2_init_boot_mode(void)
>> +{
>> +	if (of_machine_is_compatible("renesas,r8a7790") ||
>> +	    of_machine_is_compatible("renesas,r8a7791") ||
>> +	    of_machine_is_compatible("renesas,r8a7792") ||
>> +	    of_machine_is_compatible("renesas,r8a7793") ||
>> +	    of_machine_is_compatible("renesas,r8a7794"))
>> +		return rcar_gen2_read_mode_pins();
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(boot_mode_set);
>
> Could you tell me the purpose of this ?
> There's no such function name in this file.

Read again the commit log, this export symbol should be 
rcar_gen2_init_boot_mode.

>> +early_initcall(rcar_gen2_init_boot_mode);
>> +
>> +MODULE_LICENSE("GPL");
>
> The license should be GPLv2 to match with the paragraph at top of this
> file, right ?
>
>> +MODULE_AUTHOR("Simon Horman <horms@verge.net.au>");
>> +MODULE_DESCRIPTION("R-Car Gen2 Boot Mode Register Driver");
>> diff --git a/include/misc/boot-mode-reg.h b/include/misc/boot-mode-reg.h
>> index 34ee653279a4..f8fea0ea5a3e 100644
>> --- a/include/misc/boot-mode-reg.h
>> +++ b/include/misc/boot-mode-reg.h
>> @@ -21,4 +21,7 @@
>>    int boot_mode_reg_get(u32 *mode);
>>    int boot_mode_reg_set(u32 mode);
>>
>> +/* Allow explicit initialisation before initcalls */
>> +int rcar_gen2_init_boot_mode(void);
>> +
>>    #endif
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
