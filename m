From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Dec 2014 14:49:58 +0000
Subject: Re: [PATCH v2] clk: shmobile: div6: Avoid changing divisor in .disable()
Message-Id: <CAMuHMdXVy7HUg_vOB+Ces1QRcuiXYZ=h35SKJh2Ket92aY9z8A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418826607-11817-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1418826607-11817-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Dec 17, 2014 at 3:40 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wednesday 17 December 2014 15:30:07 Geert Uytterhoeven wrote:
>> While DIV6 clocks require the divisor field to be non-zero when stopping
>> the clock, some clocks (e.g. ZB on sh73a0) fail to be re-enabled later
>> if the divisor field is changed when stopping the clock.
>> The reason for this is unknown.
>>
>> To fix this, do not touch the divisor field if it's already non-zero.
>>
>> On kzm9g, the smsc911x Ethernet controller is connected to the sh73a0
>> Bus State Controller, which is clocked by the ZB clock. Without this
>> fix, if the ZB clock is disabled during system suspend, and re-enabled
>> during resume, the kernel locks up when the smsc911x driver tries to
>> access the Ethernet registers.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

> By the way, have you noticed the issue on any platform other than sh73a0 ?
> There might be a chance to get feedback on the hardware on a new platform, but
> not on such an old one.

No, it doesn't seem to happen with e.g. the SD and MMC clocks on r8a7791,
which are also div6.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
