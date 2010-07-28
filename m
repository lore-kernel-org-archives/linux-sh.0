From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Jul 2010 09:20:42 +0000
Subject: Re: MMC slots on MS7724
Message-Id: <AANLkTin3v4XdOyypOOnFBo8GZffk37HX5=pnajXpUq5N@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4C4DFEE4.1040409@naoi.ca>
In-Reply-To: <4C4DFEE4.1040409@naoi.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Hi Bill,

On Tue, Jul 27, 2010 at 9:49 PM, Bill Traynor <wmat@naoi.ca> wrote:
> On 10-07-27 12:50 AM, Magnus Damm wrote:
>>
>> On Tue, Jul 27, 2010 at 6:32 AM, Bill Traynor<wmat@naoi.ca> =A0wrote:
>>
>>>
>>> Can someone with an MS7724 ecovec board confirm something for me? =A0Wh=
en
>>> the
>>> board is powered on, are the two MMC slot LED power indicators lit? =A0=
The
>>> LEDs are right off the back left corner of the slots. =A0On my board on=
ly
>>> one
>>> LED lights up and only blinks sporadically. =A0I can't get the board to
>>> recognize any SD cards at all and I suspect the hardware may be faulty.
>>>
>>
>> I recognize the case with one LED blinking. For me I think it was
>> caused by a mismatch in between the kernel configuration and the dip
>> switch settings. If you still have problems then please post your
>> kernel configure and I will give it a try.
>>
>
> I'm using the latest ecovec24_defconfig in Paul's git tree.

The ecovec defconfig seems to have the MMCIF driver disabled.
Feel free to try CONFIG_MMC_SH_MMCIF=3Dy.

The MMC stuff on Ecovec is like a big maze. On the hardware side you
have an external bus switch controlled by dip switches. Inside the SoC
you can select between MMCIF or SDHI for one of the slots. On top of
that you can use MSIOF for MMC-over-SPI.

The hardware setting need to be reflected by the kernel configuration.
I recommend you to browse through the platform device comments in
arch/sh/boards/mach-ecovec24/setup.c

Cheers,

/ magnus
