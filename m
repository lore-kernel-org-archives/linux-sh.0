From: Jeremy Kerr <jeremy.kerr@canonical.com>
Date: Wed, 09 Feb 2011 06:41:33 +0000
Subject: [RFC,PATCH 0/3] Common struct clk implementation, v12
Message-Id: <1297233693.241680.897691111624.0.gpush@pororo>
List-Id: <linux-sh.vger.kernel.org>
In-Reply-To: <201102011711.31258.jeremy.kerr@canonical.com>
References: <1297058877.799617.749783078584.0.gpush@pororo>
In-Reply-To: <1297058877.799617.749783078584.0.gpush@pororo>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hi all,

These patches are an attempt to allow platforms to share clock code. At
present, the definitions of 'struct clk' are local to platform code,
which makes allocating and initialising cross-platform clock sources
difficult, and makes it impossible to compile a single image containing
support for two ARM platforms with different struct clks.

The three patches are for the architecture-independent kernel code,
introducing the common clk infrastructure. The changelog for the first
patch includes details about the new clock definitions.

Ben Herrenschmidt is looking at using common struct clk code for powerpc
too, hence the kernel-wide approach.

Many thanks to the following for their input:
 * Ben Dooks <ben-linux@fluff.org>
 * Baruch Siach <baruch@tkos.co.il>
 * Russell King <linux@arm.linux.org.uk>
 * Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
 * Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
 * Vincent Guittot <vincent.guittot@linaro.org>
 * Sascha Hauer <s.hauer@pengutronix.de>
 * Ryan Mallon <ryan@bluewatersys.com>
 * Colin Cross <ccross@google.com>
 * Jassi Brar <jassisinghbrar@gmail.com>

Cheers,


Jeremy

--
v12:
 * Always refcount, even when enable/prepare ops are NULL
 * Unify prepare & enable count checking
 * Update comments for prepare/unprepare
 * Use spin_{lock,unlock}_irqsave
 * Change clk_put to __clk_put, and use the shared clk_put

v11:
 * add prepare/unprepare for non-atomic switching, document atomicity
 * move to drivers/clk/

v10:
 * comment fixups, from Uwe's review
 * added DEFINE_CLK_FIXED

v9:
 * comment improvements
 * kerneldoc fixups
 * add WARN_ON to clk_disable

v8:
 * add atomic clocks, and locking wrappers
 * expand comments on clk and clk_ops

v7:
 * change CLK_INIT to initialise clk->mutex statically

v6:
 * fixed up references to 'clk_operations' in the changelog

v5:
 * uninline main API, and share definitions with !USE_COMMON_STRUCT_CLK
 * add __clk_get
 * delay mutex init
 * kerneldoc for struct clk

v4:
 * use mutex for enable/disable locking
 * DEFINE_CLK -> INIT_CLK, and pass the clk name for mutex init
 * struct clk_operations -> struct clk_ops

v3:
 * do clock usage refcounting in common code
 * provide sample port

v2:
 * no longer ARM-specific
 * use clk_operations

---
Jeremy Kerr (3):
      Add a common struct clk
      clk: Generic support for fixed-rate clocks
      clk: add warnings for incorrect enable/prepare semantics

