From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 03 Dec 2019 09:49:15 +0000
Subject: Re: [PATCH v4 1/2] drivers: move the early platform device support to arch/sh
Message-Id: <CAMRc=MebSL+WA-nHFkaUd0rHTmwLkv2e16D9oO1=PY8-sPnzzQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20191003092913.10731-1-brgl@bgdev.pl> <20191003092912.G3pupKBmyct1r9ScP5Skuw9D-_ALcMVSnfMfHAlwe0Y@z>
 <20191202041440.GA1628@roeck-us.net> <CAMpxmJW3i4zmJJ14Xg65+T27kF3sgR1WG0K3FUT6+jeKtiHx=Q@mail.gmail.com>
 <3f8ffe03-98b8-423a-7cba-53961a5600cb@roeck-us.net> <CAMpxmJUmTF3FwacjvTrC+Vvzm8MscS9E=ZyWLbJV87LkQhqVow@mail.gmail.com>
 <5e7aafc9-deb9-9305-afea-2c86e310683f@roeck-us.net>
In-Reply-To: <5e7aafc9-deb9-9305-afea-2c86e310683f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Jiri Slaby <jslaby@suse.com>, Linux-sh list <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org

wt., 3 gru 2019 o 06:24 Guenter Roeck <linux@roeck-us.net> napisał(a):
>
> On 12/2/19 9:18 AM, Bartosz Golaszewski wrote:
> > pon., 2 gru 2019 o 14:03 Guenter Roeck <linux@roeck-us.net> napisał(a):
> >>
> >> On 12/1/19 11:40 PM, Bartosz Golaszewski wrote:
> >>> pon., 2 gru 2019 o 05:14 Guenter Roeck <linux@roeck-us.net> napisał(a):
> >>>>
> >>>> On Thu, Oct 03, 2019 at 11:29:12AM +0200, Bartosz Golaszewski wrote:
> >>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>>>>
> >>>>> SuperH is the only user of the current implementation of early platform
> >>>>> device support. We want to introduce a more robust approach to early
> >>>>> probing. As the first step - move all the current early platform code
> >>>>> to arch/sh.
> >>>>>
> >>>>> In order not to export internal drivers/base functions to arch code for
> >>>>> this temporary solution - copy the two needed routines for driver
> >>>>> matching from drivers/base/platform.c to arch/sh/drivers/platform_early.c.
> >>>>>
> >>>>> Also: call early_platform_cleanup() from subsys_initcall() so that it's
> >>>>> called after all early devices are probed.
> >>>>>
> >>>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>>>
> >>>> Wondering ... has anyone tested this patch on affected hardware ?
> >>>> All my qemu boot tests (both sh and sheb) fail because of it.
> >>>> Bisect log below.
> >>>>
> >>>> Guenter
> >>>>
> >>>> ---
> >>>> # bad: [72c0870e3a05d9cd5466d08c3d2a3069ed0a2f9f] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input
> >>>> # good: [89d57dddd7d319ded00415790a0bb3c954b7e386] Merge tag 'media/v5.5-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media
> >>>> git bisect start 'HEAD' '89d57dddd7d3'
> >>>> # good: [0a6cad5df541108cfd3fbd79eef48eb824c89bdc] Merge branch 'vmwgfx-coherent' of git://people.freedesktop.org/~thomash/linux into drm-next
> >>>> git bisect good 0a6cad5df541108cfd3fbd79eef48eb824c89bdc
> >>>> # bad: [9a3d7fd275be4559277667228902824165153c80] Merge tag 'driver-core-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core
> >>>> git bisect bad 9a3d7fd275be4559277667228902824165153c80
> >>>> # good: [59274c7164807d27b24e6c068dfe734f7bea4623] Merge tag 'usb-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> >>>> git bisect good 59274c7164807d27b24e6c068dfe734f7bea4623
> >>>> # good: [e71903106721dc53923e90aa484d78bc86c039a9] staging: mt7621-dma: align to match open parenthesis
> >>>> git bisect good e71903106721dc53923e90aa484d78bc86c039a9
> >>>> # good: [8f56e4ebe05c26c30e167519273843476e39e244] Merge tag 'char-misc-5.5-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc
> >>>> git bisect good 8f56e4ebe05c26c30e167519273843476e39e244
> >>>> # good: [8bde9f3d2a217d1635a7c7bdf8ad4c25c9a34b50] Merge tag 'iio-for-5.5c' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next
> >>>> git bisect good 8bde9f3d2a217d1635a7c7bdf8ad4c25c9a34b50
> >>>> # bad: [0628cda318df6baec439ca6e6e274007492f1ccd] mac80211: Use debugfs_create_xul() helper
> >>>> git bisect bad 0628cda318df6baec439ca6e6e274007492f1ccd
> >>>> # bad: [03324507e66c7664c754b1ef92c5c3be24c78aa2] driver core: Allow fwnode_operations.add_links to differentiate errors
> >>>> git bisect bad 03324507e66c7664c754b1ef92c5c3be24c78aa2
> >>>> # bad: [313f5dbba41d905d59c820bb2d91ee6c661aff99] debugfs: remove return value of debugfs_create_u16()
> >>>> git bisect bad 313f5dbba41d905d59c820bb2d91ee6c661aff99
> >>>> # good: [d4387cd117414ba80230f27a514be5ca4a09cfcc] of: property: Create device links for all child-supplier depencencies
> >>>> git bisect good d4387cd117414ba80230f27a514be5ca4a09cfcc
> >>>> # bad: [c31e73121f4c1ec45a3e523ac6ce3ce6dafdcec1] base: soc: Handle custom soc information sysfs entries
> >>>> git bisect bad c31e73121f4c1ec45a3e523ac6ce3ce6dafdcec1
> >>>> # bad: [201e91091b1d47047f55580b5474e1239f4d17aa] sh: add the sh_ prefix to early platform symbols
> >>>> git bisect bad 201e91091b1d47047f55580b5474e1239f4d17aa
> >>>> # bad: [507fd01d5333338753a1cc26322dfc9f856c109f] drivers: move the early platform device support to arch/sh
> >>>> git bisect bad 507fd01d5333338753a1cc26322dfc9f856c109f
> >>>> # first bad commit: [507fd01d5333338753a1cc26322dfc9f856c109f] drivers: move the early platform device support to arch/sh
> >>>
> >>> Hi Guenter,
> >>>
> >>> can you post some bootlogs? Is it the same problem everywhere?
> >>>
> >>
> >> I don't have any useful logs. The boot fails too early for that.
> >>
> >
> > Yeah, it touched "early" devices after all...
> >
> >> Sorry, I don't understand "everywhere". It fails in mainline and -next, if that is what you mean.
> >
> > I referred to "All my qemu boot tests" when saying everywhere.
> >
> > I don't have any relevant HW - the idea for this patch is to stop
> > compiling for everyone a bunch of code that's only used by one largely
> > irrelevant architecture and free the namespace for a generic early
> > platform drivers implementation.
> >
> > How are you creating your SH qemu images? I'm seeing there's something
> > in buildroot for superh - maybe I'll be able to bearly_platform_cleanupuild something
> > useful.
> >
>
> Below is a possible fix. As I had suspected, the call to early_platform_cleanup()
> is in the wrong place.
>

