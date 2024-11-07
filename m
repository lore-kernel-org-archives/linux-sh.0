Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6661991D2
	for <linux-sh@vger.kernel.org>; Thu,  7 Nov 2024 07:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730966266; cv=none; b=C9IKjt7i+n9JYvkyoYnXE5d3gxR8fQALoT/JhcD9kXz6CjnBZJb/iQ189JWaBtfkr/AQu/vd1aNIwrYB0DL2gZpcURPFjebXbQGbzUokFDyLgmmkriY6DkJ+iUIIBwqUhNT/2m4CdDQeLO+XdsiH3cSDBnB65r1b+VuzskSNB1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730966266; c=relaxed/simple;
	bh=48p4FWA3IcK5bK6CATIdjjyeAiPcHj3X+N44tTC3nRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WHSPDmsrExAbEu9xx2fc9mJuVo4ENNavRItRp+ksIAf1vEr+9L9754YafzYHnD+oChJ7l+YnWQpMSomqJlhsKBri36XI5oRqqmt1gyTxRj/bnkqT0BQVBpfb5b8MGMuXKmI/n9PzmQKYj2eNlE+PUvB1x559Tcai52fg87/HVMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XkZDL2sYyz4f3jsL
	for <linux-sh@vger.kernel.org>; Thu,  7 Nov 2024 15:57:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 670C51A018C
	for <linux-sh@vger.kernel.org>; Thu,  7 Nov 2024 15:57:40 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP4 (Coremail) with SMTP id gCh0CgDHoobzcixnAo1eBA--.13519S2;
	Thu, 07 Nov 2024 15:57:40 +0800 (CST)
Message-ID: <48f866a1-0412-4a41-b880-e7282265336f@huaweicloud.com>
Date: Thu, 7 Nov 2024 15:57:39 +0800
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sh: intc: Fix possible UAF in register_intc_controller
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 ysato@users.sourceforge.jp, dalias@libc.org, gregkh@linuxfoundation.org,
 ricardo@marliere.net, damm@opensource.se, lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, wangweiyang2@huawei.com
References: <20241030060813.1307698-1-chenridong@huaweicloud.com>
 <e1792bb5-6212-4452-9c1d-c372204c3348@huaweicloud.com>
 <cf281c9e0d04483d7cafd89aeb25b55878e81385.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <cf281c9e0d04483d7cafd89aeb25b55878e81385.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDHoobzcixnAo1eBA--.13519S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Xr43AF1DKrWUZrWrtr15XFb_yoW8Jryfpr
	Z7ua45CF48XrWjy3sFva4agFWaka1ayFy8Zwn29a48Xr1YqF95KFyUCry8WF98Gw4Skrya
	yFW5W34IvFZ5ArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU10PfPUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/11/7 15:35, John Paul Adrian Glaubitz wrote:
> Hi Chen,
> 
> On Thu, 2024-11-07 at 08:57 +0800, Chen Ridong wrote:
>>
>> On 2024/10/30 14:08, Chen Ridong wrote:
>>> From: Chen Ridong <chenridong@huawei.com>
>>>
>>> When it goes to error, the 'd' is freed, but 'd->list' was not deleted
>>> from 'intc_list', which may lead to a UAF.
>>>
>>> Fixes: 01e9651a21bc ("sh: add INTC out of memory error handling")
>>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
>>> ---
>>>  drivers/sh/intc/core.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
>>> index 74350b5871dc..a30d205e7a43 100644
>>> --- a/drivers/sh/intc/core.c
>>> +++ b/drivers/sh/intc/core.c
>>> @@ -387,6 +387,7 @@ int __init register_intc_controller(struct intc_desc *desc)
>>>  
>>>  	kfree(d->window);
>>>  err1:
>>> +	list_del(&d->list);
>>>  	kfree(d);
>>>  err0:
>>>  	pr_err("unable to allocate INTC memory\n");
>>
>> Friendly ping
> 
> I have seen your patch. I will try to review it on the weekend. I have been very busy
> with lots of other work, unfortunately. I usually have one day where I do all the review
> and merge the patches for SH.
> 
> Adrian
> 

Thank you.

Best regards,
Ridong

