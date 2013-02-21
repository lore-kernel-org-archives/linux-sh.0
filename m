From: Bastian Hecht <hechtb@gmail.com>
Date: Thu, 21 Feb 2013 14:54:06 +0000
Subject: Re: [PATCH] i2c: sh_mobile: Don't start transfers when suspending
Message-Id: <CABYn4swuDgTvvyigjnabcg46rcze-DnGhv2Rh7WEFdwkXcHR4Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1360862257-10807-1-git-send-email-hechtb+renesas@gmail.com>
	<CANqRtoSzyAj=pDmtDy1gh=Pxrom644tM07z15b4S=DX4Cby=MQ@mail.gmail.com>
	<CABYn4szejurs2gBVOx_+geOxw13r9KvoShfRiM7OOF5wVvDPLA@mail.gmail.com>
	<20130221091434.GA22806@the-dreams.de>
In-Reply-To: <20130221091434.GA22806@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-i2c@vger.kernel.org

Hi Wolfram,

oh yes I can gladly do so. To make a realistic estimation it might
take a few weeks until I find time for it though. If we can wait so
long, count on me.

Best,

 Bastian

2013/2/21 Wolfram Sang <wsa@the-dreams.de>:
> Hi Bastian,
>
>> > Also, do you know the reason why this isn't handled in the i2c layer
>> > by default? I ask because your comment mentions that i2c-tegra.c does
>> > the same thing and I can't see anything in this patch that is actually
>> > related to our I2C hardware.
>>
>> Yes, many drivers have a similar scheme and to me it more looked like
>> all drivers need to take care about this case unrelated to different
>> hardware. So the question arises if this can't be handled in the core
>> - or if I get something wrong here.
>
> I don't see any reason why this couldn't be handled in the core. If you
> want to have a take on this issue (after the other bug is fixed), this
> will be highly appreciated.
>
> Thanks,
>
>    Wolfram
>
