From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 09 Apr 2012 07:57:56 +0000
Subject: Re: [PATCH] sh: fixup pm.c compile error
Message-Id: <20120409075754.GB11820@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Apr 08, 2012 at 08:51:26PM -0700, Kuninori Morimoto wrote:
> This patch fixup below compile error which came from
> e839ca528718e68cad32a307dc9aabf01ef3eb05
> (Disintegrate asm/system.h for SH)
> 
> ${LINUX}/arch/sh/kernel/cpu/shmobile/pm.c: In function 'sh_pm_enter':
> ${LINUX}/arch/sh/kernel/cpu/shmobile/pm.c:137:2:
> 	error: implicit declaration of function 'set_bl_bit'
> ${LINUX}/arch/sh/kernel/cpu/shmobile/pm.c:140:2:
> 	error: implicit declaration of function 'clear_bl_bit'
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This should already be fixed upstream?
