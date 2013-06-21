From: Katsuya MATSUBARA <matsu@igel.co.jp>
Date: Fri, 21 Jun 2013 13:04:44 +0000
Subject: Re: [PATCH v6] V4L2: soc_camera: Renesas R-Car VIN driver
Message-Id: <20130621.220444.280357674.matsu@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <51C41F66.1060300@cogentembedded.com>
	<20130621.190157.27985389.matsu@igel.co.jp>
	<51C42BA5.9050105@cogentembedded.com>
In-Reply-To: <51C42BA5.9050105@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vladimir.barinov@cogentembedded.com
Cc: sergei.shtylyov@cogentembedded.com, g.liakhovetski@gmx.de, mchehab@redhat.com, linux-media@vger.kernel.org, magnus.damm@gmail.com, linux-sh@vger.kernel.org, phil.edworthy@renesas.com


Hi Vladimir,

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Date: Fri, 21 Jun 2013 14:32:05 +0400

> Katsuya MATSUBARA wrote:
>> Hi Vladimir,
>>
>> From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>> Date: Fri, 21 Jun 2013 13:39:50 +0400
>>
>> (snip)
>>   
>>>> I have not seen such i2c errors during capturing and booting.
>>>> But I have seen that querystd() in the ml86v7667 driver often
>>>> returns V4L2_STD_UNKNOWN, although the corresponding function
>>>>         
>>> could you try Hans's fix:
>>> https://patchwork.kernel.org/patch/2640701/
>>>     
>>
>> The fix has been already applied in my environment.
>>   
> I've found that after some iteration of submission we disabled the
> input signal in autodetection in ml86v7667_init(). per
> recommendations.
> That could be the case why the input signal is not locked.
> 
> On adv7180 it still has optional autodetection but Hans recommended to
> get rid from runtime autodetection.
> So I've added input signal detection only during boot time.
> 
> Could you please try the attached patch?

With the patch, V4L2_STD_UNKNOWN often returned by querystd()
in the ml86v7667 driver has been gone.
But, captured images are still incorrect that means wrong
order of fields desite '_BT' chosen for V4L2_STD_525_60.

Thanks,
---
Katsuya Matsubara / IGEL Co., Ltd
matsu@igel.co.jp

