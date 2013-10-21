From: =?UTF-8?B?44Kr44Kq44CA44Of44Oz44CA44OS44Kn44OD44OX?=  <cm-hiep@jinso.co.jp>
Date: Mon, 21 Oct 2013 01:29:13 +0000
Subject: Re: [PATCH 2/2 v2] ARM: shmobile: Lager:add SPI FLASH support on QSPI
Message-Id: <52648369.9020407@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1382074384-24975-3-git-send-email-cm-hiep@jinso.co.jp>
In-Reply-To: <1382074384-24975-3-git-send-email-cm-hiep@jinso.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Sergei

Thanks for your comment.


>> +void __init r8a7790_add_qspi_device(struct rspi_plat_data *pdata)
>
>    You apparently forgot to change the name prefix to 'lager_'. Also, 
> there's no dire need in this function, you can register the QSPI 
> device right in lager_add_standard_devices().
>
>> +{
>> +    platform_device_register_resndata(
>
>    You're breaking the line to early, I think.
>
>> +        &platform_bus, "qspi", 0,
>> +        qspi_resources, ARRAY_SIZE(qspi_resources),
>> +        pdata, sizeof(*pdata));
>> +}
>> +
>>   static const struct pinctrl_map lager_pinctrl_map[] = {
>>       /* DU (CN10: ARGB0, CN13: LVDS) */
>>       PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
>
I'll update this patch as you pointed out to me!

Best Regards,

Hiep.
