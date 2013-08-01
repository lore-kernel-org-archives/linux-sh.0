From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Thu, 01 Aug 2013 12:04:35 +0000
Subject: Re: [RFC 0/5] Non-functional zboot implementation for KZM9G
Message-Id: <CAO3366yt0eDSKGrerrZj=jTAfn65C5r=qFgcOOv6zQ24iXvT5A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375207047-8655-1-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1375207047-8655-1-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 1, 2013 at 11:51 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Thanks for posting your code. I will give your code a go when I find
> time later on.

OK, thanks.

> on target SoC and board. Also, they assume that the boot loader
> actually set up the SCIF and PFC for you already - this seems to be
> the case with your zboot code but you may want to double check.

PFC, (I think) yes; SCIF, no.

> I think you should be able to use 3 instruction hack included in
> "linux-3.12-pre-arm-shmobile-smp-mpidr-dbg-sh73a0-20130731b.patch" on
> KZM9G more or less as-is.

I actually had something like that, but I didn't feel like working out
the timings, so I stuck with the LEDs. (In hindsight, it probably
would have been easier than writing down addresses digit by digit...)

CU
Uli
