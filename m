From: Kieran Bingham <kieranbingham@gmail.com>
Date: Tue, 29 Jan 2008 11:38:14 +0000
Subject: Re: rsk+/7203 audio support
Message-Id: <1201606694.20171.20.camel@Atlas>
List-Id: <linux-sh.vger.kernel.org>
References: <200801291223.02967.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <200801291223.02967.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Fabio,

Do you have audio jacks on your board? I thought you had an RSK+ board.
I'm not sure that there is anything on there.

I think the SH7203 has SSI which could drive some audio - but I don't
know how that can be used yet. You should speak to Renesas where you
purchased the board for details on how to extend the hardware support
for audio.

I have a USB Sound Card which I might try and plug in to the board and
see if I can get anything with that. I think that would be the easiest
and quickest option perhaps.

I'm trying to get another board up and running at the moment, so haven't
had chance to look at your C++ issues.
I've asked one of my colleagues to look into it, as he wants to get the
C++ working for his project.

Have you successfully compiled and run programs with the C++ toolchain
you sent us?

--
Cheers
Kieran



On Tue, 2008-01-29 at 12:23 +0100, Fabio Giovagnini wrote:
> Hi Kerian,
> into the arch/sh/boards/rsk+/7203
> subdir I see nothing about audio.
> What could be tne best start point to add the audio support?
> 
> Thanks a lot.


