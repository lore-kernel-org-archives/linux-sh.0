From: =?UTF-8?B?44Kr44Kq44CA44Of44Oz44CA44OS44Kn44OD44OX?=  <cm-hiep@jinso.co.jp>
Date: Mon, 17 Mar 2014 12:01:40 +0000
Subject: Re: [RFC] spi: Using Trigger number to transmit/receive data
Message-Id: <5326E424.9040709@jinso.co.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1394699364-5669-1-git-send-email-cm-hiep@jinso.co.jp>	<1394699364-5669-2-git-send-email-cm-hiep@jinso.co.jp>	<CAMuHMdUpm_4f7LynObRA+NDn4vqeUc0a2XZW-E=4LKL_Ro3XZw@mail.gmail.com>	<53264BA4.3000401@jinso.co.jp> <CAMuHMdWP-tNCtnwP6=XZ1BNacWretVYjrpbT3R+KTEO=047+Nw@mail.gmail.com>
In-Reply-To: <CAMuHMdWP-tNCtnwP6=XZ1BNacWretVYjrpbT3R+KTEO=047+Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Hi Geert

On 03/17/2014 04:54 PM, Geert Uytterhoeven wrote:
> Hi Hiep,
>
> On Mon, Mar 17, 2014 at 2:11 AM, カオ　ミン　ヒェップ <cm-hiep@jinso.co.jp> wrote:
>> On 03/13/2014 06:23 PM, Geert Uytterhoeven wrote:
>>> On Thu, Mar 13, 2014 at 9:29 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp>
>>> wrote:
>>>> In order to transmit and receive data when have 32 bytes of data that
>>>> ready has prepared on Transmit/Receive Buffer to transmit or receive.
>>>> Instead transmits/receives a byte data using Transmit/Receive Buffer
>>>> Data Triggering Number will improve the speed of transfer data.
>>> Thanks for your patch, this looks like a valuable improvement!
>>>
>>> Unfortunately your patch doesn't apply against spi/for-next anymore, as
>>> the driver has changed a lot lately, due to the addition of RZ/A1H and
>>> Quad/Dual support.
>>>
>> Thanks, Do you mean this patch did not need for next and I don't mind about
>> it?
> It means you will have to rework your patch to apply on top of
> https://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/tree/drivers/spi?h=for-next
> before the SPI maintainer can accept it.
Thanks, I understood, I will rework my patch and report to your later.

Cao Minh Hiep.

