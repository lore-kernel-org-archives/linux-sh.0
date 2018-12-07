From: John Stultz <john.stultz@linaro.org>
Date: Fri, 07 Dec 2018 16:58:14 +0000
Subject: Re: [PATCH 8/8] timekeeping: remove obsolete time accessors
Message-Id: <CALAqxLVwaY2yQ5cP2qBVVyWB8pyD8BNoSEe-Lra2LPPi3CjO-w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20181207134824.300024-1-arnd@arndb.de> <20181207134824.300024-9-arnd@arndb.de>
In-Reply-To: <20181207134824.300024-9-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, lkml <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, linux-sh@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Fri, Dec 7, 2018 at 5:49 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> There are no more remaining users of these deprecated wrappers, so
> let's remove them before new users have a chance to make it in.
>
> See Documentation/core-api/timekeeping.rst for replacements when
> porting old drivers that contain calls to this function.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/timekeeping.h   | 14 --------------
>  include/linux/timekeeping32.h |  9 ---------
>  2 files changed, 23 deletions(-)

Acked-by: John Stultz <john.stultz@linaro.org>
