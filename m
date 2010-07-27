From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 27 Jul 2010 04:50:35 +0000
Subject: Re: MMC slots on MS7724
Message-Id: <AANLkTik96J-5hfUxOkfsu=7JcQgiH_axmiH2bVeGC5RT@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4C4DFEE4.1040409@naoi.ca>
In-Reply-To: <4C4DFEE4.1040409@naoi.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

On Tue, Jul 27, 2010 at 6:32 AM, Bill Traynor <wmat@naoi.ca> wrote:
> Can someone with an MS7724 ecovec board confirm something for me? =A0When=
 the
> board is powered on, are the two MMC slot LED power indicators lit? =A0The
> LEDs are right off the back left corner of the slots. =A0On my board only=
 one
> LED lights up and only blinks sporadically. =A0I can't get the board to
> recognize any SD cards at all and I suspect the hardware may be faulty.

I recognize the case with one LED blinking. For me I think it was
caused by a mismatch in between the kernel configuration and the dip
switch settings. If you still have problems then please post your
kernel configure and I will give it a try.

Cheers,

/ magnus
