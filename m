From: Christoph Hellwig <hch@infradead.org>
Date: Fri, 07 Dec 2018 15:45:02 +0000
Subject: Re: [PATCH 1/8] sh: dreamcast: rtc: push down rtc class ops into driver
Message-Id: <20181207154502.GA21335@infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20181207134824.300024-1-arnd@arndb.de>
 <20181207134824.300024-2-arnd@arndb.de>
In-Reply-To: <20181207134824.300024-2-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-sh@vger.kernel.org, Baolin Wang <baolin.wang@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, John Stultz <john.stultz@linaro.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Fri, Dec 07, 2018 at 02:48:17PM +0100, Arnd Bergmann wrote:
> The dreamcast RTC support has an extra level of indirection to
> provide either the old read_persistent_clock/update_persistent_clock
> interface or the rtc-generic device for hctosys/systohc.

s/dreamcast/sh/ in the above sentence?  Also repeated in the other
patches.
