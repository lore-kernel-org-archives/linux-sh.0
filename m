From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 12 Mar 2013 12:31:29 +0000
Subject: Re: [PATCH 03/04] ARM: shmobile: r8a73a4 IRQC support
Message-Id: <201303121231.29869.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20130312045559.19701.77841.sendpatchset@w520>
 <20130312045628.19701.58216.sendpatchset@w520>
In-Reply-To: <20130312045628.19701.58216.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tuesday 12 March 2013, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add IRQC interrupt controller support to r8a73a4 by
> hooking up two IRQC instances to handle 58 external
> IRQ signals. There IRQC controllers are tied to SPIs
> of the GIC. On r8a73a4 exact IRQ pin routing is handled
> by the PFC which is excluded from this patch.
> 
> Both platform devices and DT devices are added in this
> patch. The platform device versions are used to provide
> a static interrupt map configuration for board code
> written in C.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

What is the status of the IRQC DT support? I remember that I wasn't
happy with a prior version, but I did not follow up on some of the
questions that came up, sorry about that.

Did the patches end up getting merged anyway, or should we resume the
discussion about those patches? I understand that lack of INTC bindings
would make new SoC support particularly hard, and I don't want to
be responsible for holding you up here.

	Arnd
