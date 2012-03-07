From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 07 Mar 2012 06:36:38 +0000
Subject: Re: [PATCH] sh/next: Fix build fail by asm/system.h in asm/bitops.h
Message-Id: <20120307063637.GE10151@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1331010429-29574-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1331010429-29574-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Mar 06, 2012 at 02:07:09PM +0900, Nobuhiro Iwamatsu wrote:
> Other files are not done include definitely by asm/system.h made
> include in asm/bitops.h.
> This patch remove asm/system.h from asm/bitops.h.
> 
Which defconfig were you using that hit this? asm/system.h is usually
included for a reason, although I can't remember off the top of my head
what's used out of it and on what CPU configuration, but I would be
rather hesitant to yank it out on an N of 1 build test.
