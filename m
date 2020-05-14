From: Stephen Boyd <sboyd@kernel.org>
Date: Thu, 14 May 2020 19:57:08 +0000
Subject: Re: [PATCH v2 07/10] clk: Allow the common clk framework to be selectable
Message-Id: <158948622898.215346.8325812794724480286@swboyd.mtv.corp.google.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200409064416.83340-1-sboyd@kernel.org>
 <20200409064416.83340-8-sboyd@kernel.org>
In-Reply-To: <20200409064416.83340-8-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, linux-m68k@lists.linux-m68k.org, Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Mark Salter <msalter@redhat.com>, Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Guan Xuetao <gxt@pku.edu.cn>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org

Quoting Stephen Boyd (2020-04-08 23:44:13)
> Enable build testing and configuration control of the common clk
> framework so that more code coverage and testing can be done on the
> common clk framework across various architectures. This also nicely
> removes the requirement that architectures must select the framework
> when they don't use it in architecture code.
> 
> There's one snag with doing this, and that's making sure that randconfig
> builds don't select this option when some architecture or platform
> implements 'struct clk' outside of the common clk framework. Introduce a
> new config option 'HAVE_LEGACY_CLK' to indicate those platforms that
> haven't migrated to the common clk framework and therefore shouldn't be
> allowed to select this new config option. Also add a note that we hope
> one day to remove this config entirely.
> 
> Based on a patch by Mark Brown <broonie@kernel.org>.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Cc: Guan Xuetao <gxt@pku.edu.cn>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: <linux-mips@vger.kernel.org>
> Cc: <linux-c6x-dev@linux-c6x.org>
> Cc: <linux-m68k@lists.linux-m68k.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Cc: <linux-sh@vger.kernel.org>
> Link: https://lore.kernel.org/r/1470915049-15249-1-git-send-email-broonie@kernel.org
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
