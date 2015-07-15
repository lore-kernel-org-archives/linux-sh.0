From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jul 2015 07:37:30 +0000
Subject: Re: [PATCH v2] ARM: shmobile: r8a7779 Marzen legacy fix V2
Message-Id: <CAMuHMdU5ZQQXDgcu9NV5azDg4VC7hP4j++8pSCEnUj9gPKCCXw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150714072522.2854.69938.sendpatchset@little-apple>
In-Reply-To: <20150714072522.2854.69938.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 15, 2015 at 8:53 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Jul 15, 2015 at 03:49:01PM +0900, Magnus Damm wrote:
>> On Wed, Jul 15, 2015 at 3:47 PM, Simon Horman <horms@verge.net.au> wrote:
>> > On Wed, Jul 15, 2015 at 02:59:32PM +0900, Magnus Damm wrote:
>> >> Hi Simon,
>> >>
>> >> On Wed, Jul 15, 2015 at 9:23 AM, Simon Horman <horms@verge.net.au> wrote:
>> >> > On Tue, Jul 14, 2015 at 04:25:22PM +0900, Magnus Damm wrote:
>> >> >> From: Magnus Damm <damm+renesas@opensource.se>
>> >> >>
>> >> >> Unbreak the r8a7779 Marzen legacy code provided by marzen_defconfig.
>> >> >>
>> >> >> As it is today Marzen multiplatform is working, but the legacy code
>> >> >> is broken. This patch intends to leave multiplatform as-is but do
>> >> >> a simple one-shot fix to unbreak the legacy code base.
>> >> >>
>> >> >> Without this patch there is no preset delay and the TWD is defined
>> >> >> both in C code and in DT. Solve the delay by invoking shmobile_init_delay()
>> >> >> and simply disable TWD in case of building for legacy.
>> >> >>
>> >> >> Marzen legacy code will be removed in the near future, but until then
>> >> >> we may as well avoid breaking it.
>> >> >>
>> >> >> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

> With the above in mind I will queue this up with the Fixes tag
> as a fix for v4.3. It may well filter into -stable from there.

Before you tag it for stable: keeping in mind commit 30225743852ed5c3
("ARM: shmobile: sh73a0 dtsi: Add Cortex-A9 TWD node), does it work with
CONFIG_CPU_IDLE=y?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
