From: Ralf Baechle <ralf@linux-mips.org>
Date: Mon, 06 Jun 2011 13:49:41 +0000
Subject: Re: [PATCH 2/3] PM / Hibernate: Remove arch_prepare_suspend()
Message-Id: <20110606134941.GB15453@linux-mips.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201105211408.28671.rjw@sisk.pl>
 <201105211410.34491.rjw@sisk.pl>
In-Reply-To: <201105211410.34491.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Frank Hofmann <frank.hofmann@tomtom.com>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On Sat, May 21, 2011 at 02:10:34PM +0200, Rafael J. Wysocki wrote:

> 
> All architectures supporting hibernation define
> arch_prepare_suspend() as an empty function, so remove it.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>  arch/frv/include/asm/suspend.h       |   20 --------------------
>  arch/mips/include/asm/suspend.h      |    2 --

I don't see what we'd possibly need that hook for so:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
