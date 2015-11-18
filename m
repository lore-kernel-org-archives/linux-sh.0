From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 18 Nov 2015 06:45:11 +0000
Subject: Re: [PATCH v2 05/10] i2c: rcar: refactor setup of a msg
Message-Id: <1616343.GkzVJHbt8F@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1447338715-9955-1-git-send-email-wsa@the-dreams.de> <20151117070053.GA952@tetsubishi> <CANqRtoS0tFtjNcB=gP5xKNzMW2_41rxAydOcZM1+fOSjfCaM7w@mail.gmail.com>
In-Reply-To: <CANqRtoS0tFtjNcB=gP5xKNzMW2_41rxAydOcZM1+fOSjfCaM7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux-I2C <linux-i2c@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

Hi Magnus,

On Wednesday 18 November 2015 11:18:00 Magnus Damm wrote:
> On Tue, Nov 17, 2015 at 4:00 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > Hi Laurent,
> > 
> >> Sorry for bringing bad news, but as with v1, this patch breaks ADV7511
> >> detection on my Koelsch board. Reverting it on top of the series fixes
> >> the problem.
> > 
> > In v1, patch 5/9 was breaking. I hope in v2, it is 6/10 and not 5/10 as
> > you replied to (patch 1/10 is the new one)? This bug is strange enough,
> > but 5/10 breaking would be extremly crazy.
> > 
> >> You'll find the dmesg and trace logs with your debugging patch applied
> >> attached to this e-mail in two versions, one with the whole series
> >> applied (- bad) and one with this patch additionally reverted on top of
> >> the series (- good).
> > 
> > Thanks for doing this. I'll think about it some more, but it may be that
> > I am running out of ideas without being able to connect a scope. Would
> > it be possible to exchange our Koelsch and Lager boards for a while? Or
> > is your multimedia work Koelsch dependant?
> 
> Swapping boards is of course one option, but shouldn't it also be
> possible to reproduce the issue by creating a similar hardware setup
> using loopback adapters? The problem is that you cannot reproduce it
> on your current hardware, right?

If I remember correctly not only has Wolfram not been able to reproduce the 
problem on his Lager board, but he hasn't been able to reproduce it you the 
remote access Koelsch board. I'm not sure how he could try to reproduce it 
locally with a "similar hardware setup" on Lager if it can't be reproduced on 
a different Koelsch board :-)

> Judging by the Koelsch schematics port EXIO_C has GP6_22/GP6_23 routed
> as SD2_CD_3/SC2_WP_3 that may be possible to repurpose as
> IIC1_SCL_C/IIC1_SDA_C. So if you want to try an IIC master device on
> Koeslch with the I2C2 devices that hold the ADV7511 chip then you
> should be able to use those ZEBAX adapters and loopback wires. If you
> want to sniff the I2C2 signals on Koelsch then the I2C2 bus is exposed
> to EXIO_A and EXIO_D.
> 
> On Lager it seems that the GP5_5/GP_6 pins with the I2C2 bus for the
> ADV7511 chip has more flexible configuration, so using either IIC or
> I2C should be possible. You can sample those pins on EXIO_A with the
> ZEBAX break out adapter.
> 
> And either way you should be able to compare the results of the I2C
> and IIC masters with GPIO using the bitbang implementation.
> 
> Feel free to let me know exactly what the problem is and I will do my
> best to help you out!

-- 
Regards,

Laurent Pinchart

