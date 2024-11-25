Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD5E36D
	for <linux-sh@vger.kernel.org>; Mon, 25 Nov 2024 01:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732497679; cv=none; b=cTU+zguvKq3mGpxJWKwL+X7N4BHCdROJy3iewsJzEam0L4g2B9kS7qt821jGpKdoIR5VPiDOYSk8jwXsZ98I3HnfaK5nBrofaWO5Va4dytI0jneGGd+9paeJjQOJZLYTKr17irwd+DTz2wWrwYjvlLswc4Sev5F6veWG5gqG4xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732497679; c=relaxed/simple;
	bh=TTRtu9qZ288j3CXN37N462dzo069m7jCOikmaOC6hpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cq0yyLzrskUtQjmmJJycfA3RzOnN5Xw+KTFFXowRHK28Pjf2QMNTfebUpTLz5VG/mGlRQZALiGgVXDegF1F+THQr7DAPMdi1sOzUN85ivBMJYE39ueGm2dYpEoAYXdAJJbLBYAL7PzFCMah5mUJaHGLT8B++yojURzUAN2x2Z1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XxSZY5StVz4f3n5m
	for <linux-sh@vger.kernel.org>; Mon, 25 Nov 2024 09:20:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 6089E1A0568
	for <linux-sh@vger.kernel.org>; Mon, 25 Nov 2024 09:21:13 +0800 (CST)
Received: from [10.67.109.79] (unknown [10.67.109.79])
	by APP1 (Coremail) with SMTP id cCh0CgAHsLEH0UNniDC_Cg--.38720S2;
	Mon, 25 Nov 2024 09:21:13 +0800 (CST)
Message-ID: <a3decec2-53f7-48bd-a2c8-2400cc7a1dad@huaweicloud.com>
Date: Mon, 25 Nov 2024 09:21:11 +0800
Precedence: bulk
X-Mailing-List: linux-sh@vger.kernel.org
List-Id: <linux-sh.vger.kernel.org>
List-Subscribe: <mailto:linux-sh+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sh+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sh: intc: Fix possible UAF in register_intc_controller
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: ysato@users.sourceforge.jp, dalias@libc.org,
 glaubitz@physik.fu-berlin.de, gregkh@linuxfoundation.org,
 ricardo@marliere.net, damm@opensource.se, lethal@linux-sh.org,
 linux-sh@vger.kernel.org, chenridong@huawei.com, wangweiyang2@huawei.com
References: <20241030060813.1307698-1-chenridong@huaweicloud.com>
 <CAMuHMdXznLuo7QegG9giQo80HcRmV4MgKh67sWy2WJXd4Pry+Q@mail.gmail.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <CAMuHMdXznLuo7QegG9giQo80HcRmV4MgKh67sWy2WJXd4Pry+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAHsLEH0UNniDC_Cg--.38720S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCF54CYxVCY1x0262kKe7AKxVWUtVW8ZwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJV
	WUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2024/11/13 16:26, Geert Uytterhoeven wrote:
> On Wed, Oct 30, 2024 at 7:17 AM Chen Ridong <chenridong@huaweicloud.com> wrote:
>> From: Chen Ridong <chenridong@huawei.com>
>>
>> When it goes to error, the 'd' is freed, but 'd->list' was not deleted
>> from 'intc_list', which may lead to a UAF.
>>
>> Fixes: 01e9651a21bc ("sh: add INTC out of memory error handling")
>> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

Hi, can this patch be applied?

Thanks,
Ridong

