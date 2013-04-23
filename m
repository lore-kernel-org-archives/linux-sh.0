From: Katsuya MATSUBARA <matsu@igel.co.jp>
Date: Tue, 23 Apr 2013 12:44:12 +0000
Subject: Re: [PATCH 0/3] Fix some bugs in the sh_veu driver
Message-Id: <20130423.214412.51075671.matsu@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1366714297-2784-1-git-send-email-matsu@igel.co.jp>
	<Pine.LNX.4.64.1304231421420.1422@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1304231421420.1422@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: g.liakhovetski@gmx.de
Cc: mchehab@redhat.com, hverkuil@xs4all.nl, linux-media@vger.kernel.org, linux-sh@vger.kernel.org


Hi Guennadi,

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 23 Apr 2013 14:25:54 +0200 (CEST)

>> This patch set fixes some small bugs in the sh_veu driver.
>> They have been tested on the Mackerel board.
>> 
>> Thanks,
>> 
>> Katsuya Matsubara (3):
>>   [media] sh_veu: invoke v4l2_m2m_job_finish() even if a job has been
>>     aborted
>>   [media] sh_veu: keep power supply until the m2m context is released
>>   [media] sh_veu: fix the buffer size calculation
> 
> Thanks for your patches. I don't think we should push them to 3.9, I'll 
> get them queued to 3.10 as fixes, after 3.9 is released we can also send 
> them to stable, do you think they are important enough?

Sure. They are not urgent for me.

Thanks,
---
Katsuya Matsubara / IGEL Co., Ltd
