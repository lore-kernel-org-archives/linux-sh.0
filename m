From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Aug 2015 00:52:57 +0000
Subject: Re: [PATCH v2] ARM: shmobile: dts: Add common file for AA121TD01 panel
Message-Id: <CANqRtoQm80+8j-SstWnMgvnMHgT47x__GzF7ykWBAo=GrkWvnA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbd4227u.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbd4227u.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Aug 5, 2015 at 7:48 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday 03 August 2015 17:38:37 Magnus Damm wrote:
>> On Mon, Aug 3, 2015 at 5:34 PM, Kuninori Morimoto wrote:
>> > Hi Wolfram
>> >
>> >> > I tested this panel on Koelsch board (with I2C fixup local patch),
>> >>
>> >> I2C fixup? The NACK issue?
>> >
>> > I don't know detail.
>> > But, I need to use gpio-i2c to use HDMI, otherwise it doesn't work.
>>
>> I wonder if it is possible to use the "I2C master" bind/unbind code
>> developed by Wolfram to switch to GPIO bit-bang at run-time?
>
> Or to fix the hardware I2C controller driver ? :-)

That would be the best way forward yes. I suspect that it may take
quite some time to do so, so until then it would be nice to not have
to carry local patches to get basic stuff working...

Cheers,

/ magnus
