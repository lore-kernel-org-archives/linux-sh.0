From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 Nov 2013 00:44:31 +0000
Subject: Re: [PATCH 03/04] ARM: shmobile: Genmai I2C-over-GPIO support
Message-Id: <CANqRtoQkZHCCZ0hZrFkgndxoOrfdjnRZQR6NUP0KLMiRMxw2Gw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20131127082736.20015.21303.sendpatchset@w520>
 <20131127082805.20015.82680.sendpatchset@w520>
 <2757102.StIMV2khe5@avalon>
In-Reply-To: <2757102.StIMV2khe5@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Laurent,

On Wed, Nov 27, 2013 at 8:15 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thank you for the patch.
>
> On Wednesday 27 November 2013 17:28:05 Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Add support for the Genmai I2C bus hooked up to P1_5 and P1_4 using
>> the i2c-gpio driver. On the bus sits a 24c128 EEPRROM.
>
> Is this a temporary workaround until we get a proper I2C controller driver, or
> is the EEPROM really hooked up to pins that are not wired to a hardware I2C
> controller ?

This is a stop-gap solution until we have upstream driver support for
the I2C master hardware. The pins used for the I2C bus can be
configured in GPIO mode or a zillion other pin functions including SCL
and SDA.

Cheers,

/ magnus