This makes sense. If it fixes the issue - do you want to send it to Greg?

Bart

> Guenter
>
> ---
>   arch/sh/drivers/platform_early.c | 11 ++---------
>   drivers/base/platform.c          |  4 ++++
>   2 files changed, 6 insertions(+), 9 deletions(-)
>
> diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_early.c
> index f6d148451dfc..16f33bffd8fc 100644
> --- a/arch/sh/drivers/platform_early.c
> +++ b/arch/sh/drivers/platform_early.c
> @@ -325,9 +325,9 @@ int __init sh_early_platform_driver_probe(char *class_str,
>   }
>
>   /**
> - * sh_early_platform_cleanup - clean up early platform code
> + * early_platform_cleanup - clean up early platform code
>    */
> -static int __init sh_early_platform_cleanup(void)
> +void early_platform_cleanup(void)
>   {
>         struct platform_device *pd, *pd2;
>
> @@ -337,11 +337,4 @@ static int __init sh_early_platform_cleanup(void)
>                 list_del(&pd->dev.devres_head);
>                 memset(&pd->dev.devres_head, 0, sizeof(pd->dev.devres_head));
>         }
> -
> -       return 0;
>   }
> -/*
> - * This must happen once after all early devices are probed but before probing
> - * real platform devices.
> - */
> -subsys_initcall(sh_early_platform_cleanup);
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 7c532548b0a6..3ba153e356ee 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -1325,10 +1325,14 @@ struct device *platform_find_device_by_driver(struct device *start,
>   }
>   EXPORT_SYMBOL_GPL(platform_find_device_by_driver);
>
> +void __weak early_platform_cleanup(void) { }
> +
>   int __init platform_bus_init(void)
>   {
>         int error;
>
> +       early_platform_cleanup();
> +
>         error = device_register(&platform_bus);
>         if (error) {
>                 put_device(&platform_bus);
>
