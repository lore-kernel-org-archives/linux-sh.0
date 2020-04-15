From: Rob Landley <rob@landley.net>
Date: Wed, 15 Apr 2020 23:21:01 +0000
Subject: Re: [PATCH] serial: sh-sci: Make sure status register SCxSR is read in correct sequence
Message-Id: <67d1a3a0-a160-f707-b7c5-ba610a3f76c8@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1585333048-31828-1-git-send-email-kazuhiro.fujita.jg@renesas.com>
 <CAMuHMdW+u5r6zyxFJsVzj21BYDrKCr=Q6Ojk5VeN+mkhvXX9Jw@mail.gmail.com>
 <OSBPR01MB3590E3D12546BC6711CEB542AAC80@OSBPR01MB3590.jpnprd01.prod.outlook.com>
 <CAMuHMdXmfQ0x7mCZ-E7OPQFv2z-=mFDT20hJ2_JKax=OePB8eA@mail.gmail.com>
 <CA+V-a8vPn_z_j1Vwr_1F=dCw8H=g5UMWvWxgRqBeVR7dzHPz8Q@mail.gmail.com>
 <CAMuHMdWc9q9NjQuAuy5M=v_x=i8XxVg5JZHswjvPsgNzhHfO0w@mail.gmail.com>
 <CAMuHMdUyV58t3eihBJv2xex5gW1Oef37Jo3FHoJstU=SspmpHA@mail.gmail.com>
In-Reply-To: <CAMuHMdUyV58t3eihBJv2xex5gW1Oef37Jo3FHoJstU=SspmpHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, Kazuhiro Fujita <kazuhiro.fujita.jg@renesas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hao Bui <hao.bui.yg@renesas.com>, KAZUMI HARADA <kazumi.harada.rh@renesas.com>, Sasha Levin <sashal@kernel.org>, Chris Brandt <Chris.Brandt@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

On 4/15/20 7:36 AM, Geert Uytterhoeven wrote:
>> Let's wait a bit, we're in the middle of the merge window anyway.
>> Probably we can get it tested on SuperH during the coming weeks.
> 
> Anyone with a real (not qemu) SuperH system who can do the basic "stty evenp"
> tests above, and report back to us?
> Thanks a lot!
The j-core boards use either uartlite or 16550a for serial, and neither of my
legacy sh4 boxes is easily accessible right now. But if nobody manages to test
this before next merge window poke me and I can set one up.

Rob
