From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 03 Aug 2015 08:38:37 +0000
Subject: Re: [PATCH v2] ARM: shmobile: dts: Add common file for AA121TD01 panel
Message-Id: <CANqRtoTC5J+Cg-nA=pYMUOiasXQBEe5NNQXRPTMprZ8x3PSQwA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbd4227u.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbd4227u.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Mon, Aug 3, 2015 at 5:34 PM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>
> Hi Wolfram
>
>> > I tested this panel on Koelsch board (with I2C fixup local patch),
>>
>> I2C fixup? The NACK issue?
>
> I don't know detail.
> But, I need to use gpio-i2c to use HDMI, otherwise it doesn't work.

I wonder if it is possible to use the "I2C master" bind/unbind code
developed by Wolfram to switch to GPIO bit-bang at run-time?

Cheers,

/ magnus
