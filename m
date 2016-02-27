From: Hans Verkuil <hverkuil@xs4all.nl>
Date: Sat, 27 Feb 2016 14:33:58 +0000
Subject: Re: sh7724 regression: commit 8222dbe21e79338de92d5e1956cd1e3994cc9f93
Message-Id: <56D1B3D6.8010103@xs4all.nl>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWR0RZhGrX4qW+fHwOYxAXffNinUdhrL=SZsMn5BUKoeA@mail.gmail.com>
In-Reply-To: <CAMuHMdWR0RZhGrX4qW+fHwOYxAXffNinUdhrL=SZsMn5BUKoeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 02/27/2016 03:28 PM, John Paul Adrian Glaubitz wrote:
> Hi Hans!
> 
> On 02/27/2016 03:20 PM, Geert Uytterhoeven wrote:
>>> I noticed that 4.1 was ok and v4.2 wasn't, so I did a git bisect and ended up with
>>> commit 8222dbe21e79338de92d5e1956cd1e3994cc9f93 (sched/preempt, mm/fault: Decouple
>>> preemption from the page fault logic) as the culprit.
> 
> If you like, please report this the kernel bug tracker and set
> "Hardware" to "SuperH". This way we are able to keep track of
> the issue.
> 
> I think Yoshinori Sato and Rich Felker will have a look at this.
> 
> Adrian
> 

Done: https://bugzilla.kernel.org/show_bug.cgi?id3321

Regards,

	Hans
