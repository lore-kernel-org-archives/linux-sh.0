From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 21 Aug 2014 21:32:24 +0000
Subject: Re: ARM: shmobile: "i2c<m>" vs. "iic<n>" DT nodes and pinmux
Message-Id: <53F66568.6030709@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWqnMZQcRURufCxiGpbkK7ocjH8KnECxdWVPcxN-68J4g@mail.gmail.com> <53F643F1.9060409@cogentembedded.com>
In-Reply-To: <53F643F1.9060409@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa@the-dreams.de>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>

Hello.

On 08/21/2014 11:09 PM, Sergei Shtylyov wrote:

>> "iic<n>", with DT aliases from "i2c<m>" to the "iic<n>" DT nodes.
>> On r8a7791, DT device nodes and C/DT pinmux data for IIC<n> are called
>> "i2c<m>", with DT aliases from "i2c<m>" to the "i2c<m>" DT nodes.

>> In light of the proliferation of other members of the R-Car Gen 2 families, is
>> there a plan to make this consistent?

>     I can probably look at this since the SH-Mobile driver (and/or hardware?)
> is clearly of better quality than R-Car one: I'm constantly getting -ENXIO and
> -EBUSY from the latter trying to read images from ADV7180 I2C video decoder.

    Indeed, on Lager reading from the same chip seems to work flawlessy. 
However, I was too optimistic about R8A7791: it doesn't have IIC controller 
matching I2C2. :-/
    So the only thing I can do is to fix inconsistent labels in 
R8A7791/Koelsch DTs if Wolfram won't beat me to it.

WBR, Sergei

