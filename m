From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 06 Jul 2009 02:35:32 +0000
Subject: Re: [PATCH] sh: add r8a66597 usb0 host to the se7724 board
Message-Id: <aec7e5c30907051935n358828d4uc0f6480c9cde8793@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uzlbibpw3.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzlbibpw3.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 6, 2009 at 9:45 AM, Kuninori
Morimoto<morimoto.kuninori@renesas.com> wrote:
>> Add USB host support for port CN27 on the Solution Engine 7724
>> board. The r8a66597-hcd driver is hooked up as a platform device
>> and some registers are configured to enable the USB host function.
>> The hardware driving the USB port is the on-chip USB0 block in
>> the sh7724 processor configured as USB host controller.
>>
>> Signed-off-by: Magnus Damm <damm@igel.co.jp>
>> ---
>
> ms7724se board only ?
> I have planned to add USB host support to setup-sh7724.c.

The USB block is of course cpu-specific, but the if/how the USB block
is used is board specific. The USB block may for instance be used as
USB function instead of host. We also have the ->port_power() platform
data callback that may need to be implemented on some boards. So
enabling the USB on per-board basis makes sense at this point in my
opinion.

Cheers,

/ magnus
