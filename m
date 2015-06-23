From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 23 Jun 2015 02:46:45 +0000
Subject: Re: [PATCH 08/08] ARM: shmobile: Remove CMT renesas,channels-mask from DTS
Message-Id: <CANqRtoRcv4VpF3vAgYKTOL1FyYURHx13-5-L9fH1HrJ-QvPymQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150621080903.10187.20998.sendpatchset@little-apple>
	<20150621081033.10187.38630.sendpatchset@little-apple>
	<8019375.XSP9R0ZLbm@avalon>
In-Reply-To: <8019375.XSP9R0ZLbm@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, SH-Linux <linux-sh@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Simon Horman <horms+renesas@verge.net.au>, Thomas Gleixner <tglx@linutronix.de>

Hi Laurent,

On Tue, Jun 23, 2015 at 7:40 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patch.
>
> On Sunday 21 June 2015 17:10:33 Magnus Damm wrote:
>> From: Magnus Damm <damm+renesas@opensource.se>
>>
>> Update the DTS to remove the now deprecated "renesas,channels-mask"
>> property.
>>
>> The channel information is now kept in the device driver and can easily
>> be determined based on the compat string.
>
> Unless I've missed something (which is entirely possibly given the late hour),
> the channel mask is only stored in the driver for the Gen2 CMT instances.

The case for sh73a0 and r8a7740 is also covered by some of the earlier
patches in this series. So unless I'm mistaken the series should cover
all current in-tree CMT DT users that we have. I'm not aware of any
out-of-tree users.

You are right that there are more unused compat strings documented, so
those will break. I would be tempted in phasing those out somehow.
Also, I did not spend much time cleaning up the non R-Car Gen2 cases,
so in general that needs some love.

Thanks!

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
