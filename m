Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB42C171C9
	for <linux-sh@vger.kernel.org>; Mon,  2 Sep 2024 01:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725240052; cv=none; b=gVnx49RReU8Df6VXQEDOMiOf1KWtxCwe93WFQjuDaP3Pmk7uKd/RsStM4Di2j7DfLvVS8iNuNsNzymvPSB0sIdPHDy0xRkrdl36ZmqJPAecy+JTHnwLWt68ZFYl5TAj93fvjc2O+gtsOk9VABZWHhtljWHIf7hEQogfODSjeeWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725240052; c=relaxed/simple;
	bh=DMEOG6Y3KW+x2wqLBG8PV8yOykfzhL0XpDqWyySFYZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sEuMlVEakiMdBdOIOwjBz4XLhkLmCwyrOPao+JVUAGUSit7lRiaMeJwyY6q50j/abx2knn9WA/IxJBUZw/ySCIc7Wbc0mB8jy1VkDu5hu7bf8/3qXEQPVcjmG+3PTottabzCngV7U9nv2W1uVWpQ8FbyD1KvKBRptYVqLwwpSZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WxrX32pGDz1BFMH;
	Mon,  2 Sep 2024 09:19:47 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 9FF00180106;
	Mon,  2 Sep 2024 09:20:41 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 2 Sep 2024 09:20:41 +0800
Message-ID: <80ec15f3-0e3e-4ef3-a70f-39e8f77b239c@huawei.com>
Date: Mon, 2 Sep 2024 09:20:40 +0800
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] sh: intc: replace simple_strtoul to kstrtoul
Content-Language: en-US
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	<ysato@users.sourceforge.jp>, <dalias@libc.org>, <geert@linux-m68k.org>
CC: <linux-sh@vger.kernel.org>
References: <20240831094310.4148930-1-lihongbo22@huawei.com>
 <ed56d2d52dce9c7bd1ea2b0a6504f2ddb50235b4.camel@physik.fu-berlin.de>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <ed56d2d52dce9c7bd1ea2b0a6504f2ddb50235b4.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/9/1 2:07, John Paul Adrian Glaubitz wrote:
> Hello Hongo,
> 
> thanks for your patch!
> 
> On Sat, 2024-08-31 at 17:43 +0800, Hongbo Li wrote:
>> The function simple_strtoul performs no error checking
>> in scenarios where the input value overflows the intended
>> output variable.
>>
>> We can replace the use of the simple_strtoul with the safer
>> alternatives kstrtoul. For fail case, we also print the extra
>> message.
>>
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>
>> ---
>> v2:
>>    - Pass the error code returned by kstrtoul() suggested by Geert.
>>
>> v1: https://lore.kernel.org/all/98c7b473-0b2b-4e47-83f6-35d9f417bb01@huawei.com/T/
>> ---
>>   drivers/sh/intc/userimask.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/sh/intc/userimask.c b/drivers/sh/intc/userimask.c
>> index abe9091827cd..5d7801b76715 100644
>> --- a/drivers/sh/intc/userimask.c
>> +++ b/drivers/sh/intc/userimask.c
>> @@ -32,8 +32,10 @@ store_intc_userimask(struct device *dev,
>>   		     const char *buf, size_t count)
>>   {
>>   	unsigned long level;
>> +	int ret = kstrtoul(buf, 10, &level);
> 
> Could you separate declaration and assignment here to make it more consistent
> with the rest of the code?

ok, thanks for your advise!

Thanks,
Hongbo

> 
>> -	level = simple_strtoul(buf, NULL, 10);
>> +	if (ret != 0)
>> +		return ret;
>>   
>>   	/*
>>   	 * Minimal acceptable IRQ levels are in the 2 - 16 range, but
> 
> Thanks,
> Adrian
> 
