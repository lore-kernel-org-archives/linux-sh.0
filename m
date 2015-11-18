From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 18 Nov 2015 08:17:16 +0000
Subject: Re: [PATCH v2 05/10] i2c: rcar: refactor setup of a msg
Message-Id: <CANqRtoQXeZQX2LNw6w1-7w+F6K985TK=m+RVYc-fLGrFPZDT8Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447338715-9955-1-git-send-email-wsa@the-dreams.de>
	<1447338715-9955-6-git-send-email-wsa@the-dreams.de>
	<2420286.JI0i0lloO0@avalon>
	<20151117070053.GA952@tetsubishi>
	<CANqRtoS0tFtjNcB=gP5xKNzMW2_41rxAydOcZM1+fOSjfCaM7w@mail.gmail.com>
	<20151118080736.GA1528@katana>
In-Reply-To: <20151118080736.GA1528@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux-I2C <linux-i2c@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

Hi Wolfram,

On Wed, Nov 18, 2015 at 5:07 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> On Lager it seems that the GP5_5/GP_6 pins with the I2C2 bus for the
>> ADV7511 chip has more flexible configuration, so using either IIC or
>> I2C should be possible. You can sample those pins on EXIO_A with the
>> ZEBAX break out adapter.
>
> Yes, that's what I basically did here for developing the whole patch
> series and for the recent testing. A simple 's/iic2/i2c2/g' on the Lager
> DTS does the trick.

Great, thanks! Lager seems to work well, but I wonder why Koelsch is unstable...

/ magnus
