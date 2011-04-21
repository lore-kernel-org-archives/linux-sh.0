From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 21 Apr 2011 13:03:17 +0000
Subject: Re: [PATCH] serial: sh-sci: suspend/resume wakeup support
Message-Id: <BANLkTi=D3oEYRebLQF4h9an4wwLmZ0QwgA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110419104344.23764.93511.sendpatchset@t400s>
In-Reply-To: <20110419104344.23764.93511.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 20, 2011 at 6:49 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Tue, Apr 19, 2011 at 07:43:44PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> This patch adds wakeup support to the sh-sci driver. As usual,
>> device_init_wakeup() and enable_irq_wake()/disable_irq_wake()
>> are used to determine if the port should be suspended/resumed
>> as usual or if it should be enabled to act as a wakeup source.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> The serial core already does all of this, so I'm not sure I see the
> point. If you've stumbled upon something the generic infrastructure
> doesn't handle properly, then fix that up instead of reinventing it and
> sidestepping the rest of the suspend/resume port ops.

Sure, I overlooked that. Have a look at V2.
