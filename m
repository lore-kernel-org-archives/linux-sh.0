From: John Stultz <john.stultz@linaro.org>
Date: Fri, 07 Dec 2018 16:57:17 +0000
Subject: Re: [PATCH 6/8] timekeeping: remove timespec_add/timespec_del
Message-Id: <CALAqxLXAvCO0RuNLgDVTdt9bcQs1593905ZPV=vmk3LkJZxx5A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20181207134824.300024-1-arnd@arndb.de> <20181207134824.300024-7-arnd@arndb.de>
In-Reply-To: <20181207134824.300024-7-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, linux-sh@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Fri, Dec 7, 2018 at 5:49 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The last users were removed a while ago since everyone moved to ktime_t,
> so we can remove the two unused interfaces for old timespec structures.
>
> With those two gone, set_normalized_timespec() is also unused, so
> remove that as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/time32.h | 25 -------------------------
>  kernel/time/time.c     | 36 ------------------------------------
>  2 files changed, 61 deletions(-)

Acked-by: John Stultz <john.stultz@linaro.org>
