From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 03 Sep 2015 20:35:01 +0000
Subject: Re: [PATCH 0/9] i2c: rcar: tackle race conditions in the driver
Message-Id: <5464456.UnsMOS3MTx@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1441311613-2681-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Kaneko <ykaneko0929@gmail.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hi Wolfram,

On Thursday 03 September 2015 22:20:04 Wolfram Sang wrote:
> Hello RCar Fans!
> 
> Two issues people have seen with the i2c-rcar driver was:
> 
> a) immediately restarted messages after NACK from client
> b) duplicated data bytes in messages
> 
> Some people already worked on those and had a tough time because it was hard
> to reproduce these issues on non-customer setup. Luckily, I somewhen had a
> state where the first transfer after boot would always show the above
> issues on a plain Renesas Lager board. When measuring, I found a third
> issue thanks to my new tool 'i2ctransfer' (and thanks to projects like
> sigrok and OpenLogicSniffer, of course. Thank you very much!):
> 
> c) after read message, no repeated start was sent, but stop + start.
> 
> Due to some unlucky design choices in the IP core, it has some race windows
> which can cause problems if interrupts get delayed. Also, for every new
> message in one transfer, context switches between interrupt and process
> were needed.
> 
> So I refactored the driver to setup new messages in interrupt context, too.
> This avoids the race for b) because we are now setting up the new message
> before we release the i2c bus clock (before we released the clock and set up
> the message in process context).

Could this fix the HDMI EDID read issue on Koelsch ?

> c) is also fixed, this was not a race but a bug in the state handling. a)
> however is not fixed 100% :( We have the race window as small as possible
> now when utilizing interrupts, so it is an improvement and worked for my
> test cases well. There were experiments by me and Renesas engineers to use
> polling to prevent the issue but this caused other side effects, sadly. So,
> let's improve the situation now and let's see where we get.

Does that mean that, due to hardware design, it's impossible to use I2C 
interrupts in a race-free way ? It would be interesting to document why in a 
commit log message, or possibly in the code itself.

> I did quite some lab testing here and also verified that slave support does
> not suffer from these changes. However, I'd really appreciate if people
> could give this real-world-testing which is always different.
> 
> Please have a look, a test, etc...
> 
> Thanks,
> 
>    Wolfram
> 
> 
> Wolfram Sang (9):
>   i2c: rcar: rework hw init
>   i2c: rcar: remove unused IOERROR state
>   i2c: rcar: remove spinlock
>   i2c: rcar: refactor setup of a msg
>   i2c: rcar: init new messages in irq
>   i2c: rcar: don't issue stop when HW does it automatically
>   i2c: rcar: check master irqs before slave irqs
>   i2c: rcar: revoke START request early
>   i2c: rcar: clean up after refactoring
> 
>  drivers/i2c/busses/i2c-rcar.c | 193 +++++++++++++++------------------------
>  1 file changed, 71 insertions(+), 122 deletions(-)

-- 
Regards,

Laurent Pinchart

