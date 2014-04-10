From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 10 Apr 2014 06:21:02 +0000
Subject: Re: [PATCH 0/4] r8a779[01] I2C clocks fixes
Message-Id: <CANqRtoTRgfjb1_PCBTGkGvQ7cLCPyUO=f_v=Gp5kzRX9zq3PPw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1396350138-26850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1396350138-26850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Apr 2, 2014 at 8:51 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Wolfram,
>
> On Wednesday 02 April 2014 13:42:20 Wolfram Sang wrote:
>> On Tue, Apr 01, 2014 at 01:02:14PM +0200, Laurent Pinchart wrote:
>> > Hello,
>> >
>> > The I2C clocks select an incorrect parent on r8a7790 and r8a7791, both in
>> > the legacy C code and in DT. This patch set fixes that.
>> >
>> > Laurent Pinchart (4):
>> >   ARM: shmobile: r8a7790: Fix the I2C clocks parents in legacy code
>> >   ARM: shmobile: r8a7791: Fix the I2C clocks parents in legacy code
>> >   ARM: shmobile: r8a7790: Fix the I2C clocks parents in DT
>> >   ARM: shmobile: r8a7791: Fix the I2C clocks parents in DT
>>
>> Reviewed-by: Wolfram Sang <wsa@sang-engineering.com>
>
> Thank you.
>
>> CC on I2C patches would be appreciated.
>
> Sure, sorry for having forgotten.

I'm a bit unclear about who is supposed to merge these patches, but
based on path it looks to me like Simon is supposed to do that.

So Simon, can you please pick up this series and include these?

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Wolfram Sang <wsa@sang-engineering.com>

Thanks,

/ magnus
