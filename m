From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 08 Jan 2014 08:14:07 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7791: Wait for status on all MSTP clocks
Message-Id: <CANqRtoStXDe_LTTHK01KLNWy-j4f=xEsVUNHiHQ=1-kL8FcKcQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389167686-13458-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1389167686-13458-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 8, 2014 at 5:13 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Wed, Jan 8, 2014 at 4:54 PM, Laurent Pinchart
> <laurent.pinchart+renesas@ideasonboard.com> wrote:
>> From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
>>
>> When enabling a module clock by clearing its bit in the MSTP control
>> register, the CPG requires waiting for the status register to signal
>> that the clock has started. Failure to do so will result in returning
>> from the clk_enable() call with the clock potentially still disabled,
>> leading to various race conditions and difficult to debug errors.
>>
>> Enable status wait for all MSTP clocks on the r8a7791.
>>
>> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> Looking good, thanks for your help!

And yes, I'm too trigger happy as usual so I forgot:

Acked-by: Magnus Damm <damm@opensource.se>

Cheers,

/ magnus
