From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 07 Dec 2018 16:41:33 +0000
Subject: Re: [PATCH 1/8] sh: dreamcast: rtc: push down rtc class ops into driver
Message-Id: <CAK8P3a2To65m5fXwbVEBqYHzReKC2XiXx361rbUbLR1Bp+=+5g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20181207134824.300024-1-arnd@arndb.de> <20181207134824.300024-2-arnd@arndb.de>
 <20181207154502.GA21335@infradead.org>
In-Reply-To: <20181207154502.GA21335@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@infradead.org>
Cc: y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Baolin Wang <baolin.wang@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, John Stultz <john.stultz@linaro.org>, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Fri, Dec 7, 2018 at 4:45 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Dec 07, 2018 at 02:48:17PM +0100, Arnd Bergmann wrote:
> > The dreamcast RTC support has an extra level of indirection to
> > provide either the old read_persistent_clock/update_persistent_clock
> > interface or the rtc-generic device for hctosys/systohc.
>
> s/dreamcast/sh/ in the above sentence?  Also repeated in the other
> patches.

Right, I guess this is at least ambiguous. What I was trying to express
here is that I'm taking the indirection out for dreamcast specifically.

In the other patches, I obviously copied it wrong. Fixed now in my
branch, thanks for the review!

      Arnd
