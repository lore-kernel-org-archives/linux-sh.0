From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Sat, 27 Feb 2016 14:28:28 +0000
Subject: Re: sh7724 regression: commit 8222dbe21e79338de92d5e1956cd1e3994cc9f93
Message-Id: <56D1B28C.2030600@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWR0RZhGrX4qW+fHwOYxAXffNinUdhrL=SZsMn5BUKoeA@mail.gmail.com>
In-Reply-To: <CAMuHMdWR0RZhGrX4qW+fHwOYxAXffNinUdhrL=SZsMn5BUKoeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Hans!

On 02/27/2016 03:20 PM, Geert Uytterhoeven wrote:
>> I noticed that 4.1 was ok and v4.2 wasn't, so I did a git bisect and ended up with
>> commit 8222dbe21e79338de92d5e1956cd1e3994cc9f93 (sched/preempt, mm/fault: Decouple
>> preemption from the page fault logic) as the culprit.

If you like, please report this the kernel bug tracker and set
"Hardware" to "SuperH". This way we are able to keep track of
the issue.

I think Yoshinori Sato and Rich Felker will have a look at this.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
