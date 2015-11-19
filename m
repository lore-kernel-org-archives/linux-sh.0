From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 19 Nov 2015 16:01:50 +0000
Subject: Re: [PATCH v3 00/11] i2c: rcar: tackle race conditions in the driver
Message-Id: <5862854.ojJ1sDI4ap@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1447948611-2615-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Hi Wolfram,

Thank you for the patches.

For the whole series,

Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

On Thursday 19 November 2015 16:56:40 Wolfram Sang wrote:
> Hello RCar Fans!
> 
> So, here is V3 of this series. After a debugging session with Laurent, we
> finally fixed his issue for good. It was not board dependent as we thought,
> but toolchain dependent! Hidden by a macro, the driver used a compound
> assignemt with a function call as the rvalue. After patch 6, this function
> also changed the flags which were to be changed by the compound assignment.
> Basically (after macro):
> 
> 	priv->flags |= i_change_priv_flags(priv);
> 
> Which is undefined behaviour, I guess. However, after my refactoring, the
> called functions always returned 0, so we can simply do:
> 
> 	i_change_priv_flags(priv);
> 
> Nasty one, but finally issue gone, for all toolchains and optimization
> settings. Furthermore, patch 11 has been added because HW engineers wanted
> it.
> 
> The branch can be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git
> renesas/rcar-i2c-rework-v3
> 
> Please test, test, test :)
> 
>    Wolfram
> 
> 
> Changes since V2:
> * patch 6/11 was cleaned up to not use the compund assignment
> * patch 11/11 introduced as requested by HW engineers
> 
> Changes since V1:
> * new patch 1/10 to ensure clock is always on
> * rebased patch 2/10 to the new patch
> * some patch descriptions slightly reworded
> 
> 
> Here is the description of the V1 series for those who missed it:
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
> the message in process context). c) is also fixed, this was not a race but
> a bug in the state handling. a) however is not fixed 100% :( We have the
> race window as small as possible now when utilizing interrupts, so it is an
> improvement and worked for my test cases well. There were experiments by me
> and Renesas engineers to use polling to prevent the issue but this caused
> other side effects, sadly. So, let's improve the situation now and let's
> see where we get.
> 
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
> Wolfram Sang (11):
>   i2c: rcar: make sure clocks are on when doing clock calculation
>   i2c: rcar: rework hw init
>   i2c: rcar: remove unused IOERROR state
>   i2c: rcar: remove spinlock
>   i2c: rcar: refactor setup of a msg
>   i2c: rcar: init new messages in irq
>   i2c: rcar: don't issue stop when HW does it automatically
>   i2c: rcar: check master irqs before slave irqs
>   i2c: rcar: revoke START request early
>   i2c: rcar: clean up after refactoring
>   i2c: rcar: handle difference in setting up non-first message
> 
>  drivers/i2c/busses/i2c-rcar.c | 249 +++++++++++++++++----------------------
>  1 file changed, 106 insertions(+), 143 deletions(-)

-- 
Regards,

Laurent Pinchart

