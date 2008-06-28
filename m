From: Paul Mundt <lethal@linux-sh.org>
Date: Sat, 28 Jun 2008 03:01:33 +0000
Subject: Re: [PATCH v2 1/4] video: sh7760fb: SH7760/SH7763 LCDC framebuffer driver part 1/3
Message-Id: <20080628030133.GA25492@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48632CAF.3090703@renesas.com>
In-Reply-To: <48632CAF.3090703@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Cc: linux-fbdev <Linux-fbdev-devel@lists.sourceforge.net>, Linux-sh <linux-sh@vger.kernel.org>

On Thu, Jun 26, 2008 at 02:44:15PM +0900, Nobuhiro Iwamatsu wrote:
> Main source code of Driver for the LCDC interface on the SH7760 and SH7763 SoCs.
> 
> Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

Also note that the SH7203 LCDC is virtually identical, so that might be
worth a brief look also. Unfortunately porting this to the RSK+ 7203 is a
bit of a headache with regards to the panel control, which is closer to
MigoR with the external controller.
