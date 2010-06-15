From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 15 Jun 2010 14:21:39 +0000
Subject: Re: [GIT PULL] sh updates for 2.6.35-rc2
Message-Id: <AANLkTil4oxgn5iDQPp0qClrtFJUtuWKA62m40_5Dp9BR@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100604050007.GD31868@linux-sh.org>
	<201006150909.01958.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201006150909.01958.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Cc: Paul Mundt <lethal@linux-sh.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 15, 2010 at 09:09, Fabio Giovagnini
<fabio.giovagnini@aurion-tech.com> wrote:
> I Paul,
> I just finished my last application ald linux 2.6 jernel based.
> I'd like to upgrade my structure to the latest kernel for giving my apport
> into the development of sh7203 target.
> Can I have an account at
>
> master.kernel.org:/pub/scm/linux/kernel/git/lethal/sh-2.6.git

Just replace "master.kernel.org:" by "git://git.kernel.org", and it will work
without an account. There may be a small delay, due to git.kernel.org
being synced
from master.kernel.org.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
