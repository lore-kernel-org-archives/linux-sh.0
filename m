From: Bastian Hecht <hechtb@gmail.com>
Date: Tue, 24 Jun 2014 08:14:12 +0000
Subject: Re: [PATCH] i2c: sh_mobile: Don't start transfers when suspending
Message-Id: <CABYn4syGYn8J+81hNPg61=18g-BmXt+gqtdFBF1Udu4xYLBU6Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1360862257-10807-1-git-send-email-hechtb+renesas@gmail.com>
	<CANqRtoSzyAj=pDmtDy1gh=Pxrom644tM07z15b4S=DX4Cby=MQ@mail.gmail.com>
	<CABYn4szejurs2gBVOx_+geOxw13r9KvoShfRiM7OOF5wVvDPLA@mail.gmail.com>
	<20130221091434.GA22806@the-dreams.de>
	<CABYn4swuDgTvvyigjnabcg46rcze-DnGhv2Rh7WEFdwkXcHR4Q@mail.gmail.com>
	<20140521110019.GS2708@katana>
In-Reply-To: <20140521110019.GS2708@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-i2c@vger.kernel.org

Just a quick note - will start next week on it.

Cheers,

 Bastian


2014-05-21 13:00 GMT+02:00 Wolfram Sang <wsa@the-dreams.de>:
> On Thu, Feb 21, 2013 at 08:54:06AM -0600, Bastian Hecht wrote:
>> Hi Wolfram,
>>
>> oh yes I can gladly do so. To make a realistic estimation it might
>> take a few weeks until I find time for it though. If we can wait so
>> long, count on me.
>
> Ping. Still interested?
>
>>
>> Best,
>>
>>  Bastian
>>
>> 2013/2/21 Wolfram Sang <wsa@the-dreams.de>:
>> > Hi Bastian,
>> >
>> >> > Also, do you know the reason why this isn't handled in the i2c layer
>> >> > by default? I ask because your comment mentions that i2c-tegra.c does
>> >> > the same thing and I can't see anything in this patch that is actually
>> >> > related to our I2C hardware.
>> >>
>> >> Yes, many drivers have a similar scheme and to me it more looked like
>> >> all drivers need to take care about this case unrelated to different
>> >> hardware. So the question arises if this can't be handled in the core
>> >> - or if I get something wrong here.
>> >
>> > I don't see any reason why this couldn't be handled in the core. If you
>> > want to have a take on this issue (after the other bug is fixed), this
>> > will be highly appreciated.
>> >
>> > Thanks,
>> >
>> >    Wolfram
>> >
