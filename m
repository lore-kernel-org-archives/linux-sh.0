From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Mon, 02 Dec 2019 17:18:22 +0000
Subject: Re: [PATCH v4 1/2] drivers: move the early platform device support to arch/sh
Message-Id: <CAMpxmJUmTF3FwacjvTrC+Vvzm8MscS9E=ZyWLbJV87LkQhqVow@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20191003092913.10731-1-brgl@bgdev.pl> <20191003092912.G3pupKBmyct1r9ScP5Skuw9D-_ALcMVSnfMfHAlwe0Y@z>
 <20191202041440.GA1628@roeck-us.net> <CAMpxmJW3i4zmJJ14Xg65+T27kF3sgR1WG0K3FUT6+jeKtiHx=Q@mail.gmail.com>
 <3f8ffe03-98b8-423a-7cba-53961a5600cb@roeck-us.net>
In-Reply-To: <3f8ffe03-98b8-423a-7cba-53961a5600cb@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.com>, linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

pon., 2 gru 2019 o 14:03 Guenter Roeck <linux@roeck-us.net> napisał(a):
>
> On 12/1/19 11:40 PM, Bartosz Golaszewski wrote:
> > pon., 2 gru 2019 o 05:14 Guenter Roeck <linux@roeck-us.net> napisał(a):
> >>
> >> On Thu, Oct 03, 2019 at 11:29:12AM +0200, Bartosz Golaszewski wrote:
> >>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>>
> >>> SuperH is the only user of the current implementation of early platform
> >>> device support. We want to introduce a more robust approach to early
> >>> probing. As the first step - move all the current early platform code
> >>> to arch/sh.
> >>>
> >>> In order not to export internal drivers/base functions to arch code for
> >>> this temporary solution - copy the two needed routines for driver
> >>> matching from drivers/base/platform.c to arch/sh/drivers/platform_early.c.
> >>>
> >>> Also: call early_platform_cleanup() from subsys_initcall() so that it's
> >>> called after all early devices are probed.
> >>>
> >>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>
> >> Wondering ... has anyone tested this patch on affected hardware ?
> >> All my qemu boot tests (both sh and sheb) fail because of it.
> >> Bisect log below.
> >>
> >> Guenter
> >>
> >> ---
> >> # bad: [72c0870e3a05d9cd5466d08c3d2a3069ed0a2f9f] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
> >> # good: [89d57dddd7d319ded00415790a0bb3c954b7e386] Merge tag 'media/v5.5-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> >> git bisect start 'HEAD' '89d57dddd7d3'
> >> # good: [0a6cad5df541108cfd3fbd79eef48eb824c89bdc] Merge branch 'vmwgfx-coherent' of git://people.freedesktop.org/~thomash/linux into drm-next
> >> git bisect good 0a6cad5df541108cfd3fbd79eef48eb824c89bdc
> >> # bad: [9a3d7fd275be4559277667228902824165153c80] Merge tag 'driver-core-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> >> git bisect bad 9a3d7fd275be4559277667228902824165153c80
> >> # good: [59274c7164807d27b24e6c068dfe734f7bea4623] Merge tag 'usb-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> >> git bisect good 59274c7164807d27b24e6c068dfe734f7bea4623
> >> # good: [e71903106721dc53923e90aa484d78bc86c039a9] staging: mt7621-dma: align to match open parenthesis
> >> git bisect good e71903106721dc53923e90aa484d78bc86c039a9
> >> # good: [8f56e4ebe05c26c30e167519273843476e39e244] Merge tag 'char-misc-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
> >> git bisect good 8f56e4ebe05c26c30e167519273843476e39e244
> >> # good: [8bde9f3d2a217d1635a7c7bdf8ad4c25c9a34b50] Merge tag 'iio-for-5.5c' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next
> >> git bisect good 8bde9f3d2a217d1635a7c7bdf8ad4c25c9a34b50
> >> # bad: [0628cda318df6baec439ca6e6e274007492f1ccd] mac80211: Use debugfs_create_xul() helper
> >> git bisect bad 0628cda318df6baec439ca6e6e274007492f1ccd
> >> # bad: [03324507e66c7664c754b1ef92c5c3be24c78aa2] driver core: Allow fwnode_operations.add_links to differentiate errors
> >> git bisect bad 03324507e66c7664c754b1ef92c5c3be24c78aa2
> >> # bad: [313f5dbba41d905d59c820bb2d91ee6c661aff99] debugfs: remove return value of debugfs_create_u16()
> >> git bisect bad 313f5dbba41d905d59c820bb2d91ee6c661aff99
> >> # good: [d4387cd117414ba80230f27a514be5ca4a09cfcc] of: property: Create device links for all child-supplier depencencies
> >> git bisect good d4387cd117414ba80230f27a514be5ca4a09cfcc
> >> # bad: [c31e73121f4c1ec45a3e523ac6ce3ce6dafdcec1] base: soc: Handle custom soc information sysfs entries
> >> git bisect bad c31e73121f4c1ec45a3e523ac6ce3ce6dafdcec1
> >> # bad: [201e91091b1d47047f55580b5474e1239f4d17aa] sh: add the sh_ prefix to early platform symbols
> >> git bisect bad 201e91091b1d47047f55580b5474e1239f4d17aa
> >> # bad: [507fd01d5333338753a1cc26322dfc9f856c109f] drivers: move the early platform device support to arch/sh
> >> git bisect bad 507fd01d5333338753a1cc26322dfc9f856c109f
> >> # first bad commit: [507fd01d5333338753a1cc26322dfc9f856c109f] drivers: move the early platform device support to arch/sh
> >
> > Hi Guenter,
> >
> > can you post some bootlogs? Is it the same problem everywhere?
> >
>
> I don't have any useful logs. The boot fails too early for that.
>

Yeah, it touched "early" devices after all...

> Sorry, I don't understand "everywhere". It fails in mainline and -next, if that is what you mean.

I referred to "All my qemu boot tests" when saying everywhere.

I don't have any relevant HW - the idea for this patch is to stop
compiling for everyone a bunch of code that's only used by one largely
irrelevant architecture and free the namespace for a generic early
platform drivers implementation.

How are you creating your SH qemu images? I'm seeing there's something
in buildroot for superh - maybe I'll be able to build something
useful.

Bartosz

> And, yes, it has failed in -next for a while, looking back at the log history.
>
> Guenter
