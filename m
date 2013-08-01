From: Chen Gang <gang.chen@asianux.com>
Date: Thu, 01 Aug 2013 00:30:44 +0000
Subject: Re: [PATCH] sh: include: asm: include "linux/sched.h" in "ptrace.h"
Message-Id: <51F9AC34.6010106@asianux.com>
List-Id: <linux-sh.vger.kernel.org>
References: <51F8D08A.8000502@asianux.com>
In-Reply-To: <51F8D08A.8000502@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 07/31/2013 06:03 PM, David Howells wrote:
> Chen Gang <gang.chen@asianux.com> wrote:
> 
>> > Need include "linux/sched.h" in "ptrace.h", or 'allmodconfig' can not
>> > pass compiling.
> You can't do that.  linux/sched.h #includes asm/ptrace.h already.

OH, really it is. Although it can pass compiling, it is incorrect (will
make things worse).

I will send patch v2 for it. :-)

Thanks.
-- 
Chen Gang
