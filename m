From: Paul Mundt <paul.mundt@renesas.com>
Date: Wed, 20 Feb 2008 02:20:21 +0000
Subject: Re: SH4 RTC periodic mode
Message-Id: <20080220022021.GB16458@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Feb 18, 2008 at 04:21:08PM +0100, Giuseppe Cavallaro wrote:
> I wonder why the sh4 rtc driver (drivers/rtc/rtc-sh.c) doesn't implement the
> periodic ioctls (RTC_IRQP_SET...) currently implemented in other drivers.
> Is there a specific reason?

These are trivially added. There is no particular reason why they are
unimplemented in the current driver, I just havent gotten around to
adding them. Feel free to submit a patch.
