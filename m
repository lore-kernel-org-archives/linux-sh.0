From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 12 May 2015 19:42:40 +0000
Subject: Re: [PATCH 2/2] ARM: multi_v7_defconfig: Replace USB_RCAR_GEN2_PHY by PHY_RCAR_GEN2
Message-Id: <2579991.7Fqv0Atap3@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <1430222884-2095-1-git-send-email-geert+renesas@glider.be>
 <3385193.PYJYK5jiMy@wuerfel>
 <CAMuHMdU9363XjsEGNmy8CyLL6OR91khWFGQjn72qwWLr9=J1cQ@mail.gmail.com>
In-Reply-To: <CAMuHMdU9363XjsEGNmy8CyLL6OR91khWFGQjn72qwWLr9=J1cQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 12 May 2015 18:30:59 Geert Uytterhoeven wrote:
> 
> I think Simon's question was more about asking what's the proper process
> for updating multi_v7_defconfig.
> 
> Should this go through you / arm@kernel.org directly?
> Should it go through arm subarchitecture maintainers, causing merge conflicts?

I think it should go through subarch maintainers, and we'll handle the
conflicts as they arise when merging into the next/defconfig branch.
This does mean that it's important to send the defconfig changes separately
from other changes if possible, but it's fine to have a branch that touches
both platform-specific and generic defconfig files.

> BTW, arm@kernel.org isn't documented in MAINTAINERS.

Right, that is intentional. We don't want to get Cc'd on 4000 patches per
month that get sent to the mailing list for mach-*. By having a maintainer
for each subdirectory and letting them decide what to forward to us,
we're able to do our job better.

	Arnd
