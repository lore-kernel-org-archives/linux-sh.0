From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 23 Apr 2013 12:25:54 +0000
Subject: Re: [PATCH 0/3] Fix some bugs in the sh_veu driver
Message-Id: <Pine.LNX.4.64.1304231421420.1422@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1366714297-2784-1-git-send-email-matsu@igel.co.jp>
In-Reply-To: <1366714297-2784-1-git-send-email-matsu@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Katsuya Matsubara <matsu@igel.co.jp>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org, linux-sh@vger.kernel.org

Hi Matsubara-san

On Tue, 23 Apr 2013, Katsuya Matsubara wrote:

> Hi Guennadi,
> 
> This patch set fixes some small bugs in the sh_veu driver.
> They have been tested on the Mackerel board.
> 
> Thanks,
> 
> Katsuya Matsubara (3):
>   [media] sh_veu: invoke v4l2_m2m_job_finish() even if a job has been
>     aborted
>   [media] sh_veu: keep power supply until the m2m context is released
>   [media] sh_veu: fix the buffer size calculation

Thanks for your patches. I don't think we should push them to 3.9, I'll 
get them queued to 3.10 as fixes, after 3.9 is released we can also send 
them to stable, do you think they are important enough?

Thanks
Guennadi

>  drivers/media/platform/sh_veu.c |   15 ++++++---------
>  1 files changed, 6 insertions(+), 9 deletions(-)
> 
> ---
> Katsuya Matsubara / IGEL Co., Ltd

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
