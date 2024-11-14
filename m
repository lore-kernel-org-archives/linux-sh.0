Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586B51E47AE
	for <linux-sh@vger.kernel.org>; Thu, 14 Nov 2024 03:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731553376; cv=none; b=tIwn6B1eIPVSwl2EJz0TTlE2jL5vyyG5foedMBSPwFd57glqDt8xFakouMAoffjiK5XD8lrJ15vsyFWdXqb5+V6fN5AYG8c6tdV0d+ldBu9Udhu1gMrOBzZdhFLzkWs4oBOnVTJ7orXYvrBGPnrhHmSfr01K+atK0Zo1JTY/pX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731553376; c=relaxed/simple;
	bh=F2ziPC3K5WJwxTFQD4EEM5if5d7isLG+JgVQ4NpBjt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSVWoxCSN51ymvxVQ69yU8V6rLrdKPdg5zojalIZA8et49v0oaN2DW8Yu2B7ATTyeA1WxA2PmOp9d09TsfLtL3VwoVKuFXyFaonl4EN0E0yyCx9W7h9RmuERnu8WMOlkTFLP80el+PtBldVpZb7ef0OEOW8SOqV+DBSdKNIPiRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XplLt2xrwz4f3jXP
	for <linux-sh@vger.kernel.org>; Thu, 14 Nov 2024 11:02:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id A7FA81A0194
	for <linux-sh@vger.kernel.org>; Thu, 14 Nov 2024 11:02:48 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP3 (Coremail) with SMTP id _Ch0CgD3h8RXaDVnO2SzBg--.42182S2;
	Thu, 14 Nov 2024 11:02:48 +0800 (CST)
Message-ID: <bdfa6d37-e3ac-4b71-9abc-b2aecba0f4c4@huaweicloud.com>
Date: Thu, 14 Nov 2024 11:02:46 +0800
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
 <7ff2dc30-1b63-4314-b154-355880bba3a7@huaweicloud.com>
 <cc97795980848b7002bf157d9e925cd6e516e9cb.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <cc97795980848b7002bf157d9e925cd6e516e9cb.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgD3h8RXaDVnO2SzBg--.42182S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYj7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF
	54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJ
	UUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/11/13 16:35, John Paul Adrian Glaubitz wrote:
> Hi Ridong,
> 
> On Wed, 2024-11-13 at 14:21 +0800, Chen Ridong wrote:
>>
>> Hi, Adrian, have you reviewed this patch?
>> Looking forward your reply.
> 
> It's still on my radar. Luckily, Geert has reviewed your patch in the meantime.
> 
> I currently have a busy week again, but I will have more time in the weekend.
> 
> Adrian
> 

Thank you guys.

Best regards,
Ridong

