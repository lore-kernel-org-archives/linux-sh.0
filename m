From: Rob Landley <rob@landley.net>
Date: Mon, 17 Aug 2020 03:17:48 +0000
Subject: Re: [PATCH] serial: sh-sci: Make sure status register SCxSR is read in correct sequence
Message-Id: <b384543f-c80d-aa63-63a6-1b5dbc47885d@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1585333048-31828-1-git-send-email-kazuhiro.fujita.jg@renesas.com>
 <CAMuHMdW+u5r6zyxFJsVzj21BYDrKCr=Q6Ojk5VeN+mkhvXX9Jw@mail.gmail.com>
 <OSBPR01MB3590E3D12546BC6711CEB542AAC80@OSBPR01MB3590.jpnprd01.prod.outlook.com>
 <CAMuHMdXmfQ0x7mCZ-E7OPQFv2z-=mFDT20hJ2_JKax=OePB8eA@mail.gmail.com>
 <CA+V-a8vPn_z_j1Vwr_1F=dCw8H=g5UMWvWxgRqBeVR7dzHPz8Q@mail.gmail.com>
 <CAMuHMdWc9q9NjQuAuy5M=v_x=i8XxVg5JZHswjvPsgNzhHfO0w@mail.gmail.com>
 <CAMuHMdUyV58t3eihBJv2xex5gW1Oef37Jo3FHoJstU=SspmpHA@mail.gmail.com>
 <CAMuHMdU0EiQuk_bWx1yrmbBTXg8mL-PeN2=P61xQ5Ucb5QmYYg@mail.gmail.com>
 <OSBPR01MB50485F5DA2F82E455DCA6B56AA5E0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
In-Reply-To: <OSBPR01MB50485F5DA2F82E455DCA6B56AA5E0@OSBPR01MB5048.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Kazuhiro Fujita <kazuhiro.fujita.jg@renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hao Bui <hao.bui.yg@renesas.com>, KAZUMI HARADA <kazumi.harada.rh@renesas.com>, Sasha Levin <sashal@kernel.org>, Chris Brandt <Chris.Brandt@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

On 8/16/20 11:22 AM, Prabhakar Mahadev Lad wrote:
>> FTR, I gave it a try on the SH7751R-based I-O DATA USL-5P aka Landisk:
>> SCIF is affected, and fixed by commit 3dc4db3662366306 ("serial: sh-sci:
>> Make sure status register SCxSR is read in correct sequence").
>>
> Thank you Geert.
> 
> Cheers,
> Prabhakar

Did we ever figure out how to get linux to talk to the _first_ serial port on
the qemu-system-sh4 r2d board? I'm still doing:

  qemu-system-sh4 -M r2d -serial null -serial mon:stdio

Because I can only get a working console on the _second_ serial port. (SCI vs
SCIF I think?)

Rob
