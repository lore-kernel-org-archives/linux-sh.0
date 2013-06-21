From: Katsuya MATSUBARA <matsu@igel.co.jp>
Date: Fri, 21 Jun 2013 10:01:57 +0000
Subject: Re: [PATCH v6] V4L2: soc_camera: Renesas R-Car VIN driver
Message-Id: <20130621.190157.27985389.matsu@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <51C40974.600@cogentembedded.com>
	<20130621.180932.452518378.matsu@igel.co.jp>
	<51C41F66.1060300@cogentembedded.com>
In-Reply-To: <51C41F66.1060300@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vladimir.barinov@cogentembedded.com
Cc: sergei.shtylyov@cogentembedded.com, g.liakhovetski@gmx.de, mchehab@redhat.com, linux-media@vger.kernel.org, magnus.damm@gmail.com, linux-sh@vger.kernel.org, phil.edworthy@renesas.com


Hi Vladimir,

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Date: Fri, 21 Jun 2013 13:39:50 +0400

(snip)
>> I have not seen such i2c errors during capturing and booting.
>> But I have seen that querystd() in the ml86v7667 driver often
>> returns V4L2_STD_UNKNOWN, although the corresponding function
>>   
> could you try Hans's fix:
> https://patchwork.kernel.org/patch/2640701/

The fix has been already applied in my environment.

Thanks,
---
Katsuya Matsubara / IGEL Co., Ltd
matsu@igel.co.jp
