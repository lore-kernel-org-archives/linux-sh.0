From: Magnus Damm <magnus.damm@gmail.com>
Date: Sat, 01 May 2010 12:11:29 +0000
Subject: Re: Timer handling discussion
Message-Id: <g2jaec7e5c31005010511j269c2bb8p62911ae8b97ece54@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201005010901.09335.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201005010901.09335.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Fabio,

On Sat, May 1, 2010 at 4:01 PM, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> Hi all,
> I'need to produce a 4KHz square wave to drive a buzzer.I have HZ set to 100;
> so the kernel timer expires each 10ms.

You may want to use hrtimers. One example how to use that is in the
following file:

sound/sh/sh_dac_audio.c

/ magnus
