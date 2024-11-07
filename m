Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82704156C6A
	for <linux-sh@vger.kernel.org>; Thu,  7 Nov 2024 00:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730941079; cv=none; b=ArpJ80onFb5EYU7esTWNSHdN7TtQzYbDBa+50iK9ugcIbU2/1ful+2xbixZEXT2e+Hh/VyjYoyGvYVKPW7IiMNRTdWn4qhyZ3MrQY1AoQpZ6xFl6ZosSnWYlIUbT2MH+04/7yYMT92213cZuxbQa2g7vOqVDTCy+PPd/mZ6zOXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730941079; c=relaxed/simple;
	bh=JzhgHtLW6ApgH1DOsM+RaXO5kapkp8Otma6bhp5QdBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BqtBhy0ffYbrHsrFFZiMb+/rz4DUZIXkAeMknOTsZY+30WSvWiyrDgfh37+alV8i24jdMBeCg7g7ZcoaxHM+piUbZ1vYPtjbl9E3LEESoBqS33tqYKJSyHXtT6GJuLGljPZqU/XYEr00RrXkw0DBNt5pflrj2Yhb5urf1fK46jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XkNw42sXzz4f3kJq
	for <linux-sh@vger.kernel.org>; Thu,  7 Nov 2024 08:57:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4C6EC1A058E
	for <linux-sh@vger.kernel.org>; Thu,  7 Nov 2024 08:57:53 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgBHPK6PECxn7twmBA--.15292S2;
	Thu, 07 Nov 2024 08:57:53 +0800 (CST)
Message-ID: <e1792bb5-6212-4452-9c1d-c372204c3348@huaweicloud.com>
Date: Thu, 7 Nov 2024 08:57:51 +0800
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sh: intc: Fix possible UAF in register_intc_controller
To: Chen Ridong <chenridong@huaweicloud.com>, ysato@users.sourceforge.jp,
 dalias@libc.org, glaubitz@physik.fu-berlin.de, gregkh@linuxfoundation.org,
 ricardo@marliere.net, damm@opensource.se, lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, wangweiyang2@huawei.com
References: <20241030060813.1307698-1-chenridong@huaweicloud.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20241030060813.1307698-1-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHPK6PECxn7twmBA--.15292S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1kuw1fZr1rXw4rur48WFg_yoW3urb_ua
	9Yvryxur1rWrn7Ja4Y9a48uFyFkFyUZr4ft3Zavr15WFWUZrWkXr40qrW8Zw18trZxZFy7
	AryfXFs0gw4xXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/10/30 14:08, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
> 
> When it goes to error, the 'd' is freed, but 'd->list' was not deleted
> from 'intc_list', which may lead to a UAF.
> 
> Fixes: 01e9651a21bc ("sh: add INTC out of memory error handling")
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  drivers/sh/intc/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/sh/intc/core.c b/drivers/sh/intc/core.c
> index 74350b5871dc..a30d205e7a43 100644
> --- a/drivers/sh/intc/core.c
> +++ b/drivers/sh/intc/core.c
> @@ -387,6 +387,7 @@ int __init register_intc_controller(struct intc_desc *desc)
>  
>  	kfree(d->window);
>  err1:
> +	list_del(&d->list);
>  	kfree(d);
>  err0:
>  	pr_err("unable to allocate INTC memory\n");

Friendly ping

