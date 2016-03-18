From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Mar 2016 03:18:25 +0000
Subject: Re: [GIT PULL] arch/sh updates for 4.6
Message-Id: <CA+55aFzXUoh6ktJ+wWmwdg6ERjHJWbvrKQ5CoRCy-Sw620Ex+g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20160317220453.GA889@brightrain.aerifal.cx>
In-Reply-To: <20160317220453.GA889@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Thu, Mar 17, 2016 at 3:04 PM, Rich Felker <dalias@libc.org> wrote:
>
> Using git.libc.org for the sh tree is only temporary until we get one
> setup on kernel.org, which is pending getting signatures on my key. I
> hope to resolve that at ELC next month. Let me know if there's
> anything you'd like me to do in the mean time to establish some
> alternate basis of trust for these commits; hopefully it's less of an
> issue being that they're not touching anything but a previously
> unmaintained arch.

I really want to see signed tags when pulling from non-kernel.org places.

Even if you don't have signatures I can check on your keys, I want to
see your key used for signing anyway, so that when your next pull
request comes in I see that it's the same key (and hopefully you
_will_ have signatures on your key eventually).

So please send me a signed tag to pull rather than just a branchname, ok?

              Linus
