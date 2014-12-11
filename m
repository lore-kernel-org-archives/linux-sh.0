From: Simon Horman <horms@verge.net.au>
Date: Thu, 11 Dec 2014 01:04:57 +0000
Subject: Re: [PATCH 0/4] ARM: shmobile: koelsch: Add DA9063 watchdog restart support
Message-Id: <20141211010456.GA28633@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1418124169-7123-1-git-send-email-geert+renesas@glider.be>
 <20141210003352.GH9690@verge.net.au>
 <CAMuHMdWY_1OsjFvT35Lg23ytzPz0MSCmcT7diGk1ughxNnmtVg@mail.gmail.com>
In-Reply-To: <CAMuHMdWY_1OsjFvT35Lg23ytzPz0MSCmcT7diGk1ughxNnmtVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Wim Van Sebroeck <wim@iguana.be>, Wolfram Sang <wsa@the-dreams.de>, Magnus Damm <magnus.damm@gmail.com>, Support Opensource <support.opensource@diasemi.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Linux Watchdog Mailing List <linux-watchdog@vger.kernel.org>, Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Wed, Dec 10, 2014 at 11:06:25AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Wed, Dec 10, 2014 at 1:33 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Tue, Dec 09, 2014 at 12:22:45PM +0100, Geert Uytterhoeven wrote:
> >> This patch series add restart support for r8a7791/koelsch through the watchdog
> >> in the DA9063 PMIC. Restart can be triggered in two ways:
> >>   1. Timeout of the watchdog timer,
> >>   2. Manual system restart, shutting down the DA9063.
> >>
> >> Dependencies:
> >>   - There are no strict merge order dependencies,
> >>   - While manual restart depends on patch 1, patches 3 and 4 can be merged
> >>     now, as restart on watchdog timeout works without patch 1.
> >>
> >> Patches:
> >>   - Patch 1 is intended for the watchdog tree (based on watchdog/next),
> >>   - Patch 2 is intended for the i2c tree (based on i2c/next),
> >>   - Patches 3 and 4 are intended for the shmobile tree (based on
> >>     renesas-devel-20141209-v3.18).
> >
> > Patches 3 and 4 look like they could be queued up for v3.20 now.
> > Shall I do so?
> 
> Please do so.
> 
> You can easily test restart on watchdog timeout using:
> 
> $ cat > /dev/watchdog0
> 
> Koelsch should restart 8 seconds after you stop typing.

Thanks, I have queued them up.
