From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 25 Jul 2013 09:27:41 +0000
Subject: Re: Mainline kernel on snowball
Message-Id: <CACRpkdagoo965=8QMR-TwiD3GEwE4FjgdJv2ET1E4R0OWq+efw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130725052317.GA25854@verge.net.au>
In-Reply-To: <20130725052317.GA25854@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Jul 25, 2013 at 7:23 AM, Simon Horman <horms@verge.net.au> wrote:

> I would like to boot the mainline kernel - ideally v3.10 and v3.11-rcX -
> on snowball. The reason being to verify CPU hotplug which
> seems to be broken on shmobile, though that is tangential to this post.

I usually compile my kernel with this makefile:
http://www.df.lth.se/~triad/krad/makefiles/u8500.mak

It appends an initramfs and it appends a DTB (if you compile it
with config-dt and build-dt) and need nothing from any FS or
similar.

But the way it looks up compilers and initramfs etc is a bit
custom I gues ... you have a copy of my initramfs here:
http://www.df.lth.se/~triad/krad/ux00/rootfs-u8500.cpio

Yours,
Linus Walleij
