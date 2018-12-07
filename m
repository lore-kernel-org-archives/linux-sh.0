From: John Stultz <john.stultz@linaro.org>
Date: Fri, 07 Dec 2018 16:56:42 +0000
Subject: Re: [PATCH 5/8] timekeeping: remove unused {read,update}_persistent_clock
Message-Id: <CALAqxLUq7PF1b7B0toY8JfwD93CQeRez2PAoFL4Ja3JKNoz=hQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20181207134824.300024-1-arnd@arndb.de> <20181207134824.300024-6-arnd@arndb.de>
In-Reply-To: <20181207134824.300024-6-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, linux-sh@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Fri, Dec 7, 2018 at 5:49 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> After arch/sh has removed the last reference to these functions,
> we can remove them completely and just rely on the 64-bit time_t
> based versions. This cleans up a rather ugly use of __weak
> functions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/timekeeping32.h |  6 ------
>  kernel/time/ntp.c             | 10 +---------
>  kernel/time/timekeeping.c     | 12 ++----------
>  3 files changed, 3 insertions(+), 25 deletions(-)

Acked-by: John Stultz <john.stultz@linaro.org>

thanks
-john
