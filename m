From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 13 Sep 2017 07:47:55 +0000
Subject: Re: sh: sh7758 User land programs crash with SIGBUS.
Message-Id: <CAMuHMdWVRfdOeWGdCS=OZ9t1mOuZqXpxN3xidG=q18vCtuKAgA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <bac7196cecbb43159feaaf1fc1605767@AUSX13MPC101.AMER.DELL.COM>
In-Reply-To: <bac7196cecbb43159feaaf1fc1605767@AUSX13MPC101.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Prashanth.Giri@dell.com
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

CC linux-sh

On Wed, Sep 13, 2017 at 12:00 AM,  <Prashanth.Giri@dell.com> wrote:
> Hi,
>
> I am trying to port from 3.4.11 kernel to 3.10.107 based on my sh7757/58 processor hardware and running into some odd behavior with user land applications. I pretty much got the kernel up and running but some of the applications in user land won't launch and are crashing with the below messages in dmesg.
>
> <5>Fixing up unaligned userspace access in "aim" pid=28533 pc=0x3b142492 ins=0x6252
> <5>Sending SIGBUS to "aim" pid=28533 due to unaligned access (PC 3b142492 PR 296167e4) ins=0x6252
> <5>Sending SIGBUS to "pm" pid=28741 due to unaligned access (PC 58b2e409 PR 297b0118) ins=0x8dc1
> <5>Sending SIGBUS to "pm" pid=28741 due to unaligned access (PC 3b142492 PR 296ce7e4) ins=0x6252
>
> Some of the older posts in the mailing lists pointed out to I/D cache issues, I tried disabling the cache altogether in a hope to root cause the issue, but still got the same responses. For some reason I believe the loader is loading these programs into odd addresses. I am clueless as to where to look for the possible issue. Is there any obvious settings that I am missing from the board/cpu setup ?
>
> Any expert help and guidance is really appreciated.
>
> Thanks,
> Prashanth
