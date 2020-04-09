From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 09 Apr 2020 08:58:36 +0000
Subject: Re: [PATCH v2 00/10] Allow COMMON_CLK to be selectable
Message-Id: <CAK8P3a1mOS4bVs+FQNcWPXuAdXpB-rKAuRE-at-Pr0m=43D68g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200409064416.83340-1-sboyd@kernel.org>
In-Reply-To: <20200409064416.83340-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Boyd <sboyd@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Michael Turquette <mturquette@baylibre.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Huacai Chen <chenhc@lemote.com>, Will Deacon <will@kernel.org>, linux-clk <linux-clk@vger.kernel.org>, linux-c6x-dev@linux-c6x.org, Alexander Shiyan <shc_work@mail.ru>, Neil Armstrong <narmstrong@baylibre.com>, Russell King <linux@armlinux.org.uk>, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Thierry Reding <treding@nvidia.com>, "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Lubomir Rintel <lkundrak@v3.sk>, linux-m68k <linux-m68k@lists.linux-m68k.org>, Mark Brown <broonie@kernel.org>, Guan Xuetao <gxt@pku.edu.cn>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Paul Burton <paulburton@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Tony Prisk <linux@prisktech.co.nz>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>

On Thu, Apr 9, 2020 at 8:44 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> This patch series cleans up a handful of selects that were redundant and
> deletes presumably dead code with the goal of making it possible to add
> kunit tests for the CCF in the future. To do that, we introduce a
> "legacy" clk Kconfig option to mark code that hasn't migrated to the
> common clk framework and then make the COMMON_CLK config option visible
> in the menuconfig as long as that legacy option isn't enabled. I've also
> included a couple patches at the end that may be more controversial but
> helped me consolidate all this logic/code.
>
> I haven't done more than compile test a few configs for arm, arm64,
> h8300, and mips. More testing is welcome.
>
> The plan is that I'll just merge the whole pile through the clk tree. If
> the first five patches or the last three patches are better going
> through another tree like arm-soc or architecture trees that's fine too,
> but there are potential conflicts between trees so maybe it's better to
> just leave it all in one tree.
>
> Changes from v1:
>  * Fixed MIPS ralink build problem pointed out by Arnd
>  * Fixed meson mx sdio build due to bad Kconfig exposed by this change
>  * Picked up acks

Whole series

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

I also made a patch to completely remove the private clk implementation
for mips/loongson2f, but it obviously clashes with your series at the moment.

I'll send you what I have today and you can decide if you want to
add it to your series after it gets an Ack from the maintainers, or I'll
send it separately later.

     Arnd
