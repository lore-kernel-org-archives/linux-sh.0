From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 30 Jun 2017 10:56:06 +0000
Subject: Re: [PATCH 5/6] i2c: pca-platform: use device_property_read_u32
Message-Id: <CAHp75Ve1daNFe4PLAMpqMudE9d+Ss2JpeZ=Sy5x5ij99gAVs_w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20170630005408.23968-1-chris.packham@alliedtelesis.co.nz>
 <20170630005408.23968-6-chris.packham@alliedtelesis.co.nz>
 <CAHp75Vc+6WGFiJifEExjv3jSFsy+ORGtRoDPmv31sSFN=zkHMg@mail.gmail.com> <20170630090354.6s6ahpjhis7ptbfg@ninjato>
In-Reply-To: <20170630090354.6s6ahpjhis7ptbfg@ninjato>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>, linux-i2c <linux-i2c@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-SH <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Fri, Jun 30, 2017 at 12:03 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > -               i2c->algo_data.i2c_clock = 59000;
>> > +               ret = device_property_read_u32(&pdev->dev, "clock-frequency",
>> > +                                              &i2c->algo_data.i2c_clock);
>> > +               if (ret)
>> > +                       i2c->algo_data.i2c_clock = 59000;
>>
>> My idea is to get rid of legacy platform data completely.
>> That's why I suggested device_* in the first place.
>>
>> In similar way like you did with GPIO lookup table, you may use
>> PROPERTY_ENTRY*() macros in the board files.
>>
>> Does it make sense?
>
> Frankly, I am not a big fan of converting board files if we cannot test
> the changes.

So, if no one is using that old boards, should we really take care
more than just compile test?

P.S. Legacy platform data makes a burden of development nowadays.
Built-in device properties API (as a part of Unified Device
Properties) is exactly for getting rid of legacy stuff and make things
much cleaner.

-- 
With Best Regards,
Andy Shevchenko
