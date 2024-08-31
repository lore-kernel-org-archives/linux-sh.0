Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6982E1758F
	for <linux-sh@vger.kernel.org>; Sat, 31 Aug 2024 02:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725069789; cv=none; b=OC8O+jQg07BDJdP0XU2Ae6Q5+/Y0ydugCYI7BO1mmVxEWRoRVJZr7Pct6GooHQHMJcgl9gNrFLB5MYJfE04LMPgGluNMC4hUa1h5KESYdH99UTbLYNGM4Wdb4rCXcqUzJymH67vv8gQyUQwxWOeYhf5lOHh16DqayIhvKQDrqOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725069789; c=relaxed/simple;
	bh=4or+kJo8h1CsDS7uiUGKHBD6iC039un85qL5l2Imy0Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WQdidNQn5kLL96PQaz9MMRwvYQq2jEOZnNGwzh1AfeR+MRXUmk2GPCgK5iLdLvYeD9mhilDpEkBiVpBOyXbtHNc9+y52NaAdp8s5vGuZFSiaCM/rRMBdtDxgaNbpbYBuusRi/GIQwVkyh06/uyulIQVOe5a8D03nxwYgvSw3Iw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WwdTJ33pcz20nFF;
	Sat, 31 Aug 2024 09:58:12 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id AFB21140360;
	Sat, 31 Aug 2024 10:03:04 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 31 Aug 2024 10:03:04 +0800
Message-ID: <98c7b473-0b2b-4e47-83f6-35d9f417bb01@huawei.com>
Date: Sat, 31 Aug 2024 10:03:04 +0800
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] sh: intc: replace simple_strtoul to kstrtoul
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: <ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <linux-sh@vger.kernel.org>
References: <20240830080401.3545399-1-lihongbo22@huawei.com>
 <CAMuHMdX-rRP3BCcm2mxJKjvSoYKnsLudMuFqArQzzVOQ8fv8aQ@mail.gmail.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <CAMuHMdX-rRP3BCcm2mxJKjvSoYKnsLudMuFqArQzzVOQ8fv8aQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/30 16:22, Geert Uytterhoeven wrote:
> Hi Hongbo,
> 
> On Fri, Aug 30, 2024 at 9:56 AM Hongbo Li <lihongbo22@huawei.com> wrote:
>> The function simple_strtoul performs no error checking
>> in scenarios where the input value overflows the intended
>> output variable.
>>
>> We can replace the use of the simple_strtoul with the safer
>> alternatives kstrtoul. For fail case, we also print the extra
>> message.
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> 
> Thanks for your patch!
> 
>> --- a/drivers/sh/intc/userimask.c
>> +++ b/drivers/sh/intc/userimask.c
>> @@ -33,7 +33,8 @@ store_intc_userimask(struct device *dev,
>>   {
>>          unsigned long level;
>>
>> -       level = simple_strtoul(buf, NULL, 10);
>> +       if (kstrtoul(buf, 10, &level))
>> +               return -EINVAL;
> 
> Please pass the error code returned by kstrtoul() instead of hardcoding
> -EINVAL.
> 
Thanks for reviewing, I'll make a change.

Thanks,
Hongbo
>>
>>          /*
>>           * Minimal acceptable IRQ levels are in the 2 - 16 range, but
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 
