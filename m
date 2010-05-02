From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Sun, 02 May 2010 08:17:50 +0000
Subject: Re: Timer handling discussion
Message-Id: <201005021017.50817.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201005010901.09335.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201005010901.09335.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Thanks Magnus. I'm solviing handling a timer directly into the buzzer /proc 
driver

Thanks


In data sabato 01 maggio 2010 14:11:29, Magnus Damm ha scritto:
: > Hi Fabio,
> 
> On Sat, May 1, 2010 at 4:01 PM, Fabio Giovagnini
> 
> <fabio.giovagnini@aurion-tech.com> wrote:
> > Hi all,
> > I'need to produce a 4KHz square wave to drive a buzzer.I have HZ set to
> > 100; so the kernel timer expires each 10ms.
> 
> You may want to use hrtimers. One example how to use that is in the
> following file:
> 
> sound/sh/sh_dac_audio.c
> 
> / magnus
> 

-- 
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
