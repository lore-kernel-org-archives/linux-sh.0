From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Sun, 06 Sep 2015 15:58:28 +0000
Subject: Re: [PATCH repost] i2c: rcar: Fix order of restart and clear status
Message-Id: <CAH1o70JeGDXOLMWNP55rX2ZXy_syfbQJcaaYTiX0qZZKc7Q+9w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1439911206-8736-1-git-send-email-ykaneko0929@gmail.com>
	<20150903203442.GA1574@katana>
In-Reply-To: <20150903203442.GA1574@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

Hello Wolfram,

2015-09-04 5:34 GMT+09:00 Wolfram Sang <wsa@the-dreams.de>:
> On Wed, Aug 19, 2015 at 12:20:06AM +0900, Yoshihiro Kaneko wrote:
>> From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
>>
>> In case of repeated START condition, the restart has to be kicked
>> before clear status (MSR register). If it is kicked after clear status,
>> R-Car I2C may transfer data (TXD register) or receive data (RXD register)
>> instead of transferring slave address (MAR register).
>>
>> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
>> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
>
> I think I could reproduce the issue but changing the order of clearing
> and kicking did not change anything for me. I have CCed you in my new
> series regarding the i2c-rcar driver. That made the issue for me go
> away. Can you kindly check, too?

Sure, but I'm not sure about the behavior of the H/W.
I would like to learn from your patch series.

Best Regards,
Kaneko

>
> Thanks,
>
>    Wolfram
>
